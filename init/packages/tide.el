(use-package tide
  :ensure t
  :init
  (progn
    (add-hook 'typescript-mode-hook
              (lambda ()
                (tide-setup)
                ))
    )
  )

