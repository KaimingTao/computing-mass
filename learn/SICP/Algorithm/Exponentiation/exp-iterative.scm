(define
    (exp b n)
    (define (iter counter product)
        (if (= n 0)
            product
            (iter
                (- counter 1)
                (* b product)
            )
        )
    )
    (iter b n 1)
)