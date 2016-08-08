(setq calendar-latitude 49.0047
	  calendar-longitude 8.3858
	  calendar-location-name "Karlsruhe, DE"
	  calendar-offset -1
	  )
;(european-calendar-style
(setq calendar-holidays '((holiday-fixed 01 01 "Gesetzlicher Feiertag (Neujahr)")
						  (holiday-fixed 01 06 "Gesetzlicher Feiertag (Heilige Drei Könige)")
                          (holiday-fixed 05 01 "Gesetzlicher Feiertag (Maifeiertag)")
                          (holiday-fixed 10 03 "Gesetzlicher Feiertag (Tag der Deutschen Einheit)")
                          (holiday-fixed 12 25 "Gesetzlicher Feiertag (1. Weihnachtstag)")
                          (holiday-fixed 12 26 "Gesetzlicher Feiertag (2. Weihnachtstag)")
                          (holiday-easter-etc -2 "Gesetzlicher Feiertag (Karfreitag)")
                          (holiday-easter-etc  1 "Gesetzlicher Feiertag (Ostermontag)")
                          (holiday-easter-etc 39 "Gesetzlicher Feiertag (Christi Himmelfahrt)")
                          (holiday-easter-etc 50 "Gesetzlicher Feiertag (Pfingstmontag)")
                          (holiday-easter-etc 60 "Gesetzlicher Feiertag (Fronleichnam)")
                          (holiday-fixed 11 01 "Gesetzlicher Feiertag (Allerheiligen)")
						  ))
(setq calendar-week-start-day 1
      calendar-day-name-array ["Sonntag" "Montag" "Dienstag" "Mittwoch"
                               "Donnerstag" "Freitag" "Samstag"]
      calendar-month-name-array ["Januar" "Februar" "März" "April" "Mai"
                                 "Juni" "Juli" "August" "September"
                                 "Oktober" "November" "Dezember"])
(require 'calendar)
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

