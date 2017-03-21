(use-package calendar
  :config
(calendar-set-date-style 'iso)

(setq view-diary-entries-initially nil)
(setq mark-diary-entries-in-calendar nil)
(require 'diary-lib)
(add-hook 'calendar-today-visible-hook 'calendar-mark-today)
(add-hook 'calendar-initial-window-hook 'calendar-mark-holidays)
(if (functionp 'calendar-mark-days-named)
	(add-hook 'calendar-initial-window-hook (lambda () 
											  (calendar-mark-days-named 0 'diary)
											  (calendar-mark-days-named 6 'diary)
											  )))

;; The following code binds RET in calendar mode to a function that opens an org agenda buffer for that day (or better that week).
(defun my-calendar-open-agenda ()
  (interactive)
  (let* ((calendar-date (or 
                         ;; the date at point in the calendar buffer
                         (calendar-cursor-to-date)
                         ;; if there's none, use the curren date
                         (calendar-current-date)))
         (day (time-to-days (encode-time 1 1 1
                                         (second calendar-date)
                                         (first calendar-date)
                                         (third calendar-date))))
         (calendar-buffer (current-buffer)))
    (org-agenda-list nil day)
    (select-window (get-buffer-window calendar-buffer))))

(define-key calendar-mode-map (kbd "RET") 'my-calendar-open-agenda)


;; small minor mode which uses the function above to refresh the
;; agenda buffer when you move point in the calendar buffer, so
;; calendar and agenda stay in sync.
(define-minor-mode my-org-agenda-follow-calendar-mode
  "If enabled, each calendar movement will refresh the org agenda
buffer."
  :lighter " OrgAgendaFollow"
  (if (not (eq major-mode 'calendar-mode))
      (message "Cannot activate my-org-agenda-follow-calendar-mode in %s." major-mode)
    (if my-org-agenda-follow-calendar-mode
        (add-hook 'calendar-move-hook 'my-calendar-open-agenda)
      (remove-hook 'calendar-move-hook 'my-calendar-open-agenda))))
;(add-hook 'calendar-mode-hook 'my-org-agenda-follow-calendar-mode)

;; display of the week-of-year in the mode-line.
(add-to-list 'calendar-mode-line-format
             '(let ((day (nth 1 date))
                    (month (nth 0 date))
                    (year (nth 2 date)))
                (format-time-string "Week of year: %V"
                                    (encode-time 1 1 1 day month year))))

)
(provide 'my-calendar)

