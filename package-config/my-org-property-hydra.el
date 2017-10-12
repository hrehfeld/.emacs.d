(use-package hydra
  :config
  (use-package my-org
	:config

    (defmacro my/org-set-property-defhydra (key values)
      `(defhydra ,(make-symbol (concat "my/org-set-property-hydra-" key)) ()
         ,(concat "Set " key " Property")
         ,@(mapcar (lambda (value)
                     `(,(downcase (substring value 0 1)) (org-set-property ,key ,value) ,value :exit t))
                   values)
         ("j" (my/org-set-property ,key) "<Enter>")))
    
    (my/org-set-property-defhydra "Context" ("Erledigen" "Research" "Kaufen" "Configure"))
    (my/org-set-property-defhydra "LOCATION" ("Home" "Karlsruhe"))

    (global-set-key
     (kbd "C-c q")
     (defhydra hydra-org-set-property ()
       "Set common properties"
       ("c" my/org-set-property-hydra-Context/body "Context" :exit t)
       ("l" my/org-set-property-hydra-LOCATION/body "LOCATION" :exit t)
       ("a" (progn
              (my/org-set-property "LOCATION")
              (my/org-set-property my/org-property-key-context)
              ) "LOCATION & Context" :exit t)
       ("E" (progn
              (org-set-property "LOCATION" "Home")
              (org-set-property my/org-property-key-context "Erledigen")
              ) "Erledigen @Home" :exit t)
       ("r" (progn
              (org-set-property my/org-property-key-context "Research")
              ) "Research")
       ("q" nil "Quit")
       ))
))
(provide 'my-org-property-hydra)
