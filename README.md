# asdf-warn

In the case where COMPILE-FILE does well enough to produce a binary but gets warnings more serious than style warnings, you may want the behavior to be consistent on all Common Lisp implementations. Unfortunately, ASDF makes this challenging by having the parameter that controls this differ among Lisp implementations, notably with SBCL having :error as its default while the default on most other Lisps is :warn. 

This shows an example of a system, "my-system", and how it works around it by having a parameter to control this that not tied to any Lisp implementation.

For doc on ```*compile-file-failure-behaviour*```, see: https://common-lisp.net/project/asdf/asdf.html#Compilation-error-and-warning-handling

See the ASDF sources for precise Lisp-implementation-specific details

For doc on COMPILE-FILE, see the CLHS (Common Lisp HyperSpec): http://www.lispworks.com/documentation/lw61/CLHS/Body/f_cmp_fi.htm
