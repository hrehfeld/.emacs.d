
(defface line-length-limit
  '((((background dark)) (:underline "#ff0")))
  "Face when more than 100 characters are in a line.")

(defface font-lock-comparison-operator-face
  '((((background dark)) (:foreground "#fff")))
  "Face for comparison operators.")



;(setq hrehf-font "DejaVu Sans Mono"
;(setq hrehf-font "Source Code Pro"
(setq hrehf-font "Inconsolata"
	  hrehf-font-variable "Dejavu Sans"
	  hrehf-font-size 11)
(setq-default line-spacing 1)

(setq hrehf-font-point-to-pixel-map '((6 . 8)
									  (7 . 9)
									  (7.5 . 10)
									  (8 . 11)
									  (9 . 12)
									  (10 . 13)
									  (10.5 . 14)
									  (11 . 15)
									  (12 . 16)
									  (13 . 17)
									  (13.5 . 18)
									  (14 . 19)
									  (14.5 . 20)
									  (15 . 21)
									  (16 . 22)
									  (17 . 23)
									  (18 . 24)
									  (20 . 26)
									  (22 . 29)
									  (24 . 32)
									  (26 . 35)
									  (27 . 36)
									  (28 . 37)
									  (29 . 38)
									  (30 . 40)
									  (32 . 42)
									  (34 . 45)
									  (36 . 48)
									  ))

(defun hrehf-x-display-points-height ()
  "Display height in point"
  (when (display-graphic-p)
    (- (round (/ (float (x-display-pixel-height))
		 (* 1.11 (float (cdr (assoc hrehf-font-size
					    hrehf-font-point-to-pixel-map))))))
	 5))
  (mapc (lambda (e) 
		(add-to-list 'default-frame-alist e))
	  `((top . 0)
		(left . 80)
		(width . 100) 
		(height . ,(hrehf-x-display-points-height)
				))))


(defun hrehf-set-font ()
  "Set the current font size from the hrehf-font and hrehf-font-size variables"
  (interactive)
    (set-face-attribute 'default nil 
			:font (concat hrehf-font "-"
				      (number-to-string hrehf-font-size))))
(when (display-graphic-p) (hrehf-set-font))

(defun hrehf-font-size-change (amount)
  (interactive)
  (setq hrehf-font-size (+ hrehf-font-size amount))
  (hrehf-set-font)
  (minibuffer-message (concat "Font-size set to " 
							  (number-to-string hrehf-font-size)))
  )

(defun hrehf-font-size-larger () (interactive) (hrehf-font-size-change 1))
(defun hrehf-font-size-smaller () (interactive) (hrehf-font-size-change -1))

(global-set-key (kbd "C-<wheel-up>") 'hrehf-font-size-smaller)
(global-set-key (kbd "C-<wheel-down>") 'hrehf-font-size-larger)

(global-set-key (kbd "C-<kp-subtract>") 'hrehf-font-size-smaller)
(global-set-key (kbd "C-<kp-add>") 'hrehf-font-size-larger)

(defun hrehf-line-spacing-change (amount)
  (interactive)
  (setq-default line-spacing (+ line-spacing amount))
  (minibuffer-message (concat "line-spacing set to " 
							  (number-to-string line-spacing)))
  )

(defun hrehf-line-spacing-larger () (interactive) (hrehf-line-spacing-change 1))
(defun hrehf-line-spacing-smaller () (interactive) (hrehf-line-spacing-change -1))
(global-set-key (kbd "C-S-<kp-subtract>") 'hrehf-line-spacing-smaller)
(global-set-key (kbd "C-S-<kp-add>") 'hrehf-line-spacing-larger)


;; visual-pitch-mode
(set-face-attribute 'variable-pitch nil 
					:family hrehf-font-variable)

;(when (display-graphic-p) (w32-maximize-frame))


