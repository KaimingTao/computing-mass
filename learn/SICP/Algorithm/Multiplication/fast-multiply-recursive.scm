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
    (cond
        ((= 0 b)
            0
        )
        ((even? b)
            (* (double a) (halve b))
        )
        (else
            (+ a (* a (- b 1)))
        )
    )
)