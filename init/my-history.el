(setq mark-ring-max 128)
(setq global-mark-ring-max 128)

;; When you visit a file, point goes to the last place where it was
;; when you previously visited the same file.
(use-package saveplace
  :config
(setq-default
 save-place t
 save-place-limit 9999
 )
)
(setq history-length 1000)

(setq recentf-max-saved-items 999)



; http://www.emacswiki.org/emacs/EmacsClient
;emacsclient (or better, emacs server) does not care about save-place
;being active. I suppose this is a bug. A temporary workaround to this
;is to set
(add-hook 'server-visit-hook 'save-place-find-file-hook)

;; save bookmarks on every action
(setq bookmark-save-flag 1)
;(global-set-key (kbd "<f2> b") 'bookmark-map)


(savehist-mode 1)
(add-to-list 'savehist-additional-variables 'kill-ring t)
(add-to-list 'savehist-additional-variables 'search-ring t)
(add-to-list 'savehist-additional-variables 'regexp-search-ring t)


;; session management
(setq desktop-base-file-name (concat (system-name) "_" (replace-regexp-in-string "\\/" "-" (symbol-name system-type)) ".desktop"))
;(set 'desktop-path (list (expand-file-name (concat (file-name-as-directory user-emacs-directory)
;                                                   (file-name-as-directory "desktop")
;                                                   (file-name-as-directory system-name)))))

(setq desktop-buffers-not-to-save
	  (concat "\\("
              "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
              "\\|\\.emacs.*\\|.*\\.desktop\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
			  "\\)$")
      desktop-modes-not-to-save
      '(tags-table-mode
		realgud-short-key-mode)
      )

(setq desktop-restore-eager 1)

;; this is at the end, because it can fail
(require 'desktop)
(add-to-list 'desktop-minor-mode-table '(cmake-project-mode nil))


(desktop-save-mode 1)
(mapc (lambda (v) (add-to-list 'desktop-globals-to-save v))
	  '(
		file-name-history
		kill-ring
		))

(provide 'my-history)
