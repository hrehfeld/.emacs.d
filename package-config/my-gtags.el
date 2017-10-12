(use-package gtags
  :config
  (setq gtags-auto-update t)

  ;; (add-hook 'gtags-mode-hook
  ;; 			(lambda()
  ;; 			  (local-set-key (kbd "M-.") 'gtags-find-tag)   ; find a tag, also M-.
  ;; 			  (local-set-key (kbd "M-,") 'gtags-find-rtag)  ; reverse tag
  ;; 			  (local-set-key (kbd "<f11>") 'gtags-find-symbol)

  ;; 										;			(local-set-key (kbd "C-f") 'forward-char)
  ;; 			  (local-set-key (kbd "C-S-f") 'gtags-find-with-grep)
  ;; 			  (local-set-key (kbd "M-*") 'gtags-pop-stack)
  ;; 			  (local-set-key (kbd "M-*") 'gtags-)
			  
  ;; 			  ))


  ;; (add-hook 'c-mode-common-hook
  ;;   (lambda ()
  ;;     (require 'gtags)
  ;;     (gtags-mode t)
  ;;     (my-gtags-create-or-update)))


  

  )
(provide 'my-gtags)
