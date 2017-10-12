;;------------------------------------------------------------------------------
;; highlight-changes-mode
;;------------------------------------------------------------------------------
;;set initial state to passive
;;(setq highlight-changes-initial-state 1)
;bind it to esc-esc-h
(global-set-key (kbd "C-c DEL") 'highlight-changes-visible-mode)
(global-set-key (kbd "C-c <next>") 'highlight-changes-rotate-faces)
(global-set-key (kbd "C-<prior>") 'highlight-changes-previous-change)
(global-set-key (kbd "C-<next>") 'highlight-changes-next-change)

(add-hook 'local-write-file-hooks 'highlight-changes-rotate-faces)


(setq my-highlight-changes-colors (split-string 
								   "#330000 #310303 #2F0606 #2E0909 #2C0C0D #2B0F10 #291213 #281516"))
(setq my-highlight-changes-faces '(
								   highlight-changes  
								   highlight-changes-1
								   highlight-changes-2
								   highlight-changes-3
								   highlight-changes-4
								   highlight-changes-5
								   highlight-changes-6
								   highlight-changes-7
								   ))
(defun my-highlight-changes-face-define (face color)
  (custom-set-faces `(,face ((t (:background ,color)))))
  )

;; (mapcar* 'my-highlight-changes-face-define my-highlight-changes-faces my-highlight-changes-colors)
;; (custom-set-faces
;;  `(highlight-changes-delete ((t (:background "#333300"))))
;;  )

(add-hook 'prog-mode-hook (lambda () (highlight-changes-mode 1)))









;activate
(highlight-changes-mode)

