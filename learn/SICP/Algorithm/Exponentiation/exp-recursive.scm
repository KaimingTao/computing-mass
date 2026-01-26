(define
    (exp b n)
    (if (= n 0)
        1
        (* b (exp b (- n 1)))
    )    
)