(use-package my-gtags
  :config
(use-package helm-gtags
  :ensure t
 
 :config
 (progn
   (setq
	helm-gtags-ignore-case t
	helm-gtags-auto-update t
	helm-gtags-use-input-at-cursor t
	helm-gtags-pulse-at-cursor t
	helm-gtags-prefix-key "\C-cg"
	helm-gtags-suggested-key-mapping t
	)

   (add-hook 'dired-mode-hook 'helm-gtags-mode)
   (add-hook 'eshell-mode-hook 'helm-gtags-mode)
   (add-hook 'c-mode-hook 'helm-gtags-mode)
   (add-hook 'c++-mode-hook 'helm-gtags-mode)
   (add-hook 'asm-mode-hook 'helm-gtags-mode)

   )
 :bind (
		("C-c g a" . helm-gtags-tags-in-this-function)
		("C-j" . helm-gtags-select)
		;("M-." . helm-gtags-dwim)
		;("M-," . helm-gtags-pop-stack)
		("C-c <" . helm-gtags-previous-history)
		("C-c >" . helm-gtags-next-history)
		)
 ))


(provide 'my-helm-gtags)
