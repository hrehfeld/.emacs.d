;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Category Tweak Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq system-time-locale "C")


(defvar user-temporary-file-directory)
(setq user-temporary-file-directory (concat user-emacs-directory "temp/"))
(make-directory user-temporary-file-directory t)

;;don't rename the original file into the backup file name, then create a new file and insert the current data into it
(setq
 ; don't clobber symlinks
 backup-by-copying t 
 ; don't litter my fs tree
 backup-directory-alist
 `((,tramp-file-name-regexp nil)
   ("." . ,user-temporary-file-directory))
)
(setq
 delete-old-versions t
 kept-new-versions 20
 kept-old-versions 20
 version-control t
)
(setq backup-enable-predicate
           (lambda (name)
             (and (normal-backup-enable-predicate name)
                  (not
                   (let ((method (file-remote-p name 'method)))
                     (when (stringp method)
                       (member method '("su" "sudo"))))))))

(setq auto-save-list-file-prefix (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms `((".*" ,user-temporary-file-directory t)))


(setq truncate-partial-width-windows nil)

;Running Make with the closest Makefile In some projects, systems do
;not have a Makefile in each directory. As an example, you may be
;working on files in srch, and you’d like to execute make -f
;../../Makefile. To do this, you’ll need to extract the closest
;makefile in the parent directory and above:
(require 'cl) ; If you don't have it already
(defun* get-closest-pathname (&optional (file "Makefile") (path default-directory))
  "Determine the pathname of the first instance of FILE starting from the current directory towards root.
This may not do the correct thing in presence of links. If it does not find FILE, then it shall return the name
of FILE in the current directory, suitable for creation"
  (let ((root (expand-file-name "/"))) ; the win32 builds should translate this correctly
    (expand-file-name file
                      (loop 
                       for d = path then (expand-file-name ".." d)
                       if (file-exists-p (expand-file-name file d))
                       return d
                       if (equal d root)
                       return nil))))
(require 'compile)
(let ((make-call (lambda () (set (make-local-variable 'compile-command) (format "make -f %s" (get-closest-pathname "Makefile"))))))
  (add-hook 'c-mode-hook make-call)
  (add-hook 'c++-mode-hook make-call)
  )
(add-hook 'java-mode-hook 
          (lambda () (set (make-local-variable 'compile-command) 
                          (format "ant -f %s" (get-closest-pathname "build.xml")))))
;compile will only prompt for a compile-command if you give it a prefix argument.
(setq compilation-read-command nil)


; sane rebuilder syntax
(setq reb-re-syntax 'string)


;;tramp mode
(when win32
  (require 'tramp)
  (setq tramp-default-method "plink")
  
;  (nconc (cadr (assq 'tramp-login-args (assoc "ssh" tramp-methods)))
;		 '(("bash" "-i")))
;  (setcdr (assq 'tramp-remote-sh (assoc "ssh" tramp-methods))
;		  '("bash -i"))
)

(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.

With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))
 
(defun sudo-edit-current-file ()
  (interactive)
  (find-alternate-file (concat "/sudo:root@localhost:" (buffer-file-name (current-buffer)))))
(global-set-key (kbd "C-c C-r") 'sudo-edit-current-file)

;Distinguish buffers of the same filename in Emacs
(require 'uniquify nil t)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn 	 (rename-file name new-name 1) 	 
                 (rename-buffer new-name) 	 
                 (set-visited-file-name new-name)
                 (set-buffer-modified-p nil))))))
(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR."
  (interactive "DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn 	(copy-file filename newname 1) 	
                (delete-file filename) 	
                (set-visited-file-name newname) 	
                (set-buffer-modified-p nil) 	
                t))))

(setq starttls-use-gnutls t
	  starttls-extra-arguments '("--starttls")
	  )


(my-load-init-file "emacsclient")

;; getting rid of the “yes or no” prompt and replace it with “y or n”:
(fset 'yes-or-no-p 'y-or-n-p)
;; And finally, the recently-added prompt in Emacs 23.2 that asks you if you want to kill a buffer with a live process attached to it:
(setq kill-buffer-query-functions nil)



(my-load-init-file "coding")

(my-load-init-file "window-setup")

;; Abbrevs
;(quietly-read-abbrev-file)    ;; reads the abbreviations file on startup
;(setq save-abbrevs t)         ;; save abbrevs when files are saved
;(abbrev-mode 1)               ;; default it to on

(setq-default tab-width 4 
			  indent-tabs-mode t)

(global-font-lock-mode 1)

(transient-mark-mode 0)

;; highlight matching parentheses
(show-paren-mode 1)
(setq show-paren-style 'mixed)

(setq recentf-max-saved-items 999)

;; bind M-g to gotoline
(global-set-key "\M-g" 'goto-line)


;compile
(global-set-key "\M-C" 'compile)
(global-set-key "\C-^" 'next-error)

;set height of compilation window
(setq compilation-window-height 8)

;I also don't like that the compilation window sticks around after a successful compile. After all, most of the time, all I care about is that the compile completed cleanly. Here's how I make the compilation window go away, only if there was no compilation errors: 
;; (add-to-list compilation-finish-functions
;;              (lambda (buf str)
;;                (let ((filters '((string-match "exited abnormally" str))))
;;                  (if ( ma
;;                               ;;there were errors
;;                               (message "compilation errors, press C-x ` to visit")
;;                               ;;no errors, make the compilation window go away in 0.5 seconds
;;                               (run-at-time 0.5 nil 'delete-windows-on buf)
;;                               (message "NO COMPILATION ERRORS!")))))))



;(when window-system 
  ;(speedbar t)
;)



(my-load-init-file "buffers")

;enable the set goal function (C-x C-n) which puts the cursor on a certain columnx
(put 'set-goal-column 'disabled nil)

(setq history-length 1000)

(my-load-init-file "search")


(my-load-init-file "persistance")
(my-load-init-file "editing")

(my-load-init-file "functions")


(add-hook 'text-mode-hook (lambda () 
                            (visual-line-mode 1)
                            ;; lines are still defined by line-breaks, not display
                            (setq line-move-visual t)
                            ))


(setq mark-ring-max 128)
(setq global-mark-ring-max 128)

(setq set-mark-command-repeat-pop t)

(define-key global-map  (kbd "M--") 'previous-buffer)
(define-key global-map  (kbd "C-M--")   'next-buffer)
