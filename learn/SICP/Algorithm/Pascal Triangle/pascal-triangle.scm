(define
    (pascal-triangle row col)
    (cond
        ((= col 1) 1)
        ((= col row) 1)
        ((> col row) (print "Not in triangle"))
        (else
            (+
                (pascal-triangle (- row 1) col)
                (pascal-triangle (- row 1) (- col 1))
            )
        )
    )
)

; not fully solved, should print it
