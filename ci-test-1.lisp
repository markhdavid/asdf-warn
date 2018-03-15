(defconstant *exit-success-value* 0)
(defconstant *exit-failure-value* 1)
(asdf:initialize-source-registry   
 `(:source-registry (:tree "./") :inherit-configuration))
(asdf:make "my-system")
(uiop:quit *exit-success-value*)
