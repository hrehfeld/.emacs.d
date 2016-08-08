(use-package smart-mode-line
  :ensure t
  :init (progn
		 (sml/setup)
		 (setq sml/shorten-directory t
			   sml/shorten-modes t)
		 (let ((add (lambda (el) (add-to-list 'sml/replacer-regexp-list el t))))
		   (funcall add '("^~/\\.emacs\\.d/init/packages" ":PKGS:"))
		   )
		 )
 )
