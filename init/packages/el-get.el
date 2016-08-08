(add-to-list 'load-path (concat user-emacs-directory "el-get/el-get"))

(when (not (require 'el-get nil 'noerror))
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
	 (let (el-get-master-branch)
	   (goto-char (point-max))
	   (eval-print-last-sexp)))))

;(use-package el-get
;  :ensure el-get

;  :init
;  (progn
	(setq el-get-sources
		  '(
										;(:name el-get :branch "master")
			;; (:name inversion
			;; 	   :type http
			;; 	   :url "http://www.gnufans.net/~deego/emacspub/site-lisp/inversion.el"
			;; 	   :features inversion
			;; 	   )
			;; (:name cedet
			;; 		 :depends inversion
			;; 		 :build/windows-nt (list 
			;; 				 (concat "make -f " 
			;; 						 (concat (file-name-as-directory user-emacs-directory)
			;; 								 "el-get/cedet/Makefile ebuild")))
			;; 		 :load nil
			;; 		 ;:load ("common/cedet.el")
			;; 		 :after (progn
			;; 				  ;(semantic-load-enable-excessive-code-helpers)
			;; 				  ;(global-ede-mode 1)
			;; 								;(defvar ac-source-semantic-analyze '((candidates . (semantic-analyze-to-ac-source-candidates))))
			
			;; 								;(add-hook 'c-mode-common-hook (lambda () (add-to-list 'ac-sources 'ac-source-semantic)) t)
			;; 				  ;(global-set-key (kbd "M-RET") 'semantic-ia-fast-jump)
			;; 				  )
			;; 		 ;:features semantic-ia semantic-gcc
			;; 		 )

			 (:name color-theme-hrehf
			 	   :type github
			 	   :pkgname "hrehfeld/emacs-color-themes"
			 	   :features color-theme-hrehf-dark color-theme-hrehf-classy
			 	   )
			 (:name org-caldav-fork
					:website "https://github.com/blaa/org-caldav"
					:description "Two-way CalDAV synchronization for org-mode"
					:type github
					:pkgname "blaa/org-caldav")
			;; (:name color-theme-dirac
			;; 	   :type git
			;; 	   :url "git://github.com/nicodds/color-theme-dirac.git"
			;; 	   :load "color-theme-dirac.el"
			;; 							;:features color-theme-dirac
			;; 	   )
			;; (:name hlsl-mode
			;; 	   :type svn
			;; 	   :url "svn://svn.code.sf.net/p/hlslmode/code/trunk/package"
			;; 	   :features hlsl-mode
			;;	   )
			;; (:name org-scrum
			;; 	   :type github
			;; 	   :pkgname "ianxm/emacs-scrum"
			;; 	   :features scrum
			;; 	   :depends gnuplot
			;; 	   )
			))
	(el-get t
			'(
			  ;color-theme-hrehf
			  )
	    )
;	)
;  )

