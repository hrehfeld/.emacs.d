(use-package latex-extra
  :ensure latex-extra
 :config (progn
		 (add-hook 'LaTeX-mode-hook (lambda () (latex-extra-mode 1)))
		 )
 )
(provide 'my-latex-extra)
