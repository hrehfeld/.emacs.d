(use-package bbdb :ensure t
  :config
  (progn
	(bbdb-initialize 'message 'sendmail)
))
