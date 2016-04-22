;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-bbdb.el ---
;; Author           : Manoj Srivastava ( srivasta@tiamat.datasync.com )
;; Created On       : Wed Apr  8 14:55:48 1998
;; Created On Node  : tiamat.datasync.com
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Tue May  3 11:40:48 2005
;; Last Machine Used: glaurung.internal.golden-gryphon.com
;; Update Count     : 35
;; Status           : Unknown, Use with caution!
;; HISTORY          :
;; Description      :
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq bbdb-canonical-hosts
      (mapconcat 'regexp-quote
		 '("cs.cmu.edu" "ri.cmu.edu" "edrc.cmu.edu" "andrew.cmu.edu"
		   "mcom.com" "netscape.com" "cenatls.cena.dgac.fr"
		   "datasync.com" "cenaath.cena.dgac.fr" "irit.fr"
		   "enseeiht.fr" "inria.fr" "cs.uiuc.edu" "ametro.net"
		   "xemacs.org" "debian.org")
		 "\\|"))
(defun my-bbdb-canonicalize-net-hook (addr)
  ;;(sample-bbdb-canonicalize-net-hook addr);; `the default'  and then
  (cond
   ;;
   ;; rewrite mail-drop hosts.
   ;;
   ((string-match
     (concat "\\`\\([^@%!]+@\\).*\\.\\(" bbdb-canonical-hosts "\\)\\'")
     addr)
    (concat (bbdb-match-substring addr 1) (bbdb-match-substring addr 2)))
   ;; Removes TMDA-related strings from addresses.
   ((string-match
     "^\\(.+?\\)\\(.\\)dated\\2[0-9]+\\.[0-9a-fA-F]+\\(@.*\\)" addr)
    (concat (match-string 1 addr) (match-string 3 addr)))
   ((string-match "\\`\\(.*?\\)\\(?:[+-][^@]*\\)\\(@.*\\)\\'" addr)
    (concat (match-string 1 addr) (match-string 2 addr)))
   ;;
   ;; Here at Lucid, our workstation names sometimes get into our email
   ;; addresses in the form "jwz%thalidomide@lucid.com" (instead of simply
   ;; "jwz@lucid.com").  This removes the workstation name.
   ;;
   ((string-match "\\`\\([^@%!]+\\)%[^@%!.]+@\\(lucid\\.com\\)\\'" addr)
    (concat (bbdb-match-substring addr 1) "@" (bbdb-match-substring addr 2)))
   ;;
   ;; Another way that our local mailer is misconfigured: sometimes addresses
   ;; which should look like "user@some.outside.host" end up looking like
   ;; "user%some.outside.host" or even "user%some.outside.host@lucid.com"
   ;; instead.  This rule rewrites it into the original form.
   ;;
   ((string-match "\\`\\([^@%]+\\)%\\([^@%!]+\\)\\(@lucid\\.com\\)?\\'" addr)
    (concat (bbdb-match-substring addr 1) "@" (bbdb-match-substring addr 2)))
   ;;
   ;; Sometimes I see addresses like "foobar.com!user@foobar.com".
   ;; That's totally redundant, so this rewrites it as "user@foobar.com".
   ;;
   ((string-match "\\`\\([^@%!]+\\)!\\([^@%!]+[@%]\\1\\)\\'" addr)
    (bbdb-match-substring addr 2))
   ;;
   ;; Sometimes I see addresses like "foobar.com!user".  Turn it around.
   ;;
   ((string-match "\\`\\([^@%!.]+\\.[^@%!]+\\)!\\([^@%]+\\)\\'" addr)
    (concat (bbdb-match-substring addr 2) "@" (bbdb-match-substring addr 1)))
   ;;
   ;; The mailer at hplb.hpl.hp.com tends to puke all over addresses which
   ;; pass through mailing lists which are maintained there: it turns normal
   ;; addresses like "user@foo.com" into "user%foo.com@hplb.hpl.hp.com".
   ;; This reverses it.  (I actually could have combined this rule with
   ;; the similar lucid.com rule above, but then the regexp would have been
   ;; more than 80 characters long...)
   ;;
   ((string-match "\\`\\([^@!]+\\)%\\([^@%!]+\\)@hplb\\.hpl\\.hp\\.com\\'"
                  addr)
    (concat (bbdb-match-substring addr 1) "@" (bbdb-match-substring addr 2)))
   ;;
   ;; Another local mail-configuration botch: sometimes mail shows up
   ;; with addresses like "user@workstation", where "workstation" is a
   ;; local machine name.  That should really be "user" or "user@netscape.com".
   ;; (I'm told this one is due to a bug in SunOS 4.1.1 sendmail.)
   ;;
   ((string-match "\\`\\([^@%!]+\\)[@%][^@%!.]+\\'" addr)
    (bbdb-match-substring addr 1))
   ;;
   ;; Sometimes I see addrs like "foo%somewhere%uunet.uu.net@somewhere.else".
   ;; This is silly, because I know that I can send mail to uunet directly.
   ;;
   ((string-match ".%uunet\\.uu\\.net@[^@%!]+\\'" addr)
    (concat (substring addr 0 (+ (match-beginning 0) 1)) "@UUNET.UU.NET"))
   ;;
   ;; Otherwise, leave it as it is.  Returning a string EQ to the one passed
   ;; in tells BBDB that we're done.
   ;;
   (t addr)))

