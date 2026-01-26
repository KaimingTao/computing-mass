; Quadriac equation, Exercise M 1.7
(define smallest-real-part 
    (lambda (a b c)
        (define 2a (* 2 a))
        (define real-part
            (/
                (- b)
                2a
            )
        )
        (define descriminant
            (-
                (* b b)
                (* 4 a c)
            )
        )
        (define is-real?
            (cond
                ((> descriminant 0) #t)
                ((= descriminant 0) #t)
                ((< descriminant 0) #f)
            )
        )
        (cond
            (is-real?
                (define sqrt-descriminant (sqrt descriminant))
                (define other-part (/ sqrt-descriminant 2a))

                (define root-1 (+ real-part other-part))
                (define abs-root-1 (abs root-1))
                (define root-2 (- real-part other-part))
                (define abs-root-2 (abs root-2))

                (if (> abs-root-1 abs-root-2)
                    abs-root-2
                    abs-root-1 ;one pitfall is that the absolute values are same
                )
            )
            (else real-part)
        )
    )
)

; Test
(smallest-real-part 1 2 3)
(smallest-real-part 1 0 0)
(smallest-real-part 1 2 0)
(smallest-real-part 1 0 3)
(smallest-real-part 1 0 -2)