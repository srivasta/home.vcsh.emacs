;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; -*- coding: utf-8; -*- -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;
;; gnusrc.el ---
;; Author           : Manoj Srivasta ( srivasta@tiamat.datasync.com )
;; Created On       : Sun Nov 23 17:58:22 1997
;; Created On Node  : tiamat.datasync.com
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Tue Sep  1 22:40:33 2009
;; Last Machine Used: anzu.internal.golden-gryphon.com
;; Update Count     : 290
;; Status           : Unknown, Use with caution!
;; HISTORY          :
;; Description      :
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "nnrss")
;;; System Level Stuff
(setq gnus-local-organization "Manoj Srivastava's Home")

(require 'gnus-registry)
(gnus-registry-initialize)

;
;; ;; receive mail
;; (add-to-list 'gnus-secondary-select-methods '(nnml ""))
;; (setq mail-sources `((pop :server "pop.gmx.de"
;;                           :user "tassilo.horn@gmx.de"
;;                           :password ,th-gnus-gmx-password)

;;; Where we get the main set of news from from
;;; (setq gnus-select-method '(nnspool "")
;;;       nnspool-lib-dir         "/var/lib/news/"
;;;       nnspool-spool-directory "/var/spool/news/articles"
;;;       )

(setq mail-sources
      '(
        (directory :path "~/var/spool/mail" :suffix ".spool")
        ;;        (imap :server "smtp.golden-gryphon.com" :dontexpunge t :stream 'tls)
        ))

(setq gnus-select-method
      '(nnml ""
         (nnml-directory "~/var/spool/news/nnml/")
         (nnml-use-compressed-files t)
         (nnml-active-file "~/var/spool/news/nnml/active")
         (nnml-newsgroups-file "~/var/spool/news/nnml/newsgroups")
         ;; (nnvirtual "^alt\\.fan\\.andrea-dworkin$\\|^rec\\.dworkin.*")
         ))
(eval-when-compile (require 'imap))
(setq imap-enable-exchange-bug-workaround t)

;;
;;(setq imap-log t)
;; Secondary select methods (Could be virtual servers, you know)
(setq gnus-secondary-select-methods
      '(
        (nntp "news.eternal-september.org"
              (nntp-address "news.eternal-september.org")
              (nntp-maximum-request 3)
              (nntp-connection-timeout 300)
              (nntp-open-connection-function nntp-open-ssl-stream)
              (nntp-port-number 563))

        (nntp "news.gmane.org"
              (nntp-address "news.gmane.org")
              (nntp-connection-timeout 300)
              (nntp-open-connection-function nntp-open-network-stream)
              (nntp-port-number 119))


       (nnimap "smtp.golden-gryphon.com"
        (nnimap-address "smtp.golden-gryphon.com")
        (nnimap-expunge-on-close 'always)
        (nnir-search-engine imap)
        (nnimap-streaming nil)
        (nnimap-authinfo-file "~/.authinfo"))

       ;;; (nnimap "gmail"
       ;;;         (nnimap-address "imap.gmail.com")
       ;;;         (nnimap-authinfo-file "~/.authinfo")
       ;;;         (nnimap-server-port 993)
       ;;;         (nnimap-stream ssl)
       ;;;         (nnmail-expiry-target "nnimap+gmail:[Gmail]/Trash")
       ;;;         (nnmail-expiry-wait immediate))

       ))


;;        (nntp "news.gwene.org"
;;              (nntp-address "news.gwene.org")
;;              (nntp-connection-timeout 300)
;;              (nntp-port-number 119))

        ;;; (nntp "reader.news4all.se"
        ;;;       (nntp-address "reader.news4all.se")
        ;;;       (nntp-maximum-request 3)
        ;;;       (nntp-port-number 119)
        ;;;       (nntp-connection-timeout 300))


        ;;;(nntp "glaurung.internal.golden-gryphon.com")
        ;;;	(nntp "quimby.gnus.org")
        ;;;     (nntp "news.datasync.com"
        ;;;           (nntp-address "localhost")
        ;;;           (nntp-port-number 11901)
        ;;;           (nntp-end-of-line "\n")
        ;;;           (nntp-prepare-server-hook
        ;;;            (lambda nil "tunnel prepare"
        ;;;              (call-process "ssh" nil 0 nil "-f" "-q"
        ;;;                            "-L" "11901:news.datasync.com:119"
        ;;;                            "datasync.com" "exec" "sleep" "60000")
        ;;;              (sit-for 3))))



;; ;; SMTP for GMX (sending)
;; (setq smtpmail-local-domain nil
;;       smtpmail-default-smtp-server "mail.gmx.net"
;;       smtpmail-debug-info t
;;       smtpmail-debug-verb t
;;       smtpmail-starttls-credentials
;;       '(("mail.gmx.net" 25 nil nil)))

;;; (setq
;;;  nnimap-inbox '("INBOX" "SENT")
;;;  nnmail-split-methods 'nnimap-split-fancy ;in case…
;;;  )

(eval-when-compile (require 'nnml))
(setq  nnml-use-compressed-files t)

;;
;; Specify directories
(eval-when-compile (require 'gnus-cache))
(eval-when-compile (require 'nnrss))
(setq
 gnus-startup-file          "~/etc/emacs/news/newsrc"
 gnus-init-file             "~/etc/emacs/news/gnusrc"
 gnus-directory             "~/var/spool/news"
 gnus-cache-directory       "~/var/spool/news/cache"
 gnus-cache-active-file     "~/var/spool/news/cache/active"
 gnus-dribble-directory     "~/var/spool/news/cache"
 gnus-default-directory     "~/"
 nnrss-directory            "~/var/spool/news/rss"
 )

;;
;; Automation and other global settings
(defun gnus-user-format-function-X (header)
  (let ((descr
         (assq nnrss-description-field (mail-header-extra header))))
    (if descr (concat "\n\t" (cdr descr)) ""))
  (let* ((to (or (cdr (assoc 'To (mail-header-extra header))) ""))
         (cc (or (cdr (assoc 'Cc (mail-header-extra header))) "")))
    (if (string-match gnus-ignored-from-addresses (concat to ", " cc))
        ">"
      ""))
  )

(defun gnus-user-format-function-Y (header)
  "Fix this"
  (let* ((listid (or (cdr (assoc 'List-ID (mail-header-extra header))) "")))
    (if (cdr (assoc listid list-label-map))
        (format " <%s>" (cdr (assoc listid list-label-map)))
      "")))


(defun gnus-user-format-function-@ (header)
  "Display @ for message with attachment in summary line.

You need to add `Content-Type' to `nnmail-extra-headers' and
`gnus-extra-headers', see Info node `(gnus)To From Newsgroups'."
  (let ((case-fold-search t)
        (ctype (or (cdr (assq 'Content-Type (mail-header-extra header)))
                   "text/plain"))
        indicator)
    (when (string-match "^multipart/mixed" ctype)
      (setq indicator "@"))
    (if indicator
        indicator
      " ")))

(defun gnus-user-format-function-parts (header)
  (let ((ctype (cdr (assq 'Content-Type
                          (mail-header-extra header)))))
    (if (or (not ctype)
            (string-match "^text/plain" ctype)
            (string-match "^multipart/\\(encrypted\\|signed\\)" ctype))
        " "
      "@")))

(defun gnus-user-format-function-d (header)
;  "Render date in (dd/mm) format"
  (let* ((date (mail-header-date header))
         (tz (timezone-parse-date date)))
    (format "%s/%s/%s"
            (aref tz 1)
            (aref tz 2)
            (aref tz 0))))
(defun gnus-user-format-function-score (header)
;  "Render date in (dd/mm) format"
  (let* ((date (mail-header-date header))
         (tz (timezone-parse-date date)))
    (format "%s/%s/%s"
            (aref tz 1)
            (aref tz 2)
            (aref tz 0))))
(defun gnus-user-format-function-y (header)
  "Convert the DATE to DD MM YYYY, HH:MM."
  (format-time-string "%d.%m.%Y, %R"
                      (gnus-date-get-time (mail-header-date header))))

(defun gnus-user-format-function-z (header)
  "Convert the DATE to DD MM YYYY"
  (format-time-string "%d.%m.%Y"
                      (gnus-date-get-time (mail-header-date header))))

(defvar *my-mails*
  (concat "srivasta@debian\\.org\\|srivasta@golden-gryphon\\.com\\|"
          "srivasta@ieee\\.org\\|srivasta@acm\\.org"))

(defun gnus-user-format-function-j (headers)
  (let ((to (gnus-extra-header 'To headers)))
    (if (string-match *my-mails* to)
        (if (string-match "," to) "~" "»")
      (if (or (string-match *my-mails*
                            (gnus-extra-header 'Cc headers))
              (string-match *my-mails*
                            (gnus-extra-header 'BCc headers)))
          "~"
        " "))))


;;;;(gnus-demon-add-nocem)
(gnus-demon-init)
(add-hook 'gnus-startup-hook
          '(lambda ()
             (gnus-demon-add-handler 'gnus-demon-scan-mail 120 60)
             (gnus-demon-add-handler 'gnus-demon-scan-news 120 60)
             (gnus-demon-add-handler 'gnus-demon-scan-timestamps nil 30)
             ))


;;;    Text inside the `%[' and `%]' specifiers will have their normal
;;; faces set using `gnus-face-0', which is `bold' by default.  If you
;;; say `%1[', you'll get `gnus-face-1' instead, and so on.  Create as
;;; many faces as you wish.  The same goes for the `mouse-face'
;;; specs--you can say `%3(hello%)' to have `hello' mouse-highlighted
;;; with `gnus-mouse-face-3'.

;;(copy-face 'bold-italic 'fp-topic-face)
;;(set-face-background 'fp-topic-face "mediumblue")

;;(copy-face 'default 'face-6)
;;(set-face-foreground 'face-6 "pink")

;;(copy-face 'default 'face-7)
;;(set-face-foreground 'face-7 "steelblue")

;;(copy-face 'default 'face-8)
;;(set-face-foreground 'face-8 "lime green")
;;(defface my-arrow '((t :inherit fixed-pitch)) "Face for Unicode arrows.")

(defvar gnus-face-5 'fp-topic-face)
(defvar gnus-face-6 'face-6)
(defvar gnus-face-7 'face-7)
(defvar gnus-face-8 'face-8)
(defvar gnus-face-10 'fixed-pitch)
;;(setq gnus-face-10 'shadow)


;;; threading
(defvar gnus-face-9 'font-lock-warning-face)


(defun summary-tree-ascii nil
  (interactive)
  (setq
   gnus-sum-thread-tree-indent          "  "
   gnus-sum-thread-tree-single-indent   nil ;; "o "
   gnus-sum-thread-tree-false-root      nil ;; "x "
   gnus-sum-thread-tree-root            nil ;; "* "
   gnus-sum-thread-tree-leaf-with-other "+-> "
   gnus-sum-thread-tree-vertical        "| "
   gnus-sum-thread-tree-single-leaf     "`-> " ;; "\\" is _one_ char
   ))

(defun summary-tree-unicode-1 nil
  (interactive)
  (setq
   gnus-sum-thread-tree-indent          "  "
   gnus-sum-thread-tree-single-indent   "● "  ;; "◎ "           "▣ " " ● "
   gnus-sum-thread-tree-false-root      "○ "  ;; "☆"            "□ " " ○ "
   gnus-sum-thread-tree-root            "┏● " ;; "● " "┌▶" "┌ " "■ " "┏● "
   gnus-sum-thread-tree-vertical        "│"   ;; "┃"
   gnus-sum-thread-tree-leaf-with-other "├─▶" ;; "┣━━❯ "
   gnus-sum-thread-tree-single-leaf     "╰─▶" ;; "┗━━❯ "
   ))

(defun summary-tree-unicode-square ()
  (interactive)
  (setq
   gnus-sum-thread-tree-indent           " "
   gnus-sum-thread-tree-single-indent    "▣ "
   gnus-sum-thread-tree-false-root       "□ "
   gnus-sum-thread-tree-root             "■ "
   gnus-sum-thread-tree-leaf-with-other  "├─▶ "
   gnus-sum-thread-tree-vertical         "│"
   gnus-sum-thread-tree-single-leaf      "└─▶ "))

(defun summary-tree-unicode-heavy ()
  (interactive)
  (setq
   gnus-sum-thread-tree-indent          " "
   gnus-sum-thread-tree-false-root      " ○ "
   gnus-sum-thread-tree-single-indent   " ● "
   gnus-sum-thread-tree-root            "┏● "
   gnus-sum-thread-tree-leaf-with-other "┣━━❯ "
   gnus-sum-thread-tree-vertical        "┃"
   gnus-sum-thread-tree-single-leaf     "┗━━❯ "))


;;  (setq
;;     gnus-sum-thread-tree-false-root      "┈┬──▷ "
;;     gnus-sum-thread-tree-single-indent   " ●  "
;;     gnus-sum-thread-tree-root            "┌─▶ "
;;     gnus-sum-thread-tree-vertical        "│"
;;     gnus-sum-thread-tree-leaf-with-other "├┬─► "
;;     gnus-sum-thread-tree-single-leaf     "╰┬─► "
;;     gnus-sum-thread-tree-indent          " ")

;;  (setq
;;   gnus-sum-thread-tree-single-indent   nil  ;; "◎ "
;;   gnus-sum-thread-tree-false-root              "◯ "
;;   gnus-sum-thread-tree-root            nil ;;  "┌ "    ;; "● "
;;   gnus-sum-thread-tree-vertical                "│"
;;   gnus-sum-thread-tree-leaf-with-other         "├─► "  ;; "├─>"
;;   gnus-sum-thread-tree-single-leaf             "╰─► "  ;; "└─>"
;;   gnus-sum-thread-tree-indent                  "  ")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (if (eq window-system 'x)                  ;;
;;     (sdl-gnus-summary-line-format-unicode) ;;
;;   (sdl-gnus-summary-line-format-ascii))    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; Mode line formats and such (do this before bbdb stuff)
;;; (setq
;;;  gnus-group-line-format
;;;      "%M%S%L%p %5,5y[%2T/%3,3I]:%(%-25,25c%) %6,6~(cut 2)d%O%6z%10D\n"
;;;  gnus-summary-line-format
;;;       "%U%R%z%4,4i %V %~(cut-left 2)~(max-right 6)~(pad 6)o %t%I%(%{[%3L:%-20,20uB]%}%)%s\n"
;;;; "%U%R%z%I%(%[%4L: %-20,20n%]%) %s\n"
;;;  gnus-summary-mode-line-format "%g %d %t %r %Z"
;;;  gnus-article-mode-line-format "%%b [%A] %w %10S"
;;;  ;; gnus-server-line-format
;;;  gnus-topic-line-format "%i[ %(%5{%n%}%) -- %g/%a/%A ]%v\n"
;;;  )
;;; gnus-summary-line-format
;;      "%U%R%z%4,4I %V %~(cut-left 2)~(max-right 6)~(pad 6)o %t%I%(%[%3L:%-20,20uB%]%)%s\n"

;; gnus-summary-line-format
;; "%M%S%L%p %4,4y[%2T/%3,3I]:%(%-25,25c%) <%2,2~(cut 6)d.%2,2~(cut 4)d.%2,2~(cut 2)d>%O%6z%10D\n"
(eval-when-compile (require 'gnus-topic))
(summary-tree-unicode-1)

(setq gnus-summary-line-format
      (concat
       "%0{%U%R%z%8V%} "
       "%1{%~(cut-left 2)~(max-right 6)~(pad 6)o%}"
       "%10{:%}"
       "%1{%~(cut-left 9)~(max-right 4)~(pad 4)o%} "
       "%(%[%3L:%uj%-20,20uB%]%)"
       "%2{%u@%}%2t " "%B" "%s \n"))

(setq
 gnus-group-line-format
 "%M%S%L%p%5,5y[%3T/%3,3I]:%(%-35,35c%) %6,6~(cut 2)d%O%6z%10D\n"
 gnus-group-mode-line-format   "Gnus: %%b {%M%:%S}"
 gnus-summary-mode-line-format "%g %Z %d %t %r %E"
 gnus-article-mode-line-format "%b [%A] %w|%m %10S"
 ;; gnus-server-line-format
 gnus-topic-line-format "%i[ %(%5{%n%}%) -- %g/%a/%A ]%v\n"
 )

(defvar my-headers '(To Cc Newsgroups Keywords X-Newsreader List-ID
                   Resent-CC X-Debian-PR-Package nnrss-description-field
                   X-Debian-PR-Message Content-Type))
(while my-headers
  (let ((header (car my-headers)))
    (if (not (member header gnus-extra-headers))
        (setq gnus-extra-headers (cons header gnus-extra-headers))))
  (setq my-headers (cdr my-headers)))

(setq nnmail-extra-headers gnus-extra-headers)

;; (require 'browse-url)
;; (defun browse-nnrss-url( arg )
;;   (interactive "p")
;;   (let ((url (assq nnrss-url-field
;;                    (mail-header-extra
;;                     (gnus-data-header
;;                      (assq (gnus-summary-article-number)
;;                            (gnus-data-header
;;                             (assq (gnus-summary-article-number)
;;                                   gnus-newsgroup-data))))))
;;              (if url
;;                  (progn
;;                    (browse-url (cdr url))
;;                    (gnus-summary-mark-as-read-forward 1))
;;                (gnus-summary-scroll-up arg))))))
;; (add-to-list 'nnmail-extra-headers nnrss-url-field)

;;
;; Groups handling
(setq
 gnus-subscribe-newsgroup-method 'gnus-subscribe-topics
 gnus-group-sort-function '(gnus-group-sort-by-alphabet
                            gnus-group-sort-by-method
                            gnus-group-sort-by-unread
                            gnus-group-sort-by-rank)
 )

;;
;; Movement between groups and such
(setq
 gnus-auto-select-next 'almost-quietly
 gnus-summary-check-current t
 gnus-auto-center-summary 2
 )

;;
;; Threading
(setq
 gnus-build-sparse-threads 'some
 gnus-thread-hide-subtree t
 gnus-thread-sort-functions '(gnus-thread-sort-by-number
                              gnus-thread-sort-by-subject
                              gnus-thread-sort-by-total-score)
 gnus-summary-gather-subject-limit 'fuzzy
 gnus-summary-same-subject " '' "
 gnus-simplify-subject-functions '(gnus-simplify-subject-re
                                   gnus-simplify-whitespace
                                   gnus-simplify-subject-fuzzy)

 )

(setq
 gnus-simplify-ignored-prefixes
 (concat
  "\\`\\[?\\("
  (mapconcat
   'identity
   '("looking"
     "wanted" "followup" "summary\\( of\\)?"
     "help" "query" "problem" "question"
     "answer" "reference" "announce"
     "How can I" "How to" "Comparison of"
     ;; ...
     )
   "\\|")
  "\\)\\s *\\("
  (mapconcat 'identity
             '("for" "for reference" "with" "about")
             "\\|")
  "\\)?\\]?:?[ \t]*"))



;;
;; Saving and caching
(setq
 gnus-use-cache t
 gnus-uncacheable-groups "^nnml"
 gnus-use-long-file-name nil
 gnus-default-article-saver 'gnus-summary-save-in-mail
 gnus-mail-save-name 'gnus-numeric-save-name
 gnus-article-save-directory "~/var/spool/news/save/"
 gnus-refer-article-method '(current
                             (nnregistry)
                             (nnweb "gmane"
                                    (nnweb-type gmane))
                             (nnir)
                             (nnweb "google"
                                    (nnweb-type google)))
 )

;;
;; Using the cache
;; (require 'cachize)

;(cachize 'mail-extract-address-components 5000)
;(cachize 'bbdb-canonicalize-address 5000)
;(cachize 'nnmail-group-pathname 1000)

;(cachize 'ange-ftp-canonize-filename 1000)
;(cachize 'ange-ftp-ftp-path 1000)


;;
;; Archiving outgoing posts
;;; (setq gnus-message-archive-method
;;;       '(nnfolder "archive"
;;;                  (nnfolder-inhibit-expiry t)
;;;                  (nnfolder-directory   "~/var/spool/news/archive")
;;;                  (nnfolder-active-file "~/var/spool/news/archive/active")
;;;                  (nnfolder-get-new-mail nil)
;;;                  ))

(setq gnus-message-archive-group
      '((if (message-news-p)
            (format-time-string
             "news.%Y-%m" (current-time))
          (format-time-string
           "mail.%Y-%m" (current-time)))))


;;
;; Duplicate suppression
(eval-when-compile (require 'gnus-dup))
(setq
 gnus-suppress-duplicates   nil ;; t
 gnus-duplicate-file        "~/var/spool/news/cache/suppression"
 )

;; (setq nnmail-spool-file '((pop :user "karl") (file)))

;;
;; Stripping header words

;;; Do evil things like stripping words out of the headers of some
;;; mailing lists.
;;; FIX FIX FIX, should do this after determining which groups the
;;; article is going to, not before?  That way I can strip annoying
;;; leading 'Pilot:' from the pilot list, but not from other email.
;(setq nnmail-list-identifiers '("\\[NOCEM-L:[0-9]*\\]" "TEAM-INTERNET:" ))
;(add-hook 'nnml-prepare-save-mail-hook ) ;; use this instead
;(add-hook 'nnmail-prepare-incoming-header-hook 'nnmail-remove-list-identifiers)
;;; (add-hook 'nnml-prepare-save-mail-hook
;;;       (lambda ()
;;;         (set-face-background 'default "lightgoldenrod")
;;;         ))
;;; (add-hook 'message-sent-hook
;;;       (lambda ()
;;;         (set-face-background 'default "rgb:c7/c7/bf")
;;;         ))
;;; (add-hook 'gnus-select-article-hook
;;;                      (lambda ()
;;;                             (set-face-background 'default "rgb:c7/c7/bf")
;;;                             ))

(setq
 gnus-list-identifiers '("\\[NOCEM-L:[0-9]*\\]" "\\[LI\\]"
                         "\\[CLUE-\\(Talk\\|Tech\\)\\]"
                         "\\[ruby-talk:[0-9]+\\]"
                         "\\[linux-elitists\\]"
                         "\\[users\\]"
                         "(keitai-l)"
                         "\\[THTTPD\\]"
                         "\\[Prcs-list\\]"
                         "\\[fetchmail\\]"
                         "\\[spamtools\\]"
                         "\\[Bitkeeper-users\\]"
                         "TEAM-INTERNET:" )
 )

;;
;; Expiring things
 ;; Can also set the total-expire element in the group parameter
(setq gnus-total-expirable-newsgroups
      (mapconcat 'identity
                 '("^nnml:" ; All nnml newgroups
                   "^nnmh"
                   )
                 "\\|"))

(setq nnmail-expiry-wait-function
      (lambda (group)
        (cond ((string-match "private"    group) 31)
              ((string-match "junk"       group) 1)
              ((string-match "important"  group) 'never)
              ((string-match "nnfolder"   group) 'never)
              ((string-match "systecture" group) 'never)
              ((string= group "nnml:debian-private")         31)
              ((string= group "debian-private")              31)
              ((string= group "nnml:outgoing")                 'never)
              ((string= group "outgoing")                      'never)
              ((string= group "nnml:debian-ctte")            600)
              ((string= group "debian-ctte")                 600)
              ((string= group "nnml:debian-vote")             60)
              ((string= group "debian-vote")                  60)
              ((string= group "nnml:quite")                   60)
              ((string= group "quite")                        60)
              ((string= group "nnml:stdc")                    60)
              ((string= group "stdc")                         60)
              ((string= group "ul-principals")                60)
              ((string= group "nnml:ul-principals")           60)
              ((string= group "tangram")                      60)
              ((string= group "nnml:tangram")                 60)
              ((string= group "nnml:tangram-support")         50)
              ((string= group "tangram-support")              50)
              ((string= group "nnml:tangram-team")            50)
              ((string= group "tangram-team")                 50)
              ((string= group "orders")                       65)
              ((string= group "nnml:orders")                  65)
              ((string= group "nnml:debian-bugs")              2)
              ((string= group "nnml:debian-user")              2)
              ((string= group "debian-bugs")                   2)
              ((string= group "debian-user")                   2)
              ((string= group "mail.junk")                     1)
              ((string= group "globus")                        1)
              ((string= group "nnml:globus")                   1)
              ;;; Services
              ((string= group "nnml:boston")              'never)
              ((string= group "nnml:codeweavers")         'never)
              ((string= group "nnml:americanexpress")     'never)
              ((string= group "nnml:relianceindiacall")   'never)
              ((string= group "nnml:discovercard")        'never)
              ((string= group "nnml:bankofamerica")       'never)
              ((string= group "nnml:tiaa-cref")           'never)
              ((string= group "nnml:toyota")              'never)
              ((string= group "nnml:sho")                 'never)
              ((string= group "nnml:countrywide")         'never)
              ((string= group "nnml:geico")               'never)
              ((string= group "nnml:verizon")             'never)
              ((string= group "nnml:expedia")             'never)
              ((string= group "nnml:dtccom")              'never)
              ((string= group "nnml:sourceforge")         'never)
              ((string= group "nnml:iitfoundation")       'never)
              ((string= group "nnml:directv")             'never)
              ((string= group "nnml:extendedstay")        'never)
              ((string= group "nnml:fool")                'never)
              ((string= group "nnml:myuhc")               'never)
              ((string= group "nnml:netflix")             'never)
              ((string= group "nnml:newmembers")          'never)
              ((string= group "nnml:planet")              'never)
              ((string= group "nnml:walgreens")           'never)
              ((string= group "nnml:xandros")             'never)
              ((string= group "nnml:creditsecure")        'never)
              ((string= group "nnml:gmacbank")            'never)
              ((string= group "nnml:last")                'never)
              ((string= group "nnml:quicken")             'never)
              ((string= group "nnml:uhc")                 'never)
              ((string= group "nnml:networksolutions")    'never)
              ((string= group "nnml:gemoney")             'never)
              ((string= group "nnml:citi")                'never)
              ((string= group "nnml:hyatt")               'never)
              ((string= group "nnml:discover")            'never)
              ((string= group "nnml:sears")               'never)
              ((string= group "nnml:paypal")              'never)
              ((string= group "nnml:unitedhealthcare")    'never)
              ((string= group "nnml:ebay")                'never)
              ((string= group "nnml:linkedin")            'never)
              ((string= group "nnml:myopenid")            'never)
              ((string= group "nnml:homeagain")           'never)
              ((string= group "nnml:checkout")            'never)
              ((string= group "boston")              'never)
              ((string= group "codeweavers")         'never)
              ((string= group "americanexpress")     'never)
              ((string= group "relianceindiacall")   'never)
              ((string= group "discovercard")        'never)
              ((string= group "bankofamerica")       'never)
              ((string= group "tiaa-cref")           'never)
              ((string= group "toyota")              'never)
              ((string= group "sho")                 'never)
              ((string= group "countrywide")         'never)
              ((string= group "geico")               'never)
              ((string= group "verizon")             'never)
              ((string= group "expedia")             'never)
              ((string= group "dtccom")              'never)
              ((string= group "sourceforge")         'never)
              ((string= group "iitfoundation")       'never)
              ((string= group "directv")             'never)
              ((string= group "extendedstay")        'never)
              ((string= group "fool")                'never)
              ((string= group "myuhc")               'never)
              ((string= group "netflix")             'never)
              ((string= group "newmembers")          'never)
              ((string= group "planet")              'never)
              ((string= group "walgreens")           'never)
              ((string= group "xandros")             'never)
              ((string= group "creditsecure")        'never)
              ((string= group "gmacbank")            'never)
              ((string= group "last")                'never)
              ((string= group "quicken")             'never)
              ((string= group "uhc")                 'never)
              ((string= group "networksolutions")    'never)
              ((string= group "gemoney")             'never)
              ((string= group "citi")                'never)
              ((string= group "hyatt")               'never)
              ((string= group "discover")            'never)
              ((string= group "sears")               'never)
              ((string= group "paypal")              'never)
              ((string= group "unitedhealthcare")    'never)
              ((string= group "ebay")                'never)
              ((string= group "linkedin")            'never)
              ((string= group "myopenid")            'never)
              ((string= group "homeagain")           'never)
              ((string= group "checkout")            'never)
              ;; SPI
              ((string= group "nnml:spi-bylaws")          2)
              ((string= group "nnml:spi-private")         2)
              ((string= group "nnml:spi-general")         2)
              ((string= group "nnml:spi-board")           2)
              ((string= group "nnml:spi-board-admin")     2)
              ((string= group "nnml:spi-private-admin")   2)
              ((string= group "nnml:spi-general-admin")   2)
              ((string= group "nnml:spi-bylaws-admin")    2)
              ((string= group "nnml:spi-board-bounces")   2)
              ((string= group "nnml:spi-inc")             2)
              ((string= group "nnml:spi-private-bounces") 2)

              ((string= group "spi-bylaws")          2)
              ((string= group "spi-private")         2)
              ((string= group "spi-general")         2)
              ((string= group "spi-board")           2)
              ((string= group "spi-board-admin")     2)
              ((string= group "spi-private-admin")   2)
              ((string= group "spi-general-admin")   2)
              ((string= group "spi-bylaws-admin")    2)
              ((string= group "spi-board-bounces")   2)
              ((string= group "spi-inc")             2)
              ((string= group "spi-private-bounces") 2)

              (t 4))))


;;
;; Scoring and killing

;;
;; Killing
(eval-when-compile (require 'gnus-kill))
(setq
 gnus-kill-files-directory "~/var/spool/news/kill"
 )

;;
;; Scoring
(eval-when-compile (require 'gnus-score))
(setq
 gnus-score-find-score-files-function '(gnus-score-find-bnews bbdb/gnus-score)
 gnus-score-interactive-default-score 1024
 ;; Decaying scores
 gnus-decay-scores t
 gnus-score-decay-constant 32
 gnus-score-expiry-days 10
 )
;; Reading an article means we might like it.
;; Ticking it and marking it dormant means we really, really like it.
;; Killing articles Usually means we don't like the subject -- and detracts a
;;         little from the author too (this need looking back at later)
;; Articles killed by kill files means lower
;; Marking articles as read with d, or catching up articles, means we
;;         do not like the subject, but detracts nothing from the author.
(setq gnus-default-adaptive-score-alist
      '((gnus-unread-mark)
        (gnus-ticked-mark      (from (+ 2 (* 16 gnus-score-decay-constant))) (subject (+ 2 (* 16 gnus-score-decay-constant))) (followup(+ 1 (* 32 gnus-score-decay-constant))))
        (gnus-dormant-mark     (from (+ 1 (*  8 gnus-score-decay-constant))) (subject (+ 1 (* 32 gnus-score-decay-constant))))
        (gnus-read-mark        (from (+ 1 gnus-score-decay-constant))        (subject (+ 1 (*  4 gnus-score-decay-constant))))
        (gnus-ancient-mark)
        (gnus-low-score-mark)
        (gnus-expirable-mark)
        (gnus-catchup-mark                                                    (subject (+ -1 (*  -1 gnus-score-decay-constant))))
        (gnus-killed-mark      (from -8)                                      (subject (+ -2 (* -16 gnus-score-decay-constant))) (followup (+ -2 (* -32 gnus-score-decay-constant))))
        (gnus-kill-file-mark   (from (+ -1 (* -4 gnus-score-decay-constant))) (subject (+ -1 (*  -2 gnus-score-decay-constant))))
        (gnus-del-mark                                                        (subject (+ -2 (* -16 gnus-score-decay-constant))))
        (gnus-spam-mark        (from (+ -1 (* -32 gnus-score-decay-constant)))(subject (+ -2 (* -16 gnus-score-decay-constant))) (followup (+ -2 (* -32 gnus-score-decay-constant))))
        ))

(setq gnus-default-adaptive-word-score-alist
      `((,gnus-read-mark . 320)
        (,gnus-ticked-mark . 640)
        (,gnus-dormant-mark . 480)
        (,gnus-catchup-mark . -1)
        (,gnus-killed-mark . -192)
        (,gnus-del-mark . -160)))

;;; (add-hook 'gnus-after-getting-new-news-hook 'gnus-notifications)

;;;
;; Printing

(add-hook
 'gnus-ps-print-hook
 (lambda ()
   (when (string-match (buffer-name) "*******Article**")
     ;;(make-local-variable 'ps-left-header)
     ;;(make-local-variable 'ps-right-header)
     (setq ps-left-header
           (list (concat "(" (mail-header-subject gnus-current-headers) ")")
                 (concat "(" (mail-header-from gnus-current-headers) ")")))
     (setq ps-right-header
           (list "/pagenumberstring load"
                 (concat "(" (mail-header-date gnus-current-headers) ")"))))))

;;
;; Timestamp stuff:
(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)
(add-hook 'gnus-group-catchup-group-hook 'gnus-group-set-timestamp)
;;(gnus-demon-add-scan-timestamps)
;;(add-hook 'gnus-after-getting-new-news-hook 'gnus-demon-scan-timestamps)

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
;;(add-hook 'nnmail-prepare-incoming-hook 'nnheader-ms-strip-cr)
(add-hook 'nnmail-prepare-incoming-header-hook
          'nnmail-remove-leading-whitespace)
;;(add-hook 'nnmail-prepare-incoming-header-hook
;;        nnmail-remove-list-identifiers)


(gnus-add-configuration
 '(article (vertical 1.0
                     (group 5)
                     (summary .25 point)
                     (article 1.0))))
(gnus-add-configuration
 '(summary
   (vertical 1.0
             (group 5)
             (summary 1.0))))

;; The next stanza makes entering a message pop up a new frame
;;; (gnus-add-configuration
;;;  '(message
;;;    (frame 1.0
;;;       (if (not (buffer-live-p gnus-summary-buffer))
;;;           (car (cdr (assoc 'group gnus-buffer-configuration)))
;;;         (car (cdr (assoc 'summary gnus-buffer-configuration))))
;;;       (vertical ((user-position . t) (top . 1) (left . 1)
;;;                  (name . "Message"))
;;;                 (message 1.0 point)))))
(defvar gnus-user-agent-alist
      '(
        ("Sylpheed\\|Ximian Evolution\\|KMail\\|Mutt\\|Gnus\\|tin\\|ELM\\|Emacs\\|slrn\\|Xnews\\|Mozilla\\|VM\\|Evolution\\|Thunderbird" gnus-header-name-face  gnus-user-agent-good-face)
        ("Incredimail\\|http://www.courier-mta.org/cone/\\|SquirrelMail\\|Web Mail\\|pine\\|CrossPoint\\|Eudora\\|Internet Mail Service\\|Microsoft\\|Novell GroupWise\\|Pegasus\\|WinVN" gnus-header-name-face gnus-user-agent-bad-face)
        ("Sylpheed-Claws\\|MicroPlanet-Gravity\\|Apple Mailer\\|MT-NewsWatcher\\|Gravity\\|MesNews\\|Forte Agent\\|MacSOUP/2.5\\|MacSOUP/F-2.4.4\\|Forte Free Agent" gnus-header-name-face gnus-user-agent-unknown-face))
      )

;; Here is the function
;; This one is by lawrence on #emacs
;; I developped my own based on gnus-article-highlight headers but this one is shorter
;; so I prefer to use this one :)

;; Note there was a bug. re-search-forward was done from point to end of buffer.
;; Fixed that problem
(defun gnus-article-user-agent-headers ()
  "Highlight article User Agent headers as specified by `gnus-user-agent-good'."
  (interactive)
  (with-current-buffer gnus-article-buffer
    (let ((buffer-read-only nil))
      (save-restriction
        (article-narrow-to-head)
        (goto-char (point-min))
        (dolist (entry gnus-user-agent-alist)
          (dolist (header '("X-Mailer" "Newsreader" "User-Agent" "X-Newsreader"))
            (save-excursion
              (while (re-search-forward (concat "^" header) nil t)
                (gnus-put-text-property (match-beginning 0)
                                        (match-end 0)
                                        'face (nth 1 entry))
                (when (re-search-forward (concat ": \\(" (nth 0 entry) "\\).*$") nil t)
                  (goto-char (match-beginning 0))
                  (forward-char 1)
                  (gnus-put-text-property (point) ;;(match-beginning 0)
                                          (point-at-eol)
                                          'face (nth 2 entry)))))))))))
(add-hook 'gnus-article-prepare-hook 'gnus-article-user-agent-headers)
;;(add-hook 'gnus-article-prepare-hook 'icalendar-import-buffer)

(add-hook 'display-time-hook
          (lambda () (setq gnus-mode-non-string-length
                           (+ 21
                              (if line-number-mode 5 0)
                              (if column-number-mode 4 0)
                              (length display-time-string)))))

(defun gnus-article-variable-pitch-mode (&optional arg)
  "Apply `variable-pitch-mode' in article buffer."
  (interactive (list (or current-prefix-arg (quote toggle))))
  (with-current-buffer gnus-article-buffer
    (variable-pitch-mode arg)))

(add-hook 'gnus-summary-mode-hook
          (lambda () (local-set-key "v" 'gnus-article-variable-pitch-mode)))

;;(add-hook 'gnus-article-mode-hook
;;          (lambda () (variable-pitch-mode t)))


;;; Don't auto-select first article if reading sources, or archives or
;;; jobs postings, etc. and just display the summary buffer
(add-hook 'gnus-select-group-hook
          (function
           (lambda ()
             (cond ((string-match "sources" gnus-newsgroup-name)
                    (setq gnus-auto-select-first nil))
                   ((string-match "jobs" gnus-newsgroup-name)
                    (setq gnus-auto-select-first nil))
                   ((string-match "comp\\.archives" gnus-newsgroup-name)
                    (setq gnus-auto-select-first nil))
                   ((string-match "reviews" gnus-newsgroup-name)
                    (setq gnus-auto-select-first nil))
                   ((string-match "announce" gnus-newsgroup-name)
                    (setq gnus-auto-select-first nil))
                   ((string-match "binaries" gnus-newsgroup-name)
                    (setq gnus-auto-select-first nil))
                   (t
                    (setq gnus-auto-select-first t))))))


;; Hide things
(setq gnus-visible-headers
      '(
        "From:" "^Newsgroups:" "^Subject:" "^Date:" "^Followup-To:"
        "^Reply-To:" "^Organization:" "^Summary:" "^Keywords:" "^To:"
        "^Cc:" "^Posted-To:" "^Mail-Copies-To:" "^Apparently-To:"
        "^Gnus-Warning:" "^Resent-From:" "X-Sent:" "^User-Agent:"
        "^X-Mailer:" "^Newsreader:" "^X-Newsreader:" "^X-Debian-PR-Message:"
        "^X-Debian-PR-Package:" "^Message-Id:" "^X-SA-Orig:" "^X-Server-Orig:"
        ))
(require 'gnus-art)
(eval-when-compile (require 'gnus-async))
(eval-when-compile (require 'gnus-registry))
(eval-when-compile (require 'deuglify))
(setq
;; gnus-asynchronous t
 ;; gnus-carpal t
 gnus-registry-install t
 gnus-suppress-duplicates t
 gnus-treat-hide-boring-headers 'head
 gnus-treat-leading-whitespace 'head
 gnus-outlook-deuglify-unwrap-stop-chars  ".?!"
 )
;; Spam
(eval-when-compile (require 'spam))

(setq
 spam-log-to-registry t     ; for spam autodetection
 ;; all groups with `spam' in the name contain spam
 gnus-spam-newsgroup-contents
 '(("spam" gnus-group-spam-classification-spam))
 ;; see documentation for these
 spam-mark-ham-unread-before-move-from-spam-group t
;; gnus-spam-process-destinations '(("^nntp\\+news\\.gmane\\.org:" "nnml:spam")
;;                                  ("^nnml.*" "nnml:spam"))
 gnus-spam-process-destinations '(("nnml:spam")
                                  ("^nnml.*" "nnml:spam"))
 gnus-ham-process-destinations
 '(("^nnml:spam" "nnml:reclassify"))
 spam-mark-ham-unread-before-move-from-spam-group t
 spam-use-crm114 t
 spam-use-hashcash t
 spam-use-blacklist t
 spam-use-whitelist t
)
;; Where to put incoming mail
(setq spam-crm114-database-directory (expand-file-name "~/var/lib/crm114"))
(setq gnus-spam-autodetect-methods
      '(
        ("^gmane\\." . (spam-use-blacklist
                        spam-use-BBDB spam-use-hashcash
                        spam-use-gmane-xref))
        ("^nntp+news\\.gmane\\.org" . (spam-use-blacklist
                        spam-use-BBDB
                        spam-use-gmane-xref))
        (".*" . (spam-use-blacklist spam-use-hashcash
                 spam-use-BBDB))
        ))

(setq gnus-spam-autodetect '(("^nntp.*" . t)
                             ("^gmane\\." .t)
                             ("^nnml:\\(debian-.*\\)$" . t)))

(setq gnus-spam-process-newsgroups
      '(("^nntp\\+news\\.gmane\\.org"
         ((spam spam-use-gmane)
          (spam spam-use-blacklist)
          ))
        ("^gmane\\."
         ((spam spam-use-gmane)
          (spam spam-use-blacklist)
          ))
        ("^nnml:\\(debian-.*\\)$"
         ((spam-use-resend)))
        (".*"
         ((spam spam-use-blacklist)
          ))
        ))

;;; (add-to-list
;;;  'gnus-parameters
;;;  '("^nnml\\."
;;;    (spam-autodetect-methods (spam-use-whitelist spam-use-BBDB))
;;;    ))
;;; (add-to-list
;;;  'gnus-parameters
;;;  '("^gmane\\."
;;;    (spam-autodetect . t)
;;;    (spam-autodetect-methods spam-use-gmane-xref spam-use-BBDB)
;;;    (spam-process '(spam spame-use-gmane))
;;;    (spam-contents gnus-group-spam-classification-ham)
;;;    ))
;;; (add-to-list
;;;  'gnus-parameters
;;;  '("^nntp+news.gmane.org"
;;;    (spam-autodetect . t)
;;;    (spam-process (
;;;                   (spam spam-use-gmane)
;;;                   (spam spam-use-blacklist)
;;;                   (ham spam-use-whitelist)
;;;                   ))
;;;    ))


;;; n order to set “spam-report-resend-to” from a group parameter
(setq gnus-newsgroup-variables '(spam-report-resend-to))
(setq gnus-article-banner-alist '((iphone . "\\(^Sent from my iPhone$\\)")
                                  (nyt . "\\(^------------ ADVERTISEMENT -------------\\(.\\|\\)*?----------------------------------------\\)\\|\\(Get home delivery of The New York Times\\(.\\|\\)*?----------------------------------------\\)\\|\\(About This E-Mail\\(.\\|\\)*\\)")))


(add-to-list
 'gnus-parameters
 '(".*" (banner . iphone)))
;;  With following entry, `S x' (`gnus-summary-mark-as-spam') marks
;;  articles in `gmane.*' groups as spam and reports the to Gmane at
;;  group exit
(add-to-list
 'gnus-parameters
 '("^nnml:\\(debian-.*\\)$"
         (to-address . "\\1@lists.debian.org")
         (to-list . "\\1@lists.debian.org")
         (admin-address . "\\1-request@lists.debian.org")
         (spam-autodetect . t)
         (spam-autodetect-methods spam-use-gmane-xref spam-use-hashcash spam-use-BBDB)
         (spam-process '(spam spam-use-resend))
         (spam-report-resend-to  "report-listspam@lists.debian.org")
         (subscribed . t)
         (total-expire . t)
         ))
;; Display `text/html' parts in `nnrss' groups.
(add-to-list
 'gnus-parameters
 '("\\`nnrss:" (mm-discouraged-alternatives nil)))

(add-to-list
 'gnus-parameters
 '("\\<\\(emacs\\|gnus\\)\\>" (gnus-button-emacs-level 10)))
(add-to-list
 'gnus-parameters
 '("\\<unix\\>"               (gnus-button-man-level 10)))
(add-to-list
 'gnus-parameters
 '("\\<tex\\>"                (gnus-button-tex-level 10)))

(add-to-list
 'gnus-parameters
 '("nnimap:spam\\.detected"
         (gnus-article-sort-functions '(gnus-article-sort-by-chars))
         (ham-process-destination "nnimap:INBOX" "nnimap:training.ham")
         (spam-autodetect-methods spam-use-whitelist spam-use-BBDB)
         (spam-contents gnus-group-spam-classification-spam)))
(add-to-list
 'gnus-parameters
 '("nnimap:\\(INBOX\\|other-folders\\)"
   (spam-process-destination . "nnimap:training.spam")
   (spam-autodetect-methods (spam-use-whitelist spam-use-BBDB))))


(setq message-subscribed-address-functions
      '(gnus-find-subscribed-addresses))

;;
;; Big brother database stuff
(autoload 'bbdb/gnus-lines-and-from "bbdb-gnus")
;;; Compiler hushing
(eval-when-compile
  (defvar gnus-optional-headers))
(eval-when-compile (require 'bbdb-gnus))
(require 'bbdb-gnus)

;(add-hook 'gnus-select-group-hook 'dmoore::gnus-toggle-bbdb-popup)
;; (setq bbdb-use-pop-up nil)
;;(require 'message-x)  ; this messes ecomplete
;;(require 'gnus-BTS)



;; Reiner Steib <reinersteib+gmane@imap.cc>
;; .newsrc.eld should have one newline per group
;;;###autoload
(defun rs-gnus-save-newsrc-with-whitespace-1 ()
  "Save ~/.newsrc.eld with extra whitespace."
  (gnus-message 5 "Adding whitespace to .newsrc.eld")
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "(\\\"\\| ((\\| (nn" nil t)
      (replace-match "\n  \\&" t))
    (delete-trailing-whitespace)))
;; <oq1ykgajdm.fsf@carouge.sram.qc.ca>

(defun rs-gnus-save-newsrc-pretty-print ()
  "Save pretty-printed ~/.newsrc.eld."
  (gnus-message 5 "Pretty printing .newsrc.eld")
  (let ((emacs-lisp-mode-hook nil))
    (emacs-lisp-mode))
  (pp-buffer)
  (while (re-search-forward "(setq gnus-" nil t)
    (replace-match "\n\\&" t))
  ;;   (save-excursion
  ;;     (goto-char (point-min))
  ;;     (search-forward-regexp "(setq gnus-zombie-list")
  ;;     (fill-region (point-at-bol) (point-max)))
  (indent-region (point-min) (point-max) 80)
  (delete-trailing-whitespace))

(add-hook 'gnus-save-quick-newsrc-hook 'rs-gnus-save-newsrc-with-whitespace-1)

;; (add-hook 'gnus-save-quick-newsrc-hook
;;  (lambda nil
;;    (goto-char (point-min))
;;    (while (search-forward "\n(setq " nil t)
;;      (replace-match "\n\n(setq "))))

;;; gnus-inews-domain-name longer exists, remove the broken autoload
;;; inside of gnus-bbdb.el.
(defun gnus-inews-domain-name (&rest x)
  nil)

; sanity check for replies in news groups
(defadvice gnus-summary-reply (around reply-in-news activate)
  (interactive)
  (when (or (not (or (gnus-news-group-p gnus-newsgroup-name)
                     (string-match "list\\." gnus-newsgroup-name)))
            (y-or-n-p "Really reply privately to the author? "))
    ad-do-it))


;;
;;; Toggle on bbdb noticing only in nnml groups.
(defun dmoore::gnus-toggle-bbdb-noticing ()
  (let ((method (gnus-find-method-for-group gnus-newsgroup-name)))
    (cond ((eq 'nnml (car method))
           (setq bbdb/news-auto-create-p 'bbdb-ignore-most-messages-hook)
           ;; renamed for tm, dammit.
           ;;(setq tm-bbdb/auto-create-p bbdb/news-auto-create-p)
           (setq bbdb-notice-hook 'bbdb-auto-notes-hook))
          (t
           (setq bbdb/news-auto-create-p nil)
           ;; renamed for tm, dammit.
           ;;(setq tm-bbdb/auto-create-p bbdb/news-auto-create-p)
           (setq bbdb-notice-hook nil)))))

(add-hook 'gnus-select-group-hook 'dmoore::gnus-toggle-bbdb-noticing)

;; Only do automatic bbdb entry popups in nnml groups.
(defun dmoore::gnus-toggle-bbdb-popup ()
  (let ((method (gnus-find-method-for-group gnus-newsgroup-name)))
    (cond ((eq 'nnml (car method))
           (setq bbdb-use-pop-up t))
          (t
           (setq bbdb-use-pop-up nil))
          )))


(require 'mail-extr)
(defun my-gnus-display-country ()
  (interactive)
  (condition-case nil
      (let* ((addr (car (ietf-drums-parse-address
                         (message-fetch-field "From" t))))
             (country (when (string-match "\\.\\(\\sw+\\)$" addr)
                        (match-string 1 addr))))
        (when country
          (condition-case nil
              (what-domain country)
            (error (message "No such domain: %s" country)))))
    (error nil)))


;;I have a KILL file like this:
;;; ,----
;;; (posting-style
;;;             (name "foobar")
;;;             ("Return-Receipt-To" user-mail-address)
;;;             ("Disposition-Notification-To" user-mail-address)
;;;             ("X-yun.yagibdah.de-info" "ref ")
;;;             (body :file "~/some-filename.txt"))
;;; `----

;;(or (string-match "nn\\(draft:\\|ml:\\|tp\\+\\|dir:\\)" gnus-newsgroup-name)
;;    (gnus-kill "From" "BJ���\\|Per Abrahamsen"
;;             '(gnus-summary-mark-as-dormant 1)))
(setq gnus-posting-styles
      '((".*"
         (name "Manoj Srivastava")
         (address "srivasta@golden-gryphon.com")
         ("X-URL" "http://www.golden-gryphon.com/")
         ("User-Agent"
          (if (= 0 (random 10))
              (format "Microsoft Gnus Express, Build %s (%s)"
                      (gnus-continuum-version (gnus-version))
                      gnus-version-number)
            (concat (gnus-extended-version)
                    " (" system-configuration ")")))
         (organization "Manoj Srivastava's Home")
         (signature-file "~/etc/mail/signature"))
        ;;;     (message-this-is-news
        ;;;      (address "srivasta@acm.org")
        ;;;      ("X-URL" "http://www.golden-gryphon.com/%7Esrivasta/")
        ;;;      (organization "The Golden Gryphon")
        ;;;      (signature-file "~/etc/mail/signature.acm"))
        ;;;     (message-this-is-mail
        ;;;      (address "srivasta@golden-gryphon.com")
        ;;;      ("X-URL" "http://www.golden-gryphon.com/")
        ;;;      (organization "Manoj Srivastava's Home")
        ;;;      (signature-file "~/etc/mail/signature"))

        ("nntp+news.gmane.org:gmane.user-groups.linux.kolkata"
         (name "Manoj Srivastava")
         (address "srivasta@debian.org")
         ("X-URL" "http://www.debian.org/%7Esrivasta/")
         (Gmane-Reply-To-List "yes")
         (Mail-Copies-To "never")
         (organization "The Debian Project")
         (signature-file "~/etc/mail/signature.debian"))
        ("nntp+news.gmane.org:gmane.user-groups.linux.mumbai"
         (name "Manoj Srivastava")
         (address "srivasta@debian.org")
         (Gmane-Reply-To-List "yes")
         (Mail-Copies-To "never")
         ("X-URL" "http://www.debian.org/%7Esrivasta/")
         (organization "The Debian Project")
         (signature-file "~/etc/mail/signature.debian"))
        ("nntp+news.gmane.org:gmane.user-groups.linux.delhi"
         (name "Manoj Srivastava")
         (address "srivasta@debian.org")
         (Gmane-Reply-To-List "yes")
         (Mail-Copies-To "never")
         ("X-URL" "http://www.debian.org/%7Esrivasta/")
         (organization "The Debian Project")
         (signature-file "~/etc/mail/signature.debian"))
        ("nntp+news.gmane.org:gmane.org.user-groups.linux.ilugc"
         (name "Manoj Srivastava")
         (address "srivasta@debian.org")
         ("X-URL" "http://www.debian.org/%7Esrivasta/")
         (Gmane-Reply-To-List "yes")
         (Mail-Copies-To "never")
         (organization "The Debian Project")
         (signature-file "~/etc/mail/signature.debian"))
        ("^nnml:.*"
         (name "Manoj Srivastava")
         (address "srivasta@acm.org")
         ("X-URL" "http://www.golden-gryphon.com/")
         (organization "The Golden Gryphon")
         (signature-file "~/etc/mail/signature.acm"))
        ("^nnml:ding"
         (name "Manoj Srivastava")
         (address "srivasta@golden-gryphon.com")
         ("X-URL" "http://www.golden-gryphon.com/")
         (organization "The Golden Gryphon")
         (signature-file "~/etc/mail/signature.acm"))
        ("^nnml:rt-users"
         (name "Manoj Srivastava")
         (address "srivasta@golden-gryphon.com")
         ("X-URL" "http://www.golden-gryphon.com/")
         (organization "The Golden Gryphon")
         (signature-file "~/etc/mail/signature.acm"))
        ("^nnml:rt-devel"
         (name "Manoj Srivastava")
         (address "srivasta@golden-gryphon.com")
         ("X-URL" "http://www.golden-gryphon.com/")
         (organization "The Golden Gryphon")
         (signature-file "~/etc/mail/signature.acm"))
        ("^nnml:gnu-arch-users"
         (name "Manoj Srivastava")
         (address "srivasta@golden-gryphon.com")
         ("X-URL" "http://www.golden-gryphon.com/")
         (Mail-Copies-To "never")
         (organization "The Golden Gryphon")
         (signature-file "~/etc/mail/signature.acm"))
        ("^nnml:debian.*"
         (name "Manoj Srivastava")
         (address "srivasta@debian.org")
         ("X-URL" "http://www.debian.org/%7Esrivasta/")
         (organization "The Debian Project")
         (signature-file "~/etc/mail/signature.debian"))
        ("^nntp+news.gmane.org:gmane.linux.debian.*"
         (name "Manoj Srivastava")
         (address "srivasta@debian.org")
         ("X-URL" "http://www.debian.org/%7Esrivasta/")
         (organization "The Debian Project")
         (signature-file "~/etc/mail/signature.debian"))
        ("^nntp:gmane.linux.debian.*"
         (name "Manoj Srivastava")
         (address "srivasta@debian.org")
         ("X-URL" "http://www.debian.org/%7Esrivasta/")
         (organization "The Debian Project")
         (signature-file "~/etc/mail/signature.debian"))
        ("^nnml:lsb-.*"
         (name "Manoj Srivastava")
         (address "srivasta@debian.org")
         ("X-URL" "http://www.debian.org/%7Esrivasta/")
         (organization "The Debian Project")
         (signature-file "~/etc/mail/signature.debian"))
        ("^nnml:nlug"
         (name "Manoj Srivastava")
         (address "srivasta@debian.org")
         ("X-URL" "http://www.debian.org/%7Esrivasta/")
         (organization "The Debian Project")
         (signature-file "~/etc/mail/signature.debian"))
        ("^nnml:debian-ctte.*"
         (name "Manoj Srivastava")
         (address "srivasta@debian.org")
         ("Approved: moderator"))
        ("^nnml:linux.*"
         (name "Manoj Srivastava")
         (address "srivasta@acm.org")
         ("X-URL" "http://www.debian.org/")
         (organization "The Debian Project")
         (signature-file "~/etc/mail/signature.debian"))
        ("^gmane"
         (name "Manoj Srivastava")
         (address "srivasta@golden-gryphon.com")
         ("Reply-To" nil)
         ("X-URL" "http://www.golden-gryphon.com/")
         (Gmane-Reply-To-List "yes")
         (Mail-Copies-To "never")
         (organization "The Golden Gryphon")
         (signature-file "~/etc/mail/signature.acm"))
        ((message-news-p)
         (name "Manoj Srivastava")
         (address "srivasta@ieee.org")
         ("Mail-Copies-To" "never"))
        ("gnu\\.emacs\\.bug"
         (name "Manoj Srivastava")
         ("Mail-Copies-To" nil))
        ))

        ;;;("^nnml:stdc*"
        ;;; (name "Manoj Srivastava")
        ;;; (address "manoj.srivastava@stdc.com")
        ;;; (organization "S/TDC")
        ;;; ("X-URL" "http://www.stdc.com/")
        ;;; (signature-file "~/etc/mail/signature.stdc"))
        ;;;("^nnml:tangram*"
        ;;; (name "Manoj Srivastava")
        ;;; (address "manoj.srivastava@stdc.com")
        ;;; (organization "S/TDC")
        ;;; ("X-URL" "http://www.stdc.com/")
        ;;; (signature-file "~/etc/mail/signature.stdc"))
        ;;;("^nnml:ul-.*"
        ;;; (name "Manoj Srivastava")
        ;;; (address "manoj.srivastava@stdc.com")
        ;;; (organization "S/TDC")
        ;;; ("X-URL" "http://www.stdc.com/")
        ;;; (signature-file "~/etc/mail/signature.stdc"))
        ;;;("^nnml:quite"
        ;;; (name "Manoj Srivastava")
        ;;; (address "manoj.srivastava@stdc.com")
        ;;; (organization "S/TDC")
        ;;; (signature-file "~/etc/mail/signature.stdc"))
        ;;;("^nnml:quite.*"
        ;;; (name "Manoj Srivastava")
        ;;; (address "manoj.srivastava@stdc.com")
        ;;; (organization "S/TDC")
        ;;; ("X-URL" "http://www.stdc.com/")
        ;;; (signature-file "~/etc/mail/signature.stdc"))
        ;;;("^nnml:tog.*"
        ;;; (name "Manoj Srivastava")
        ;;; (address "manoj.srivastava@stdc.com")
        ;;; ("X-URL" "http://www.stdc.com/")
        ;;; (organization "S/TDC")
        ;;; (signature-file "~/etc/mail/signature.stdc"))
        ;;;("^nnml:selinux"
        ;;; (name "Manoj Srivastava")
        ;;; (address "manoj.srivastava@stdc.com")
        ;;; (organization "S/TDC")
        ;;; ("X-URL" "http://www.stdc.com/")
        ;;; (signature-file "~/etc/mail/signature.stdc"))
        ;;;     ((header "From.*To" ".*opengroup.org.*")
        ;;;            (address "manoj.srivastava@stdc.com")
        ;;;            (organization "S/TDC")
        ;;;            (signature-file "~/etc/mail/signature.stdc"))
        ;;;     ((header "From.*To" ".*stdc.com.*")
        ;;;            (address "manoj.srivastava@stdc.com")
        ;;;            (organization "S/TDC")
        ;;;            (signature-file "~/etc/mail/signature.stdc"))
        ;;;     ((header "From.*To" ".*teknowledge.com.*")
        ;;;            (address "manoj.srivastava@stdc.com")
        ;;;            (organization "S/TDC")
        ;;;            (signature-file "~/etc/mail/signature.stdc"))
        ;;;;    ("^nnml:tog.*"
        ;;;          (address "m.srivastava@opengroup.org")
        ;;;          (organization "The Open Group")
        ;;;          (signature-file "~/etc/mail/signature.tog"))
        ;;;     ((header "From.*To" ".*opengroup.org.*")
        ;;;           (address "m.srivastava@opengroup.org")
        ;;;           (organization "The Open Group")
        ;;;           (signature-file "~/etc/mail/signature.tog"))
        ;;;     ((header "From.*To" ".*dec.com.*")
        ;;;      (address "manoj@zk3.dec.com")
        ;;;      (organization "COMPAQ")
        ;;;      (signature-file "~/etc/mail/signature.dec"))
        ;;;     ((and (message-mail-p)
        ;;;           (stringp gnus-newsgroup-name))
        ;;;      ("Mail-Followup-To"
        ;;;       (gnus-group-get-parameter gnus-newsgroup-name 'to-address)))

(setq
 gnus-summary-highlight
  '(
    ((eq mark gnus-canceled-mark)           . gnus-summary-cancelled)
    ((and uncached (> score default-high))  . gnus-summary-high-undownloaded)
    ((and uncached (< score default-low))   . gnus-summary-low-undownloaded)
    (uncached                               . gnus-summary-normal-undownloaded)
    ((and (> score 3074)
          (eq mark gnus-unread-mark))       . my-gnus-own-posting-face)
    ((and (>= 3074 score)
          (>= score 2048)
          (eq mark gnus-unread-mark))       . my-gnus-direct-fup-face)
    ((and (>= 2048 score)
          (>= score 1024)
          (eq mark gnus-unread-mark))       . my-gnus-indirect-fup-face)
    ((and (> score default-high)
          (or (eq mark gnus-dormant-mark)
              (eq mark gnus-ticked-mark)))  . gnus-summary-high-ticked)
    ((and (< score default-low)
	  (or (eq mark gnus-dormant-mark)
	      (eq mark gnus-ticked-mark)))  . gnus-summary-low-ticked)
    ((or (eq mark gnus-dormant-mark)
	 (eq mark gnus-ticked-mark))        . gnus-summary-normal-ticked)
    ((and (> score default-high)
          (eq mark gnus-ancient-mark))      . gnus-summary-high-ancient)
    ((and (< score default-low)
          (eq mark gnus-ancient-mark))      . gnus-summary-low-ancient)
    ((eq mark gnus-ancient-mark)            . gnus-summary-normal-ancient)
    ((and (> score default-high)
          (eq mark gnus-unread-mark))        . gnus-summary-high-unread)
    ((and (< score default-low)
          (eq mark gnus-unread-mark))       . gnus-summary-low-unread)
    ((eq mark gnus-unread-mark)             . gnus-summary-normal-unread)
    ((> score default-high)                 . gnus-summary-high-read)
    ((< score default-low)                  . gnus-summary-low-read)
    (t                                      . gnus-summary-normal-read)
    ))




;;;        (setq gnus-group-highlight
;;;              '(((> unread 800) . my-group-unread-critical-1)
;;;                ((> unread 400) . cyan-bold)
;;;                ((> unread 200) . violet-bold)
;;;                ((and (< level 3) (zerop unread)) . my-group-face-2)
;;;                ((< level 2) . magenta-bold)
;;;                ((< level 3) . my-group-face-3)
;;;                ((< level 4) . orchid-bold)
;;;                ((zerop unread) . my-group-face-4)
;;;                (t . my-group-face-5)))
(setq
 gnus-group-highlight
 '(;; Mail
   ((and mailp (= unread 0)   (eq level 1)) .     gnus-group-mail-1-empty)
   ((and mailp (> unread 800) (eq level 1)) .     my-group-mail-unread-crit-1)
   ((and mailp (> unread 400) (eq level 1)) .     my-group-mail-unread-high-1)
   ((and mailp (> unread 200) (eq level 1)) .     my-group-mail-unread-mod-1)
   ((and mailp (eq level 1)) .                    gnus-group-mail-1)
   ((and mailp (= unread 0)   (eq level 2)) .     gnus-group-mail-2-empty)
   ((and mailp (> unread 800) (eq level 2)) .     my-group-mail-unread-crit-2)
   ((and mailp (> unread 400) (eq level 2)) .     my-group-mail-unread-high-2)
   ((and mailp (> unread 200) (eq level 2)) .     my-group-mail-unread-mod-2)
   ((and mailp (eq level 2)) .                    gnus-group-mail-2)
   ((and mailp (= unread 0) (eq level 3)) .       gnus-group-mail-3-empty)
   ((and mailp (> unread 800) (eq level 3)) .     my-group-mail-unread-crit-3)
   ((and mailp (> unread 400) (eq level 3)) .     my-group-mail-unread-high-3)
   ((and mailp (> unread 200) (eq level 3)) .     my-group-mail-unread-mod-3)
   ((and mailp (eq level 3)) .                    gnus-group-mail-3)
   ((and mailp (= unread 0)) .                    gnus-group-mail-low-empty)
   ((and mailp) .                                 gnus-group-mail-low)
   ;; News.
   ((and (= unread 0) (eq level 1)) .             gnus-group-news-1-empty)
   ((and (> unread 800) (eq level 1)) .           my-group-mail-unread-crit-1)
   ((and (> unread 400) (eq level 1)) .           my-group-mail-unread-high-1)
   ((and (> unread 200) (eq level 1)) .           my-group-mail-unread-mod-1)
   ((and (eq level 1)) .                          gnus-group-news-1)
   ((and (= unread 0) (eq level 2)) .             gnus-group-news-2-empty)
   ((and (> unread 800) (eq level 2)) .           my-group-mail-unread-crit-2)
   ((and (> unread 400) (eq level 2)) .           my-group-mail-unread-high-2)
   ((and (> unread 200) (eq level 2)) .           my-group-mail-unread-mod-2)
   ((and (eq level 2)) .                          gnus-group-news-2)
   ((and (= unread 0) (eq level 3)) .             gnus-group-news-3-empty)
   ((and (> unread 800) (eq level 3)) .           my-group-news-unread-crit-3)
   ((and (> unread 400) (eq level 3)) .           my-group-news-unread-high-3)
   ((and (> unread 200) (eq level 3)) .           my-group-news-unread-mod-3)
   ((and (eq level 3)) .                          gnus-group-news-3)
   ((and (= unread 0) (eq level 4)) .             gnus-group-news-4-empty)
   ((and (> unread 800) (eq level 4)) .           my-group-news-unread-crit-4)
   ((and (> unread 400) (eq level 4)) .           my-group-news-unread-high-4)
   ((and (> unread 200) (eq level 4)) .           my-group-news-unread-mod-4)
   ((and (eq level 4)) .                          gnus-group-news-4)
   ((and (= unread 0) (eq level 5)) .             gnus-group-news-5-empty)
   ((and (> unread 800) (eq level 5)) .           my-group-news-unread-crit-5)
   ((and (> unread 400) (eq level 5)) .           my-group-news-unread-high-5)
   ((and (> unread 200) (eq level 5)) .           my-group-news-unread-mod-5)
   ((and (eq level 5)) .                          gnus-group-news-5)
   ((and (= unread 0) (eq level 6)) .             gnus-group-news-6-empty)
   ((and (> unread 800) (eq level 6)) .           my-group-news-unread-crit-6)
   ((and (> unread 400) (eq level 6)) .           my-group-news-unread-high-6)
   ((and (> unread 200) (eq level 6)) .           my-group-news-unread-mod-6)
   ((and (eq level 6)) .                          gnus-group-news-6)
   ((and (= unread 0)) .                          gnus-group-news-low-empty)
   (t .                                           gnus-group-news-low)
   ))


(setq gnus-group-icon-list
      '(((> unread 0)
        . "/usr/share/icons/gnome/16x16/status/mail-unread.png")
       ((> ticked 0)
        . "/usr/share/icons/gnome/16x16/actions/mail-mark-important.png")
       (t . "/usr/share/icons/gnome/16x16/status/mail-read.png"))
      )
;;      (((eq mark gnus-ticked-mark) . italic)
;;       ((> score default) . bold)))

(gnus-registry-initialize)
(spam-initialize)

;;; Cleanup all Gnus buffers on exit

(defun exit-gnus-on-exit ()
  (if (and (fboundp 'gnus-group-exit)
           (gnus-alive-p))
      (with-current-buffer (get-buffer "*Group*")
        (let (gnus-interactive-exit)
          (gnus-group-exit)))))

(add-hook 'kill-emacs-hook 'exit-gnus-on-exit)

;;; This instructs the imap.el package to log any exchanges with the
;;; server. The log is stored in the buffer `*imap-log*'. Look for
;;; error messages, which sometimes are tagged with the keyword BAD
;;(setq imap-debug t imap-log t)



;;; (setq
;;;  gnus-score-over-mark ?↑           ; ↑ ☀
;;;  gnus-score-below-mark ?↓         ; ↓ ☂
;;;  gnus-ticked-mark ?⚑
;;;  gnus-dormant-mark ?⚐
;;;  gnus-expirable-mark ?♻
;;;  gnus-read-mark ?✓
;;;  gnus-del-mark ?✗
;;;  gnus-killed-mark ?☠
;;;  gnus-replied-mark ?⟲
;;;  gnus-forwarded-mark ?⤳
;;;  gnus-cached-mark ?☍
;;;  gnus-recent-mark ?★
;;;  gnus-unseen-mark ?✩
;;;  gnus-unread-mark ?✉)

;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:
