(use-package dynamic-fonts
  :ensure t
  :config (progn
	  (setq dynamic-fonts-preferred-monospace-point-size 11)
	  (dynamic-fonts-setup))
  )
(provide 'my-dynamic-fonts)
