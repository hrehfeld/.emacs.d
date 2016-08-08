(use-package org
  :ensure org
  :config
  (progn
	(load-file (concat user-emacs-directory "/init/packages/org-config.el"))
	)
  :commands (
			 org-agenda
			 org-iswitchb
			 org-store-link
			 org-insert-link
			 org-capture
			 )
  :bind (
		 ("C-c a" . org-agenda)
		 ("C-c b" . org-iswitchb)
		 ("C-c l" . org-store-link)
		 ("C-c L" . org-insert-link)
		 ("C-c c" . org-capture)
		 ("C-c C-x C-x" . org-clock-in-last)
		 ("C-c C-x C-o" . org-clock-out)
		 )
  )
