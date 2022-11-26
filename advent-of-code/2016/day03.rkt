#lang racket/base

(require racket/file
         racket/string)

(module* main #f
  (let ([lines (file->lines "day03.txt")])
    (printf "part 1: ~a~n" (part-1 lines))
    (printf "part 2: ~a~n" (part-2 lines))))

(define (part-1 lines)
  (for/sum ([l lines]) (let-values ([(a b c) (parse-triangle l)]) (one-if-triangle a b c))))

(define (part-2 lines)
  (for/fold ([sum 0] [t1 '()] [t2 '()] [t3 '()] #:result sum) ([l lines])
    (let*-values
        ([(a b c) (parse-triangle l)] [(t1) (cons a t1)] [(t2) (cons b t2)] [(t3) (cons c t3)])
      (if (= 3 (length t1))
          (values
           (+ sum (apply one-if-triangle t1) (apply one-if-triangle t2) (apply one-if-triangle t3))
           '()
           '()
           '())
          (values sum t1 t2 t3)))))

(define (parse-triangle line)
  (apply values (map string->number (string-split line))))

(define (one-if-triangle a b c)
  (if (and (< a (+ b c)) (< b (+ a c)) (< c (+ a b))) 1 0))

(module+ test
  (require rackunit
           rackunit/text-ui)

  (define sample
    (list "101 301 501" "102 302 502" "103 303 503" "201 401 601" "202 402 602" "203 403 603"))

  (define suite
    (test-suite "day 3 tests"
                (test-equal? "part 1 with sample input" (part-1 sample) 3)
                (test-equal? "part 2 with sample input" (part-2 sample) 6)))

  (run-tests suite))
