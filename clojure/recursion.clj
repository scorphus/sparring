(def foo (loop [i 2]
           (if (> (rem i 359) 0)
             (recur (+ i 2))
             (+ i 1))))
(println foo)

(defn increase [i]
  (if (<= i 10)
    (recur (inc i))
    i))

(println (increase 0))
