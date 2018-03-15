(defconstant *exit-success-value* 0)
(defconstant *exit-failure-value* 1)
(defvar *basedir*
  (make-pathname
   :defaults *load-pathname*
   :name nil
   :type nil
   ::version nil))
(asdf:initialize-source-registry   
 `(:source-registry (:tree ,*basedir*) :inherit-configuration))
(asdf:make "my-system")
(uiop:quit *exit-success-value*)
