;;bug http://stackoverflow.com/questions/885793/emacs-error-when-calling-server-start
;;(require 'server)
(when (and (= emacs-major-version 23)
           (= emacs-minor-version 1)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t)) ; Suppress error "directory
					; ~/.emacs.d/server is unsafe"
					; on windows.

;;automatically start server for emacsclient
;;(server-start)

;;Making C-x k end an emacsclient session
; If your fingers are wired to using C-x k to kill off buffers (and
; you dont like having to type C-x #) then try this:
;(add-hook 'server-switch-hook 
;		  (lambda ()
;			(when (current-local-map)
;			  (use-local-map (copy-keymap (current-local-map))))
;			(local-set-key (kbd "C-x k") 'server-edit)))

