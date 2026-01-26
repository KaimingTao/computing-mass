(define (double n)
    (+ n n)
)

(define (even? n)
    (= (remainder n 2) 0)
)

(define (halve n)
    (/ n 2)
)

(define (* a b)
    (define (iter x y n)
        (cond
            ((= 0 n)
                x
            )
            ((even? n)
                (iter x (double y) (halve n))
            )
            (else
                (iter (+ x y) y (- n 1))
            )
        )
    )
    (iter 0 a b)
)