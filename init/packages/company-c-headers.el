(use-package company-c-headers
  :ensure t
  :init (progn
		  (add-to-list 'company-backends 'company-c-headers)
		  )
  :config (setq company-c-headers-path-system c++-system-include-paths)
  )

