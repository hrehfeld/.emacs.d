(use-package mpc
 :ensure t
 :config (progn
		   (setq mpc-host "foobar2000@127.0.0.1:6600")
		   (setq mpc-browser-tags '(;Genre
									Artist|Composer;|Performer
									Album;|Playlist
									))
	   )
 )
