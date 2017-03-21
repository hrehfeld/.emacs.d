(use-package tramp
  :ensure t
  :config (progn
			(when (eq system-type 'windows-nt)
			  (setq tramp-default-method "plink")
			  )))
(use-package tramp-sh
  :config (progn
			(add-to-list 'tramp-remote-path "/usr/local/sbin")
			(add-to-list 'tramp-remote-path "/opt/java/current/bin")
			(add-to-list 'tramp-remote-path "~/bin")))

(provide 'my-tramp)
