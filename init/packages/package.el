(require 'package)
										;work-around for marmalade tls
(setq package-check-signature nil)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)
										; melpa blocked in atis
;(setq url-proxy-services '(("http" . "proxy.ira.uka.de:3128"))) ;("no_proxy" . "") 
(setq url-proxy-services nil)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(setq package-archives
	  '(("gnu" . "https://elpa.gnu.org/packages/")
		("marmalade" . "https://marmalade-repo.org/packages/")
		("melpa" . "http://melpa.org/packages/"))
	  )


;first, install use-package
(package-initialize 'dont-activate)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
;load just use-package
(let ((package-load-list '(all)))
  (package-initialize))
(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant


(defun my-package-exists (p)
  (let ((compare-f (lambda (alist)
					 (let ((o (car alist)))
					   (equal p o)))))	
	(cl-find-if compare-f package-archive-contents)
	)
)

;; (defun my-use-package (mode)
;;   (if (consp mode)
;; 	  (progn
;; 		(setq package (cdr mode))
;; 		(setq mode (car mode)))
;; 	(setq package mode))
  
;;   (setq args nil)
;;   (if (my-package-exists package)
;; 	  (setq args (append args (list ':ensure package))))
;;   (let*
;; 	  (
;; 	   (filename (my-init-file-name mode))
;; 	   (do-load (file-exists-p filename))
;; 	   (manual-load (and do-load (not (member mode my-package-load-list-converted))))
;; 	   )
;; 	(if (and do-load (not manual-load))
;; 		(let* ((use-package-options (when do-load
;; 									  (my-read-sexp-from-file filename))))
;; 		  (message (concat "Loading settings from " filename))
;; 		  (setq args (append args use-package-options))
;; 		  (prin1 args)
;; 		  ))
;; 	;(prin1 args)
;; 	(eval `(use-package ,mode :defer t ,@args))
;; 	(if manual-load
;; 		(load-file filename)
;; 	  ))
;;   t
;;   )
