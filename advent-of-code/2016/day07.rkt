#lang racket/base

(require racket/file
         racket/list
         racket/string)

(module* main #f
  (let ([lines (file->lines "day07.txt")])
    (printf "part 1: ~a~n" (part-1 lines))
    (printf "part 2: ~a~n" (part-2 lines))))

(define (part-1 lines)
  (for/sum ([ip (map parse-ip lines)] #:when (supports-tls? ip)) 1))

(define (part-2 lines)
  "part 2")

(define (parse-ip line)
  (string-split line #rx"[][]"))

(define (supports-tls? ip)
  (let ([groups (group-by (compose even? second) (map list ip (range (length ip))))])
    (and (not (ormap (compose is-abba? first) (second groups)))
         (ormap (compose is-abba? first) (first groups)))))

(define (is-abba? string)
  (for/fold ([a ""] [b ""] [c ""] [it´s-abba #f] #:result it´s-abba) ([d string] #:break it´s-abba)
    (values b c d (and (not (eq? a c)) (eq? a d) (eq? b c)))))

(module+ test
  (require rackunit
           rackunit/text-ui)

  (define sample (list "abba[mnop]qrst" "abcd[bddb]xyyx" "aaaa[qwer]tyui" "ioxxoj[asdfgh]zxcvbn"))
  (define another-sample
    (list "abba[mnop]qrst"
          "abcd[bddb]xyyx"
          "aaaa[qwer]tyui"
          "ioxxoj[asdfgh]zxcvbn"
          "abba[abcd]abcd[abba]abcd"
          "abcd[abcd]abcd[abcd]abcd[abcd]abba"))

  (define suite
    (test-suite "day 7 tests"
                (test-equal? "part 1 with sample input" (part-1 sample) 2)
                (test-equal? "part 1 with another sample input" (part-1 another-sample) 3)
                (test-equal? "part 2 with sample input" (part-2 sample) "part 2")))

  (run-tests suite))
