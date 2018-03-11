;; -*- mode: lisp -*-

;;; Initialize ASDF source registry to this repo's directory tree.

(let* ((load-pathname
         (or *load-pathname*
             ;; If *load-pathname* nil, must not be loading.
             (error "This must be called from LOAD. Cannot continue.")))
       (directory-pathname
         ;; nameless, typeless, versionless pathname
         (make-pathname 
          :defaults load-pathname :name nil :type nil :version nil))
       (ensured-directory-pathname
         (uiop:ensure-directory-pathname directory-pathname)))
  (asdf:initialize-source-registry
   `(:source-registry 
     (:tree ,ensured-directory-pathname)
     :inherit-configuration)))
