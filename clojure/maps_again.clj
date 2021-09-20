(def person
  {:first-name "Kelly"
   :last-name "Keen"
   :age 32
   :occupation "Programmer"})
(println person)
(println (keys person))
(println (vals person))
(println (get person :occupation))
(println (person :occupation))
(println (:occupation person))
(println (:favorite-color person "green"))

(def person (assoc person :occupation "Pro Cyclist"))
(def person (dissoc person :age))
(println person)

(def company
  {:name "WidgetCo"
   :address {:street "123 Main St"
             :city "Springfield"
             :state "IL"}})
(println company)
(println (get-in company [:address :city]))

(def company (assoc-in company [:address :street] "303 Broadway"))
(def company (assoc-in company [:address :country] "USA"))
(println company)
