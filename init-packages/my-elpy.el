(use-package elpy
  :ensure elpy
  :config
  (progn
	(elpy-enable)
	(setq elpy-rpc-backend "rope")
	  
	  (defun pdb-restart ()
		(interactive)
		(comint-insert-send "restart")
		(sleep-for 1)
		(when
			(or
			 (last-lines-match "raise Restart.*
Restart")
			 (last-lines-match "restart")
			 (not (get-buffer-process (current-buffer)))
			 )
		  
		  (let (
				(kill-buffer-query-functions nil );disable confirming for process kill
				(pdbcmd (car-safe (symbol-value (gud-symbol 'history nil 'pdb))))
				(default-directory default-directory)
				)
			(kill-this-buffer)
			(cd default-directory)
			(realgud:pdb pdbcmd)
			(prin1 "test")
			)
		  )
		(comint-insert-send "n")
		)
	  (defun comint-insert-send (input)
		(insert input)
		(comint-send-input)
		)
	  (defun last-lines-match (regexp &optional n)
		(setq n (or n 3))
		(re-search-backward regexp (line-beginning-position (- 0 n)) t))

	  (add-hook 'python-mode-hook (lambda () (progn
										  (local-set-key (kbd "<f5>") 'realgud:pdb)
										  (local-set-key (kbd "S-<F5>") 'realgud:cmd-quit))))
	  )
  :bind (("M-," . pop-tag-mark))
  )
(provide 'my-elpy)
