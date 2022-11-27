#lang racket

(module+ test
  (require rackunit)
  (define ε 1e-10))

(provide drop
         to-energy)

(define (drop t)
  (* 1/2 9.8 t t))

(module+ test
  (check-= (drop 0) 0 ε)
  (check-= (drop 10) 490 ε))

(define (to-energy m)
  (* m (expt 299792458.0 2)))

(module+ test
  (check-= (to-energy 0) 0 ε)
  (check-= (to-energy 1) 9e+16 1e+15))

(module* main #f
  (printf "~s\n" (to-energy 1))
  (printf "~s\n" (to-energy 1)))