(defun bbdb/pgp-key (email)
  "Return the pgp key belonging to the person with the specified email
address.  Return nil if no record is found or if the record does not
contain the appropriate field.  The BBDB field used is specified by
the variable bbdb/pgp-field."
  (let* ((record (car (bbdb-search (bbdb-records) nil nil email))))
    (and record (bbdb-record-getprop record bbdb/pgp-field)))
)

(defun my-message-mode-hook-mail-aliases ()
  (define-key message-mode-map (kbd "C-c a")
    'mail-interactive-insert-alias))

(add-hook 'gnus-load-hook
	  (function
	   (lambda ()
	     ((bbdb-initialize 'gnus 'message 'sc 'sendmail)))))

;;; So after evaluating the piece of advice below, I can type `:' in Gnus
;;; Summary mode to see/create the BBDB entry for the sender, or I can type
;;; `C-u :' to see/create BBDB entries for the sender and all recipients.

;;; This also makes a nicer window configuration than
;;; `bbdb-show-all-recipients' does on its own.

(defadvice bbdb/gnus-show-sender
  (around gdr-bbdb-show-all first (&optional arg) activate)
  "With a prefix argument, display the contents of the BBDB for the
  sender and all the recipients of the message."
  (interactive "P")
  (if arg
      (progn
	(gnus-summary-select-article)
	(gnus-summary-select-article-buffer)
	(bbdb-pop-up-bbdb-buffer)
	(bbdb-show-all-recipients)
	(let ((summary-window (get-buffer-window gnus-summary-buffer)))
	  (when summary-window
	    (select-window summary-window))))
    (let ((bbdb-use-pop-up t))
      ad-do-it)))


;;; I took a totally different approach; I decided that I wanted someone in my
;;; bbdb if I replied to their email.  So, as a gnus user, I did this:
;;; The save-window-excursion is quite necessary, as message-reply expects a
;;; particular window configuration and would otherwise get confused at the
;;; sudden appearance of the bbdb popup buffer.

(defun my-bbdb/gnus-force-create ()
  "Add bbdb entry for this message."
  (interactive)
  (let ((bbdb/news-auto-create-p t))
    ))

(defadvice message-reply (before pdf-bbdb/add-on-reply activate)
  "Add addresses replied to to bbdb."
  (save-excursion
    (save-window-excursion
      (my-bbdb/gnus-force-create))))


;;;  Is there something I can do such that the bbdb window isn't normally
;;;  shown, and when I hit `:', a third window for bbdb is created as with
;;;  bbdb-use-pop-up?

;;; (defadvice bbdb/gnus-show-sender (after split-article-window last activate)
;;;   (gnus-summary-show-article)
;;;   (bbdb/gnus-pop-up-bbdb-buffer t))

;;; (defadvice gnus-summary-display-article (before delete-bbdb-window first
;;;  						activate)
;;;   (delete-windows-on (get-buffer bbdb-buffer-name)))

(defun bbdb/gnus-alternative-show-sender ()
  (interactive)
  (gnus-summary-select-article)
  )

(defun bbdb/mail-insert-address-at-point (address)
  "Prompt for and insert an address from the BBDB at point."
  (interactive (list (bbdb-read-addresses-with-completion "Cc: ")))
  (insert address))

(defun bbdb/sendmail-update-records (&optional offer-to-create)
  "Returns the new records corresponding to the current *mail*
message, creating or modifying it as necessary.  A record will be
created if `bbdb/mail-auto-create-p' is non-nil, or if
OFFER-TO-CREATE is true and the user confirms the creation."
  (unless (eq major-mode 'mail-mode) (set-buffer "*mail*"))
  (save-restriction
    (save-excursion
      (narrow-to-region (point-min) (mail-header-end))
      (let ((addrs
             (split-string
              (mapconcat 'identity (list (mail-fetch-field "to" nil t)
                                         (mail-fetch-field "cc" nil t)
                                         (mail-fetch-field "bcc" nil t)) ", ")
              ",[[:space:]]*" t))
            records)
        (dolist (addr addrs records)
          (let ((rec (bbdb-annotate-message-sender
                      addr t
                      (or (bbdb-invoke-hook-for-value
                           bbdb/mail-auto-create-p)
                          offer-to-create)
                      offer-to-create)))
            (when rec (push rec records))))))))


;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:
