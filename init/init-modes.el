
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Category Modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'prog-mode-hook 'subword-mode)

;(my-load-init-file 'mu4e)
;(my-load-init-file 'highlight-changes)
;(my-load-init-file 'mark)

(my-use-package 'package)
(my-use-package 'helm)
(my-use-package 'org)
(my-use-package 'org-caldav)
(my-use-package 'orgbox)

(my-use-package 'mode-line)

(my-use-package 'hydra)

(my-use-package 'el-get)

(my-use-package 'magit)
(my-use-package 'monky) ;magit for hg

(my-use-package 'auto-dictionary)
(my-use-package 'cmake-project)
(my-use-package 'dtrt-indent)
(my-use-package 'frame-fns)
;this was breaking helm
;(my-use-package 'ggtags)
;seems to break helm?!
;(my-use-package 'helm-cmd-t)
(my-use-package 'helm-ag)
(my-use-package 'helm-descbinds)
;(my-use-package 'helm-gtags)
(my-use-package 'helm-swoop)
(my-use-package 'highlight-symbol)
(my-use-package 'js2-mode)
(my-use-package 'tide)
(my-use-package 'tern)
;(my-use-package 'minimap)
(my-use-package 'multiple-cursors)
(my-use-package 'org-context)
;(my-use-package 'org-page)
(my-use-package 'palette)
(my-use-package 'rainbow-delimiters)
(my-use-package 'smart-mode-line)
(my-use-package 'smarty-mode)
(my-use-package 'synonyms)
(my-use-package 'visible-mark)
(my-use-package 'yasnippet)

;(my-use-package 'workgroups)
;(my-use-package 'purpose)
;(my-use-package 'helm-purpose)

;(my-use-package 'golden-ratio)
(my-use-package 'window-numbering)
;
;;; ;breaks with some packages!?
;;; ;(my-use-package 'auto-package-update)
(my-use-package 'auctex)
(my-use-package 'haskell-mode)
(my-use-package 'apache-mode)
(my-use-package 'cmake-mode)
(my-use-package 'color-theme-modern)
(my-use-package 'color-file-completion)
(my-use-package 'company)
(my-use-package 'company-math)
(my-use-package 'company-quickhelp)
(my-use-package 'company-tern)
(my-use-package 'control-lock)
(my-use-package 'cppcheck)
;(my-use-package 'cpputils-cmake)
(my-use-package 'crontab-mode)
(my-use-package 'css-mode)
(my-use-package 'csv-mode)
(my-use-package 'diff-hl)
(my-use-package 'dircmp)
(my-use-package 'evil-search-highlight-persist)
;(my-use-package 'flymake-checkers)
;(my-use-package 'flymake-css)
;(my-use-package 'flymake-haskell-multi)
;(my-use-package 'flymake-json)
(my-use-package 'flycheck)
(my-use-package 'glsl-mode)
(my-use-package 'gnuplot)
(my-use-package 'gtags)
(my-use-package 'imgur)
(my-use-package 'jabber)
(my-use-package 'javadoc-help)
(my-use-package 'jedi)
(my-use-package 'js2-mode)
(my-use-package 'json-mode)
(my-use-package 'latex-extra)
(my-use-package 'legalese)
(my-use-package 'levenshtein)
(my-use-package 'markdown-mode)
(my-use-package 'multiple-cursors)
(my-use-package 'mc-extras)
(my-use-package 'anzu)
(my-use-package 'phi-search)
(my-use-package 'phi-search-mc)
(my-use-package 'nxml-mode)
(my-use-package 'php-mode)
(my-use-package 'projectile)
(my-use-package 'helm-projectile)
(my-use-package 'realgud)
(my-use-package 'smart-tabs-mode)
(my-use-package 'speed-type)
(my-use-package 'sticky-windows)
(my-use-package 'string-inflection)
(my-use-package 'typescript)
(my-use-package 'tiny)
(my-use-package 'window-jump)

;(my-load-init-file "semantic")

;modes that don't load on package init

(my-load-init-file "spell")

;modes

(my-load-init-file "calendar")


(my-use-package 'info-look)
;for testing
(my-use-package 'c++-system)
(my-use-package 'cc-mode)
(my-use-package 'irony)
(my-use-package 'company-c-headers)
(my-use-package 'company-irony)
(my-use-package 'rtags)
(my-use-package 'cmake-ide)

(my-use-package 'elpy)
(my-use-package 'my/python)
(my-use-package 'realgud)



(my-use-package 'mpc)



;not in elpa yet?
;TODO
(when-available 'hlsl-mode (add-to-list 'auto-mode-alist '("\\.hlsl\\'" . hlsl-mode)))
;; hlsl
(font-lock-add-keywords 'hlsl-mode
						'(("__hlsl_[^	 (){}\[\]]+" . font-lock-keyword-face)))


;(my-load-init-file "irony")


(my-use-package 'dim)

