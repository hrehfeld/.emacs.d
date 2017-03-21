(use-package my-company
  :config
(use-package company-tern
  :ensure t

  :config (progn
		  (let ((start (lambda ()
						 (add-to-list 'company-backends 'company-tern))))
			(add-hook 'js-mode-hook start)
			))
  ))
(provide 'my-company-tern)
