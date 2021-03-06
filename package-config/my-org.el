(use-package private-org)
(use-package org
  :ensure t
  :commands (
			 org-agenda
			 org-iswitchb
			 org-store-link
			 org-insert-link
			 org-capture
			 )
  :bind (
		 ("C-c a" . org-agenda)
		 ("C-c b" . org-iswitchb)
		 ("C-c l" . org-store-link)
		 ("C-c L" . org-insert-link)
		 ("C-c c" . org-capture)
		 ("C-c C-x C-x" . org-clock-in-last)
		 ("C-c C-x C-o" . org-clock-out)
		 )
  :config
(defun my/org-file (f) (concat org-directory f))

(setq org-export-coding-system 'utf-8
	  org-html-html5-fancy t)

(run-at-time "00:00" (* 60 10) 'org-save-all-org-buffers)

(setq org-global-properties
	  '(
		("Effort_ALL". "0 0:15 0:30 1:00 2:00 3:00 4:00")
		))

;;workaround
	(when (not (boundp 'org-drawers)) (setq org-drawers nil))

	(setq org-mobile-directory (expand-file-name "~/mobileorg/"))
	(setq org-mobile-inbox-for-pull (concat org-directory "mobile-inbox.org"))

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
(setq org-special-ctrl-k t
	  org-special-ctrl-a/e t
	  )
	  



	(setq org-default-notes-file (my/org-file "personal.org"))

	(setq org-todo-keywords
		  '(
			(sequence 
			 "TODO(t!)"
			 "|"
			 "DONE(d!/!)"
			 )
			(sequence 
;			 "STARTED(S!)"
			 "WAITING(w@/!)"
			 "DECIDE(D!/!)"
			 "|"
			 "CANCELLED(c@/!)"
			 "DEFERRED(f@/!)"
			 "SOMEDAY(s!)")
			(sequence "HABIT(h!)" "|" "DONE(!)")
			))
	(setq org-todo-state-tags-triggers
		  (quote (("CANCELLED" ("CANCELLED" . t))
				  ("WAITING" ("WAITING" . t))
				  (done ("WAITING"))
				  ("TODO" ("WAITING") ("CANCELLED"))
;				  ("STARTED" ("ACTIVE" . t))
				  ("DONE" ("WAITING") ("CANCELLED")))))

  ;;; -----------------

	(setq org-todo-keyword-faces
		  '(
			("TODO" . (:foreground "red" :underline t :weight bold))
			("DONE" . (:foreground "lime green" :weight normal))
			("STARTED" . "#00ff00")
			("WAITING" . "#c0cf00")
			("CANCELLED" . (:foreground "RosyBrown3" :weight normal))
			("SOMEDAY" . "#888888")
			("HABIT" . "dark cyan")
			; Packliste
			("BESORGEN" . "#ff0000")
			("WASCHEN" . "#aa7700")
			("STAPELN" . "#000077")
			("PACKEN" . "#007700")
			("ANZIEHEN" . "#007700")
			))



	(setq org-use-fast-todo-selection t)
(setq org-enforce-todo-dependencies t)
(use-package org-depend)
(setq org-agenda-dim-blocked-tasks t
	  org-agenda-persistent-filter t
	  org-agenda-sticky t
	  org-agenda-compact-blocks t
	  )


(setq org-cycle-level-after-item/entry-creation t)

(setq org-log-done 'time)
(setq org-log-into-drawer t)
(use-package org-expiry
  :config
  (defun my/org-expiry-insert-created-timestamp()
	"Insert a CREATED property using org-expiry.el for TODO entries"
	(when (or (string-prefix-p "CAPTURE-" (buffer-name))
			  (member buffer-file-name org-agenda-files))
	  (save-excursion
		(org-expiry-insert-created)
		)))

  ;; Whenever a TODO entry is created, I want a timestamp
  ;; Advice org-insert-todo-heading to insert a created timestamp using org-expiry
  ;; (defadvice org-insert-todo-heading (after my/created-timestamp-advice activate)
  ;; 	"Insert a CREATED property using org-expiry.el for TODO entries"
  ;; 	(my/insert-created-timestamp)
  ;; 	)
  ;; Make it active
  ;; (ad-activate 'org-insert-todo-heading)
  (add-hook 'org-capture-before-finalize-hook 'my/org-expiry-insert-created-timestamp)
  (add-hook 'org-insert-heading-hook 'my/org-expiry-insert-created-timestamp)
  )

(defvar my/insert-inactive-timestamp nil)

(defun my/toggle-insert-inactive-timestamp ()
  (interactive)
  (setq my/insert-inactive-timestamp (not my/insert-inactive-timestamp))
  (message "Heading timestamps are %s" (if my/insert-inactive-timestamp "ON" "OFF")))

(defun my/insert-inactive-timestamp ()
  (interactive)
										;(org-insert-time-stamp nil t t nil nil nil)
  )
;; -------------------------

(defun my/insert-heading-inactive-timestamp ()
  (save-excursion
    (when my/insert-inactive-timestamp
      (org-return)
      (org-cycle)
      (my/insert-inactive-timestamp))))

;(add-hook 'org-insert-heading-hook 'my/insert-heading-inactive-timestamp 'append)

(setq org-insert-heading-respect-content t)

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

(setq
org-startup-indented t
org-startup-folded 'showall
; lets hang emacs if file is on non-accessible fs with long timeout...
	  org-startup-with-inline-images nil
 )
	(setq org-hide-leading-stars t)

(setq org-cycle-emulate-tab 'whitestart
	  org-cycle-separator-lines 0
		  org-show-context-detail '((isearch . tree)
									(bookmark-jump . lineage)
									(default . tree)
									)
		  )

(setq org-ctrl-k-protect-subtree nil
	  org-catch-invisible-edits t
	  org-clone-delete-id t
	  org-id-link-to-org-use-id t
	  )

(setq org-pretty-entities t
	  org-src-fontify-natively t
	  org-src-preserve-indentation t
	  )


	(setq org-tags-match-list-sublevels 'indented)
	(setq org-agenda-tags-column -100
		  org-agenda-show-inherited-tags nil)

	(setq org-agenda-prefix-format '((agenda . "%i %-12:c %?-12t %s %b")
									 (timeline . "  % s")
									 (tags-todo . "%i %-12:c %?12t %s")
									 (todo . "%i %-10:c %?12t %?12 s %b")
									 (tags . " %i %-12:c")
									 ))

;;-----------------

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

(setq org-agenda-sorting-strategy
          '((agenda habit-down
                    time-up
                    priority-down
                    user-defined-up
                    effort-up
                    category-keep)
            (todo category-up priority-down effort-up)
            (tags priority-down category-up effort-up)
            (search priority-down category-up)))

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


;;--------------------------------

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



	(setq org-capture-templates
		  `(("t" "Todo" entry (file ,(my/org-file "personal.org")) "** TODO %?
%i
")
			("h" "Todo from here" entry (file ,(my/org-file "personal.org")) "** TODO %?
from %a:
%i
")
			("r" "Reference" entry (file+headline "personal.org" "Reference") "** %?
%i
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
	  (my-org-export-headless-latex))

	
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

(defun my/org-set-property (property)
  "Quick access to set property"
  (interactive)
  (let ((value (org-read-property-value property)))
	(org-set-property property value)))

(defvar my/org-property-key-context "Context")
(defvar my/org-property-value-context-research "Research")
(defvar my/org-property-value-location-home "Home")

(defun my/get-org-property-setter (p)
  (lambda () (interactive) (my/org-set-property p)))


  )
(provide 'my-org)
