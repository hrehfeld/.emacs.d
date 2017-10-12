(setq org-clock-report-include-clocking-task t
	  org-agenda-clockreport-parameter-plist
	  '(:maxlevel 10 :fileskip0 t :score agenda :block thismonth :compact t :narrow 60))

(org-clock-persistence-insinuate)
(setq org-clock-persist t)
(setq org-clock-persist-query-resume t)
(setq org-clock-auto-clock-resolution 'when-no-clock-is-running)

(setq org-clock-idle-time nil
	  org-clock-history-length 32
	  org-clock-in-resume t
	  org-clock-out-remove-zero-time-clocks t
	  org-clock-out-when-done t
	  )

;;Make sure that you don't clock for too long. There's no reason to clock for four straight hours, and if I do that, I'm probably lying.
(setq org-agenda-clock-consistency-checks
      '(:max-duration "4:00"
					  :min-duration 0
					  :max-gap 0
					  :gap-ok-around ("4:00")))


(defvar bh/keep-clock-running)
(setq bh/keep-clock-running t)
(defun bh/clock-out-maybe ()
  (when (and bh/keep-clock-running
             (not org-clock-clocking-in)
             (marker-buffer org-clock-default-task)
             (not org-clock-resolving-clocks-due-to-idleness))
    (rrix/clock-in-sibling-or-parent-task)))

(add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)

(defun rrix/clock-in-sibling-or-parent-task ()
  "Move point to the parent (project) task if any and clock in"
  (let ((parent-task)
        (parent-task-is-flow)
        (sibling-task)
        (curpoint (point)))
    (save-excursion
      (save-restriction
        (widen)
        (outline-back-to-heading)
        (org-cycle)
        (while (and (not parent-task) (org-up-heading-safe))
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq parent-task (point))))
        (goto-char curpoint)
        (while (and (not sibling-task) (org-get-next-sibling))
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq sibling-task (point))))
        (setq parent-task-is-flow (cdr (assoc "FLOW"
                                              (org-entry-properties parent-task))))
        (cond ((and sibling-task
                    parent-task-is-flow)
               (org-with-point-at sibling-task
                 (org-clock-in))
               (org-clock-goto))
              (parent-task
               (org-with-point-at parent-task
                 (org-clock-in))
               (org-clock-goto))
              (t (when bh/keep-clock-running
                   (bh/clock-in-default-task))))))))

(defun bh/clock-in-default-task ()
  (interactive)
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in)
      (org-clock-goto))))

(defun bh/clock-in-last-task (arg)
  "Clock in the interrupted task if there is one
Skip the default task and get the next one.
A prefix arg forces clock in of the default task."
  (interactive "p")
  (let ((clock-in-to-task
         (cond
          ((eq arg 4) org-clock-default-task)
										;clock active and we come from default
          ((and (org-clock-is-active)
                (equal org-clock-default-task (cadr org-clock-history)))
           (caddr org-clock-history))
										;clock active
          ((org-clock-is-active) (cadr org-clock-history))
										;in default
          ((equal org-clock-default-task (car org-clock-history)) (cadr org-clock-history))
          (t (car org-clock-history)))))
    (widen)
    (org-with-point-at clock-in-to-task
      (org-clock-in nil))))

										;(global-set-key (kbd "C-c C-x C-i") 'bh/clock-in-last-task)
(global-set-key (kbd "C-c C-x C-i") 'org-clock-in)
(defun my/org-clock-if-active (s)
  (let ((clock (org-clock-is-active)))
	(if clock
		(concat s org-clock-current-task))
	)
  )
