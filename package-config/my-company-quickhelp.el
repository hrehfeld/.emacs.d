(use-package my-company
  :config
  (use-package company-quickhelp
  :ensure t
 :config (progn
		 (setq company-quickhelp-delay 1.0)
		 (company-quickhelp-mode 1)
		 
	   )
 ))
(provide 'my-company-quickhelp)
