(use-package info-look
  :defer 10
  :config
  (info-lookup-add-help
   :mode 'c-mode
   :regexp "[^][()'\" \t\n]+"
   :ignore-case t
   :doc-spec '(("(libc)Symbol Index" nil nil nil))))
  
(provide 'my-info-look)
