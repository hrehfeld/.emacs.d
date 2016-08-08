(setq tex-open-quote "“"
      tex-close-quote "”")

(defun hrehf-latex-create-umlaut-escape (letter) (concat "\\\\\"" letter))
(hrehf-latex-create-umlaut-escape "a")

(defun hrehf-latex-convert-umlaute ()
  (interactive)
  (let ((case-fold-search nil)
		(start (min (region-beginning) (region-end)))
		(end (max (region-beginning) (region-end))))
	(save-excursion
	  (mapc (lambda (um) 
			  (let ((escaped (cdr um))
					(unescaped (car um)))
				(message (concat "Replacing " escaped " with " unescaped))
				(goto-char start)
				(while (re-search-forward escaped end t)
				  (replace-match unescaped t nil))))
			(cons hrehf-sz 
				  (mapcar (lambda (um) `(,(car um) . ,(hrehf-latex-create-umlaut-escape (cdr um))))
						  hrehf-umlaute)))
)))


