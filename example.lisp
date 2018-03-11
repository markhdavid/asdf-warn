(defpackage #:example
  (:use #:cl)
  (:export))

(in-package "EXAMPLE")

(eval-when (:compile-toplevel)
  (warn "Warning: example warning!"))
