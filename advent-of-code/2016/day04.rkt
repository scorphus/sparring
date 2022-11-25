#lang racket/base

(require racket/list)
(require racket/string)

(module* main #f
  (printf "part 1: ")
  (call-with-input-file "day04.txt" (λ (port) (part-1 (in-lines port)))))

(define (part-1 lines)
  (for/sum ([l lines])
           (define room (reverse (string-split (string-replace l #rx"[][-]+" " "))))
           (if (is-real-room room) (string->number (car (cdr room))) 0)))

(define (is-real-room room)
  (define checksum (car room))
  (define name (string-join (cdr (cdr room)) ""))
  (define letter-freq (count-letters name))
  (define sorted-letter-freq (sort (hash->list letter-freq) sort-letter-frequency))
  (define name-checksum (map car (take sorted-letter-freq 5)))
  (equal? (list->string name-checksum) checksum))

(define (count-letters string)
  (for/fold ([count-map #hash()] #:result count-map) ([c (string->list string)])
    (hash-update count-map c add1 0)))

(define (sort-letter-frequency s t)
  (if (= (cdr s) (cdr t)) (char<? (car s) (car t)) (> (cdr s) (cdr t))))

(module+ test
  (require rackunit
           rackunit/text-ui)

  (define sample-input
    (list "aaaaa-bbb-z-y-x-123[abxyz]"
          "a-b-c-d-e-f-g-h-987[abcde]"
          "not-a-real-room-404[oarel]"
          "totally-real-room-200[decoy]"))

  (define suite (test-suite "part 1 tests" (test-equal? "sample input" (part-1 sample-input) 1514)))

  (run-tests suite))
