
(define (>= x y)
    (or
        (> x y)
        (= x y)
    )
)

(define (>= x y)
    (not (< x y))
)


(define x 10)
(define y 8)
(>= x y)


(define (>= a b)
    (not
        (< a b)
    )
)
