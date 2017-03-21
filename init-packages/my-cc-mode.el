;(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; visuals

(use-package cc-mode
  :config


(defface font-lock-special-syntax-face '((((background dark)) (:foreground "#fff"))) "Face used for syntax constructs that are somehow special")
(defface font-lock-syntax-face '((((background dark)) (:foreground "#ff0"))) "Face used for syntax constructs")

(defun my-cc-mode-define-faces ()
  (let ((word-delimiter "[^A-Za-z0-9]"))
	(font-lock-add-keywords nil '(("[ \\t\\n]+\\([0-9]+[fd]\\)[ \\t\\n]" 1 'font-lock-warning-face t)))
	(font-lock-add-keywords nil '(("\\([A-Za-z][A-Za-z0-9]*\\)([^)]*)" 1 'font-lock-function-name-face t)))
	(font-lock-add-keywords nil '(
								  ("\\(*\\|&\\)[a-z]" 1 'font-lock-special-syntax-face t)
								  ("\\([.()]\\|->\\)" 0 'font-lock-syntax-face t)
										; cuda stuff
								  ("__\\(inline\\|device\\|host\\|global\\)__" 0 'font-lock-keyword-face t)
								  ))
	))

(add-hook 'c++-mode-hook 'my-cc-mode-define-faces)


;; keys

;(define-key c-mode-base-map "\C-m" 'c-context-line-break)
;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

; jump to header/implementation
;(define-key c-mode-base-map "\C-c o" 'ff-find-other-file)

;; settings

(setq-default c-electric-flag nil)

(c-add-style "hrehf" 
			 `("bsd"
			   ;(indent-tabs-mode . t)
			   (c-basic-offset . ,tab-width)
			   (c-offsets-alist . ((inline-open . 0) ; custom indentation rules
								   (brace-list-open . 0)
								   (statement-case-open . +)
								   (template-args-cont . +)
								   ;(statement-block-intro . +)
								   (member-init-intro . +)
								   (arglist-intro . +)
								   (arglist-cont-nonempty . +)
								   ))))
(setq c-default-style "hrehf")




(defface font-lock-comparison-operator-face
  '((((background dark)) (:foreground "#fff")))
  "Face for comparison operators.")

(add-hook 'c-mode-common-hook
          (lambda ()
			(set 'fill-column 100)
			;; (font-lock-add-keywords
			;;  nil '(("[^=]\\(==\\)[^=]" 1 font-lock-comparison-operator-face nil)
			;; 	   ("\\(!=\\)" 1 font-lock-comparison-operator-face nil)
			;; 	   ("[^>]\\(>=\\)" 1 font-lock-comparison-operator-face nil)
			;; 	   ("[^<]\\(<=\\)" 1 font-lock-comparison-operator-face nil)
			;; 	   ("[^<]\\(<\\)[^a-zA-Z_<=]" 1 font-lock-comparison-operator-face nil)
			;; 	   ("[^a-zA-Z0-9_>\\-]\\(>\\)[^>]" 1 font-lock-comparison-operator-face nil)

			;; 	   ;; stupid stupid octal literals
			;; 	   ("\\(^\\|[^0-9.\n]\\)\\(0[0-9]+\\)" 2 font-lock-warning-face nil)
			;; 	   ;; ("\\_<0[0-9]+\\>" 0 font-lock-warning-face nil)
			;; 	   ;; integer and float literals
			;; 	   ("\\<\\([[:digit:]]+\\>\\)\\|\\([[:digit:]]*\\.[[:digit:]]+\\([eE][+-]?[[:digit:]]+\\)?\\)[fFlL]?\\>"
			;; 		0 font-lock-string-face nil)

			;; 	   ("\\(=!\\)" 1 font-lock-warning-face nil)
			;; 	   ("\\(=>\\)" 1 font-lock-warning-face nil)
			;; 	   ("\\(=<\\)" 1 font-lock-warning-face nil)

			;; 	   ;; hex literals
			;; 	   ("\\<0[xX][0-9a-fA-F]+\\>" 0 font-lock-string-face nil)

			;; 	   ;; escaped newlines in comments = evil
			;; 	   ("//.*\\\\\n" 0 font-lock-warning-face t)

			;; 	   ;; semi colons in the wrong place
			;; 	   ("\\(if\\|while\\|switch\\)\\s-*([^\n)]*)\\s-*;" 0 font-lock-warning-face t)
			;; 	   ))

            )
 )

	(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
	(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
	(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
	(add-to-list 'auto-mode-alist '("\\.cu.h\\'" . c++-mode))
	(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))

	(defun namespaces-from-filepath (path)
	  (let* ((dirlist (filter (lambda (s) (not (= (length s) 0)))
							  (split-string (file-name-directory (buffer-file-name)) "/")))
			 (ns nil)
			 (dirs dirlist)
			 (cur (car (last dirlist)))
			 (root-dirs '("src" "source" "include" "lib"))
			 (max-ns-length 3))
		(progn (message dirs)
			   (while (let ((empty (= (length dirs) 0))
							(cur-is-root (let ((is-root nil))
										   (dolist (csrc root-dirs is-root)
											 (if (and (> (length cur) 0)
													  (string-equal (downcase cur) csrc))
												 (setq is-root t))))))
						(not (or empty ns-too-large cur-is-root)))
				 (add-to-list 'ns cur)
				 (setq dirs (butlast dirs))
				 (setq cur (car (last dirs)))
				 (message cur)
				 )
			   (if (> (length ns) max-ns-length) nil ns)))
	  )

; TODO member-function.el, see stackoverflow post
    (defun c-file-enter ()
      "Expands all member functions in the corresponding .h file"
      (let* ((c-file (buffer-file-name (current-buffer)))
             (h-file-list (list (concat (substring c-file 0 -3 ) "h")
                                (concat (substring c-file 0 -3 ) "hpp")
                                (concat (substring c-file 0 -1 ) "h")
                                (concat (substring c-file 0 -1 ) "hpp"))))
        (if (or (equal (substring c-file -2 ) ".c")
                (equal (substring c-file -4 ) ".cpp"))
            (mapcar (lambda (h-file)
                      (if (file-exists-p h-file)
                          (expand-member-functions h-file c-file)))
                    h-file-list))))
    
                                        ;(add-hook 'c++-mode-hook c-file-enter)    


;;misc

;(defadvice c-indent-region (around intelligent-tabs (start end) activate)
;  (let ((indent-region-function nil))
;    (indent-region start end)))
;
;(defadvice c-indent-line (before intelligent-tabs activate)
;  (save-excursion
;    (beginning-of-line)
;    (when (looking-at "\t*[ ]+\t*")
;      (just-one-space 0))))
;
;(defvar retabify-c-align-list
;  '(arglist-close
;    arglist-cont-nonempty
;    brace-entry-open
;    brace-list-entry
;    c
;    comment-intro
;    statement
;    statement-cont
;    stream-op
;    string)
;  "List of syntactic contexts of space-aligned lines.")
;
;(defadvice c-shift-line-indentation (around intelligent-tabs activate)
;  (defvar c-syntactic-context)
;  (let ((indent-tabs-mode t))
;    ad-do-it
;    (let* ((indentation (current-indentation))
;           (syntax (car c-syntactic-context))
;           (type (car syntax))
;           (base (car (cdr syntax)))
;           (old-column (current-column)))
;      (and (memq type retabify-c-align-list)
;           (setq base (save-excursion
;                        (goto-char base)
;                        (move-to-column (current-indentation))
;                        (buffer-substring
;                         (save-excursion
;                           (beginning-of-line) (point))
;                         (point))))
;           (let ((indent-tabs-mode nil))
;             (beginning-of-line)
;             (just-one-space 0)
;             (insert base)
;             (indent-to indentation)
;             (move-to-column old-column))))))
;

(defun retabify-c-buffer ()
  "Reencode C buffer with tabs for indentation and spaces for alignment.

A space-aligned line is one that lines up with a specific
character in a previous line, as in the C++ code below:

    cout << \"foo \"
         << \"bar\"; // aligned line

Space-aligned lines are identified on the basis of
`retabify-c-align-list' and indented with a combination of tabs
and spaces, in a way that is independent of tab width.
Other lines are indented with tabs only.

The function doesn't change the indentation levels themselves,
only the way the indentation is represented. The code should
already be properly indented by use of commands such as
`indent-region'. Furthermore, `c-basic-offset' should be equal to
`tab-width' and `indent-tabs-mode' should be deactivated, e.g.,

    (setq tab-width 4)
    (setq c-basic-offset tab-width)
    (setq-default indent-tabs-mode nil)

The best use of this function is in `before-save-hook', so that
it is automatically invoked when saving the file:

    (add-hook 'before-save-hook 'retabify-c-buffer)

This is safe as the function doesn't do anything when not editing
C files. (It is easily modified to also recognize Java,
Objective-C and other CC Mode languages, but these are
untested.)"
  (interactive)
  (when (member major-mode '(c-mode c++-mode java-mode php-mode)) ; only work with these modes
    (message "Re-tabbing...")
    (let ((indent-level 0)  ; indentation of current line
          (tab-level 0)     ; amount of indentation to convert to tabs
          (orig-line (line-number-at-pos)) ; remember these manually
          (orig-column (current-column)))  ; since buffer size changes
      (save-restriction
        (widen)

        ;; Move through buffer line by line
        (goto-char (point-min))         ; first line
        (while (not (eobp))
          (beginning-of-line)
          (setq indent-level (current-indentation)) ; read indent level
          (when (> indent-level 0)
            ;; Convert all indentation to spaces
            (untabify (point) (+ indent-level (point)))

            ;; Check syntactic context to determine tab-level. Unless
            ;; line has alignment, tabify all of indentation; else
            ;; tabify up to last tab-level.
            (unless (member (car (car (c-guess-basic-syntax)))
                            retabify-c-align-list)
              (setq tab-level indent-level))

            ;; Make tabs
            (tabify (point) (+ tab-level (point))))

          (forward-line 1)))            ; next line

      ;; Done; restore position of point
      (goto-line orig-line)
      (move-to-column orig-column))
    (message "Re-tabbing...done")))


) 
(provide 'my-cc-mode)
