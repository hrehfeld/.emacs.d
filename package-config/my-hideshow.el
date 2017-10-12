(use-package hideshow
  :bind
  ("C-c C-<f1>". hs-show-block)
  ("C-c C-<f2>".  hs-hide-block)
  ("C-c C-<f3>".    hs-hide-all)
  ("C-c C-<f4>".  hs-show-all)
  :diminish hs-minor-mode
  :config (hs-minor-mode t)
  )
(provide 'my-hideshow)


