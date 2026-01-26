(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))
    )
)


; _TODO_, how many remainder call, applicative order, logarithmic
; _TODO_, how many remainder call, normal order, linear