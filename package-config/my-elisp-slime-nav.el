(use-package elisp-slime-nav
  :ensure t
  :diminish elisp-slime-nav-mode
  :config
  (progn
	(add-hook 'emacs-lisp-mode-hook (lambda () (elisp-slime-nav-mode 1)))
	))
(provide 'my-elisp-slime-nav)
