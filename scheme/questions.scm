(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
  (map (lambda (s) (append (list first) s)) rests)
)

(define (zip pairs)
  (list (map car pairs) (map cadr pairs))
)

;; Problem 16
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 16
  (define (helper i s)
    (if (null? s)
      nil
      (cons (list i (car s))
            (helper (+ i 1) (cdr s)))
    )
  )
  (helper 0 s)
)
  ; END PROBLEM 16

;; Problem 17
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 17
;  (if (or (null? denoms) (<= total 0))
;    nil
;  )
;  (if (< total (car denoms))
;    (list-change total (cdr denoms))
;  )
;  (if (= total (car denoms))
;    (append (list total) (list-change total (cdr denoms)))
;  )
;  (if (> total (car denoms))
;    (begin
;      (define insert-all (cons-all (car denoms) (list-change (- total (car denoms)) denoms)))
;      (list-change total (cdr denoms))
;    )
;  )
  (cond ((null? denoms) nil)
        ((<= total 0) nil)
        ((< total (car denoms)) (list-change total (cdr denoms)))
        ((= total (car denoms)) (append (list (list total)) (list-change total (cdr denoms))))
        ((> total (car denoms))
          (begin
            (define insert-all (cons-all (car denoms) (list-change (- total (car denoms)) denoms)))
            (append insert-all (list-change total (cdr denoms)))
          )
        )
  )
)
  ; END PROBLEM 17

;; Problem 18
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 18
         expr
         ; END PROBLEM 18
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 18
         expr
         ; END PROBLEM 18
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
           (append (list form params) (map let-to-lambda body))
           ; END PROBLEM 18
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
           (let ((form (map let-to-lambda (cadr (zip values))))
                 (params (car (zip values)))
                 (body (map let-to-lambda body)))
                 (cons (append (list 'lambda params) body) form)
           )
           ; END PROBLEM 18
           ))
        (else
         ; BEGIN PROBLEM 18
         (map let-to-lambda expr)
         ; END PROBLEM 18
         )))
