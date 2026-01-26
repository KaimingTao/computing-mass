# Builtin

## Primitive types

- int
    - `Integer.parseInt`
    - 32 bits
    - operations
        - sign
        - add
        - subtract
        - multiply
        - divide
            - negative dividor, different with Python
            - run-time Exception, 1/0, only in integer number not float number
        - remainder
            - negative dividor, different with Python
    - overflow
        - Math.abs(-2147483648)
    - boundary condition
- long
- short
- byte
- double
    - literal
        - `6.022e23`
    - `Math` library
    - issue of precision
    - `Infinity`
    - `NaN`
    - 15 significant digits
    - IEEE 754
- float
    - 7 digits
- boolean
    - `true`
    - `false`
- Char
    - 2**16 possible char values
        - Unicode
    - escape sequence

## String

- concatenation
    - automatic conversion
- issue
    - input long string can't fit into a line
