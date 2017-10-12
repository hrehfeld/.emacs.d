(use-package private-org-contacts
  :config
(use-package org-contacts
  :config
  (progn
	(add-to-list 'org-capture-templates
				 '("C" "Contact" entry (file my/org-contacts-file)
				   "* %(org-contacts-template-name)
:PROPERTIES:
:EMAIL: %(org-contacts-template-email)
:END:"))
	
	))
)
(provide 'my-org-contacts)
