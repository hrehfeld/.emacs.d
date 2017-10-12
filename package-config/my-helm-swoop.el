(use-package helm-swoop
  :ensure helm-swoop
  :config
  (progn
	;; When doing isearch, hand the word over to helm-swoop
	(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)

	;; From helm-swoop to helm-multi-swoop-all
	(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

	;; Save buffer when helm-multi-swoop-edit complete
	(setq helm-multi-swoop-edit-save t)

	;; If this value is t, split window inside the current window
	(setq helm-swoop-split-with-multiple-windows nil)

	;; Split direcion. 'split-window-vertically or 'split-window-horizontally
	(setq helm-swoop-split-direction 'split-window-vertically)

	;; If nil, you can slightly boost invoke speed in exchange for text color
	(setq helm-swoop-speed-or-color t)


	)
 :bind (
		("C-c s" . helm-swoop)
		("M-i" . helm-swoop)
		("C-x c s" . helm-multi-swoop-all)
		)
 )
(provide 'my-helm-swoop)
