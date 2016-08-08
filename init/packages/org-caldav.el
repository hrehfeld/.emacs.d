(use-package org-caldav
  :ensure t
  :config (progn
		  (setq
		   ;important: also sync caldav state when syncing agenda files
		   org-caldav-save-directory org-directory
		   org-icalendar-timezone "utc"
		   ;also see private.el
		   )
		  )
  )
