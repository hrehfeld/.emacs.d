(use-package dim
  :ensure t
  :defer nil
  :init (progn

			(dim-major-names
			 '((emacs-lisp-mode           "elisp")
			   (emacs-lisp-byte-code-mode "elisp-byte")
			   (calendar-mode             "📆")
			   ))
			
			(dim-minor-names '(
							   (dim "" dim)
							   (flycheck-mode "FC")
							   (helm-mode "")
							   (workgroups-mode "" workgroups-mode)
							   (org-indent-mode "" org-mode)
							   (dtrt-indent-mode "" dtrt-indent-mode)
							   (highlight-symbol-mode "" highlight-symbol)
							   (highlight-indentation-mode "")
							   ))
			)
  )
