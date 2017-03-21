(use-package color-theme-modern
  :ensure t
;  :demand
  :config
  (progn
    (load-theme 'standard t t)
    (enable-theme 'standard)
	  ;(color-theme-initialize)
	  ;(setq color-theme-is-global t)
	  ;(color-theme-standard)
))
(provide 'my-color-theme-modern)
