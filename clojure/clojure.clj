(use '[clojure.string :only (join)])

(defn messenger-builder [greeting func]
  (fn [who] (func greeting who))) ; closes over greeting

;; greeting provided here, then goes out of scope
(def hello-er (messenger-builder "Hello" println))

;; greeting value still available because hello-er is a closure
(println (hello-er "world!"))
;; Hello world!
;; nil

(def hello-er (messenger-builder "Hello" str))
(println (hello-er "world!"))

(def hello-er (messenger-builder "Hello" #(join " " %&)))
(println (hello-er "world!"))

(defn joiner [& args]
  (join " " args))

(def hello-er (messenger-builder "Hello" joiner))
(println (hello-er "world!"))

(def greet (fn [] (println "Hello")))
(greet)

(def greet #(println "Hello"))
(greet)

(defn greeting
  ([] (greeting "World"))
  ([x] (greeting "Hello" x))
  ([x, y] (str x ", " y "!")))
(assert (= "Hello, World!" (greeting)))
(assert (= "Hello, Clojure!" (greeting "Clojure")))
(assert (= "Good morning, Clojure!" (greeting "Good morning" "Clojure")))

(println "Allez Gut!")
