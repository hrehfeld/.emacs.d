(use-package yasnippet
  :ensure t
  :config
  (progn
;	(add-to-list 'yas-snippet-dirs `(,(concat (file-name-as-directory user-emacs-directory) "yasnippet/snippets")))
;	(setq yas-prompt-functions '(yas-ido-prompt  yas-completing-prompt))
	(setq yas-indent-line 'auto)
	(yas-global-mode 1)

	(define-key yas-minor-mode-map [(tab)] nil)
	(define-key yas-minor-mode-map (kbd "TAB") nil)
	(define-key yas-minor-mode-map (kbd "C-c e") 'yas-expand)
	)
)
(provide 'my-yasnippet)
