
(defun synonyms-get-thesaurus (language) "Get the default path to a language file."
  (concat user-emacs-directory "synonyms/" language ".txt"))

;; (setq synonyms-languages `(,(let* ((lang "german")
;;                                      (thesaurus (synonyms-get-thesaurus lang)))
;;                                `(,lang . ((:thesaurus . ,thesaurus)
;;                                         (:definition-url . "http://de.thefreedictionary.com/lexikon?Word="))))
;;                              ))


;; (defun synonyms-set-language (language)
;;   "Set the synonyms thesaurus file to <user-emacs-directory>/synonyms/<language>.txt"
;;   (interactive "MLanguage:")
;;   (let* ((data (assoc-default language synonyms-languages))
;;          (thesaurus (assoc-default :thesaurus data))
;;          (definition-url (assoc-default :definition-url data))
;;          )
;;     (if (not data)
;;         (message (concat "No such language '" language "'"))
;;       (progn
;;         (if (not (or thesaurus (file-exists-p thesaurus)))
;;              (message (concat "No thesaurus file " thesaurus " found."))
;;              (progn 
;;                (setq synonyms-file thesaurus)
;;                (let ((cache (concat thesaurus ".cache")))
;;                  (setq synonyms-cache-file cache))))
;;         (if definition-url
;;             (setq synonyms-dictionary-url definition-url)
;;           ))
;;       )))
;; (synonyms-set-language "german")

