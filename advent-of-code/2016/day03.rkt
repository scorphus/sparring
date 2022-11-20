#lang racket/base

(require racket/string)

(define (one-if-triangle a b c)
  (if (and (< a (+ b c)) (< b (+ a c)) (< c (+ a b))) 1 0))

(printf "part 1: ")

(call-with-input-file
 "day03.txt"
 (λ (port)
   (for/sum ([l (in-lines port)])
            (define-values (a b c) (apply values (map string->number (string-split l))))
            (one-if-triangle a b c))))

(printf "part 2: ")

(call-with-input-file
 "day03.txt"
 (λ (port)
   (for/fold ([sum 0] [t1 '()] [t2 '()] [t3 '()] #:result sum) ([l (in-lines port)])
     (define-values (a b c) (apply values (map string->number (string-split l))))
     (define t1´ (cons a t1))
     (define t2´ (cons b t2))
     (define t3´ (cons c t3))
     (if (= 3 (length t1´))
         (values
          (+ sum (apply one-if-triangle t1´) (apply one-if-triangle t2´) (apply one-if-triangle t3´))
          '()
          '()
          '())
         (values sum t1´ t2´ t3´)))))
