(define (even? n)
    (= (remainder n 2) 0)
)
(define
    (exp b n)
    (cond
        ((= n 0) 1)
        ((even? n) (square (exp b (/ n 2))))
        (else (* b (exp b (- n 1))))    
    )    
)

(define (nmult n)
    (cond
        ((= n 0) 0)
        ((even? n)
            (+ 1 (nmult (/ n 2)))
        )
        (else
            (+ 1 (nmult (- n 1)))
        )
    )
)

; Wrong algorithm
; (define
;     (exp b n)
;     (cond
;         ((= n 0) 1)
;         ((even? n)
;             (*
;                 (exp b (/ n 2))
;                 (exp b (/ n 2))
;             )
;         )
;         (else (* b (exp b (- n 1))))    
;     )    
; )
; 
; (define (nmult n)
;     (cond
;         ((= n 0) 0)
;         ((even? n)
;             (+ 1 (nmult (/ n 2)) (nmult (/ n 2)))
;         )
;         (else
;             (+ 1 (nmult (- n 1)))
;         )
;     )
; )