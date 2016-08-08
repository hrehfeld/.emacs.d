(use-package floobits
  :ensure t
  :config (progn
            (setq bookmark-save-flag t)
            (global-set-key (kbd "<F6>") 'floobits-follow-mode-toggle)
            )
  )
