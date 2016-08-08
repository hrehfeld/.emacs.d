(use-package cmake-ide
  :ensure t
  :init 
  :config (progn
			(setq
			 cmake-ide-flags-c++
			 (append
			  (mapcar (lambda (path) (concat "-I" path)) c++-system-include-paths)
			  '("-std=c++14")
			  )
			 )
			(if (boundp 'cmake-ide-src-extensions)
			    (add-to-list 'cmake-ide-src-extensions ".cu" t)
			  )
			(cmake-ide-setup)
			)
  )

