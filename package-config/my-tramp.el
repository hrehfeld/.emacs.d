(use-package tramp
  :ensure t
  :config (progn
			(when (eq system-type 'windows-nt)
			  (setq tramp-default-method "plink")
			  )))

(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

(defun my/tramp-remote-matches (server)
  "return t if in a tramp buffer on server SERVER"
  (let ((re (concat "^/.+:" server ":")))
	(string-match re (buffer-file-name))))

(use-package tramp-sh
  :config (progn
			(add-to-list 'tramp-remote-path "/usr/local/sbin")
			(add-to-list 'tramp-remote-path "/opt/java/current/bin")
			(add-to-list 'tramp-remote-path "~/bin")))

(provide 'my-tramp)
