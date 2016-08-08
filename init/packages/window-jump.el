(use-package window-jump
  :ensure window-jump
 :init (progn
		(global-set-key (kbd "C-c C-h") 'window-jump-left)
		(global-set-key (kbd "C-c C-j") 'window-jump-down)
		(global-set-key (kbd "C-c C-k") 'window-jump-up)
		(global-set-key (kbd "C-c C-l") 'window-jump-right)
		 )
 )
