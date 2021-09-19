;; A geometric series is the sum of the numbers in a geometric progression:
;; a * (1 − r^n ) / (1 − r)

(def a 1)
(def r 2)
(def n 7)
(->>
 (quot
  (* a (- 1 (Math/pow r n)))
  (- 1 r))
 (println))
