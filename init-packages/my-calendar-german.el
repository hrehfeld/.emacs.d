(use-package my-calendar
  :config
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
  )
(provide 'my-calendar-german)
