(use-package hydra
  :config
  (use-package my-multiple-cursors
	:config
    (global-set-key
     (kbd "C-x r t")
     (defhydra hydra-multiple-cursors (:hint nil)
       "
     ^Up^            ^Down^        ^Miscellaneous^
----------------------------------------------
[_p_]     Previous  [_n_]     Next      [_l_] Edit lines
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
))
(provide 'my-multiple-cursors-hydra)
