# asdf-warn

In the case where COMPILE-FILE does well enough to produce a binary but gets warnings more serious than style warnings, you may want the behavior to be consistent on all Common Lisp implementations.

One application of this would be in a Continuous Integration system running builds. Having the parameter differ between Lisps simply gets in the way of the uniformity that Common Lisp is intended to bring about, at least in this fairly specialized situation.

Unfortunately, ASDF makes this challenging by having the parameter that controls this differ among Lisps, notably with SBCL having :error as its default while the default on most other Lisps is :warn.  It is also confusing and unclear where to hook in to this variable if one wished to parameterize reliably for the building of one's own system (and any subsystems build as a side effect). That is, rather than by requiring a change to the underlying Lisp, i.e., such that the variable has some other default value at boot time, so to speak.

This shows an example .asd file for "my-system" with a parameter that has the same spec as ```*compile-file-failure-behaviour*``` but not tied to any Lisp implementation. For the doc for  ```*compile-file-failure-behaviour*``` see: https://common-lisp.net/project/asdf/asdf.html#Compilation-error-and-warning-handling

For the various Lisp-implementation-specific defaults for this variable, see the ASDF sources (https://github.com/fare/asdf).

For doc on COMPILE-FILE, see the CLHS (Common Lisp HyperSpec): http://www.lispworks.com/documentation/lw61/CLHS/Body/f_cmp_fi.htm
