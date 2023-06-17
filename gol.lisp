(defun dagame (oldhash)
  (blt:clear)
  (let ((newhash (make-hash-table)))
    (maphash #'(lambda (k v) 
		 (let ((count 0))
		   (when (zerop v) 
		     (setf (blt:cell-char (realpart k) (imagpart k)) #\x))
		   (dolist (mod '(#C( 0 -1) #C(0  1) #C(-1 0) #C(1 0)
				  #C(-1 -1) #C(1 -1) #C(-1 1) #C(1 1)))
		     (when (zerop (gethash (+ mod k) oldhash 1)) 
		       (incf count)))
		   (setf (gethash k newhash)
			 (if (or (and (zerop v) (or (= count 2) (= count 3)))
				 (and (= v 1) (= count 3)))
			     0
			     1))))
	     oldhash)
    (blt:refresh)
    (unless (blt:has-input-p) 
      (dagame newhash))))

(defun game-of-life (seed dimx dimy &optional (hash (make-hash-table)))
  (blt:with-terminal 
    (blt:set "window.size = ~AX~A" dimx dimy)
    (dagame (dotimes (x dimx hash)
	      (dotimes (y dimy)
		(let ((coord (complex x y)))
		  (setf (gethash coord hash)
			(if (member coord seed)
			    0 
			    1))))))))

