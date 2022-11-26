#lang racket/base

(require racket/file)
(require racket/list)
(require racket/string)

(module* main #f
  (define lines (file->lines "day04.txt"))
  (printf "part 1: ")
  (part-1 lines)
  (printf "part 2: ")
  (part-2 lines "northpoleobjects"))

(define (part-1 lines)
  (for/sum ([room (map parse-room lines)])
           (if (is-real-room room) (string->number (car (cdr room))) 0)))

(define (part-2 lines lookup)
  (for/first ([room (map parse-room lines)]
              #:when (and (is-real-room room) (room-contains room lookup)))
    (string->number (car (cdr room)))))

(define (parse-room line)
  (reverse (string-split (string-replace line #rx"[][-]+" " "))))

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

(define (room-contains room lookup)
  (define sector-id (string->number (car (cdr room))))
  (define name (string-join (reverse (cdr (cdr room))) ""))
  (define decrypted-name (rotate name sector-id))
  (string-contains? decrypted-name lookup))

(define (rotate string n)
  (list->string (map (λ (c) (rotate-char c n)) (string->list string))))

(define (rotate-char char n)
  (integer->char (+ (char->integer #\a)
                    (modulo (+ (- (char->integer char) (char->integer #\a)) (modulo n 26)) 26))))

(module+ test
  (require rackunit
           rackunit/text-ui)

  (define sample-1
    (list "aaaaa-bbb-z-y-x-123[abxyz]"
          "a-b-c-d-e-f-g-h-987[abcde]"
          "not-a-real-room-404[oarel]"
          "totally-real-room-200[decoy]"))

  (define sample-2
    (list "aaaaa-bbb-z-y-x-123[abxyz]"
          "a-b-c-d-e-f-g-h-987[abcde]"
          "not-a-real-room-404[oarel]"
          "totally-real-room-200[decoy]"
          "qzmt-zixmtkozy-ivhz-343[zimth]"))

  (define suite
    (test-suite "day 4 tests"
                (test-equal? "part 1 with sample input" (part-1 sample-1) 1514)
                (test-equal? "part 2 with sample input" (part-1 sample-2) 1857)
                (test-equal? "part 2 with sample input" (part-2 sample-2 "veryencryptedname") 343)))

  (run-tests suite))
