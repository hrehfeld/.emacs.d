(setq org-export-coding-system 'utf-8)

(run-at-time "00:00" (* 60 10) 'org-save-all-org-buffers)

(setq org-global-properties
	  '(
		("Effort_ALL". "0 0:15 0:30 1:00 2:00 3:00 4:00")
		))

										;workaround
	(when (not (boundp 'org-drawers)) (setq org-drawers nil))

	(setq org-mobile-directory (concat org-directory "mobile"))
	(setq org-mobile-inbox-for-pull (concat org-directory "mobile.org"))

(setq org-return-follows-link t)
;point at eol should not follow link
(defun my/org-return ()
  "disable org-return-follows-link if at bol or eol"
  (interactive)
  (let* ((follow org-return-follows-link)
		 (org-return-follows-link (and follow (not (or (bolp) (eolp))))))
	(org-return)))
(define-key org-mode-map (kbd "<return>") 'my/org-return)
;C-m should always just edit text
(define-key org-mode-map (kbd "C-m") 'newline-and-indent)
	  



	(setq org-default-notes-file ".notes")

	(setq org-todo-keywords
		  '(
			(sequence 
			 "TODO(t!)"
			 "|"
			 "DONE(d!/!)"
			 )
			(sequence 
;			 "STARTED(s!)"
			 "WAITING(w@/!)"
			 "DECIDE(D!/!)"
			 "|"
			 "CANCELLED(c@/!)"
			 "DEFERRED(f@/!)")
			(sequence "HABIT(h!)" "|" "DONE(!)" "Skip(s!)")
			))
	(setq org-todo-state-tags-triggers
		  (quote (("CANCELLED" ("CANCELLED" . t))
				  ("WAITING" ("WAITING" . t))
				  (done ("WAITING"))
				  ("TODO" ("WAITING") ("CANCELLED"))
;				  ("STARTED" ("ACTIVE" . t))
				  ("DONE" ("WAITING") ("CANCELLED")))))
	(setq org-todo-keyword-faces
		  '(
			("TODO" . (:foreground "red" :underline t :weight bold))
			("DONE" . (:foreground "lime green" :weight 'normal))
			("STARTED" . "#00ff00")
			("WAITING" . "#c0cf00")
			("CANCELLED" . (:foreground "RosyBrown3" :weight 'normal))
			("HABIT" . "dark cyan")
			))


(setq org-clock-report-include-clocking-task t)

	(setq org-clock-persist t)
(org-clock-persistence-insinuate)
(setq org-clock-persist-query-resume nil)
(setq org-clock-auto-clock-resolution 'when-no-clock-is-running)

(setq org-clock-idle-time nil)
;(setq org-clock-in-switch-to-state
(setq org-clock-history-length 32

	  org-clock-in-resume t
	  org-clock-out-remove-zero-time-clocks t
	  org-clock-out-when-done t
)

;Make sure that you don't clock for too long. There's no reason to clock for four straight hours, and if I do that, I'm probably lying.
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

	(setq org-use-fast-todo-selection 'prefix)
(setq org-enforce-todo-dependencies t)
	(setq org-agenda-dim-blocked-tasks t)


(setq org-cycle-level-after-item/entry-creation t)

(setq org-log-done 'time)
(setq org-log-into-drawer t)

(defvar my/insert-inactive-timestamp nil)

(defun my/toggle-insert-inactive-timestamp ()
  (interactive)
  (setq my/insert-inactive-timestamp (not my/insert-inactive-timestamp))
  (message "Heading timestamps are %s" (if my/insert-inactive-timestamp "ON" "OFF")))

(defun my/insert-inactive-timestamp ()
  (interactive)
										;(org-insert-time-stamp nil t t nil nil nil)
  )

(defun my/insert-heading-inactive-timestamp ()
  (save-excursion
    (when my/insert-inactive-timestamp
      (org-return)
      (org-cycle)
      (my/insert-inactive-timestamp))))

;(add-hook 'org-insert-heading-hook 'my/insert-heading-inactive-timestamp 'append)

(setq org-export-with-timestamps nil)

	(setq org-archive-location "%s.archive::* Archived Projects")
	(setq org-archive-default-command 'org-archive-subtree)


	(setq org-hierarchical-todo-statistics t)

	(setq org-agenda-window-setup 'current-window)
(setq org-agenda-log-mode-items '(closed state clock))

(setq org-refile-use-outline-path 'file
	  org-log-refile 'time
	  org-refile-allow-creating-parent-nodes 'confirm
	  org-refile-targets '((org-agenda-files :maxlevel . 3) (nil :maxlevel . 3))
	  org-refile-use-cache t
	  )

										; Targets complete directly with IDO
	(setq org-outline-path-complete-in-steps nil)

										; Allow refile to create parent tasks with confirmation
	(setq org-refile-allow-creating-parent-nodes 'confirm)

										; Use IDO for both buffer and file completion and ido-everywhere to t
										;(setq org-completion-use-ido t)

	(defun my/verify-refile-target ()
	  "Exclude todo keywords with a done state from refile targets"
	  (not (member (nth 2 (org-heading-components)) org-done-keywords)))
	(setq org-refile-target-verify-function 'my/verify-refile-target)

(setq org-startup-indented t
	  org-startup-folded 'showall
	  )
	(setq org-hide-leading-stars t)

(setq org-cycle-emulate-tab 'whitestart
	  org-cycle-separator-lines 0
		  org-show-context-detail '((isearch . tree)
									(bookmark-jump . lineage)
									(default . tree)
									)
		  )

(setq org-ctrl-k-protect-subtree t
	  org-catch-invisible-edits t
	  org-clone-delete-id t
	  org-id-link-to-org-use-id t
	  )

(setq org-pretty-entities t
	  org-src-fontify-natively t)


	(setq org-tags-match-list-sublevels 'indented)
	(setq org-agenda-tags-column -100
		  org-agenda-show-inherited-tags nil)

	(setq org-agenda-prefix-format '((agenda . "%i %-12:c %?-12t %s %b")
									 (timeline . "  % s")
									 (tags-todo . "%i %-12:c %?12t %s")
									 (todo . "%i %-10:c %?12t %?12 s %b")
									 (tags . " %i %-12:c")
									 ))



										;agenda will always begin on the current day
	(setq org-agenda-start-on-weekday nil)
	(setq org-agenda-span 14)
	(setq org-agenda-deadline-leaders  '("Deadline:  " "Deadline: %3d d: " "%2d d. ago: ")
		  org-agenda-scheduled-leaders '("Scheduled: " "Scheduled: %2dx: ")
		  )
	
	(setq org-agenda-skip-deadline-if-done t)
	(setq org-agenda-skip-scheduled-if-done t
		  org-agenda-skip-scheduled-if-deadline-is-shown t
		  )
	(setq org-agenda-time-grid '((daily weekly today require-timed)
								 "----------------"
								 (800 1000 1200 1400 1600 1800 2000)))
	(setq org-agenda-use-time-grid nil)

	(setq org-agenda-todo-ignore-deadlines 'far)
	(setq org-agenda-todo-ignore-scheduled 'future)

	(defun hrehf-org-has-tag-subtree (tag)
	  "t if current subtree has tag"
	  (save-excursion
		(re-search-backward "\*+")
		(member tag (org-get-tags-at))
		)
	  )

	(defun hrehf-skip-tag (tag)
	  "Skip trees that have tag tag"
	  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
		(if (hrehf-org-has-tag-subtree tag)
										; continue after end of subtree
			subtree-end
										; do not skip
		  nil          
		  )))

	(defun hrehf-skip-not-tag (tag)
	  "Skip trees that do not have tag tag"
	  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
		(if (hrehf-org-has-tag-subtree tag)
										; do not skip
			nil          
										; continue after end of subtree
		  subtree-end
		  )))

	(defun hrehf-skip-habits ()
	  "Skip trees that are habits"
	  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
		(re-search-backward "\*+")
		(if (member "alltaeglich" (org-get-tags-at))
										; continue after end of subtree
			subtree-end
										; do not skip
		  nil          
		  )))

	(setq org-agenda-custom-commands nil)
	(add-to-list 'org-agenda-custom-commands 
				 '("i" "Important Agenda Items"
				   agenda nil
				   (
					(org-agenda-skip-function 'hrehf-skip-habits)
					(org-agenda-overriding-header "Only the important agenda: ")
					)
				   ))

	(add-to-list 'org-agenda-custom-commands 
				 '("h" "Agenda and Home-related tasks"
				   ((agenda "")
					(tags-todo "@home")
					(tags "@home"))))

	(add-to-list 'org-agenda-custom-commands 
				 '("o" "Office-related tasks"
				   (
					(agenda nil)
					(tags-todo "+@office+teaching" 
							   ((org-agenda-overriding-header "Teaching: ")))
					(tags-todo "+@office+research"
							   ((org-agenda-overriding-header "Research: ")))
					(tags-todo "+@office-research-teaching"
							   ((org-agenda-overriding-header "Miscellaneous: ")))
					)
				   ((org-agenda-sorting-strategy '(time-up))
					(org-agenda-skip-function (lambda () (hrehf-skip-not-tag "@office")))
					)))

	(setq org-agenda-category-icon-alist nil)

	(setq my-org-agenda-category-icons
		  '(
			;https://useiconic.com/open#icons
			("personal" "https://raw.githubusercontent.com/iconic/open-iconic/master/png/person-2x.png" png)
			("kit" "https://raw.githubusercontent.com/iconic/open-iconic/master/png/briefcase-2x.png" png)
			("contacts" "https://raw.githubusercontent.com/iconic/open-iconic/master/png/people-2x.png" png)
			("habits" "https://raw.githubusercontent.com/iconic/open-iconic/master/png/loop-circular-2x.png" png)
			("teaching" "https://raw.githubusercontent.com/iconic/open-iconic/master/png/book-2x.png" png)
			))
	(if nil
		(mapc
		 (lambda (icon-data)
		   (lexical-let (
						 (url (nth 1 icon-data))

						 (name (nth 0 icon-data))
						 (type (nth 2 icon-data))
						 )
			 (message url)

			 (let ((lexical-binding t))
			   (ignore-errors
				 (web-http-get
				  (lambda (con hdr data)
					(message (concat "downloaded " name))
					(prin1 data)
					(add-to-list 'org-agenda-category-icon-alist
								 (list name (string-as-unibyte data) type t :ascent 'center))
					)
				  :url url)))
			 )

		   )
		 my-org-agenda-category-icons
		 ))

	(setq org-default-notes-file (concat org-directory "/notes.org"))

(defun file (f) (concat org-directory f))

(defun my/org-clock-if-active (s)
  (let ((clock (org-clock-is-active)))
	(if clock
		(concat s org-clock-current-task))
	)
  )

	(setq org-capture-templates
		  `(("t" "Todo" entry (file+olp ,(file "personal.org") "Sort") "** TODO %?
%i

from %a
%(my/org-clock-if-active \"while working on: \")

:LOGBOOK:  
- State \"TODO\"       from \"\"       %U
:END:      

")
			("r" "Reference" entry (file+headline "personal.org" "Reference") "** %?
%i
%U
from %a
%(my/org-clock-if-active \"while working on: \")
")))


	(setq org-export-with-toc nil
		  org-export-with-archived-trees nil
		  )

	(setq org-latex-caption-above nil
		  org-latex-prefer-user-labels t)
	
	
	(defun my-org-export-headless-latex ()
	  "exports to a .tex file without any preamble"
	  (interactive)
	  (org-latex-export-as-latex nil nil nil t)
	  )

	(setq my-org-export-latex-name "hauke_sds")

	(defun my-org-export-headless-latex-file ()
	  (interactive)
	  (my-org-export-headless-latex)
	  )

	
	(defun my-org-latex-remove-default-package (package)
	  (delete
	   '("" package nil)
	   org-latex-default-packages-alist)
	  )

	(defun my-org-latex-get-class ()
	  (save-excursion
		(end-of-buffer)
		(save-match-data
		  (let ((case-fold-search nil))
			(re-search-backward "^ *\\#\\+LATEX_CLASS\\: *\\([^ \n\t]+\\)$" 0 t)
			(match-string 1)))))
	(defun my-org-latex-is-egstyle ()
	  (equal (my-org-latex-get-class) "egpubl")
	  )

	;; latex classes is defined in ox latex
	(with-eval-after-load 'ox-latex 
	  (progn
		(add-to-list 'org-latex-classes
					 '("acmsiggraph"
					   "\\documentclass{acmsiggraph}"
					   ("\\section{%s}" . "\\section*{%s}")
					   ("\\subsection{%s}" . "\\subsection*{%s}")
					   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
					   ("\\paragraph{%s}" . "\\paragraph*{%s}")
					   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
		(add-to-list 'org-latex-classes
					 '("egpubl"
					   "\\documentclass{egpubl}"
					   ("\\section{%s}" . "\\section*{%s}")
					   ("\\subsection{%s}" . "\\subsection*{%s}")
					   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
					   ("\\paragraph{%s}" . "\\paragraph*{%s}")
					   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

		;;disable modern packages in eg style
		(add-hook 'org-export-before-processing-hook
				  (lambda (backend)
					(if (equal backend 'latex)
						(if (my-org-latex-is-egstyle)
							(progn
							  (message "egstyle found.")
							  (make-local-variable 'org-latex-with-hyperref)
							  (setq org-latex-with-hyperref nil)
							  (make-local-variable 'org-latex-default-packages-alist)
							  (setq org-latex-default-packages-alist
									(let ((invalid-pkgs '("hyperref" "fixltx2e")))
									  (cl-remove-if (lambda (e)
													  (if (listp e)
														  (let ((pkg (nth 1 e)))
															(member pkg invalid-pkgs)
															)))
													org-latex-default-packages-alist
													)))
							  (prin1 org-latex-default-packages-alist)
								)
						  )
					  )
					)
				  )
		)
	  )
;	#+LATEX_CLASS: bla
;	#+LATEX_CLASS: egpubl
	(org-add-link-type "cite"
					   (defun my-org-follow-cite (name)
						 "Open bibliography and jump to appropriate entry.
        The document must contain \bibliography{filename} somewhere
        for this to work"
						 (find-file-other-window
						  (save-excursion
							(beginning-of-buffer)
							(save-match-data
							  (re-search-forward "\\\\bibliography{\\([^}]+\\)}")
							  (concat (match-string 1) ".bib"))))
						 (beginning-of-buffer)
						 (search-forward name))
					   
					   (defun my-org-export-cite (path desc format)
						 "Export [[cite:cohen93]] as \cite{cohen93} in LaTeX."
						 (if (eq format 'latex)
							 (if (or (not desc) (equal 0 (search "cite:" desc)))
								 (format "\\cite{%s}" path)
							   (format "\\cite[%s]{%s}" desc path))))
										;'my-org-follow-cite 'my-org-export-cite
   )
   (org-add-link-type
	"citet"
	'my-org-follow-cite
	(defun my-org-export-cite-t (path desc format)
	  "Export [[cite:cohen93]] as \cite{cohen93} in LaTeX."
	  (if (eq format 'latex)
		  (if (or (not desc) (equal 0 (search "cite:" desc)))
			  (format "\\shortcite{%s}" path)
			(format "\\shortcite[%s]{%s}" desc path))))
	)

	(setq org-priority-start-cycle-with-default nil)
	(setq org-default-priority 67
		  org-lowest-priority 68)
	(setq org-use-property-inheritance '("PRIORITY"))
	
	(set-face-attribute 'org-agenda-date-weekend nil :weight 'normal :foreground "steel blue")

	(add-to-list 'org-modules 'org-habit)
	(setq org-habit-show-habits-only-for-today nil
		  org-habit-show-habits t)
	(add-hook 'org-agenda-mode-hook
			  (lambda ()
				(setq org-habit-graph-column (- (window-width) 30))))



	(defun my-diary-repeated-range (start-year start-month start-day length-days every-n-days)
	  (let* ((today (calendar-absolute-from-gregorian date))
			 (date (calendar-absolute-from-gregorian (list start-month start-day start-year)))
			 (dist (- today date))
			 (moddist (% dist every-n-days))
			 )
										;(print moddist)
		(< moddist length-days)
		))

	(defun org-summary-todo (n-done n-not-done)
	  "Switch entry to DONE when all subentries are done, to TODO otherwise."
	  (let (org-log-done org-log-states)   ; turn off logging
		(org-todo (if (= n-not-done 0) "DONE" "TODO"))))
	(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

	(org-babel-do-load-languages
	 'org-babel-load-languages
	 '((gnuplot . t)))

	(defun org-repair-property-drawers ()
  "Fix properties drawers in current buffer.
 Ignore non Org buffers."
  (interactive)
  (when (eq major-mode 'org-mode)
    (org-with-wide-buffer
     (goto-char (point-min))
     (let ((case-fold-search t)
           (inline-re (and (featurep 'org-inlinetask)
                           (concat (org-inlinetask-outline-regexp)
                                   "END[ \t]*$"))))
       (org-map-entries
        (lambda ()
          (unless (and inline-re (org-looking-at-p inline-re))
            (save-excursion
              (let ((end (save-excursion (outline-next-heading) (point))))
                (forward-line)
                (when (org-looking-at-p org-planning-line-re) (forward-line))
                (when (and (< (point) end)
                           (not (org-looking-at-p org-property-drawer-re))
                           (save-excursion
                             (and (re-search-forward org-property-drawer-re end t)
                                  (eq (org-element-type
                                       (save-match-data (org-element-at-point)))
                                      'drawer))))
                  (insert (delete-and-extract-region
                           (match-beginning 0)
                           (min (1+ (match-end 0)) end)))
                  (unless (bolp) (insert "\n"))))))))))))
