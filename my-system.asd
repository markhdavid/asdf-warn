;;; -*- Mode: LISP; Syntax: COMMON-LISP -*-

(defsystem "my-system"
  :version "0.0.1"
  :depends-on ()
  :serial t
  :components ((:file "example")))

(defparameter *system-compile-file-failure-behavior* :warn
  "What ASDF should to do when the operate method is called with the BUILD-OP
  operator and \"my-system\" component when COMPILE-FILE returns non-nil as its
  first value but also returns true as its third value. CLHS calls these first
  and third values output-truename and failure-p, respectively.")

(defmethod operate :around 
        ((op build-op) 
         (component (eql (find-system "my-system" nil)))
         &rest keys)
      (declare (ignorable keys))
      (let ((*compile-file-failure-behaviour* *system-compile-file-failure-behavior*))
        (call-next-method)))
