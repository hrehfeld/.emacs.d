(use-package company-tern
  :ensure t

  :init (progn
		  (let ((start (lambda ()
						 (add-to-list 'company-backends 'company-tern))))
			(add-hook 'js-mode-hook start)
			))
  )
