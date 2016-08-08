(use-package haskell-mode
  :ensure t
  :config
  (progn
	(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
	(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
	)
  :mode
  (
   "\\.[hg]s"
   "\\.hi"
   ("\\.l[hg]s" . literate-haskell-mode)
   )
  )



