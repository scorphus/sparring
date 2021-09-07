(use '[clojure.string :only (join upper-case)])

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

(println "=> Allez Gut!")

(defn my-identity [x] x)
(println (my-identity 359))

(defn always-thing [& _] 5759)
(println (always-thing 89 179 359 791 1439 2879))

(defn my-constantly [x] (fn [& _] x))
(let [n (rand-int Integer/MAX_VALUE)
      f (my-constantly n)]
  (assert (= n (f)))
  (assert (= n (f 123)))
  (assert (= n (apply f 123 (range)))))

(println "=> Allez OK!")

(defn triplicate [f]
  (f) (f) (f))
(triplicate #(println "ding!"))

(defn my-complement [f]
  (fn [& args] (not (apply f args))))
(let [f (my-complement (fn [] true))]
  (println (f)))
(let [f (my-complement #(my-identity false))]
  (println (f)))
(let [f (my-complement #(and %1 %2))]
  (println (f true true)))
(let [f (my-complement #(and %1 %2))]
  (println (f true false)))
(let [f (my-complement #(reduce (fn [a b] (and a b)) %&))]
  (println (f true true true false)))

(defn triplicate2 [f & args]
  (triplicate #(apply f args)))
(triplicate2 println "ding" "again!")

(println "The cosine of pi is:" (Math/cos Math/PI))
(let [a (Math/pow (Math/cos 359) 2)
      b (Math/pow (Math/sin 359) 2)]
  (println "For some x, sin(x)^2 + cos(x)^2:" (+ a b)))

(defn http-get [url]
  (slurp
    (.openStream
      (java.net.URL. url))))
(println (http-get "https://api.ipify.org/"))

(defn one-less-arg [f x]
  (fn [& args] (apply f x args)))
(def foo (one-less-arg println "first"))
(foo "second")

(defn two-fns [f g]
  (fn [arg] (f (g arg))))
(let [foo (two-fns println upper-case)]
  (foo "foo"))
