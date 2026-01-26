; Exercise M1.7, M1.8 (solution example)
(define power-close-to
    (lambda (b n)
        (define (power-it e)
            (if (> (expt b e) n)
                e
                (power-it (+ e 1))
            )
        )
        (power-it 1)
    )
)
