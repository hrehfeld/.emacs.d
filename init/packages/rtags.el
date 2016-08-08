(use-package rtags
 :init (progn
	(add-hook 'c-mode-common-hook 
				 (lambda () 
				   (rtags-enable-standard-keybindings)
				   (local-set-key (kbd "M-.") 'rtags-find-symbol-at-point)
				   (local-set-key (kbd "M-s") 'rtags-find-symbol)
				   (local-set-key (kbd "M-*") 'rtags-location-stack-back)
				   (local-set-key (kbd "C-M-*") 'rtags-location-stack-forward)
				   (local-set-key (kbd "M-N") 'rtags-next-match)
				   (local-set-key (kbd "M-P") 'rtags-previous-match)
				   (local-set-key (kbd "C-S-SPC") 'rtags-print-cursorinfo)
				   ))
	(add-hook 'company-mode-hook
			  (lambda ()
				(use-package company-rtags
				  :init (progn
						 (add-hook 'c-mode-common-hook
								   (lambda ()
									 (add-to-list 'company-backends 'company-rtags)))))))
	))
