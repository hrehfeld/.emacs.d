(global-set-key "\M-C" 'compile)
(global-set-key "\C-^" 'next-error)

;set height of compilation window
(setq compilation-window-height 8)
(setq compilation-scroll-output 'first-error)


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


(provide 'my-compile)
