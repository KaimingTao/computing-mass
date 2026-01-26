## Lambda Calculus

### extensional equality

In Lambda calculus, any two function is the same, $iff$ the input is the same and the output is the same. They're interchangeable.

## Church encoding

[Church encoding](https://en.wikipedia.org/wiki/Church_encoding) reflects how **Set Theory** could be actually used to design a computer system

## Fizzbuzz

- [Using FizzBuzz to Find Developers who Grok Coding](https://imranontech.com/2007/01/24/using-fizzbuzz-to-find-developers-who-grok-coding/)
- https://www.reddit.com/comments/10d7w

### The semantics

(1..100).each do |n|
  if (n % 15).zero?
    'FizzBuzz'
  elsif (n % 3).zero?
    'Fizz'
  elsif (n % 5).zero?
    'Buzz'
  else
    n.to_s
  end
end

### Natural number

The idea of natural number is from **Counting**(the verb), any two different types of objects, if doing counting equally and get the same result, would mean have the same name.

So just change the verb **Counting** to an abstract **Object** we get the definition of natural number.

So another way to think about axiomatic approach is, they're trying to find how original idea created.

**Counting** also means the iteration of counting


def zero(counting, x)
  x
end

def one(counting, x)
  counting(counting(x))
end

def two(counting, x)
  counting(counting(counting(x)))
end


ZERO  = -> c { -> x {       x    } }
ONE   = -> c { -> x {     c[x]   } }
TWO   = -> c { -> x {   c[c[x]]  } }
THREE = -> c { -> x { c[c[c[x]]] } }


## Translate meaning to Computer
## The ruby number literal & Our new representation gets the same result

def to_integer(number)
  counting = -> n { n + 1}
  number[counting][0]
end
  
puts to_integer(ZERO)
puts to_integer(ONE)
puts to_integer(TWO)
puts to_integer(THREE)



FIVE    = -> p { -> x { p[p[p[p[p[x]]]]] } }
FIFTEEN = -> p { -> x { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]] } }
HUNDRED = -> p { -> x { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]] } }

puts to_integer(FIVE)
puts to_integer(FIFTEEN)
puts to_integer(HUNDRED)


## Boolean

Actually boolean value has no meaning of true or false, they're just two different value. For one we use to denote the meaning of true, other false. The key point is the process we use them.

So the definition is **a choice between two values**

TRUE  = -> x { -> y { x } }
FALSE = -> x { -> y { y } }


def to_boolean(boolean)
  boolean[true][false]
end

puts to_boolean(TRUE)
puts to_boolean(FALSE)


IF =
  -> b {
    -> x {
      -> y {
        b[x][y]
      }
    }
  }


if defined? IF
  Object.send(:remove_const, :IF)
end

IF = -> b { b }


PAIR  = -> x { -> y { -> f { f[x][y] } } }
LEFT  = -> p { p[-> x { -> y { x } } ] }
RIGHT = -> p { p[-> x { -> y { y } } ] }

INCREMENT = -> n { -> p { -> x { p[n[p][x]] } } }

SLIDE     = -> p { PAIR[RIGHT[p]][INCREMENT[RIGHT[p]]] }
DECREMENT = -> n { LEFT[n[SLIDE][PAIR[ZERO][ZERO]]] }

to_integer(DECREMENT[FIVE])

ADD      = -> m { -> n { n[INCREMENT][m] } }
SUBTRACT = -> m { -> n { n[DECREMENT][m] } }
MULTIPLY = -> m { -> n { n[ADD[m]][ZERO] } }
POWER    = -> m { -> n { n[MULTIPLY[m]][ONE] } }

- https://en.wikipedia.org/wiki/Monus
- https://en.wikipedia.org/wiki/Monoid#Commutative_monoid
- https://en.wikipedia.org/wiki/Abelian_group


IS_LESS_OR_EQUAL =
  -> m { -> n {
    IS_ZERO[SUBTRACT[m][n]]
  } }


## Y-Combinator

- https://en.wikipedia.org/wiki/Fixed-point_combinator#Fixed_point_combinators_in_lambda_calculus


Z = -> f { -> x { f[-> y { x[x][y] }] }[-> x { f[-> y { x[x][y] }] }] }


MOD =
  Z[-> f { -> m { -> n {
    IF[IS_LESS_OR_EQUAL[n][m]][
      -> x {
        f[SUBTRACT[m][n]][n][x]
      }
    ][
      m
    ]
  } } }]
