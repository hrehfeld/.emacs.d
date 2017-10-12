(use-package evil-search
  :disabled t
  :config
  (use-package evil-search-highlight-persist
	:ensure t
	:config (progn
			  (global-evil-search-highlight-persist t)
			  )
	))
