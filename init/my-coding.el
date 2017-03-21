;; deal with encoding

;; putty with screen
(define-key input-decode-map "\e[1;2A" [S-up])


;utf8 stuff
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(setq-default buffer-file-coding-system 'utf-8-unix)
;;Save whatever's in the current (system) clipboard before replacing it with the Emacs' text.
(setq save-interprogram-paste-before-kill t)
(setq select-enable-clipboard t)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; MS Windows clipboard is UTF-16LE 
(if (eq system-type 'windows-nt)
    (set-clipboard-coding-system 'utf-16le-dos))

;; Unicode handling
;Another way is to use C-q t by default, if you type C-q followed
;by some digits, those are interpreted as an octal code. Set
;read-quoted-char-radix to 10, and then you can type like a normal
;person.
(setq read-quoted-char-radix 10)
;Now try C-q 160 RET you should get something that looks like a
;space. Move back by one and use `C-u C-x =` you should get
;something like this:

(defun revert-buffer-with-line-endings (newstyle)
  (interactive)
  (revert-buffer-with-coding-system
   (let ((coding-str (symbol-name buffer-file-coding-system)))
     (when (string-match "-\\(?:dos\\|mac\\|unix\\)$" coding-str)
       (setq coding-str
             (concat (substring coding-str 0 (match-beginning 0)) "-" newstyle))
       (message "CODING: %s" coding-str)
       (revert-buffer-with-coding-system (intern coding-str))))))
(global-set-key (kbd "C-. c") (lambda () (interactive) (revert-buffer-with-line-endings "dos")))

;TODO is this necessary still?
(add-to-list 'file-coding-system-alist '("\\.cpp\\|\\.c\\|\\.hpp\\|\\.h\\|\\.cu\\|\\.cuh\\|\\.cu.h" . prefer-utf-8))


(provide 'my-coding)
