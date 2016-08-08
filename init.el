
(defun load-init (name)
  (interactive)
  (load-file (concat user-emacs-directory "/init/" name ".el"))
  )

;(set 'message-log-max 1000)
;(set 'max-specpdl-size (expt 2 16))
;(set 'max-lisp-eval-depth (expt 2 16))
;(set 'debug-on-error t)

(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p custom-file)	(load custom-file))



(defun my-read-sexp-from-file (filename)
  (with-temp-buffer (insert-file-contents filename) (read (current-buffer))))

(setq my-init-file-dir (concat user-emacs-directory "init/"))
(defun my-init-file-name (package)
  (let ((package (if (symbolp package) (symbol-name package) package)))
	(concat (file-name-as-directory my-init-file-dir) "init-" package ".el")))
(defun my-load-init-file (package)
  (let ((package-file (my-init-file-name package)))
	(if (file-exists-p package-file)
		(load-file package-file))))

(defun my-use-package (package)
  (assert (symbolp package))
  (let* (
		 (package-name (symbol-name package))
		 (package-file
		 (concat (file-name-as-directory my-init-file-dir)
				 (file-name-as-directory "packages")
				 package-name
				 ".el")))
	(if (file-exists-p package-file)
		(load-file package-file)
	  (progn
		;(message (concat "File not found '" package-file "'"))
		(use-package package :ensure package)
		)
	  
	  )))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Category System Specific Options
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Define OS
(defconst win32
  (eq system-type 'windows-nt)
  "Are we running on a Win system?")
(defconst linux
    (or (eq system-type 'gnu/linux)
        (eq system-type 'linux))
  "Are we running on a GNU/Linux system?")

(if linux
    (setq boost-path "/usr/include/boost"))

(defmacro when-available (func init-code)
  "*Do something if FUNCTION is available."
  `(if (boundp ,func)
	   ,init-code
	(eval-after-load ,func (quote ,init-code)
							   ))
)


(add-to-list 'safe-local-variable-values
             '(cmake-ide-cmake-command . "cmake -DRTCORE_TASKING_SYSTEM=Off -DENABLE_ISPC_SUPPORT=Off"))

;(load-init "init-base")
(load-init "init-utils")
(load-init "init-modes")
(load-init "init-display")
(load-init "init-settings")
(load-init "init-history")
(load-init "private")

