(setq flymake-log-level -1)
(setq flymake-gui-warnings-enabled nil)
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.2)
(setq help-at-pt-display-when-idle '(flymake-display-err-minibuf))


(defun flymake-create-temp-intemp (file-name prefix)
  "Return file name in temporary directory for checking FILE-NAME.
This is a replacement for `flymake-create-temp-inplace'. The
difference is that it gives a file name in
`temporary-file-directory' instead of the same directory as
FILE-NAME.

For the use of PREFIX see that function.

Note that not making the temporary file in another directory
\(like here) will not if the file you are checking depends on
relative paths to other files \(for the type of checks flymake
makes)."
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext  (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext))
         )
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))

(defun flymake-create-temp-inplace-extension (file-name extension)
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or extension
      (setq extension "flymake"))
  (let* ((temp-name   (concat (file-name-sans-extension file-name)
			      "_" extension)))
    (flymake-log 3 "create-temp-inplace: file=%s temp=%s" file-name temp-name)
    temp-name))

(require 'flymake)


(when-available 'flymake-cursor-mode
                (add-hook 'flymake-mode-hook (lambda () (flymake-cursor-mode t))))
