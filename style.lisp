(defpackage #:example
  (:use #:cl)
  (:export))

(in-package "EXAMPLE")



;;; EXAMPLE-STYLE: does not do anything interesting. The point is that
;;; when it's compiled, it should get a style warning.

(defun example-style ()
  (let ((var 13))  ; var VAR unused, so gets style warning
    13))
