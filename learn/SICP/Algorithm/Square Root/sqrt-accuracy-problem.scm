; Pre-requirements
(define
    (average x y)
    (/
        (+ x y)
        2
    )
)
(define (square x) (* x x))
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
    (define (good-enough? guess)
        (display guess)
        (<
            (abs
                (- (square guess) n)
            )
            0.001
        )
    )
    (define (iter guess)
        (if (good-enough? guess)
            guess
            (iter (improve guess))
        )
    )
    (iter 1.0)
)

; Test
(sqrt 9)



;Problem Analsysis
; Exercise 1.7
; (define
;     (good-enough? guess x)
;     (<
;         (abs
;             (- (square guess) x)
;         )
;         0.001
;     )
; )
; for small numbers
; try (sqrt 0.00001), the tolerance of 0.001 is too large.
; Even for 0, the algorithm would stop at 0.03125
; for large numbers
; try (sqrt 123456789012345678901234567890),
; the tolerance is too small,
; float point number representation can't narrow down the difference.
; So either it stops the improvement of the guess too early,
; or it can't improve the guess anymore and stuck in loop.
; _TODO_, Deep study this issue.
; _TODO_, Which is the smallest number that stops at some intolerable state, error rate
; _TODO_, Which is the number started to go into infinite loop?
; _TODO_, evalutate Convergence
; how to debug the code?

; this function won't work for very big numbers or very small numbers

; wont stop
(sqrt 100000000000000)
