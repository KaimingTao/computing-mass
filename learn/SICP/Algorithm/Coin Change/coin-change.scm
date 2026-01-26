; Example: Counting change
; To Accelarate this program some technics like _tabulation_ or _memorization_ should be perform
; _TODO_: Visualize this program
; _TODO_: Design a better algorithm than tree recursion
; _TODO_: implement "Smart Compiler", using memorization
(define count-change (lambda (amount)
    (define half-dollar 50)
    (define quarter 25)
    (define dime 10)
    (define nickel 5)
    (define penny 1)

    (define (cc amount kinds-or-coins)
        (define (first-denomination kinds-or-coins)
            (cond
                ((= kinds-or-coins 1) penny)
                ((= kinds-or-coins 2) nickel)
                ((= kinds-or-coins 3) dime)
                ((= kinds-or-coins 4) quarter)
                ((= kinds-or-coins 5) half-dollar)
            )
        )
        (cond
            ((= amount 0) 1)
            ((< amount 0) 0)
            ((= kinds-or-coins 0) 0)
            (else
                (+
                    (cc 
                        amount
                        (- kinds-or-coins 1))
                    (cc
                        (- amount (first-denomination kinds-or-coins))
                        kinds-or-coins)
                )
            )
        )
    )

    (cc amount 5)
))
(count-change 100)