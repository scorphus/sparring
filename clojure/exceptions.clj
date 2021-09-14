(println (try
  (/ 3 2)
  (catch ArithmeticException e
    false)
  (finally
    (println "-- cleanup"))))

(println (try
  (/ 5 2)
  (catch ArithmeticException e
    false)
  (finally
    (println "-- cleanup"))))

(println (try
  (/ 7 0)
  (catch ArithmeticException e
    false)
  (finally
    (println "-- cleanup"))))

(println (try
  (throw (Exception. "something went wrong"))
  (catch Exception e (.getMessage e))))

(println (try
  (throw (ex-info "There was a problem" {:detail 42}))
  (catch Exception e
    (ex-data e))))

(let [f (clojure.java.io/writer "/tmp/new")]
  (try
    (.write f "some text")
    (finally
      (.close f))))
;; the above can be written as:
(with-open [f (clojure.java.io/writer "/tmp/new")]
  (.write f "some text again"))

(println (with-open [f (clojure.java.io/reader "/tmp/new")]
  (reduce conj [] (line-seq f))))
