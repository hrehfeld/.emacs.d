(use-package company
 :ensure company
 :config
 (progn
   (setq company-idle-delay 0.1
		 company-async-timeout 5)
   (setq company-dabbrev-code-modes nil
		 company-dabbrev-code-ignore-case t
		 company-dabbrev-downcase nil
		 )
   (when (fboundp 'js2-mode)
	 (add-to-list 'company-dabbrev-code-modes 'js2-mode))
   (when (fboundp 'gud-mode)
	 (add-to-list 'company-dabbrev-code-modes 'gud-mode))

   (setq company-backends (delete 'company-semantic company-backends))
   (make-local-variable 'company-backends)

   (add-hook 'after-init-hook 'global-company-mode)

   (defun my-company-mode-setup ()
	 (define-key company-mode-map [remap completion-at-point]
	   'company-complete)
	 (define-key company-mode-map [remap complete-symbol]
	   'company-complete))
   (add-hook 'company-mode-hook 'my-company-mode-setup)
   )
 :bind
 (
  ("\t" . company-complete)
  )
 )
(provide 'my-company)
