(def players #{"Alice", "Bob", "Kelly"})
(println players)
(def players (conj players "Molly"))
(println players)
(def players (disj players "Bob" "Sal"))
(println players)
(println (contains? players "Molly"))
(println (contains? players "Bob"))

(def new-players ["Tim" "Sue" "Joe"])
(def players (into players new-players))
(println players)

(def new-players #{"Tim" "Sue" "Joe"})
(def players (into players new-players))
(println players)

(def nato (conj (sorted-set) "Delta" "Bravo" "Tango" "Echo" "Alpha"))
(println nato)

(def new-code-words ["Charlie" "Sierra" "Romeo"])
(def nato (into nato new-code-words))
(println nato)

(def new-code-words #{"Charlie" "Sierra" "Romeo"})
(def nato (into nato new-code-words))
(println nato)
