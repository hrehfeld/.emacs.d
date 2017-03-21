(use-package private-mail)
(use-package mu4e
  :config (progn
	    ;;smtp config is in private.el
	    
	    ;; don't keep message buffers around
	    (setq message-kill-buffer-on-exit t)

	    (setq mu4e-use-fancy-chars t)
		(add-hook 'mu4e-view-mode-hook (lambda () (variable-pitch-mode 1)))


	    ;; default
	    (setq mu4e-maildir (getenv "MAILDIR"))


	    ;; allow for updating mail using 'U' in the main view:
		(setq mu4e-get-mail-command "true"
			  mu4e-update-interval 60
			  ;;mu4e-hide-index-messages t
			  mu4e-confirm-quit nil
			  mu4e-context-policy 'pick-first
			  )

	    
	    )
  :bind (("<f2>" . mu4e))
  )
(provide 'my-mu4e)
