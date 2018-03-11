;;; -*- Mode: LISP; Syntax: COMMON-LISP -*-



;;; This code is intended to run the same in any Lisp implementation with any
;;; version of ASDF, version 3.1 or later. So far it has been tested with ASDF
;;; 3.3.1 on recent versions of SBCL ("1.4.5"), CCL ("Version 1.11-r16635
;;; (DarwinX8664)"), and LispWorks ("7.1.0") as of Mar 10, 2018.

#-asdf3.1 
(cerror "Continue anyhow" 
        "This Lisp seems not to be running a supported version of ASDF.")



;;; My-system has code that signals a non-style WARNING condition at compile
;;; time. Based on our parameter *my-system-compile-file-failure-behavior*,
;;; which can be :warn, :error, or :ignore, after compile-file has returned its
;;; result, specifically `failure-p' the third return value, this warns, errors,
;;; or ignores in accordance.  This warns by default; you can change our
;;; parameter to customize this.

(defparameter *my-system-compile-file-failure-behavior* :warn
  "What ASDF should to do when the operate method is called with the BUILD-OP
  operator and \"my-system\" component when COMPILE-FILE returns non-nil as its
  first value but also returns true as its third value. CLHS calls these first
  and third values output-truename and failure-p, respectively This default
  value is :WARN..")

(defsystem "my-system"
  :version "0.0.1"
  :depends-on ()
  :serial t
  :components ((:file "example")))

(defmethod operate :around 
        ((op build-op) 
         (component (eql (find-system "my-system" nil)))
         &rest keys)
      (declare (ignorable keys))
      (let ((*compile-file-failure-behaviour*
              *my-system-compile-file-failure-behavior*))
        (call-next-method)))




;;; My-system/warn is similar to my-system but always warns after the
;;; compilation.

(defsystem "my-system/warn"
  :version "0.0.1"
  :depends-on ()
  :serial t
  :components ((:file "example")))

(defmethod operate :around 
        ((op build-op) 
         (component (eql (find-system "my-system/warn" nil)))
         &rest keys)
      (declare (ignorable keys))
      (let ((*compile-file-failure-behaviour* :warn))
        (call-next-method)))



;;; My-system/error is similar to my-system but always errors after the
;;; compilation.

(defsystem "my-system/error"
  :version "0.0.1"
  :depends-on ()
  :serial t
  :components ((:file "example")))

(defmethod operate :around 
        ((op build-op) 
         (component (eql (find-system "my-system/error" nil)))
         &rest keys)
      (declare (ignorable keys))
      (let ((*compile-file-failure-behaviour* :error))
        (call-next-method)))



;;; My-system/ignore is similar to my-system but always does nothing (ignores
;;; the warning) after the compilation.

(defsystem "my-system/ignore"
  :version "0.0.1"
  :depends-on ()
  :serial t
  :components ((:file "example")))

(defmethod operate :around 
        ((op build-op) 
         (component (eql (find-system "my-system/ignore" nil)))
         &rest keys)
      (declare (ignorable keys))
      (let ((*compile-file-failure-behaviour* :ignore))
        (call-next-method)))



;;; My-system/lisp is similar to my-system but does whatever the default is for
;;; *compile-file-failure-behaviour* on the particular Lisp this is running on
;;; after the compilation.

(defsystem "my-system/lisp"
  :version "0.0.1"
  :depends-on ()
  :serial t
  :components ((:file "example")))
