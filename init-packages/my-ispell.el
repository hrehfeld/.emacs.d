;;spelling
;; C-. is the spelling prefix key

(setq ispell-dictionary "english"
	  ispell-alternate-dictionary "german8"
	  ispell-extra-args '("--sug-mode=ultra" "--ignore=2")
	  ispell-personal-dictionary "~/.flyspelldict"
	  )

(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+"))
(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))

(setq flyspell-issue-message-flag nil)

(global-set-key (kbd "C-. b") 'flyspell-buffer)

(defun hrehf-ispell-toggle-dictionary () (interactive)
  (let ((alt-dict ispell-alternate-dictionary))
	(setq ispell-alternate-dictionary ispell-dictionary)
	(setq ispell-dictionary alt-dict)
	(message (concat "Toggled ispell-dictionary to '" ispell-dictionary "'"))
	))
(global-set-key (kbd "C-. d") 'hrehf-ispell-toggle-dictionary)

(provide 'my-ispell)
