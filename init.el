;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

;; if we need more debugging
;(set 'message-log-max 1000)
;(set 'max-specpdl-size (expt 2 16))
;(set 'max-lisp-eval-depth (expt 2 16))
;(set 'debug-on-error t)

(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p custom-file)	(load custom-file))

(setq my/init-dirs (list (concat user-emacs-directory "init-packages")
						 (concat user-emacs-directory "init")))

(mapc (lambda (d) (add-to-list 'load-path d)) my/init-dirs)

;; (mapc (lambda (d) (byte-recompile-directory d 0 t)) my/init-dirs)
;; (byte-recompile-file (buffer-file-name))


(require 'my-package)
(setq req-package-log-level 'trace)


(global-set-key (kbd "<f8>") (lambda () (interactive) (load-file "~/.emacs.d/init.el")))

;; for easier conversion
;; (global-set-key (kbd "<f9>") (lambda () (interactive) (insert (concat "(provide '" (file-name-base (buffer-file-name)) ")\n"))))


(defmacro use-packages (&rest pkgs)
  (let ((forms (mapcar (lambda (pkg) `(use-package ,pkg)) pkgs)))
	`(progn ,@forms)))


;(use-package my-functions)
(use-package my-editing)
(use-package my-display)
(use-package my-security)
(use-package my-files)
(use-package my-compile)
(use-package my-sudo)
(use-package my-coding)
(use-package my-history)
(use-package my-windows)



(use-package private-safe-local-variables)

;Distinguish buffers of the same filename in Emacs
(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))



(use-package my-helm)

(use-package my-hydra)


(use-package my-org)

 ;; my-org-clock
(use-package org-clock-convenience :ensure t)

(use-package private-org-caldav)
(use-package my-org-contacts)

(use-package my-org-babel)
(use-package my-org-plantuml)

(use-package my-org-context)
 ;;org-page


(use-package orgbox :ensure t)

(use-package undo-tree :ensure t)

(use-package my-mu4e)
(use-package org-mu4e :if 'mu4e)

(use-packages
 my-ispell
 my-calendar-german
 private-calendar)


(use-package
 my-el-get)

(use-package my-subword)

(use-package magit
  :ensure t
)
(use-package monky
  :ensure t
)
(use-packages
 my-tramp
 my-dired

 my-auto-dictionary
 my-cmake-project
 my-dtrt-indent
 frame-fns
 my-gtags
 ;;ggtags ; this was breaking helm
 ;;helm-cmd-t ; seems to break helm?!
 )

(use-package helm-ag :ensure t)
(use-package helm-descbinds :ensure t)
(use-packages
 my-helm-gtags
 my-helm-swoop
 my-helm-org-rifle
 )
(use-package my-highlight-symbol)
(use-package my-semantic)
(use-packages
 my-eldoc
 my-elisp-slime-nav
 my-js2-mode
 my-tide
 my-tern
 ;;minimap
 my-multiple-cursors
 )
(use-package my-multiple-cursors-hydra :if 'hydra)
 ;;palette
(use-packages
 ;my-rainbow-delimiters
 ;smarty-mode
 ;my-yasnippet
 )
(use-package rainbow-identifiers :ensure t)
(use-packages
 ;synonyms
 my-visible-mark
 my-workgroups
 ;;purpose
 ;;helm-purpose

 ;; didnt like it
 ;;golden-ratio

 )
(use-packages
 my-window-numbering

 ;;my-auctex
 my-haskell-mode
 apache-mode
 my-cmake-mode
 my-color-theme-modern
 color-file-completion
 my-company
 my-company-math
 my-company-quickhelp
 my-company-tern
 my-control-lock
 cppcheck
 ;;cpputils-cmake
 crontab-mode
 my-css-mode
 csv-mode
 diff-hl
 dircmp
 )
(use-packages
 ;;evil-search-highlight-persist
 ;;flymake-checkers
 ;;flymake-css
 ;;flymake-haskell-multi
 ;;flymake-json
 my-flycheck
 my-flycheck-pos-tip
 glsl-mode
 gnuplot
 imgur
 jabber
 ;;javadoc-help
 jedi
 json-mode
 my-latex-extra
 legalese
 levenshtein
 markdown-mode
 mc-extras
 my-anzu
 my-phi-search
 phi-search-mc
 ; php-mode
 my-projectile
 my-helm-projectile
 my-helm-flyspell
 my-helm-flx
 my-realgud
 my-smart-tabs-mode
;; smart-tab
 speed-type
 ;;sticky-windows
 my-string-inflection
 typescript
 tiny
 ;my-window-jump
 hy-mode
 java-imports
 )


(use-package nxml-mode)

(use-packages
 my-info-look
 my-hideshow
 ;; for testing
 my-c++-system
 my-cc-mode
 my-irony
 my-company-c-headers
 my-company-irony
 my-rtags
 my-rtags-company
 ;my-cmake-ide
 my-elpy
 my-python
 my-mpc
 private-mpc
 )



;not in elpa yet?
(use-package hlsl-mode
  :mode "\\.hlsl\\'"
  :config
  (font-lock-add-keywords 'hlsl-mode
						  '(("__hlsl_[^	 (){}\[\]]+" . font-lock-keyword-face))))


(use-packages
 my-dim
 my-dynamic-fonts
 ;; Error during redisplay: (eval (mode-icons--generate-major-mode-item)) signaled (void-function nil) [3 times]
 my-mode-icons
 ;; modeline at end because it might ask for confirmation
 my-smart-mode-line
 )

(req-package-finish)

