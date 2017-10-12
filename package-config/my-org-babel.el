(use-package my-org)
(setq org-confirm-babel-evaluate nil)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   ;;(elasticsearch . t)
   ;;(clojure . t)
   (dot . t)
   (sh . t)
   (js . t)
   (haskell . t)
   ;;(ruby . t)
   (python . t)
   (gnuplot . t)
   (plantuml . t)
   (latex . t)))


;; ensure this variable is defined
(unless (boundp 'org-babel-default-header-args:sh)
  (setq org-babel-default-header-args:sh '()))

;; add a default shebang header argument shell scripts
(add-to-list 'org-babel-default-header-args:sh
			 '(:shebang . "#!/usr/bin/env bash"))

;; add a default shebang header argument for python
(add-to-list 'org-babel-default-header-args:python
			 '(:shebang . "#!/usr/bin/env python"))


(provide 'my-org-babel)

