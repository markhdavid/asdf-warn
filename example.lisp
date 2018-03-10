(defpackage #:example
  (:use #:cl)
  (:export example example2 example3))

(in-package "EXAMPLE")

(defun example ()
  (map 
   #'list  ; <= bogus: should be a sequence subtype; this supplies a function
   #'char "EXAMPLE"))

(defun example2 ()
  (let (some-var) ; unused var, a style warning, which should NOT
                  ;   make compile-file failure-p 3rd value true
    (get-current-time)))

(defun example3 ()
    (mapcan #'what-the-heck? '((1) (2) (3))))

(eval-when (:compile-toplevel)
  (warn "Warning: example warning!"))
