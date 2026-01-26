; Compound predicates
(and
    (> x 5)
    (< x 10)
)
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



(define (square x)
    (* x x)
)
; (square 3)

(define (sign x)
    (cond
        ((< x 0) -1)
        ((= x 0) 0)
        ((> x 0) 1)
    )
)

(define (>= a b)
    (not
        (< a b)
    )
)

(define
    (average x y)
    (/
        (+ x y)
        2
    )
)
