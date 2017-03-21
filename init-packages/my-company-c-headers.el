(use-package my-c++-system
  :config
(use-package my-company
  :config
(use-package company-c-headers
  :ensure t
  :config (progn
	    (setq company-c-headers-path-system c++-system-include-paths)
	    (add-to-list 'company-backends 'company-c-headers)
	  )
  )))
(provide 'my-company-c-headers)
