(use-package my-org-babel)
(setq org-plantuml-jar-path
      (setq plantuml-jar-path (expand-file-name "/opt/plantuml/plantuml.jar")))

(if (file-readable-p org-plantuml-jar-path)
	(org-babel-do-load-languages
	 'org-babel-load-languages
	 '((plantuml . t))))

(provide 'my-org-plantuml)
