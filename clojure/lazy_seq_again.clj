(defrecord Square [x y])
(defrecord Delta [dx dy])
(defrecord SpiralMemory [memory square delta next-turn steps])

(defn make-spiral-memory
  ([] (make-spiral-memory {(->Square 0 0) 1} 0 0 0 -1 0 0))
  ([memory x y dx dy next-turn steps]
   (->SpiralMemory memory (->Square x y) (->Delta dx dy) next-turn steps)))

(defn adj-nn [x, y] (->Square      x  (inc y)))
(defn adj-ne [x, y] (->Square (inc x) (inc y)))
(defn adj-ee [x, y] (->Square (inc x)      y))
(defn adj-se [x, y] (->Square (inc x) (dec y)))
(defn adj-ss [x, y] (->Square      x  (dec y)))
(defn adj-sw [x, y] (->Square (dec x) (dec y)))
(defn adj-ww [x, y] (->Square (dec x)      y))
(defn adj-nw [x, y] (->Square (dec x) (inc y)))

(defn adjacency [{{x :x y :y} :square
                  {dx :dx dy :dy} :delta}]
  (case [dx dy]
    [0  1] [(adj-nw x y) (adj-ww x y) (adj-sw x y) (adj-ss x y)]
    [-1 0] [(adj-sw x y) (adj-ss x y) (adj-se x y) (adj-ee x y)]
    [0 -1] [(adj-se x y) (adj-ee x y) (adj-ne x y) (adj-nn x y)]
    [1  0] [(adj-ne x y) (adj-nn x y) (adj-nw x y) (adj-ww x y)]))

(defn walk
  [{memory :memory
    {x :x y :y} :square
    {dx :dx dy :dy} :delta
    next-turn :next-turn
    steps :steps}]
  (let [should-turn (= steps next-turn)
        next-turn (if (and should-turn (not (zero? dy))) (inc next-turn) next-turn)
        steps (if should-turn 1 (inc steps))
        [dx dy] (if should-turn [(- dy) dx] [dx dy])]
    (make-spiral-memory memory (+ x dx) (+ y dy) dx dy next-turn steps)))

(defn write
  [{memory :memory
    {x :x y :y} :square :as spiral-memory}] (identity spiral-memory))

(defn write-next
  [spiral-memory] (write (walk spiral-memory)))

(defn write-until
  ([predicate]
   (write-until predicate (make-spiral-memory)))
  ([predicate spiral-memory]
   (lazy-seq
    (cons spiral-memory (write-until predicate (write-next spiral-memory))))))

(map println (take 25 (write-until "some predicate")))
