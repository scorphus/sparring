(ns day-17-part-1)

(defn parse-input
  [input]
  (let [[low-x upp-x low-y upp-y] (map #(Integer/parseInt %) (re-seq #"-?\d+" input))]
    [low-x upp-x low-y upp-y]))

(defn count-hits
  [x y dx dy low-x upp-x low-y upp-y hits]
  (if (or (> x upp-x) (< y low-y)) hits
      (if (and (<= low-x x upp-x) (<= low-y y upp-y)) (inc hits)
          (recur
           (+ x dx) (+ y dy)
           (if (> dx 0) (dec dx) dx) (dec dy)
           low-x upp-x low-y upp-y
           hits))))

(defn solve
  [] (let [[low-x upp-x low-y upp-y] (parse-input (slurp "day-17.txt"))]
       (reduce
        (fn [ans dx]
          (first
           (reduce
            (fn [[ans dx] dy]
              [(count-hits 0 0 dx dy low-x upp-x low-y upp-y ans) dx])
            [ans dx]
            (range low-y (- low-y)))))
        0
        (range 1 (inc upp-x)))))

(println (solve))
