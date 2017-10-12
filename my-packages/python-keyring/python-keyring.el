;;; python-keyring.el --- query keyring from emacs via python

;; Copyright (C) 2017 Hauke Rehfeld

;; Author: Hauke Rehfeld <emacs@haukerehfeld.de>
;; Version: 0.1
;; Package-Requires: ()
;; Keywords: password, keyring, identity
;; URL: https://github.com/hrehfeld/emacs-python-keyring

;;; License:

;; This file is not (yet) part of GNU Emacs.
;; However, it is distributed under the same license.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Functions to call the python keyring functions


;;; Code:

(defvar python-keyring/-cmd '("python" "-c" "import keyring; p = keyring.get_password(%S, %S); print(p if p is not None else '')"))
(setq python-keyring/-cmd '("python" "-c" "import keyring; p = keyring.get_password(%S, %S); print(p if p is not None else '')"))

(defun python-keyring/-call-process (program &rest args)
  (let (result)
    (condition-case nil
        (with-temp-buffer
          (apply 'call-process program nil t nil args)
          (setq result (buffer-substring-no-properties (point-min)
													   ;;newline
                                                       (if (> (point-max) (point-min)) (- (point-max) 1) (point-max)))))
      ((t (setq result nil))))
    result))

(defun python-keyring/-get-password (cat name)
  "Retrieve a password from the keyring. 
If the password is found in the keyring, it is returned.

To add a password to the keyring, see `python-keyring/add-password';
it is best to only call this if the password is correct.

CAT and NAME  are used to identify the password in the keyring.
Typical entries are the protocol and the host."
  (let* ((args (mapcar (lambda (c) (format c cat name)) python-keyring/-cmd))
		 (result
		   (apply 'python-keyring/-call-process 
				  args)))
    (if (equal result "") nil result)))

;; (defun python-keyring/-add-password-gnome (name alist secret)
;;   (let (list)
;;     (mapc (lambda (elt)
;;             (setq list (append (car elt) (cdr elt) list)))
;;           alist)
;;     (python-keyring/-call-process python-keyring/-gnome-program "set"
;;                            (nreverse list)
;;                            name secret)))

;;;###autoload
(defun python-keyring/get-password-or-prompt (prompt cat name)
  "Retrieve a password, from the user or the keyring.

If the password is found in the keyring, it is returned.
Otherwise, the user is prompted for the password and a cons
of the form `(t . PASSWORD)' is returned.

To add a password to the keyring, see `python-keyring/add-password';
it is best to only call this if the password is correct.

CAT and NAME  are used to identify the password in the keyring.
Typical entries are the protocol and the host."
  (let ((pw (python-keyring/-get-password cat name)))
    (or pw (read-passwd (concat prompt ": ")))))

;; (defun python-keyring/add-password (name alist secret)
;;   "Add a password to the keyring.
;; NAME is a user-readable name for the password.
;; ALIST is an alist, as in `python-keyring/get-password'.
;; SECRET is the password to add.
;; If the password already exists in the keyring, it is updated."
;;   (funcall (python-keyring/-get-symbol "add") name alist secret))

;; (defun python-keyring/add-passwd-ask-user (name alist secret)
;;   ;; Maybe a variable to let the user always save?
;;   ;; Would be friendly to record which ones *not* to save, at least
;;   ;; for the duration of this session.
;;   (if (y-or-n-p (format "Save password for `%s'? " name))
;;       (python-keyring/add-passwd name alist secret)))
(provide 'python-keyring)
