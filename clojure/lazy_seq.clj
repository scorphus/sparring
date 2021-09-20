;; Laziness in Clojure
;; http://clojure-doc.org/articles/language/laziness.html

(defn fib
  "Lazily generates Fibonacci numbers"
  ([]
   (fib 0 1))
  ([a b]
   (lazy-seq
    (cons a (fib b (+ a b))))))

(println (take 20 (fib)))
