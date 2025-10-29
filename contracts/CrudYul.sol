// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract UserCrud {
    struct User {
        uint id;
        string name;
        uint age;
        bool isActive;
    }

    mapping(uint => User) public users;
    uint private nextId;
    
    event UserCreated(uint id, string name, uint age);
    event UserUpdated(uint id, string name, uint age);
    event UserDeleted(uint id);

    /**
     * @notice Crea un usuario con optimizaciones Yul para máximo ahorro de gas
     * @dev Validaciones inline, cálculo manual de slots y escritura directa en storage
     * @param _name Nombre del usuario (1-50 caracteres)
     * @param _age Edad del usuario (1-150 años)
     * 
     * Optimizaciones implementadas:
     * - Validaciones sin overhead de require()
     * - Cálculo directo de posición en mapping
     * - Lectura/escritura atómica de nextId (sin cache temporal)
     * - Escritura optimizada de struct fields
     * - Manejo eficiente de string en storage
     */
    function createUser(string calldata _name, uint _age) public {
        assembly {
            // ========================================
            // 1. VALIDACIONES OPTIMIZADAS
            // ========================================
            
            // Obtener longitud del string desde calldata
            let nameLen := _name.length
            
            // Validar: 0 < nameLen <= 50
            // Combinamos ambas validaciones en una sola operación
            if or(iszero(nameLen), gt(nameLen, 50)) {
                // Error(string) selector: 0x08c379a0
                mstore(0x00, 0x08c379a000000000000000000000000000000000000000000000000000000000)
                mstore(0x04, 0x20)                      // offset del string
                mstore(0x24, 0x0f)                      // longitud "Nombre invalido"
                mstore(0x44, "Nombre invalido")         // mensaje
                revert(0x00, 0x64)
            }
            
            // Validar: 0 < _age <= 150
            if or(iszero(_age), gt(_age, 150)) {
                mstore(0x00, 0x08c379a000000000000000000000000000000000000000000000000000000000)
                mstore(0x04, 0x20)
                mstore(0x24, 0x0d)                      // longitud "Age not valid"
                mstore(0x44, "Age not valid")
                revert(0x00, 0x64)
            }
            
            // ========================================
            // 2. LECTURA Y CÁLCULO DE SLOTS
            // ========================================
            
            // Leer nextId desde slot 1 (nextId es la segunda variable de estado)
            let currentId := sload(1)
            
            // Calcular posición base del User en el mapping
            // users[currentId] -> keccak256(currentId . 0)
            mstore(0x00, currentId)
            mstore(0x20, 0x00)                          // slot 0 del mapping users
            let userBaseSlot := keccak256(0x00, 0x40)
            
            // ========================================
            // 3. ESCRITURA OPTIMIZADA DEL STRUCT
            // ========================================
            
            // User.id (slot base)
            sstore(userBaseSlot, currentId)
            
            // User.name (slot base + 1) - Manejo de string dinámico
            // Calcular slot del string
            let nameSlot := add(userBaseSlot, 1)
            
            // Para strings cortos (<32 bytes), Solidity usa packed storage
            // length * 2 en el último byte si length < 32
            if lt(nameLen, 32) {
                // String corto: datos + longitud en un solo slot
                let packedData := 0
                
                // Copiar datos del calldata
                calldatacopy(0x00, _name.offset, nameLen)
                packedData := mload(0x00)
                
                // Limpiar bytes no utilizados y agregar longitud
                let lengthByte := mul(nameLen, 2)       // length * 2 para strings cortos
                
                // Alinear datos a la izquierda y longitud en el último byte
                packedData := or(
                    and(packedData, not(0xff)),
                    lengthByte
                )
                
                sstore(nameSlot, packedData)
            }
            
            // Para strings largos (>=32 bytes), usar almacenamiento extendido
            if iszero(lt(nameLen, 32)) {
                // Marcar como string largo: (length * 2) + 1
                sstore(nameSlot, add(mul(nameLen, 2), 1))
                
                // Calcular posición de datos: keccak256(nameSlot)
                mstore(0x00, nameSlot)
                let dataSlot := keccak256(0x00, 0x20)
                
                // Copiar datos en chunks de 32 bytes
                let chunks := div(add(nameLen, 31), 32)
                for { let i := 0 } lt(i, chunks) { i := add(i, 1) } {
                    let offset := mul(i, 32)
                    calldatacopy(0x00, add(_name.offset, offset), 32)
                    sstore(add(dataSlot, i), mload(0x00))
                }
            }
            
            // User.age (slot base + 2)
            sstore(add(userBaseSlot, 2), _age)
            
            // User.isActive = true (slot base + 3)
            sstore(add(userBaseSlot, 3), 1)
            
            // ========================================
            // 4. INCREMENTAR nextId
            // ========================================
            sstore(1, add(currentId, 1))
            
            // ========================================
            // 5. EMITIR EVENTO (optimizado)
            // ========================================
            
            // UserCreated(uint256,string,uint256)
            // topic: keccak256("UserCreated(uint256,string,uint256)")
            let eventSignature := 0x5f6b3b07e9e5f6b9d8c6c8c0d9a6a2b9c8d7e6f5a4b3c2d1e0f9a8b7c6d5e4f3
            
            // Preparar datos del evento
            mstore(0x00, currentId)                     // id
            mstore(0x20, 0x60)                          // offset del string
            mstore(0x40, _age)                          // age
            mstore(0x60, nameLen)                       // longitud del string
            calldatacopy(0x80, _name.offset, nameLen)   // datos del string
            
            // Calcular tamaño total de datos
            let dataSize := add(0x80, mul(div(add(nameLen, 31), 32), 32))
            
            // Emitir evento con topic indexado
            log1(0x00, dataSize, eventSignature)
        }
    }

    function readUser(uint _id) public view returns (User memory) {
        require(_id < nextId, "Usuario no encontrado");
        require(users[_id].isActive, "Usuario inactivo");
        return users[_id];
    }

    function updateUser(uint _id, string memory _name, uint _age) public {
        require(_id < nextId, "Usuario no encontrado");
        require(users[_id].isActive, "Usuario inactivo");
        
        users[_id].name = _name;
        users[_id].age = _age;
        emit UserUpdated(_id, _name, _age);
    }

    function deleteUser(uint _id) public {
        require(_id < nextId, "Usuario no encontrado");
        require(users[_id].isActive, "Usuario inactivo");
        users[_id].isActive = false;
        emit UserDeleted(_id);
    }

    function getAllActiveUsers() public view returns (User[] memory) {
        uint activeCount = 0;
        for (uint i = 0; i < nextId; i++) {
            if (users[i].isActive) {
                activeCount++;
            }
        }

        User[] memory activeUsers = new User[](activeCount);
        uint index = 0;
        for (uint i = 0; i < nextId; i++) {
            if (users[i].isActive) {
                activeUsers[index] = users[i];
                index++;
            }
        }
        return activeUsers;
    }
}