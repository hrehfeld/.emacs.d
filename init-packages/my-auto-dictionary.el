(use-package auto-dictionary
  :ensure auto-dictionary
  :config
  (add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1)))
  )
(provide 'my-auto-dictionary)
