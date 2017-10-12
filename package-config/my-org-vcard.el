(use-package org-vcard
  :config
  (progn
	(setq org-vcard-append-to-existing-export-buffer nil
		  org-vcard-default-export-file (concat org-directory "contacts_import.org")
		  org-vcard-default-import-file "~/.contacts/contacts.vcf"
		  org-vcard-default-language "en"
		  org-vcard-include-import-unknowns t
		  )
	(defun my/org-vcard-import ()
	  (let ((version org-vcard-default-version)
			(language org-vcard-default-language)
			(style org-vcard-default-style))
		(org-vcard-transfer-helper
		 ;;org-vcard-default-export-file
		 ;;org-vcard-default-import-file
		 "file"
		 "file"
		 style language version 'import)
	  ))))
