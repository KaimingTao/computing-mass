; please think about test code
; I believe the test should only cover the there branches, and marginal conditions
; The marginal conditions include 
(define (abs x)
    (if (< x 0)
        (- x)
        x
    )
)