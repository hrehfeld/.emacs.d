(use-package tern
  :ensure t

  :config (progn
		  (add-hook 'js-mode-hook (lambda () (tern-mode t)))
		  )
  )
(provide 'my-tern)
