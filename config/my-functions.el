
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; http://www.dotemacs.de/dotfiles/ElijahDaniel.emacs.html

(defun filter (cond list) 
  "Drop all elements that do not satisfy cond" 
  (delq nil
        (mapcar (lambda (x) (and (funcall cond x) x)) list)))

(defun fold (f start list)
  "Recursively applies (f i j) where j is the jth element in the list li and j is the result of the i-1th function call. For example, (fold f x '(1 2)) returns (f (f x 1) 2)"
  (let ((list2 list) (start2 start))
    (while list2
      (setq start2 (funcall f start2 (pop list2)))
      )
    start2
    )
  )

(defun buffer-type-p (extension)
  (let ((ext (file-name-extension buffer-file-name)))
	(equalp extension ext)))

(require 'cl)
(defun my/files-remove-if-not-ext (files ext)
  (remove-if-not (lambda (filename) (equal ext (file-name-extension filename)))
                 files))


(defun directory-files-recursive-regexp (dir re)
  "Returns list of files in directory matching to given regex"
  (when (file-accessible-directory-p dir)
    (let ((files (directory-files dir t))
          matched)
      (dolist (file files matched)
        (let ((fname (file-name-nondirectory file)))
          (cond
           ((or (string= fname ".")
                (string= fname "..")) nil)
           ((and (file-regular-p file)
                 (string-match re fname))
            (setq matched (cons file matched)))
           ((file-directory-p file)
            (let ((tfiles (directory-files-recursive-regexp file re)))
              (when tfiles (setq matched (append matched tfiles)))))))))))

(defun directory-files-recursive (dir) 
  "like directory-files, but recurse into subdirectories"
  (let ((files `(,dir)) 
        (i 0))
    (while (< i (length files))
      (let ((dir (nth i files)))
        (mapc (lambda (f) (add-to-list 'files f t)) 
                     (filter (lambda (f)
                               (and (file-directory-p f)
                                        ;drop parent dirs
                                    (< (length (expand-file-name dir))
                                       (length (expand-file-name f))))
                               )
                             (directory-files dir t nil t)))
        (setq i (+ i 1))
        )
      )
    files
    )
  )


(defun my-upward-find-topmost-file (filename &optional startdir)
  "Move up directories until root and return the last directory in
which we found filename it. Start at startdir or . if startdir not given"

  (let ((dirname (expand-file-name
				  (if startdir startdir ".")))
		(found-tip nil)
		(top nil))  ; top is set when we get
										; to / so that we only check it once

	;; While we've still got the file keep looking to find where we lose it
	(while (not top)
	  ;; If we're at / set top flag.
	  (if (string-match "^\\([a-zA-Z]:\\)?/$" (expand-file-name dirname))
		  (setq top t))
	  
	  ;; Check for the file in the directory above
	  (let ((parent (expand-file-name ".." dirname)))
		(if (file-exists-p (expand-file-name filename parent))
			(setq found-tip parent)
		  )
		(setq dirname parent)
		))
	
	(if found-tip found-tip nil)))


(defun my-upward-find-first-file (filename &optional startdir)
  "Move up directories until we find a certain
filename and return the last directory in
which we found it. Start at startdir or . if startdir not given"

  (let ((dirname (expand-file-name
                  (if startdir startdir ".")))
        (found-tip nil) ; set if we stop finding it so we know when to exit loop
        (top nil))  ; top is set when we get
                    ; to / so that we only check it once

      ;; While we've still got the file keep looking to find where we lose it
      (while (not (or found-tip top))
        ;; If we're at / set top flag.
        (if (string-match "^\\([a-zA-Z]:\\)?/$" (expand-file-name dirname))
            (setq top t)

          ;; Check for the file in the directory above
          (let ((parent (expand-file-name ".." dirname)))
            (if (not (file-exists-p (expand-file-name filename parent)))
                (setq found-tip t)
              ;; If we found it, keep going till we don't
              (setq dirname parent)))))

      (if (and found-tip (not top)) dirname nil)))

(provide 'my-functions)
