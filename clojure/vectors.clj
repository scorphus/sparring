(def my_vector ["abc" false 99])
(println my_vector)

(println (get my_vector 0))
(println (get my_vector 1))
(println (get my_vector 2))
(println (get my_vector 3))

(println (count my_vector))

(def another_vector (vector 1 2 3))
(println another_vector)

(println (conj another_vector 4 5 6))
(println another_vector)

(def another_vector (conj another_vector 4 5 6))
(println another_vector)
