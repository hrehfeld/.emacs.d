(use-package js2-mode
  :ensure js2-mode
  :mode ("\\.js$" . js2-mode)
  :init (progn
          (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
          (add-hook 'js-mode-hook 'js2-minor-mode)
          )

)
