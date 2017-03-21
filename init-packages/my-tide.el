(use-package tide
  :ensure t
  :config
  (progn
    (add-hook 'typescript-mode-hook
              (lambda ()
                (tide-setup)
                ))
    )
  )

(provide 'my-tide)
