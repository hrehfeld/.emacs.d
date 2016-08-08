(use-package hydra
  :ensure t
  :defer nil
  :init (progn
		  (global-set-key
		   (kbd "C-M-g")
		   (defhydra hydra-move
			 ();(:body-pre (next-line))
			 "move"
			 ("n" next-line)
			 ("p" previous-line)
			 ("f" forward-char)
			 ("b" backward-char)
			 ("a" beginning-of-line)
			 ("e" move-end-of-line)
			 ("v" scroll-up-command)
			 ;; Converting M-v to V here by analogy.
			 ("M-v" scroll-down-command)
			 ("l" recenter-top-bottom)
			 ("q" nil "quit" :color blue)
			 ))


		  
		  (defun my/insert-unicode (unicode-name)
			"Same as C-x 8 enter UNICODE-NAME."
			(insert-char (cdr (assoc-string unicode-name (ucs-names)))))

		  (global-set-key
		   (kbd "C-. u")
		   (defhydra hydra-unicode (:color blue);(:hint nil)
			 "insert unicode char"
			 ("A" (insert "Ä") "Ä")
			 ("a" (insert "ä") "ä")
			 ("O" (insert "Ö") "Ö")
			 ("o" (insert "ö") "ö")
			 ("u" (insert "ü") "ü")
			 ("U" (insert "Ü") "Ü")
			 ("s" (insert "ß") "ß")
			 ("-" (defhydra hydra-dashes (:color blue)
					"dashes"
					("n" (insert "–") "en")
					("m" (insert "—") "em")
					("f" (insert "‒") "dash within numbers")
					) "dashes" :color red)
			 ("e" (my/insert-unicode "EURO SIGN") "€")
			 ("SPC" (my/insert-unicode "ZERO WIDTH SPACE") "zero-width space")
			 ("`" (my/insert-unicode "DEGREE SIGN") "°")
			 (">" (my/insert-unicode "RIGHTWARDS ARROW") "→")
			 ("<" (my/insert-unicode "LEFTWARDS ARROW") "←")
			 ("m" (my/insert-unicode "MICRO SIGN") "µ")
			 ))

		  (global-set-key
		   (kbd "<f2> t")
		   (defhydra hydra-multiple-cursors (:hint nil)
  "
     ^Up^            ^Down^        ^Miscellaneous^
----------------------------------------------
[_p_]     Next      [_n_]     Next      [_l_] Edit lines
[_P_]     Skip      [_N_]     Skip      [_a_] Mark all
[_M-p_]   Unmark    [_M-n_]   Unmark  
[_C-p_]   Prev word [_C-n_]   Next word [_q_] Quit
"
  ("l" mc/edit-lines "lines" :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("C-p" mc/mark-prev-word-like-this)
  ("C-n" mc/mark-next-word-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("q" nil)
  ))

(defhydra hydra-next-error
  (global-map "C-x")
  "
Compilation errors:
_n_: next error        _<_: first error    _q_uit
_p_: previous error    _>_: last error
"
  ("`" next-error     nil)
  ("n" next-error     nil :bind nil)
  ("p" previous-error nil :bind nil)
  ("<" first-error    nil :bind nil)
  (">" (condition-case err
		   (while t
			 (next-error))
		 (user-error nil))
   nil :bind nil)
  ("q" nil            nil :color blue))
		  )
  )
