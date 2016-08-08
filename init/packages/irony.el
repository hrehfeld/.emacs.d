(use-package irony
  :ensure t
  :defer t
  :commands 'irony-mode
  :init
  (progn
	(add-hook 'c++-mode-hook 'irony-mode)
	(add-hook 'c-mode-hook 'irony-mode)
	(add-hook 'objc-mode-hook 'irony-mode)
	)

  :config
  (progn
	(setq irony-user-dir (concat user-emacs-directory "temp/irony"))
	(setq irony-clang-options-updated-hook nil)
))

