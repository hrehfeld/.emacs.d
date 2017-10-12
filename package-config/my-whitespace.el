(setq show-trailing-whitespace t)
(setq whitespace-style '(face trailing tabs
							  tab-mark
							  lines-tail space-before-tab))
(setq whitespace-display-mappings
	  '((space-mark 32
					[183]
					[46])
		(space-mark 160
					[164]
					[95])
		(newline-mark 10
					  [36 10])
		(tab-mark 9
				  [8594 9]
				  [187 9]
				  [92 9])))
(defface whitespace-tab 
  '((t (:foreground "Azure"))) "Face to use to visualize tabs.")
