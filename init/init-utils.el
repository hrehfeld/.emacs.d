
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
(defun directory-files-recursive-ext (dir ext)
  (remove-if-not (lambda (filename) (eq "ext" (file-name-extension filename)))
                 (directory-files-recursive dir)))

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
