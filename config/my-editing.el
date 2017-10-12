(setq system-time-locale "en_US")

(turn-off-auto-fill)

;(define-key isearch-mode-map "\C-h" 'isearch-mode-help)
(define-key isearch-mode-map "\C-t" 'isearch-toggle-regexp)
(define-key isearch-mode-map "\C-C" 'isearch-toggle-case-fold)
(define-key isearch-mode-map "\C-c" 'isearch-complete)


; sane rebuilder syntax
(setq reb-re-syntax 'string)



;; Abbrevs
;(quietly-read-abbrev-file)    ;; reads the abbreviations file on startup
;(setq save-abbrevs t)         ;; save abbrevs when files are saved
;(abbrev-mode 1)               ;; default it to on

(setq-default tab-width 4 
			  indent-tabs-mode t)


(transient-mark-mode 0)
(setq set-mark-command-repeat-pop t)

(setq mouse-yank-at-point t)


;; bind M-g to gotoline
(global-set-key (kbd "M-g") nil)
(global-set-key (kbd "M-g l") 'goto-line)

;enable the set goal function (C-x C-n) which puts the cursor on a certain columnx
(put 'set-goal-column 'disabled nil)

(add-hook 'text-mode-hook (lambda () 
                            (visual-line-mode 1)
                            ;; lines are still defined by line-breaks, not display
                            (setq line-move-visual t)
                            ))



(define-key global-map  (kbd "C-<f7>") 'previous-buffer)
(define-key global-map  (kbd "C-<f8>")   'next-buffer)


(defun my/font-lock-add-keywords-todo ()
  (let ((keywords (mapcar
                   (lambda (s)
                     (list (concat"\\b\\(" s "\\)\\b")
                           1 
                           font-lock-warning-face t))
                   (split-string "fixme todo TODO @todo FIXME bug BUG" " " t))))
    (font-lock-add-keywords nil keywords)))

(add-hook 'prog-mode-hook 'my/font-lock-add-keywords-todo)
(add-hook 'text-hook 'my/font-lock-add-keywords-todo)
 


;;enable function
;(put 'downcase-region 'disabled nil)

(global-set-key "\C-c\C-c" 'comment-or-uncomment-region)

(normal-erase-is-backspace-mode 1)


        
(defun increment-number-at-point (n)
  (interactive "p")
  (number-change n))
(defun decrement-number-at-point (n)
  (interactive "p")
  (number-change (- 0 n)))
(global-set-key (kbd "<kp-add>") 'increment-number-at-point)
(global-set-key (kbd "<kp-subtract>") 'decrement-number-at-point)


(defun number-change (n &optional pos)
  (let ((oldpoint (point)))
    (if (not pos)
        (setq pos (point)))
    (save-excursion
      (goto-char pos)
      (or (looking-back "-?[0-9]+" (- pos 64) t)
          (error "No number at point"))
      )
    (replace-match (number-to-string (+ (string-to-number (match-string 0)) n)))
    ))


;; kill-line-and-linebreak
(defun kill-line-and-linebreak (n)
  "Kill the line point is on.
  With prefix arg, kill this many lines starting at the line point is on."
  (interactive "p")
  (kill-region (line-beginning-position)
               (progn (forward-line n) (point))))
(global-set-key "\C-c\C-w" 'kill-line-and-linebreak)


;; duplicate-line
(defun duplicate-line (n)
  "Duplicates the line point is on.  
 With prefix arg, duplicate current line this many times."
  (interactive "p")
  (save-excursion 
    (copy-region-as-kill (line-beginning-position) 
                         (progn (forward-line 1) (point)))
    (while (< 0 n)
      (yank)
      (setq n (1- n)))))

;; insert-date
;; This is a piece of code from JorgenSchaefersEmacsConfig - it's very
;; specifically tailored for my needs. E.g. it explicitly sets a german
;; locale for the third variant, since I usually don't want german stuff,
;; except in this special case.
(defun my/insert-date (prefix)
  "Insert the current date. Without prefix-argument, use ISO format. With prefix argument, insert just the date. With
   two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%Y-%m-%d %H:%M")
                 ((equal prefix '(4)) "%d.%m.%Y")
                 ((equal prefix '(16)) "%A, %d. %B %Y"))))
    (insert (format-time-string format))))

;this binds only the real tab
(global-set-key [tab] 'completion-at-point)

(provide 'my-editing)
