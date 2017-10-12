;; Mode line setup
(setq
 mode-line-format
 '("%e"
   mode-line-front-space
   mode-line-mule-info
   mode-line-client
   mode-line-modified
   mode-line-remote
   mode-line-frame-identification
   mode-line-buffer-identification
   org-clock-mode-line-entry
   sml/pos-id-separator
   mode-line-position
   (wg-mode-line-on
	(:eval
	 (wg-mode-line-string)))
   (vc-mode vc-mode)
   sml/pre-modes-separator
   mode-line-modes
   mode-line-misc-info
   mode-line-end-spaces
   ))
