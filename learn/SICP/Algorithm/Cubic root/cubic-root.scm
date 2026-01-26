; SICP Exercise 1.8

; Pre-requirements
(define (square x) (* x x))
(define (abs x)
    (if (< x 0)
        (- x)
        x
    )
)

; Cubic root
(define (cbrt n)
    (define
        (improve guess)
        (/
            (+
                (/
                    n
                    (square guess)
                )
                (* 2 guess)
            )
            3
        )
    )
    (define (good-enough? guess improved-guess)
        (< 
            (abs
                (- guess improved-guess)
            )
            0.001
        )
    )
    (define (iter guess previous-guess)
        (if (good-enough? guess previous-guess)
            guess
            (iter (improve guess) guess)
        )
    )
    (iter 1.0 0)
)

; Test
(cube-root 27)