(use-package matlab-mode
  :disabled t
  :ensure t
  :config (setq matlab-indent-function t)

  :mode (
		 ("\\.m$\\'" . matlab-mode)
		 )
  )
