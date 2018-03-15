(defpackage #:example
  (:use #:cl)
  (:export))

(in-package "EXAMPLE")                  ; some in-package for EXAMPLE

(eval-when (:compile-toplevel)
  (warn "Warning: example warning!"))
