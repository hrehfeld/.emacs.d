(use-package mu4e
  :init (progn
		  ;; default
  (setq mu4e-maildir (getenv "MAILDIR"))

  (setq mu4e-drafts-folder "/Drafts")
  (setq mu4e-sent-folder   "/Sent")
  (setq mu4e-trash-folder  "/Trash")

  ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
										;(setq mu4e-sent-messages-behavior 'delete)

  ;; (See the documentation for `mu4e-sent-messages-behavior' if you have
  ;; additional non-Gmail addresses and want assign them different
  ;; behavior.)

  ;; setup some handy shortcuts
  ;; you can quickly switch to your Inbox -- press ``ji''
  ;; then, when you want archive some messages, move them to
  ;; the 'All Mail' folder by pressing ``ma''.

  (add-hook 'mu4e-view-mode-hook (lambda () (variable-pitch-mode 1)))

  (setq mu4e-maildir-shortcuts
		`( ("/INBOX"               . ?i)
		   (,mu4e-sent-folder . ?s)
		   (,mu4e-trash-folder       . ?t)))

  ;; allow for updating mail using 'U' in the main view:
										;(setq mu4e-get-mail-command "offlineimap")

  )
  :config (progn
  ;; something about ourselves
  (setq
   mu4e-compose-signature nil
   )

  ;;smtp config is in private.el
  
  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t)

  (setq mu4e-use-fancy-chars t)

  )
  :bind (("<f2>" . mu4e))
  )
