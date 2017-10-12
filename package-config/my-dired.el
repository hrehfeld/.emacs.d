(use-package dired
  :bind ("C-x C-j" . dired-jump)
  :config
  (use-package dired-x
    :init (setq-default dired-omit-files-p t)
    :config
    (add-to-list 'dired-omit-extensions ".DS_Store"))
  (customize-set-variable 'diredp-hide-details-initially-flag nil)
  (use-package dired+ :ensure t)
  (use-package dired-aux
    :init (use-package dired-async))
  (put 'dired-find-alternate-file 'disabled nil)
  (setq ls-lisp-dirs-first t
        dired-recursive-copies 'always
        dired-recursive-deletes 'always
        dired-dwim-target t
        ;; -F marks links with @
        dired-ls-F-marks-symlinks t
        delete-by-moving-to-trash t
        ;; Auto refresh dired
        global-auto-revert-non-file-buffers t
        wdired-allow-to-change-permissions t)
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  (define-key dired-mode-map (kbd "C-M-u") 'dired-up-directory)
  ;;(define-key dired-mode-map (kbd "M-o") #'my/dired-open)
  (define-key dired-mode-map (kbd "C-x C-q") 'wdired-change-to-wdired-mode)
  (bind-key "l" #'dired-up-directory dired-mode-map)
  (bind-key "M-!" #'async-shell-command dired-mode-map)
  (add-hook 'dired-mode-hook #'hl-line-mode)
  ;;(add-hook 'dired-mode-hook #'my/dired-mode-hook)
  )
(provide 'my-dired)
