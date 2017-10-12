(use-package my-company :config
  (use-package my-rtags :config 
(use-package company-rtags
  :ensure rtags
  :config
  (add-hook 'c-mode-common-hook
			(lambda ()
			  (if (symbolp 'company-backends)
				  (add-to-list 'company-backends 'company-rtags)))))))
(provide 'my-rtags-company)


