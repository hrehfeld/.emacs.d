(use-package company-irony
  :ensure t
  :config
  (progn
	(message "initializing company-irony")
	(setq company-backends (delete 'company-semantic company-backends))
	(setq company-backends (delete 'company-clang company-backends))
	(add-to-list 'company-backends 'company-irony)
	(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
	))
