(defun dagame (oldhash)
  (blt:clear)
  (let ((newhash (make-hash-table)))
    (loop for k being the hash-keys in oldhash using (hash-value v)
	  for count = 0 do
	(when (zerop v) 
	  (setf (blt:cell-char (realpart k) (imagpart k)) #\x))
	(dolist (mod '(#C( 0 -1) #C(0  1) #C(-1 0) #C(1 0)
		       #C(-1 -1) #C(1 -1) #C(-1 1) #C(1 1)))
	  (incf count (- 1 (gethash (+ mod k) oldhash 1))))
	(setf (gethash k newhash)
	      (if (member (complex count v) '(2 3 #C(3 1))) 0 1))
	finally (blt:refresh))
    (unless (blt:has-input-p) 
      (dagame newhash))))

(defun game-of-life (seed dimx dimy &optional (hash (make-hash-table)))
  (blt:with-terminal 
    (blt:set "window.size = ~AX~A" dimx dimy)
    (dagame (dotimes (x dimx hash)
	      (dotimes (y dimy)
		(let ((coord (complex x y)))
		  (setf (gethash coord hash)
			(if (member coord seed) 0 1))))))))


