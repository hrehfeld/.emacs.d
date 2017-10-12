(global-font-lock-mode 1)

;; highlight matching parentheses
(show-paren-mode 1)
(setq show-paren-style 'mixed)

;; echo keystrokes earlier
(setq echo-keystrokes 0.2)

(defface line-length-limit
  '((((background dark)) (:underline "#ff0")))
  "Face when more than 100 characters are in a line.")

(set-face-attribute 'minibuffer-prompt nil :foreground "black" :background "chartreuse")

;; getting rid of the “yes or no” prompt and replace it with “y or n”:
(fset 'yes-or-no-p 'y-or-n-p)
;; And finally, the recently-added prompt in Emacs 23.2 that asks you if you want to kill a buffer with a live process attached to it:
(setq kill-buffer-query-functions nil)





(global-set-key (kbd "C-<wheel-up>") 'text-scale-increase)
(global-set-key (kbd "C-<wheel-down>") 'text-scale-decrease)
;linux wheel
(global-set-key (kbd "C-<mouse-4>") 'text-scale-increase)
(global-set-key (kbd "C-<mouse-5>") 'text-scale-decrease)

(use-package default-text-scale
  :ensure t
  :bind (
	 ("C-S-<wheel-up>" . default-text-scale-increase)
	 ("C-S-<wheel-down>" . default-text-scale-decrease)
					;linux wheel
	 ("C-S-<mouse-4>" . default-text-scale-increase)
	 ("C-S-<mouse-5>" . default-text-scale-decrease))
  )

(provide 'my-display)




