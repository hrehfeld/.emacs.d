;(filesets-init)

;;settings

;cpu hog if t
(setq auto-revert-check-vc-info nil
      auto-revert-interval 5)

(global-auto-revert-mode 1)
(setq auto-revert-verbose t)
(setq auto-revert-mode-text "aRevert")


;; midnight mode
(require 'midnight)
(setq clean-buffer-list-delay-general 7)


