#lang racket/base

(require racket/file
         racket/function
         racket/list
         racket/string)

(module* main #f
  (let ([lines (file->lines "day06.txt")])
    (printf "part 1: ~a~n" (part-1 lines))
    (printf "part 2: ~a~n" (part-2 lines))))

(define (part-1 lines)
  (produce-error-corrected-message lines argmax))

(define (part-2 lines)
  (produce-error-corrected-message lines argmin))

(define (produce-error-corrected-message lines predicate)
  (list->string (map (compose car (curry predicate cdr) hash->list)
                     (for/fold ([count-maps (make-list (string-length (first lines)) #hash())]
                                #:result count-maps)
                               ([line lines])
                       (map (curryr hash-update add1 0) count-maps (string->list line))))))

(module+ test
  (require rackunit
           rackunit/text-ui)

  (define sample
    (list "eedadn"
          "drvtee"
          "eandsr"
          "raavrd"
          "atevrs"
          "tsrnev"
          "sdttsa"
          "rasrtv"
          "nssdts"
          "ntnada"
          "svetve"
          "tesnvt"
          "vntsnd"
          "vrdear"
          "dvrsen"
          "enarar"))

  (define suite
    (test-suite "day 6 tests"
                (test-equal? "part 1 with sample input" (part-1 sample) "easter")
                (test-equal? "part 2 with sample input" (part-2 sample) "advent")))

  (run-tests suite))
