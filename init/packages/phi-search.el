(use-package phi-search
  :ensure phi-search
 :config (progn
		 (setq phi-search-limit           100
			   phi-search-case-sensitive  'guess
			   )

		 ;(set-face-attribute 'phi-search-selection-face nil
          ;          :background "orange")
		 )
 :bind (
		;("C-s" . phi-search)
		;("C-r" . phi-search-backward)
		("M-%" . phi-replace-query)
	   )
 )
