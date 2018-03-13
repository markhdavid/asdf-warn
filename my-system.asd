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

(defparameter *my-system-compile-file-warnings-behavior* :warn
  "What ASDF should to do when the operate method is called with the BUILD-OP
  operator and \"my-system\" component when COMPILE-FILE returns non-nil as its
  first value but also returns true as its second value. CLHS calls these first
  and second values output-truename and warnings-p, respectively. The default
  value is :WARN.")

(defparameter *my-system-compile-file-failure-behavior* :warn
  "What ASDF should to do when the operate method is called with the BUILD-OP
  operator and \"my-system\" component when COMPILE-FILE returns non-nil as its
  first value but also returns true as its third value. CLHS calls these first
  and third values output-truename and failure-p, respectively. The default
  value is :WARN.")

(defmacro call-next-method-with-behaviors ((warnings-var failure-var))
  `(let ((*compile-file-warnings-behaviour*
           (ecase ,warnings-var
             ((:ignore :warn :error) ,warnings-var)
             ((nil) *my-system-compile-file-warnings-behavior*)))
         (*compile-file-failure-behaviour*
           (ecase ,failure-var
             ((:ignore :warn :error) ,failure-var)
             ((nil) *my-system-compile-file-failure-behavior*))))
     (call-next-method)))



(defsystem "my-system"
  :version "0.0.1"
  :depends-on ()
  :serial t
  :components ((:file "example")))

(defmethod operate :around 
    ((op build-op) 
     (component (eql (find-system "my-system" nil)))
     &rest keys &key warnings-behavior failure-behavior)
  (declare (ignorable keys))  
  (call-next-method-with-behaviors (warnings-behavior failure-behavior)))


(defsystem "my-system/style"
  :version "0.0.1"
  :depends-on ()
  :serial t
  :components ((:file "style")))

(defmethod operate :around 
    ((op build-op) 
     (component (eql (find-system "my-system/style" nil)))
     &rest keys &key warnings-behavior failure-behavior)
  (declare (ignorable keys))  
  (call-next-method-with-behaviors (warnings-behavior failure-behavior)))




;;;; Examples

;;; Note: these examples all supply ':force t' keyword argument in
;;; order to force compilation, i.e., so it's unnecessary to flush
;;; binaries or take similar steps to force compilation.

;;; (asdf:make "my-system/style" :warnings-behavior :error :force t)
;;; => signals error
;;;
;;; (asdf:make "my-system/style" :warnings-behavior :warn :force t)
;;; (asdf:make "my-system/style" :force t)
;;; => just gets warning
;;;
;;; (asdf:make "my-system/style" :failure-behavior :error :force t)
;;; => just gets warning
;;;
;;; (asdf:make "my-system/style" :warnings-behavior :warn :force t)
;;; (asdf:make "my-system/style" :force t)
;;; => just gets warning
;;;
;;; (asdf:make "my-system" :failure-behavior :error :force t)
;;; => gets error
;;;
;;; (asdf:make "my-system" :failure-behavior :warn :force t)
;;; (asdf:make "my-system" :force t)
;;; => just gets warning
