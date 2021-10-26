(defmacro ignore-last-operand
  [func-call]
  (butlast func-call))

(println (ignore-last-operand (+ 1 2 10)))

(println (ignore-last-operand (+ 1 2 (println "this won't print"))))

(println (macroexpand '(ignore-last-operand (+ 1 2 10))))

(println (macroexpand '(ignore-last-operand (+ 1 2 (println "this won't print")))))

(defmacro infix [[a b c]] (list b a c))

(infix (1 + 2))
