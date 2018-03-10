# asdf-warn

In the case were COMPILE-FILE does well enough to produce a binary but gets warnings more serious than style warnings, you may want the behavior to be consistent on all Common Lisp implementations. Unfortunately, ASDF makes this challenging by having the parameter that controls this default based on which Lisp you're on. The most prominent Lisp implementation affected is SBCL, for which the default is set to :error, but there are a few other special cases. See the sources.

This shows a way to work around this. You can have your own parameter in your .asd file that controls this that will override whatever Lisp-implementation-specific default that ASDF may have chosen throughout the build of your system, on any Lisp implementation, and this will also apply to the building of any systems built as a side effect of building your system, unless dynamically overridden by some system further down, the behavior specified by the parameter will be in force.

The benefit is that you can have uniform handling of this outcome across Lisp implementations.  If you want to have ASDF signal an error, you can so by setting the parameter to :error.  If you want to have ASDF warn, you can set the parameter to :warn.  You can also set it to :ignore.

