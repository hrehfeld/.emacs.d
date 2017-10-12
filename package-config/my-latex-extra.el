(use-package latex-extra
  :ensure latex-extra
  :commands latex-extra-mode
  :config (progn
			(add-hook 'LaTeX-mode-hook (lambda () (latex-extra-mode 1)))
			)
  )
(provide 'my-latex-extra)
