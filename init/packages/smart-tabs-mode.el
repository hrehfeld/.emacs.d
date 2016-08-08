(use-package smart-tabs-mode
  :ensure t
  :init (progn
          (smart-tabs-insinuate 'c 'c++ 'java 'javascript)
          ;(add-hook 'c-mode-common-hook 'smart-tabs-mode-enable)
          ))

