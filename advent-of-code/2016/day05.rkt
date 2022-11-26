#lang racket/base

(require file/md5
         racket/stream
         racket/string)

(module* main #f
  (let* ([door-id "wtnhxymk"])
    (printf "part 1: ~a~n" (part-1 door-id))
    (printf "part 2: ~a~n" (part-2 door-id))))

(define (part-1 door-id)
  (string-join (stream->list
                (stream-take (for/stream ([hash (generate-hashes door-id)]) (substring hash 5 6)) 8))
               ""))

(define (part-2 door-id)
  (define seen-indexes (make-hash))
  (string-join
   (map cadr
        (sort (stream->list
               (stream-take (for/stream ([hash (generate-hashes door-id)]
                                         #:do [(define index (string->number (substring hash 5 6)))]
                                         #:when (and (number? index)
                                                     (<= 0 index 7)
                                                     (not (hash-has-key? seen-indexes index))
                                                     (string-prefix? hash "00")))
                                        (hash-set! seen-indexes index #t)
                                        (list index (substring hash 6 7)))
                            8))
              (λ (u v) (< (car u) (car v)))))
   ""))

(define (generate-hashes door-id)
  (for/stream ([i (in-naturals)] #:do [(define door-id-i (string-append door-id (number->string i)))
                                       (define hash (bytes->string/utf-8 (md5 door-id-i)))]
                                 #:when (string-prefix? hash "00000"))
              hash))

(module+ test
  (require rackunit
           rackunit/text-ui)

  (define suite
    (test-suite "day 5 tests"
                (test-equal? "part 1 with sample input" (part-1 "abc") "18f47a30")
                (test-equal? "part 2 with sample input" (part-2 "abc") "05ace8e3")))
  (run-tests suite))
