;guess indentation
(use-package dtrt-indent
  :ensure dtrt-indent
  :init
  (progn
    (add-hook 'prog-mode-hook (lambda () (dtrt-indent-mode t)))
    (setq dtrt-indent-verbosity 0)
    )
  )

