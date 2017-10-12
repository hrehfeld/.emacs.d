(use-package helm
  :ensure t
  :defer nil
 :config
 (progn
   (require 'helm-config)
   (setq
;	helm-idle-delay 0.4
;	helm-input-idle-delay helm-idle-delay
	helm-quick-update t
;	helm-split-window-in-side-p t ;; open helm buffer inside current window, not occupy whole other window
;	helm-ff-skip-boring-files t
	)
;   (setq helm-never-delay-on-input nil)
   (setq helm-ff-auto-update-initial-value nil)
   (setq helm-candidate-number-limit 100)

   ;is too slow for me
   (setq helm-buffer-skip-remote-checking t)

   (setq
;	helm-buffers-fuzzy-matching t
;	helm-recentf-fuzzy-matching t
;	helm-M-x-fuzzy-matching t
	helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.

	)
   (helm-mode 1)
   ;(helm-adaptative-mode 1)
   (helm-autoresize-mode 1)

   (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
   (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)


   ;; show minibuffer history with Helm
   (define-key minibuffer-local-map (kbd "M-p") 'helm-minibuffer-history)
   (define-key minibuffer-local-map (kbd "M-n") 'helm-minibuffer-history)



   (defun helm-mini ()
  "Preconfigured `helm' lightweight version \(buffer -> recentf\)."
  (interactive)
  (require 'helm-files)
  (unless helm-source-buffers-list
    (setq helm-source-buffers-list
          (helm-make-source "Buffers" 'helm-source-buffers)))
  (let ((helm-ff-transformer-show-only-basename nil))
    (helm :sources helm-mini-default-sources
          :buffer "*helm mini*"
          :truncate-lines t)))


   (setq helm-mini-default-sources '(
									 helm-source-buffers-list
									 helm-source-files-in-current-dir
									 helm-source-file-name-history
									 helm-source-buffer-not-found
									 ))
   )
 :diminish helm-mode
 :bind (
		("C-h a" . helm-apropos)
		("C-x C-b" . helm-buffers-list)
		("C-x b" . helm-mini)
		("C-x C-f" . helm-find-files)
		("M-y" . helm-show-kill-ring)
		("M-x" . helm-M-x)
		("C-x c o" . helm-occur)
		("C-x c SPC" . helm-all-mark-rings)
		)
 )
(provide 'my-helm)
