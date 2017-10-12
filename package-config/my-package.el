;work-around for marmalade tls
;(setq package-check-signature nil)

; melpa blocked in atis
;(setq url-proxy-services '(("http" . "proxy.ira.uka.de:3128"))) ;("no_proxy" . "") 
;(setq url-proxy-services nil)

(setq package-archives
      '(
	("org" . "http://orgmode.org/elpa/")
	("gnu" . "https://elpa.gnu.org/packages/")
	("marmalade" . "https://marmalade-repo.org/packages/")
	("melpa" . "https://melpa.org/packages/"))
      )


;; (defadvice use-package-ensure-elpa (around use-package-ensure-safe activate)
;;   "Capture errors from installing packages."
;;   (condition-case-unless-debug err
;;       ad-do-it
;;     (error
;;      (ignore
;;       (display-warning 'use-package
;;                        (format "Failed to install %s: %s"
;;                                package (error-message-string err))
;;                        :error)))))

;(let ((package-enable-at-startup nil))
(require 'package)

(setq package-enable-at-startup nil)
(package-initialize)

(setq my/refreshed-this-startup nil)
(defun require-package (package &optional min-version no-refresh)
    "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
    (unless (package-installed-p package min-version)
	  (progn
	  (unless (or no-refresh my/refreshed-this-startup (assoc package package-archive-contents))
		(package-refresh-contents)
		(setq my/refreshed-this-startup t))
	  (package-install package)
	  (package-activate package)
	  )))


(setq
 use-package-debug nil
 use-package-verbose nil
 )

;; I use `use-package' to install and setup all packages except `use-pacakge'
;; itself. You can't use it if it is not already installed and activated. So
;; make sure that it is installed and setup using only built-in package.el
;; functions.
(require-package 'use-package)

(use-package req-package :ensure t)

;; We *must* install `org-plus-contrib' or `org' package very early on so that
;; these shadow the built-in org-mode files. If this is not done early, and one
;; or more of the built-in org-mode files are loaded during emacs startup, then
;; failures may arise later on while installing `org-plus-contrib' or `org'
;; packages. Typical errors in such case are "void-function
;; org-link-set-parameters" or "void-function org-link-types". Such errors
;; started popping up with spacemacs around August 2016 when emacs is started
;; after removing all installed packages which forced installation of all
;; needed packages.
;;
;; The need to install this early on is the reason for all the setup done so far.
(use-package org-plus-contrib :ensure t :defer t)

(use-package diminish :ensure t)                ;; if you use :diminish
(use-package bind-key :ensure t)                ;; if you use any :bind variant


(provide 'my-package)
