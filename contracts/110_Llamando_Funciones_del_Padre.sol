// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/*
LLamando funciones de padre
    direct
    super

    E
 /    \
F      G
 \    /
   H

*/


contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.fu Original");
    }

    function bar() public virtual  {
        emit Log("E.fu Original");
    }
}

contract F is E {
    function foo() public override virtual {
        emit Log("F.fu Sobreescrita en F");
        E.foo();  // LLamada directa
    }

    function bar() public override virtual  {
        emit Log("F.fu Sobreescrita en F");
        super.bar();  // Lammada con super
    }
}


contract G is E {
    function foo() public override virtual {
        emit Log("G.fu Sobreescrita en G");
        E.foo();  // LLamada directa
    }

    function bar() public override virtual {
        emit Log("G.fu Sobreescrita en G");
        super.bar();  // Lammada con super
    }
}

contract H is F, G {
    function foo() public override(F, G) {
        F.foo();  // LLamada directa
        G.foo();
    }

    function bar() public override(F, G)  {
        super.bar();  // LLamada con super
    }
}

