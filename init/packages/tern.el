(use-package tern
  :ensure t

  :init (progn
		  (add-hook 'js-mode-hook (lambda () (tern-mode t)))
		  )
  )
