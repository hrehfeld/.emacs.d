(use-package my-org
  :config 
  (use-package org-caldav
  :ensure t
  :defer 10
  :config (progn
	    (setq
	     ;; important: also sync caldav state when syncing agenda files
	     org-caldav-save-directory org-directory
	     org-icalendar-timezone "utc"
		 org-icalendar-use-scheduled nil
	     ;;also see private.el
	     )
	    )
  :bind (("<f11>" . org-caldav-sync))
  ))
(provide 'my-org-caldav)

