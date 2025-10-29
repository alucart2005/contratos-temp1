// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract UserCrud {
    struct User {
        uint id;
        string name;
        uint age;
        bool isActive;
    }

    mapping ( uint => User ) public users;  // function users(uint id) public view returns (User memory)
    uint private nextId;
    event UserCreated(uint id, string name, uint age);
    event UserUpdated(uint id, string name, uint age);
    event UserDeleted(uint id);

    function createUser(string memory _name, uint _age) public {
        require(bytes(_name).length > 0 && bytes(_name).length <= 50, "Nombre invalido");
        require(_age > 0 && _age <= 150, "Age not valid");

        uint id = nextId;
        users[id] = User(id, _name, _age, true);
        emit UserCreated(nextId, _name, _age);
        nextId++;
    }

    function readUser(uint _id) public view returns (User memory){
        require(_id < nextId, "Usuario no encontrado");
        require(users[_id].isActive, "Usuario inactivo");

        return users[_id];
    }

    function updateUser(uint _id, string memory _name, uint _age) public {
        require(_id < nextId, "Usuario no encontrado");
        require(users[_id].isActive, "Usuario inactivo");

        /*Crea una referencia directa al usuario en el storage del contrato
        Al usar storage, cualquier cambio en user se refleja directamente en users[_id]
        pero se puede reemplazar mucho mejor por:
            users[_id].name = _name;  // ✅ Acceso directo
            users[_id].age = _age;    // ✅ Acceso directo
        */
        User storage user = users[_id];
        user.name = _name;
        user.age = _age;
        emit UserUpdated(_id, _name, _age);
    }

    function deleteUser(uint _id) public  {
        require(_id < nextId, "Usuario no encontrado");
        require(users[_id].isActive, "Usuario inactivo");
        users[_id].isActive = false;
        emit UserDeleted(_id);
    }

    function getAllActiveUsers() public view returns (User[] memory) {
        uint activeCount = 0;
        for (uint i=0; i < nextId; i++) {
            if (users[i].isActive) {
                unchecked {activeCount++;}
            }
        }

        User[] memory activeUsers = new User[](activeCount);
        uint index = 0;
        for (uint i=0; i < nextId; i++) {
            if (users[i].isActive) {
                activeUsers[index] = users[i];
                unchecked {index++;}
            }
        }
        return activeUsers;
    }
}