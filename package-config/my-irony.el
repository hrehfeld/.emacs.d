(use-package irony
  :ensure t
  :defer t
  :commands 'irony-mode
  :config
  (progn
	(setq irony-user-dir (concat user-emacs-directory "temp/irony"))
	(setq irony-clang-options-updated-hook nil)
	(add-hook 'c++-mode-hook 'irony-mode)
	(add-hook 'c-mode-hook 'irony-mode)
	(add-hook 'objc-mode-hook 'irony-mode)
))

(provide 'my-irony)
