(use-package clocker
  :ensure t
  :config
  (progn
	(diminish 'clocker-mode "⌛")
	(setq clocker-keep-org-file-always-visible nil)
	)
)
