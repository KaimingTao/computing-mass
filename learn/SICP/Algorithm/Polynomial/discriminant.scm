(define (average x y)
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

(define (min x y)
    (if (< x y) x y)
)

(define (smallest-real-part a b c)
    (define descriminant? (- (* b b) (* 4 a c)))

    (define sqrt-descriminant
        (cond
            ((> descriminant? 0) (sqrt descriminant?))
            ((= descriminant? 0) 0)
            ((< descriminant? 0) 0)
        )
    )

    (define root1 (
            /
            (+ (- b) sqrt-descriminant)
            (* 2 a)
        )
    )

    (define root2 (
            /
            (- (- b) sqrt-descriminant)
            (* 2 a)
        )
    )

    (cond
        ((> (abs root1) (abs root2)) root2)
        (else root1)
    )
)
