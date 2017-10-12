;; if we need more debugging
;(set 'message-log-max 1000)
;(set 'max-specpdl-size (expt 2 16))
;(set 'max-lisp-eval-depth (expt 2 16))
;(set 'debug-on-error t)

(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p custom-file)	(load custom-file))

(setq my/init-dirs
	  (mapcar (lambda (p) (concat user-emacs-directory p))
			  '("package-config" "config" "private-config")))


(mapc (lambda (d) (add-to-list 'load-path d)) my/init-dirs)

(setq my/package-dirs (list (concat user-emacs-directory "my-packages")))


(defun my/byte-compile-init-files ()
  (interactive)
  (mapc (lambda (dir) (byte-recompile-directory dir 0 t)) my/init-dirs)
  (byte-recompile-file (concat user-emacs-directory "init-essential.el") t 0 t)
  (byte-recompile-file user-init-file t 0 t))

;; (my/byte-compile-init-files)


(require 'my-package)
(setq req-package-log-level 'trace)


(global-set-key (kbd "<f8>") (lambda () (interactive) (load-file "~/.emacs.d/init.el")))

;; for easier conversion
;; (global-set-key (kbd "<f9>") (lambda () (interactive) (insert (concat "(provide '" (file-name-base (buffer-file-name)) ")\n"))))



(defmacro use-packages (&rest pkgs)
  (let ((forms (mapcar (lambda (pkg) `(use-package ,pkg)) pkgs)))
	`(progn ,@forms)))

(provide 'init-essential)
