(use-package highlight-symbol
  :ensure highlight-symbol
  :init
 (progn
   (let ((f (lambda ()
			  (global-set-key (kbd "C-M-S-f") 'highlight-symbol-next)
			  (global-set-key (kbd "C-M-S-b") 'highlight-symbol-prev)
			  (highlight-symbol-mode 1)
			  )))
	 (add-hook 'prog-mode-hook f)
	 (add-hook 'text-mode-hook f)
	 )
   )
 :config
 (progn
   (setq highlight-symbol-on-navigation-p t)
   (setq highlight-symbol-idle-delay 0.75)
   (setq highlight-symbol-occurence-message '(explicit))
   )
										;(global-set-key [(meta f3)] 'highlight-symbol-query-replace)
 )
