;;;; gol.asd

(asdf:defsystem #:gol
  :description "A Conway's Game of Life."
  :author "Christian Mehrstam <whitehackrpg@gmail.com>"
  :license  "MIT"
  :serial t
  :depends-on (#:cl-blt)
  :components ((:file "package")
	       (:file "windback")
	       (:file "gol")
	       (:file "patterns")))


