(use-package flycheck
  :config
(if (symbolp 'global-flycheck-mode)
    (add-hook 'after-init-hook (lambda () (setq global-flycheck-mode t))))

(defun my/check-prefix (prefix string f)
  (if (string-prefix-p prefix string)
	(let ((path (substring string (length prefix))))
	  (funcall f path)
	  )))

(defun my/flycheck-fill-clang-from-irony (options)
  (mapc (lambda (o)
		  (my/check-prefix "-I" o (lambda (path) (add-to-list 'flycheck-clang-include-path path)))
		  (my/check-prefix "-D" o (lambda (path) (add-to-list 'flycheck-clang-definitions path)))
		  (my/check-prefix "-W" o (lambda (w) (add-to-list 'flycheck-clang-warnings w)))
		  (my/check-prefix "-std=" o (lambda (std) (setq flycheck-clang-language-standard std)))
		  )
		options))

;(setq flycheck-before-syntax-check-hook nil)
(add-hook
 'flycheck-before-syntax-check-hook
 (lambda ()
   (when (boundp 'irony--clang-options)
	 (my/flycheck-fill-clang-from-irony irony--clang-options)))
 )

(setq flycheck-idle-change-delay 1.7
	  flycheck-check-syntax-automatically '(save idle-change mode-enabled)
	  flycheck-highlighting-mode 'columns
	  )
)
(provide 'my-flycheck)
