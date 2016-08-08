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

