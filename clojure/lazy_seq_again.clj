(defrecord Square [x y])
(defrecord Delta [dx dy])
(defrecord SpiralMemory [memory square delta])

(defn make-spiral-memory
  ([]
   (make-spiral-memory {(->Square 0 0) 1} 0 0 0 -1))
  ([memory x y dx dy]
   (->SpiralMemory memory (->Square x y) (->Delta dx dy))))

(defn adj-nn [x, y] (->Square      x  (inc y)))
(defn adj-ne [x, y] (->Square (inc x) (inc y)))
(defn adj-ee [x, y] (->Square (inc x)      y))
(defn adj-se [x, y] (->Square (inc x) (dec y)))
(defn adj-ss [x, y] (->Square      x  (dec y)))
(defn adj-sw [x, y] (->Square (dec x) (dec y)))
(defn adj-ww [x, y] (->Square (dec x)      y))
(defn adj-nw [x, y] (->Square (dec x) (inc y)))

(defn adjacency
  [{{x :x y :y} :square
    {dx :dx dy :dy} :delta}]
  (case [dx dy]
    [0  1] [(adj-nw x y) (adj-ww x y) (adj-sw x y) (adj-ss x y)]
    [-1 0] [(adj-sw x y) (adj-ss x y) (adj-se x y) (adj-ee x y)]
    [0 -1] [(adj-se x y) (adj-ee x y) (adj-ne x y) (adj-nn x y)]
    [1  0] [(adj-ne x y) (adj-nn x y) (adj-nw x y) (adj-ww x y)]))

(defn write
  [{memory :memory
    square :square
    :as spiral-memory}]
  (->>
   (adjacency spiral-memory)
   (map #(get memory % 0))
   (reduce +)
   (assoc memory square)
   (assoc spiral-memory :memory)))

(defn walk
  [{memory :memory
    {x :x y :y} :square
    {dx :dx dy :dy} :delta}]
  (let [should-turn (or (= x y)
                        (and (pos? y) (zero? (+ x y)))
                        (and (<= y 0) (zero? (+ x y -1))))
        [dx dy] (if should-turn [(- dy) dx] [dx dy])]
    (make-spiral-memory memory (+ x dx) (+ y dy) dx dy)))

(defn write-squares
  ([]
   (write-squares (make-spiral-memory)))
  ([spiral-memory]
   (lazy-seq (cons spiral-memory (write-squares (write (walk spiral-memory)))))))

(defn get-square-value [{memory :memory square :square}] (get memory square))

(println (take 50 (map get-square-value (write-squares))))

(def after-747 (first (for [{memory :memory square :square} (write-squares)
                            :when (> (get memory square) 747)]
                        (get memory square))))

(assert (= after-747 806) (str "Actual: " after-747))
