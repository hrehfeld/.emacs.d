;(filesets-init)

;;settings

;cpu hog if t
(setq auto-revert-check-vc-info nil
      auto-revert-interval 5)

(global-auto-revert-mode 1)
(setq auto-revert-verbose t)
(setq auto-revert-mode-text "aRevert")


;; midnight mode
(require 'midnight)
(setq clean-buffer-list-delay-general 7)


(defvar user-temporary-file-directory)
(setq user-temporary-file-directory (concat user-emacs-directory "temp/"))
(make-directory user-temporary-file-directory t)

;;don't rename the original file into the backup file name, then create a new file and insert the current data into it
(setq
 ; don't clobber symlinks
 backup-by-copying t 
 ; don't litter my fs tree
 backup-directory-alist
 `((,tramp-file-name-regexp . nil)
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

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "*FRename to: ")
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


(provide 'my-files)
