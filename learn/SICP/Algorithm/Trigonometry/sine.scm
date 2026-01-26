; SICP Exercise 1.15
(define
    (sine angle)
    (define (cube x) (* x x x))
    (define (p x)
        (-
            (* 3 x)
            (* 4 (cube x))
        )
    )
    (if
        (not (> (abs angle) 0.1))
        angle
        (p (sine (/ angle 3.0)))
    )
)