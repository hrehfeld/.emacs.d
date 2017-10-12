(use-package helm-flyspell
  :ensure t
  :config (define-key flyspell-mode-map (kbd "C-;") 'helm-flyspell-correct)
  )
(provide 'my-helm-flyspell)
