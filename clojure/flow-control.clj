(println (str "2 is " (if (even? 2) "even" "odd")))
(println (if (true? false) "impossible!"))

(println "true is" (if true :truthy :falsey))
(println "object is" (if (Object.) :truthy :falsey))
(println "empty string is" (if "" :truthy :falsey))
(println "empty collection is" (if [] :truthy :falsey))
(println "zero is" (if 0 :truthy :falsey))
(println "false is" (if false :truthy :falsey))
(println "nil is" (if nil :truthy :falsey))

(if (even? 5)
  (do (println "even"))
  (do (println "odd")))

(if (even? 5)
  (do (println "even")
      true)
  (do (println "odd")
      false))

(if (even? 5)
  (do (println "even")
      true))

(def x -5)

(println
 (cond
   (< x 2) "x is less than 2"
   (< x 10) "x is less than 10"))

(def x 5)

(println
 (cond
   (< x 2) "x is less than 2"
   (< x 10) "x is less than 10"))

(def x 10)

(println
 (cond
   (< x 2)  "x is less than 2"
   (< x 10) "x is less than 10"
   :else  "x is greater than or equal to 10"))

(when (neg? x)
  (throw (RuntimeException. (str "x must be positive: " x))))

(defn foo [x]
  (case x
    5 "x is 5"
    10 "x is 10"))

(println (foo 10))
;; (println (foo 11)) ;; No matching clause: 11

(defn foo [x]
  (case x
    5 "x is 5"
    10 "x is 10"
    "x isn't 5 or 10"))
(println (foo 11))
