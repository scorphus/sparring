(ns day-17-part-1)

(defn parse-input
  [input]
  (let [[low-x upp-x low-y upp-y] (map #(Integer/parseInt %) (re-seq #"-?\d+" input))]
    [low-x upp-x low-y upp-y]))

(defn find-max-y
  [x y dx dy upp-x low-y max-y]
  (if (or (> x upp-x) (< y low-y)) max-y
      (recur
       (+ x dx) (+ y dy)
       (if (> dx 0) (dec dx) dx) (dec dy)
       upp-x low-y
       (max y max-y))))

(defn solve
  [] (let [[_ upp-x low-y _] (parse-input (slurp "day-17.txt"))]
       (reduce
        (fn [ans dx]
          (first
           (reduce
            (fn [[ans dx] dy]
              [(find-max-y 0 0 dx dy upp-x low-y ans) dx])
            [ans dx]
            (range (- low-y)))))
        0
        (range 1 (inc upp-x)))))

(println (solve))
