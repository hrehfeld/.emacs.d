(use-package visible-mark
  :ensure visible-mark
  :defer t
  :config
  (setq visible-mark-max 16)
  (global-visible-mark-mode t)
  )
(provide 'my-visible-mark)
