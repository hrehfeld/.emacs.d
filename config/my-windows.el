;; window stuff

;; suppress the startup messages
(setq inhibit-startup-message t)

;; dont display the menu, scroll, tool bar
(add-hook 'window-setup-hook (lambda () 
                               (tool-bar-mode -1)
                               (menu-bar-mode -1)
							   (scroll-bar-mode -1)
							   (if (display-graphic-p)
								   nil
								 )))
(blink-cursor-mode -1)

(setq truncate-partial-width-windows nil)


;; put file/buffer name in frame title
(setq-default frame-title-format (list "%f"))
;;  put buffer name in icon
(setq-default icon-title-format (list "%b"))

;; this maximizes the emacs frame
(defun w32-maximize-frame ()
  "Maximize the current frame"
  (interactive)
  (if (eq system-type 'windows-nt)
	  (w32-send-sys-command 61488)))


;; modeline options
; show current function in modeline
;(which-func-mode t)
(which-func-mode nil)

;; show the column in buffer status
(column-number-mode 1)

(setq-default indicate-empty-lines t)



(setq scroll-margin 5)

(setq scroll-conservatively 0
      scroll-preserve-screen-position 'always)
(setq mouse-wheel-follow-mouse t
	  mouse-wheel-scroll-amount '(0.3 ((shift) . 1)))

(provide 'my-windows)
