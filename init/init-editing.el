(turn-off-auto-fill)
;;enable function
(put 'downcase-region 'disabled nil)

(global-set-key "\C-c\C-c" 'comment-or-uncomment-region)

(normal-erase-is-backspace-mode 1)


(defvar hrehfeld-intelligent-delete-char-kill-regexp "[ \t]\\{2,\\}" 
  "The regexp for chars that get skipped over and killed.")
(make-variable-buffer-local 'hrehfeld-intelligent-delete-char-kill-regexp)

(defvar hrehfeld-intelligent-delete-char-trigger-killall-regexps '((".\\|\n" . "[ \t\n]")
                                                                 ("[ \t\n]" . ".\\|\n"))
  "A list of pairs of matching regexp that trigger a full delete. The first element needs to match at the beginning of the delete region, the second at the end (always in the same directions).")
(make-variable-buffer-local 'hrehfeld-intelligent-delete-char-trigger-killall-regexps)

(add-hook 'lisp-mode-hook (lambda () 
                            (add-to-list 'hrehfeld-intelligent-delete-char-trigger-killall-regexps
                                         '("(" . "."))
                            (add-to-list 'hrehfeld-intelligent-delete-char-trigger-killall-regexps
                                         '("." . ")"))
                            ))
(add-hook 'text-mode-hook (lambda () 
                            (add-to-list 'hrehfeld-intelligent-delete-char-trigger-killall-regexps
                                         '("." . "\\."))
                            ))
                                                  

(defun hrehfeld-intelligent-delete-backward-char (arg)
  "If there is more than one char of whitespace between previous word and point, delete all but one unless there's whitespace or newline directly after the point--which will delete all whitespace back to word--, else fall back to (delete-backward-char 1)"
  (interactive "P")
  (hrehfeld-intelligent-delete-char t))

(defun hrehfeld-intelligent-delete-forward-char (arg)
  "If there is more than one char of whitespace between point and next word, delete all but one unless there's whitespace or newline directly before the point--which will delete all whitespace up to word--, else fall back to (delete-char 1)"
  (interactive "P")
  (hrehfeld-intelligent-delete-char))
(global-set-key [backspace] 'hrehfeld-intelligent-delete-backward-char)
(global-set-key "\C-d" 'hrehfeld-intelligent-delete-forward-char)

(defun hrehfeld-intelligent-delete-char-trigger (to from) 
  "Return t if the region (FROM TO) should be killed completely."
  (save-excursion
    (let ((from (min to from))
          (to (max to from)))
      (if (or (equal to (point-max))
              (equal from (point-min)))
          t
        (fold (lambda (a b) (or a b)) nil
              (mapcar (lambda (pair) 
                        (and (progn (goto-char from)
                                    (looking-back (car pair)))
                             (progn (goto-char to)
                                    (looking-at (cdr pair)))))
                      hrehfeld-intelligent-delete-char-trigger-killall-regexps))))))


(defun hrehfeld-intelligent-delete-char (&optional backwards)
  "If there is more than one char of whitespace between previous word and point, delete all but one unless there's whitespace or newline directly after the point--which will delete all whitespace back to word--, else fall back to (delpete-backward-char 1)"
  (interactive "P")
  (let (check kill-end-match change-point fallback)
    (if backwards
        (setq check (lambda (regexp) (looking-back regexp  0 t))
              kill-end-match 'match-beginning
              change-point '1+
              fallback 'delete-backward-char)
        (setq check 'looking-at
              kill-end-match 'match-end
              change-point '1-
              fallback 'delete-char)
      )
    (if (funcall check hrehfeld-intelligent-delete-char-kill-regexp)
        (let* ((start (funcall kill-end-match 0))
               (kill-start (if (hrehfeld-intelligent-delete-char-trigger start (point)) 
                               start
                             (funcall change-point start)
                             )))
          (kill-region (min kill-start (point)) (max kill-start (point))))
      ;just fallback to normal delete
      (funcall fallback 1)
             )))
  

(defun increment-number-at-point () (interactive) (number-change '1+))
(defun decrement-number-at-point () (interactive) (number-change '1-))
(global-set-key (kbd "<kp-add>") 'increment-number-at-point)
(global-set-key (kbd "<kp-subtract>") 'decrement-number-at-point)


(defun number-change (fn &optional pos)
  (let ((oldpoint (point)))
    (if (not pos)
        (setq pos (point)))
    (save-excursion
      (goto-char pos)
      (skip-chars-backward "0123456789")
      (or (looking-at "[0123456789]+")
          (error "No number at point"))
      )
    (replace-match (number-to-string (funcall fn (string-to-number (match-string 0)))))
    (goto-char oldpoint)))


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
(defun insert-date (prefix)
  "Insert the current date. Without prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%Y-%m-%d %H:%M")
                 ((equal prefix '(4)) "%d.%m.%Y")
                 ((equal prefix '(16)) "%A, %d. %B %Y")))
        (system-time-locale "de_DE"))
    (insert (format-time-string format))))

(global-subword-mode 1)

;this binds only the real tab
(global-set-key [tab] 'completion-at-point)
