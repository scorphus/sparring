;; Define a record structure
(defrecord Person [first-name last-name age occupation])

;; Positional constructor - generated
(def kelly (->Person "Kelly" "Keen" 32 "Programmer"))

(println kelly)

;; Map constructor - generated
(def kelly (map->Person
            {:first-name "Kelly"
             :last-name "Keen"
             :age 32
             :occupation "Pro Cyclist"}))

(println kelly)
(println (:occupation kelly))
