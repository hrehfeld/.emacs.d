;;spelling
;; C-. is the spelling prefix key

(setq ispell-dictionary "english"
	  ispell-alternate-dictionary "german8")
(setq ispell-extra-args '("--sug-mode=ultra"))

(setq flyspell-issue-message-flag nil)
(global-set-key (kbd "C-. b") 'flyspell-buffer)

(defun hrehf-ispell-toggle-dictionary () (interactive)
  (let ((alt-dict ispell-alternate-dictionary))
	(setq ispell-alternate-dictionary ispell-dictionary)
	(setq ispell-dictionary alt-dict)
	(message (concat "Toggled ispell-dictionary to '" ispell-dictionary "'"))
	))
(global-set-key (kbd "C-. d") 'hrehf-ispell-toggle-dictionary)
