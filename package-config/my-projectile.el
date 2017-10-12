(use-package projectile
  :ensure t
  :diminish (projectile-mode . "proj")
  :config (progn
			(projectile-global-mode)
			(setq projectile-completion-system 'helm)
			)
 )
(provide 'my-projectile)
