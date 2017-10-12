(use-package semantic
  :ensure t
  :config
  (progn

	(require 'semantic/ia)
    (require 'semantic/wisent)
	
    (setq
     semanticdb-default-save-directory (concat user-emacs-directory "tmp/semanticdb/")
     )

    (add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
    (add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
    (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
    (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
    (add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
    (add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)

    (defun my-semantic-find-definition (arg)
      "Jump to the definition of the symbol, type or function at point.
  With prefix arg, find in other window."
      (interactive "P")
      (let* ((tag (or (semantic-idle-summary-current-symbol-info-context)
		      (semantic-idle-summary-current-symbol-info-brutish)
		      (error "No known tag at point")))
	     (pos (or (semantic-tag-start tag)
		      (error "Tag definition not found")))
	     (file (semantic-tag-file-name tag)))
	(message "%s %s" file pos)
	(if file
	    (if arg (find-file-other-window file) (find-file file))
	  (if arg (switch-to-buffer-other-window (current-buffer))))
	(push-mark)
	(goto-char pos)
	;; 	(end-of-line)
	))
    (set-default 'semantic-case-fold t)

    ;; (require 'semantic/bovine/c)
    ;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file
    ;; 				"/usr/lib/gcc/x86_64-linux-gnu/4.8/include/stddef.h")
	(add-hook 'java-mode-hook (lambda () (semantic-mode 1)))
    )
;;  :bind (
	 ;; 		("C-c p p" . helm-projectile-switch-project)
;;	 )
  )

(provide 'my-semantic)
