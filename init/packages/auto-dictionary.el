(use-package auto-dictionary
  :ensure auto-dictionary
  :init
  (add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1)))
  )
