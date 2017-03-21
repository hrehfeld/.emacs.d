(use-package my-company
  :config
  (use-package company-math
	:ensure company-math
	:config (progn
			  (defun my-init-company-math ()
				(setq-local company-backends
							(append '(company-math-symbols-latex company-latex-commands)
									company-backends)))
			  (add-hook 'TeX-mode-hook 'my-init-company-math)
			  (add-hook 'org-mode-hook 'my-init-company-math)
			  (add-hook 'text-mode (lambda () (setq-local company-backends
														  (append '(company-math-symbols-latex company-latex-commands)
																  company-backends))))
			  )
	))
(provide 'my-company-math)
