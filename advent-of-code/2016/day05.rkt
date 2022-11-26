#lang racket/base

(require file/md5
         racket/stream
         racket/string)

(module* main #f
  (let ([door-id "wtnhxymk"]) (printf "part 1: ~a~n" (part-1 door-id))))

(define (part-1 door-id)
  (string-join
   (stream->list
    (stream-take (for/stream ([i (in-naturals)]
                              #:do [(define door-id-i (string-append door-id (number->string i)))
                                    (define hash (bytes->string/utf-8 (md5 door-id-i)))]
                              #:when (string-prefix? hash "00000"))
                             (substring hash 5 6))
                 8))
   ""))

(module+ test
  (require rackunit
           rackunit/text-ui)

  (define suite
    (test-suite "day 5 tests" (test-equal? "part 1 with sample input" (part-1 "abc") "18f47a30")))

  (run-tests suite))
