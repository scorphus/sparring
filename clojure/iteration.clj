(dotimes [i 3]
  (prn i))

(println)
(doseq [n (range 3)]
  (prn n))
(println)
(doseq [n (range 3 6)]
  (prn n))

(println)
(doseq [letter [:a :b :c]
        number (range 3)]
  (prn [letter number]))
(println)
(doseq [letter [:a :b :c]
        number (range 3 6)]
  (prn [letter number]))
(println)
(doseq [letter [:a :b :c]
        number (range 5)]
  (prn [letter number]))

(println (for [letter [:a :b]
               number (range 3)]
           [letter number]))
