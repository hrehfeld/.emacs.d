(use-package multiple-cursors
  :ensure multiple-cursors
  :init (progn
		  (global-set-key (kbd "C-M->") 'mc/mark-next-like-this)
		  (global-set-key (kbd "C-M-<") 'mc/mark-previous-like-this)
		  (global-set-key (kbd "C->") 'mc/mark-next-word-like-this)
		  (global-set-key (kbd "C-<") 'mc/mark-previous-word-like-this)
		  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
		  (global-set-key (kbd "C-x r t") 'mc/edit-lines)
))

