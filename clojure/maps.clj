(def scores {"Fred"   1400
             "Bob"    1240
             "Angela" 1024})
(println scores)

;; same as the last one!
(def scores {"Fred" 1400, "Bob" 1240, "Angela" 1024})
(println scores)

(def scores (assoc scores "Sally" 1080))
(println scores)

(def scores (assoc scores "Bob" 0))
(println scores)

(def scores (dissoc scores "Fred"))
(println scores)

(println (get scores "Angela"))
(println (get scores "Fred"))
(println (get scores "Fred" "default"))

(def directions {:north 0
                 :east 1
                 :south 2
                 :west 3})

(println (directions :north))
(println (directions :foo))
(println (directions :foo "bar"))

(println (contains? scores "Fred"))
(println (contains? scores "Angela"))
(println (find scores "Angela"))

(println (keys scores))
(println (vals scores))

(def players #{"Alice" "Angela" "Kelly"})
(println (zipmap players (repeat 0)))

(println "p1")
;; with map and into
(def new-scores (into {} (map (fn [player] [player 0]) players)))
(println new-scores)

(println "p2")
;; with reduce
(def new-scores (reduce (fn [acc player] (assoc acc player 0)) {} players))
(println new-scores)

(def newest-scores (merge scores new-scores))
(println newest-scores)

(def newest-scores (merge-with + scores new-scores))
(println newest-scores)

(def sm (sorted-map
         "Bravo" 204
         "Alfa" 35
         "Sigma" 99
         "Charlie" 100))
(println sm)
(println (keys sm))
(println (vals sm))
