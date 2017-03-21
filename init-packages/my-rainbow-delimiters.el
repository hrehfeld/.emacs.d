(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'after-change-major-mode-hook 'rainbow-delimiters-mode))
(provide 'my-rainbow-delimiters)
