(define
    (move-tower size from to extra)

    (define
        (print-move from to)
        (newline)
        (display "move top disk from ")
        (display from)
        (display " to ")
        (display to)
    )

    (cond
        ((= size 0) #t)
        (else
            (move-tower (- size 1) from extra to)
            (print-move from to)
            (move-tower (- size 1) extra to from)
        )
    )
)