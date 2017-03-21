(use-package sticky-window-delete
  :disabled t
;  :ensure t
  :bind (("C-x 0" . sticky-window-delete-window)
		 ("C-x 1" . sticky-window-delete-other-windows)
		 ("C-x 9" . sticky-window-keep-window-visible)
		 ))
