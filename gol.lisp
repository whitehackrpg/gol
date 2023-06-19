(defun dagame (old)
  (blt:clear)
  (let ((new (make-hash-table))
	(surr '(#C(0 -1) -1 #C(-1 -1) #C(-1 1) #C(0 1) 1 #C(1 1) #C(1 -1))))
    (loop for k being the hash-keys in old do
      (dolist (coord (cons k (mapcar #'(lambda (n) (+ n k)) surr)))
	(let ((c (reduce #'+ (mapcar #'(lambda (n) 
					 (- 1 (gethash (+ coord n) old 1)))
				     surr))))
	  (when (member (complex c (gethash coord old 1)) '(2 3 #C(3 1)))
	    (setf (gethash coord new) 0
		  (blt:cell-char (realpart coord) (imagpart coord)) 
		  (code-char 31))))))
  (blt:refresh)
    (unless (and (blt:has-input-p) (= (blt:read) 41)) (dagame new))))

(defun game-of-life (seed dimx dimy &optional (hash (make-hash-table)))
  (blt:with-terminal 
    (blt:set "window.size = ~AX~A" dimx dimy)
    (dagame (dolist (c seed hash) (setf (gethash c hash) 0)))))
