(setq mingw-path "Z:/pdk/usr/local/bin/MinGW-w64_64_bit/")
(setq mingw-version "4.7.2")
(setq mingw-variant "x86_64-w64-mingw32")

;(setq mingw-path "z:/pdk/usr/manual/MinGW_4.6/")
;(setq mingw-version "4.6.2")
;(setq mingw-variant "mingw32")


(defun my-auto-complete-clang-setup ()
  (progn
	(setq-default ac-clang-flags
				  (append (list
						   "-cc1"
						   "-fmsc-version=1700"
						   "-fms-extensions"
						   "-nostdinc++"
						   "-code-completion-macros"
						   "-code-completion-patterns"
						   "-std=c++11"
										; "-ferror-limit=200"
						   )
						  (let ((make-include-param (lambda (e) (concat "-I" (file-truename (file-name-as-directory e))))))
							(mapcar  make-include-param
									 (if win32
										 (append
										  (split-string "
d:/my-stuff/libs/assimp--2.0.863-sdk/include
d:/my-stuff/masterlib/src
"
														"\n")
										  (let ((path "d:/my-stuff/Framework/Source"))
											(if (file-readable-p path)
												(directory-files path t nil t)))
										  (list (concat mingw-path "include/"))
										  (list (concat mingw-path mingw-variant "/include/"))
										  (list (concat mingw-path "include/c++/" mingw-version))
										  (list (concat mingw-path "include/c++/" mingw-version "/" mingw-variant))
										  (list (concat mingw-path "lib/gcc/" mingw-variant "/" mingw-version "/include"))
										  (list (concat mingw-path "lib/gcc/" mingw-variant "/" mingw-version "/include/c++"))
										  (list (concat mingw-path "lib/gcc/" mingw-variant "/" mingw-version "/include/c++/mingw32"))
										  
										  (list (file-truename (concat (getenv "DXSDK_DIR") "Include")))
										  (list (file-truename (getenv "CUDA_INC_PATH")))
										  (list (file-truename (getenv "BOOST_ROOT")))
										;(list (file-truename (concat (getenv "VS100COMNTOOLS") "../../VC/include")))
										;(list (file-truename (concat (getenv "VS110COMNTOOLS") "../../VC/include")))
										  
										  ))))))
										;(setq ac-user-dictionary-files (concat (file-name-as-directory user-emacs-directory) ".dictionary"))

	(setq-default ac-clang-cflags ac-clang-flags)


	;; (setq-default ac-sources 
	;; 				 '(;ac-source-abbrev 
	;;                 ;ac-source-dictionary
	;; 				   ac-source-words-in-same-mode-buffers))
										;   (require 'auto-complete-clang)
	(if (fboundp 'ac-complete-clang-async)
		(add-hook 'c-mode-common-hook 
				  (lambda () 
					(local-set-key (kbd "C-c C-.") 'ac-complete-clang-async)
					(add-to-list 'ac-sources 'ac-source-clang-async)
;					(setq ac-sources '(ac-source-clang-async))
					(ac-clang-launch-completion-process)
					;(add-hook 'kill-buffer-hook (lambda ()
					;							  (if ac-clang-completion-process
					;								  (delete-process ac-clang-completion-process))))
					))
	  (if nil (when-available 'ac-complete-clang
					(progn 
					  (setq ac-clang-executable "clang++")
					  (setq ac-clang-executable "z:/pdk/home/hrehfeld/.emacs.d/emacs-clang-complete-async/clang-test.bat")
					  (make-variable-buffer-local 'ac-clang-flags)

					  ))))
	(if nil 
		(when-available 'flymake
					(progn
					  (defun flymake-clang-init ()
						(let* ((temp-file (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace-extension))
							   (local-file (expand-file-name temp-file))
							   (cmd (list ac-clang-executable (append ac-clang-flags (list local-file)))))
						  cmd))

					  (defun flymake-clang-load ()
						(interactive)
						(unless (eq buffer-file-name nil)
						  (mapc (lambda (ext) (add-to-list 'flymake-allowed-file-name-masks
														   `(,ext flymake-clang-init)))
								'("\\.cc\\'" "\\.cpp\\'" "\\.h\\'" "\\.hpp\\'"))
						  (make-variable-buffer-local 'flymake-err-line-patterns)
						  (setq flymake-err-line-patterns
								'(("^\\(\\([a-zA-Z]:\\)?[^:(	\n]+\\):\\([0-9]+\\):\\([0-9]+\\): \\(\\(error\\|warning\\|fatal error\\):[ 	]+\\(.+\\)\\)" 1 3 4 5)))
						  (flymake-mode t)))
					  
					  (mapc (lambda (mode) (add-hook mode 'flymake-clang-load)) '(c-mode-hook c++-mode-hook))
					  )))
	))

(when-available 'auto-complete
 (progn
   (my-auto-complete-clang-setup)
   ;(define-key ac-mode-map (kbd "C-TAB") 'auto-complete)
   (global-auto-complete-mode t)
   

   
   ;(setq ac-quick-help nil)
   (setq ac-quick-help-delay 0.1)
   (setq ac-auto-show-menu 0.5)
   (setq ac-ignore-case t)
   
   ;(setq ac-fuzzy-enable t)
   t)
)



