; Pre-requirements
(define
    (average x y)
    (/
        (+ x y)
        2
    )
)
(define (abs x)
    (if (< x 0)
        (- x)
        x
    )
)

; Square root
(define (sqrt n)
    (define (improve guess)
        (average
            guess
            (/ n guess)
        )

    )
    (define (good-enough? guess improved-guess)
        (<
            (abs
                (- guess improved-guess)
            )
            (/ 1 1000)
        )
    )
    (define (iter guess previous-guess)
        (if (good-enough? guess previous-guess)
            guess
            (iter (improve guess) guess)
        )
    )
    (iter 1 0)
)

; Test
(sqrt 9)
