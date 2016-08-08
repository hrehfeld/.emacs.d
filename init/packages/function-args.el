(:init
 (progn
   (add-hook 'c++-mode-hook 'turn-on-function-args-mode)
   (add-hook 'c-mode-hook 'turn-on-function-args-mode))
   ;(fa-config-default)
 :demand
 )


