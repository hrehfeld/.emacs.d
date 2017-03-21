(use-package eldoc
  :ensure t
  :diminish eldoc-mode
  :config
  (progn
	(add-hook 'emacs-lisp-mode-hook (lambda () (eldoc-mode 1)))
	))
(provide 'my-eldoc)
