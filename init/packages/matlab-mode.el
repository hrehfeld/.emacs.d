(use-package matlab-mode
  :ensure matlab-mode
  :config (setq matlab-indent-function t)

  :mode (
		 ("\\.m$\\'" . matlab-mode)
		 )
  )
