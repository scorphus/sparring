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
  (for/sum ([ip (map parse-ip lines)] #:when (supports-ssl? ip)) 1))

(define (parse-ip line)
  (string-split line #rx"[][]"))

(define (supports-tls? ip)
  (let ([groups (group-by (compose even? second) (map list ip (range (length ip))))])
    (and (not (ormap (compose is-abba? first) (second groups)))
         (ormap (compose is-abba? first) (first groups)))))

(define (is-abba? string)
  (for/fold ([a ""] [b ""] [c ""] [it´s-abba #f] #:result it´s-abba) ([d string] #:break it´s-abba)
    (values b c d (and (not (eq? a c)) (eq? a d) (eq? b c)))))

(define (supports-ssl? ip)
  (let* ([groups (group-by (compose even? second) (map list ip (range (length ip))))]
         [supernets (flatten (filter-not empty? (map (compose take-aba first) (first groups))))]
         [hypernets (flatten (filter-not empty? (map (compose take-aba first) (second groups))))])
    (ormap corresponding? (cartesian-product supernets hypernets))))

(define (take-aba string)
  (for/fold ([a ""] [b ""] [aba-list '()] #:result aba-list) ([c string])
    (let ([is-aba (and (not (eq? a b)) (eq? a c))])
      (values b c (if is-aba (cons (list->string (list a b c)) aba-list) aba-list)))))

(define (corresponding? aba-bab)
  (equal? (substring (first aba-bab) 0 2) (substring (second aba-bab) 1 3)))

(module+ test
  (require rackunit
           rackunit/text-ui)

  (define sample-1 (list "abba[mnop]qrst" "abcd[bddb]xyyx" "aaaa[qwer]tyui" "ioxxoj[asdfgh]zxcvbn"))
  (define another-sample
    (list "abba[mnop]qrst"
          "abcd[bddb]xyyx"
          "aaaa[qwer]tyui"
          "ioxxoj[asdfgh]zxcvbn"
          "abba[abcd]abcd[abba]abcd"
          "abcd[abcd]abcd[abcd]abcd[abcd]abba"))
  (define sample-2 (list "aba[bab]xyz" "xyx[xyx]xyx" "aaa[kek]eke" "zazbz[bzb]cdb"))
  (define another-sample-2
    (list "aba[bab]xyz"
          "xyx[xyx]xyx"
          "aaa[kek]eke"
          "zazbz[bzb]cdb"
          "xyx[xyx]zazbz[bzb]cdb"
          "aaa[kek]xyx[xyx]zazbz[bzb]cdb"))

  (define suite
    (test-suite "day 7 tests"
                (test-equal? "part 1 with sample input" (part-1 sample-1) 2)
                (test-equal? "part 1 with another sample input" (part-1 another-sample) 3)
                (test-equal? "part 2 with sample input" (part-2 sample-2) 3)
                (test-equal? "part 2 with sample input" (part-2 another-sample-2) 5)))

  (run-tests suite))
