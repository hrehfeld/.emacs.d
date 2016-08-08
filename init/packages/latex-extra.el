(use-package latex-extra
  :ensure latex-extra
 :init (progn
		 (add-hook 'LaTeX-mode-hook #'latex-extra-mode)
		 )
 )
