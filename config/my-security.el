(setq tls-program
      ;; Defaults:
      ;; '("gnutls-cli --insecure -p %p %h"
      ;;   "gnutls-cli --insecure -p %p %h --protocols ssl3"
      ;;   "openssl s_client -connect %h:%p -no_ssl2 -ign_eof")
      '("gnutls-cli -p %p %h"
        "openssl s_client -connect %h:%p -no_ssl2 -no_ssl3 -ign_eof"))

(setq starttls-use-gnutls t
	  starttls-extra-arguments '("--starttls")
	  )


(provide 'my-security)
