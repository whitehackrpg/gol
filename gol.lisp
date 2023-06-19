;;;; gol.lisp

(in-package #:gol)

(defparameter *surr* '(#C(0 -1) #C(-1 0) #C(-1 -1) #C(-1 1)
		       #C(0 1) #C(1 0) #C(1 1) #C(1 -1)))

(let ((xdim 40) (ydim 40))
  (defun within-dims (coord)
    (let ((x (realpart coord)) (y (imagpart coord)))
      (and (<= y ydim) (<= x xdim) (>= y 0) (>= x 0) (values xdim ydim)))))

(defun dagame (old)
  (blt:clear)
  (let ((new (make-hash-table)))
    (loop for k being the hash-keys in old do
      (dolist (coord (cons k (mapcar #'(lambda (n) (+ n k)) *surr*)))
	(let ((c (reduce #'+ (mapcar #'(lambda (n) 
					 (- 1 (gethash (+ coord n) old 1)))
				     *surr*))))
	  (when (member (complex c (gethash coord old 1)) '(2 3 #C(3 1)))
	    (setf (gethash coord new) 0)
	    (when (within-dims coord)
	      (setf (blt:cell-char (realpart coord) (imagpart coord)) 
		    (code-char 31)))))))
    (blt:refresh)
    (logit new)
    (unless (and (blt:has-input-p)
		 (case (blt:read)
		   (41 t)
		   (44 (windback (last-count)))))
      (dagame new))))

(defun game-of-life (seed &optional (hash (make-hash-table)))
  (blt:with-terminal 
    (multiple-value-bind (dimx dimy) (within-dims 0)
      (blt:set "window.size = ~AX~A" dimx dimy))
    (dagame (dolist (c seed hash) (setf (gethash c hash) 0)))))


