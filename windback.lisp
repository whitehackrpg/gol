;;;; windback.lisp

(in-package #:gol)

(defparameter *backlog* (make-hash-table))

(let ((count 99))
  (defun last-count ()
    (1+ count))
  (defun logit (hash)
    (if (zerop count)
	(let ((new (make-hash-table)))
	  (loop for k being the hash-keys in *backlog* using (hash-value v) do
	    (setf (gethash (1+ k) new) v))
	  (remhash 100 new)
	  (setf (gethash 0 new) hash
		*backlog* new))
	(setf (gethash count *backlog*) hash
	      count (1- count)))))

(defun windback (n)
  (unless (minusp n)
    (blt:clear)
    (loop for k being the hash-keys 
	    in (gethash n *backlog* (gethash (1+ n) *backlog*)) do
	      (setf (blt:cell-char (realpart k) (imagpart k)) (code-char 31)))
    (blt:refresh)
    (windback (case (blt:read)
		(13 (if (= n 99) n (1+ n)))
		(14 (if (= n (last-count)) n (1- n)))
		(41 -1)
		(t n)))))


