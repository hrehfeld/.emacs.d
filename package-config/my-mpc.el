(use-package mpc
 :ensure t
 :config (progn
		   (setq mpc-browser-tags '(;Genre
									Artist|Composer;|Performer
									Album;|Playlist
									))
	   )
 )
(provide 'my-mpc)
