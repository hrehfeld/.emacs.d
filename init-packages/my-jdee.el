(use-package jdee
  :config (progn
			(setq
			 jdee-server-dir (concat user-emacs-directory "jdee/server/target/")
			 jdee-global-classpath
			 `(
			   "$ANDROID_HOME"
			   "$ANDROID_HOME/extras/android/m2repository/"
			   "$ANDROID_HOME/platforms/android-22/android.jar"
			   "$ANDROID_HOME/platforms/android-23/android.jar"
			   )
			 jdee-sourcepath `("$ANDROID_HOME/sources/android-23")
			 my/jdee-m2repo "$ANDROID_HOME/extras/android/m2repository/"
			 )

			(when nil ;;debuggin
			  (setq jdee-help-docsets
					'((nil "http://docs.oracle.com/javase/8/docs/api" "1.8")
					  (nil "http://docs.oracle.com/javase/7/docs/api" "1.7")
					  (nil "http://docs.oracle.com/javase/6/docs/api" "1.6")
					  (nil "http://docs.oracle.com/j2se/1.5.0/docs/api" "1.5"))))

			(add-to-list 'jdee-help-docsets
						 `(nil , (concat "file://" (getenv "ANDROID_HOME") "/platform-tools/api") "1.8"))

			(defun my/jdee-set-classpath (&rest cps)
			  (mapc (lambda (cp)
					  (add-to-list 'jdee-global-classpath cp)
					  )
					cps)
			  (jdee-set-variables `(jdee-global-classpath ,(quote jdee-global-classpath)))
			  (jdee-bsh-exit)
			  "Set classpath and restarted beanshell."
			  )
			)
  ;;:bind (:map java-mode-map ("M-." . jdee-open-class-at-point))
  )



;;(my/jdee-set-classpath "test" "foo")
