(use-package cmake-project :ensure t
  :config (progn
			;(setq-default cmake-project-build-directory nil)

			(defun my/cmake-project-enable ()
			  (interactive)
										;(cmake-project-mode 0)
			  (if cmake-project-build-directory
										;(message (concat "cmake-project-build-directory " (buffer-file-name)))
										;(prin1 cmake-project-build-directory)
										;(message "cmake-project-build-directoryend" )
				  (cmake-project-mode 1)
				)
			  )

			(let ((enable
				   (lambda () (add-hook 'hack-local-variables-hook
										'my/cmake-project-enable t t))))
			  (add-hook 'c-mode-hook enable)
			  (add-hook 'c++-mode-hook enable)
			  )
			(defun my/cmake-project-dir-from-cmake-ide ()
			  (when cmake-ide-build-dir
				;; (message "setting build dir" cmake-ide-build-dir)
				(setq cmake-project-build-directory cmake-ide-build-dir)))
			;; (add-hook 'cmake-project-mode-hook
			;; 							;(lambda () (run-with-timer 10 nil
			;; 		  'my/cmake-project-dir-from-cmake-ide)
										;))
			;(setq cmake-project-mode-hook nil)
			)
  )
(provide 'my-cmake-project)
