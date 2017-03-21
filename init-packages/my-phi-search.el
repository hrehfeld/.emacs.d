(use-package phi-search
  :ensure t
  :config (progn
		 (setq phi-search-limit           100
			   phi-search-case-sensitive  'guess
			   )

		 (set-face-attribute
		  'phi-search-match-face nil
		  :background "gainsboro")
		 (set-face-attribute
		  'phi-search-selection-face nil
		  :background "red")
		 
		 (use-package phi-replace
		   :config
		   (set-face-attribute
			'phi-replace-preview-face nil
			:background "DarkOliveGreen1"))
		 )
 :bind (
		;("C-s" . phi-search)
		;("C-r" . phi-search-backward)
		("M-%" . phi-replace-query)
	   )
 )
(provide 'my-phi-search)
