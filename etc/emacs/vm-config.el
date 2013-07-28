(setq

 ;;; `M-x vm' causes VM to visit a folder known as your "primary inbox"
 vm-primary-inbox (concat my-mail-dir "/INBOX")
 ;; vm-crash-box is where messages are stored temporarily as it is moved into
 ;; your primary inbox file (vm-primary-inbox). Here we just tack on a
 ;; .crash to name it separately:
 vm-crash-box (concat vm-primary-inbox ".crash")

 ;;;If the variable `vm-auto-get-new-mail' is set non-`nil', VM will
 ;;;gather any new mail that has arrived and integrate it into your
 ;;;primary inbox.


 ;;;If you want to associate spool files with folders other than or in
 ;;;addition to the primary inbox, the value of `vm-spool-files' must
 ;;;be a list of lists.  Each sublist specifies three entities, a
 ;;;folder, a spool file and a crash box.  When retrieving mail for a
 ;;;particular folder, VM will scan `vm-spool-files' for folder names
 ;;;that match the current folder's name.  The spool file and crash
 ;;;box found in any matching entries will be used to gather mail for
 ;;;that folder.

 vm-spool-files (list
                 (list "INBOX"  "~/mbox"  "INBOX.CRASH" )
                 (list "INBOX" (concat "/var/mail/" (user-login-name))
                       "INBOX.CRASH" )
                 (list "INBOX" (concat "/var/spool/mail/" (user-login-name))
                       "INBOX.CRASH" )
                 (list "INBOX" (concat  "/usr/mail/" (user-login-name))
                       "INBOX.CRASH" )
                 (list "INBOX" (concat "/usr/spool/mail/" (user-login-name))
                       "INBOX.CRASH" )
                 (list "INBOX" (concat  real-home-directory
                                "/var/spool/mail/important")
                       "INBOX.CRASH" )
                 (list "ADMIN" (concat  real-home-directory
                                "/var/spool/mail/admin")
                       "ADMIN.CRASH")
                 (list "BCAST" (concat  real-home-directory
                                "/var/spool/mail/bcast")
                       "BCAST.CRASH")
                 (list "spam" (concat real-home-directory
                                      "/var/spool/mail/spam")
                       "spam.CRASH")
                 (list "grey" (concat real-home-directory
                                      "/var/spool/mail/grey.mbox")
                       "grey.CRASH")
                 (list "MISC" (concat real-home-directory
                                      "/var/spool/mail/misc")
                       "MISC.CRASH")
                 (list "orders" (concat real-home-directory
                                        "/var/spool/mail/orders")
                       "orders.CRASH")
  )

 ;;; VM can create an index file which describes the messages contained in a
 ;;; folder.  If such an index file exists and is up to date, then VM will
 ;;; read the contents of the index file first while starting up in order to
 ;;; quickly form the summary of the folder.
 vm-index-file-suffix "idx"


 ;;; The variable `vm-startup-with-summary' controls whether VM
 ;;; automatically displays a summary of the folder's contents at startup.  A
 ;;; value of `nil' gives no summary; a value of `t' always gives a summary.
 ;;; A value that is a positive integer N means that VM should generate a
 ;;; summary if there are N or more messages in the folder.  A negative
 ;;; value -N means generate a summary only if there are N or fewer
 ;;; messages.  The default value of `vm-startup-with-summary' is `t'.
 vm-startup-with-summary t

 ;;; move forward and backward through the current folder.  By
 ;;; default, these commands skip messages flagged for deletion.  This
 ;;; behavior can be disabled by setting the value of the variable
 ;;; `vm-skip-deleted-messages' to `nil'.  These commands can also be
 ;;; made to skip messages that have been read; set
 ;;; `vm-skip-read-messages' to `t' to do this.
 vm-skip-deleted-messages 0
 vm-skip-read-messages nil

 ;;; You can also select messages by using the summary window.  VM
 ;;; will select the message under the cursor in the summary window
 ;;; before executing such commands. Note that this occurs _only_ when
 ;;; you execute a command when the cursor is in the summary buffer
 ;;; window
 vm-follow-summary-cursor t


 ;;; When a folder is visited or when you type `g' and VM retrieves some
 ;;; mail, the default action is to move to the first new or unread message
 ;;; in the folder.  New messages are favored over old but unread messages.
 ;;; If you set `vm-jump-to-new-messages' to `nil', VM will favor old,
 ;;; unread messages over new messages if the old, unread message appears
 ;;; earlier in the folder.  If you set `vm-jump-to-unread-messages' to
 ;;; `nil' also, VM will not search for new or unread messages.

 ;;; If the value of `vm-preview-lines' is a number, it tells VM how many
 ;;; lines of the text of the message should be visible.
 vm-preview-lines 5

 ;;; vm-highlighted-header-regexp'.  The value of this variable should
 ;;; be a single regular expression that matches the beginnings of any
 ;;; header that should be presented in inverse video when previewing.
 vm-highlighted-header-regexp (if window-system nil "^From\\|^Subject")

 ;;; If the value of `vm-honor-page-delimiters' is non-`nil', VM will
 ;;; recognize and honor page delimiters.
 vm-honor-page-delimiters t

 ;;; Sometimes you will receive messages that contain lines that are too
 ;;; long to fit on your screen without wrapping.  Setting
 ;;; `vm-word-wrap-paragraphs' to t will cause VM to use the `longlines.el'
 ;;; library by Grossjohann, Schroeder and Yidong to carry out word
 ;;; wrapping.
 vm-word-wrap-paragraphs t

 ;;; If the value of the variable `vm-search-using-regexps' is
 ;;; non-`nil', a regular expression may be used instead of a fixed
 ;;; string for the search pattern; VM defaults to the fixed string
 ;;; search.
 vm-search-using-regexps t


 ;;; VM has Emacs-Lisp based Quoted-Printable and BASE64 encoders and
 ;;; decoders, but you can have VM use external programs to perform
 ;;; these tasks and the process will almost certainly be faster.
 vm-mime-qp-decoder-program "qp-decode"
 vm-mime-qp-encoder-program "qp-encode"
 vm-mime-base64-decoder-program "base64-decode"
 vm-mime-base64-encoder-program "base64-encode"
 vm-mime-uuencode-decoder-program "uudecode"

 ;;; If there are character codes in the composition greater than 128,
 ;;; the variable `vm-mime-8bit-composition-charset' tells VM what
 ;;; character set to assume when encoding the message.  The default
 ;;; is `iso-8859-1'.
 vm-mime-8bit-composition-charset "utf-8"

 ;;; The first step in displaying a MIME message is decoding it to
 ;;; determine what object types it contains.  The variable
 ;;; `vm-auto-decode-mime-messages' controls when this happens.
 vm-auto-decode-mime-messages t

 ;;; The variable `vm-auto-displayed-mime-content-types' specifies the
 ;;; types that are displayed immediately.  Its value should be a list
 ;;; of MIME content types that should be displayed immediately after
 ;;; decoding.  Other types will be displayed as a button that you
 ;;; must activate to display the object.
 vm-auto-displayed-mime-content-types  '("text" "image" "multipart"
                                         "message/rfc822" "plain text"
                                         "mail message" "text/x-vcard"
                                         "text/enriched" )



 ;;; The MIME attachments can be saved to disk with `$ w'
 ;;; (`vm-mime-reader-map-save-file').  They can be deleted at the same time
 ;;; by setting the variable `vm-mime-delete-after-saving'.  In this case,
 ;;; the attachment is deleted and replaced by a MIME part that refers to
 ;;; the saved copy.  The variable `vm-mime-attachment-save-directory'
 ;;; specifies the default directory to save the attachments in.
 vm-mime-delete-after-saving t
 vm-mime-attachment-save-directory (concat real-home-directory
                                           "/mail/attachments")


 ;;; The variable `vm-mime-internal-content-types' specifies which
 ;;; types should be displayed internally within Emacs.
 vm-mime-internal-content-types '("text" "multipart" "message/rfc822"
                                  "plain text" "mail message" "text/x-vcard"
                                  "text/enriched" )

 ;;; Non-nil value should be a string that VM should add to the beginning
 ;;; of the Subject header in replies, if the string is not already present.
 vm-reply-subject-prefix "Re: "

 ;;; The variable `vm-included-text-attribution-format' specifies the
 ;;; format for the attribution of included text.
 vm-included-text-attribution-format "On %H %w, %d %m %y %z, %F wrote"


 ;;; The variable `vm-in-reply-to-format' specifies the format of the
 ;;; In-Reply-To header that is inserted into the header section of
 ;;; the reply buffer.
 ;; vm-in-reply-to-format "%i:%F's message of %h %w,%d %m %y "


 ;;; If the variable `vm-strip-reply-headers' is non-`nil', the
 ;;; recipient headers will be stripped of all information except the
 ;;; actual addresses.
 vm-strip-reply-headers t

 ;;; value should be a list of regular expressions that match
 ;;; addresses that VM should automatically remove from the recipient
 ;;; headers of replies
 vm-reply-ignored-addresses (list (concat "\\b" (regexp-quote
                                                 (user-login-name)) "\\b"))


 ;;; should specify the format of the Subject header of the forwarded
 ;;; message.
 vm-forwarding-subject-format "Forwarded message from %F, %h %w,%d %m %y"


 ;;; If you have a directory where you keep all your mail folders, you
 ;;; should set the variable `vm-folder-directory' to point to it.
 vm-folder-directory (concat my-mail-dir "/")

 ;;; The variable `vm-visit-when-saving' controls which method is
 ;;; used.  A value of `t' causes VM to always visit a folder before
 ;;; saving message to it.  A `nil' value causes VM to always append
 ;;; directly to the folder file.  In this case VM will not save
 ;;; messages to the disk copy of a folder that is being visited.
 ;;; This restriction is necessary to insure that the buffer and
 ;;; on-disk copies of the folder are consistent. If the value of
 ;;; `vm-visit-when-saving' is not `nil' and not `t' (e.g. 0, the
 ;;; default), VM will append to the folder's buffer if the buffer is
 ;;; currently being visited, otherwise VM will append to the file
 ;;; itself.
 vm-visit-when-saving 'okay

 ;;; If the variable `vm-delete-after-saving' is non-`nil', VM will
 ;;; flag messages for deletion automatically after saving them.
 vm-delete-after-archiving t
 vm-delete-after-bursting t
 vm-delete-after-saving t

 ;;; Setting the variable `vm-move-after-deleting' non-`nil' causes VM
 ;;; to move past the messages after flagging them for deletion.
 ;;; Setting `vm-move-after-undeleting' non-`nil' causes similar
 ;;; movement after undeletes.  Setting `vm-move-after-killing'
 ;;; non-`nil' causes VM to move after killing messages with
 ;;; `vm-kill-subject'.
 vm-move-after-deleting t
 vm-move-after-killing t
 vm-move-after-undeleting t

 ;;; The variable `vm-auto-center-summary' controls whether VM will
 ;;; keep the summary arrow vertically centered within the summary
 ;;; window.  A value of `t' causes VM to always keep the arrow
 ;;; centered.  A value of `nil' (the default) means VM will never
 ;;; bother centering the arrow.  A value that is not `nil' and not
 ;;; `t' causes VM to center the arrow only if the summary window is
 ;;; not the only existing window.
 vm-auto-center-summary 0
 ;;; The variable `vm-summary-format' controls the format of each
 ;;; message's summary.
 vm-summary-format "%2n%UA%*%a %-17.17UB %-3.3m %2d %4l/%-5c %I\"%s\"\n"
 vm-summary-uninteresting-senders (concat "\\b" (regexp-quote
                                                 (user-login-name)) "\\b")
 vm-summary-uninteresting-senders-arrow "==> "

 ;;; A virtual folder is defined by its name, the folders that it
 ;;; contains and its selectors.  The variable
 ;;; `vm-virtual-folder-alist' is a list of the definitions of all
 ;;; named virtual folders.  In order to visit a virtual folder with
 ;;; the `vm-visit-virtual-folder' (`V V') command, a virtual folder
 ;;; must have an entry in vm-virtual-folder-alist.
 vm-virtual-folder-alist '(
                           ("misc"
                            (("ADMIN" "BCAST" "MISC" ) ;;;;
                             (any)))
                           )

 ;;; VM saves information about your window configurations in the file
 ;;; named by the variable `vm-window-configuration-file'
 vm-window-configuration-file "~/etc/vm.windows"

 vm-netscape-program "firefox"
 vm-url-browser 'vm-mouse-send-url-to-netscape
 vm-netscape-program-switches nil


)

;;; If you want VM to always display messages using threads, you should
;;; set the default value of the variable `vm-summary-show-threads'
;;; non-`nil' in your VM init file.
(setq-default vm-summary-show-threads t)

(bbdb-insinuate-vm)


(defun vm-summary-function-A (m)
  (if (string-match "Manoj Srivastava" (vm-su-to m)) "+" " "))

;;"%2n %*%a %-17.17F %-3.3m %2d %4l/%-5c \"%s\"\n"
;;"%2n %*%a %-17.17U %-3.3m %2d %4l/%-5c \"%s\"\n"

(defvar vm-ml-ids
  '(
    "info-vm-request"
    "info-mm"
    "ange-ftp-lovers"
    "info-gnuplot-request"
    "lucid-emacs"
    "Gutenberg"
    "hyperbole"
    "auc-tex"
    "owner-supercite"
    "fsp-discussion"
    )
  "*List of strings naming the mailing lists that VM should know
 about. VM archives mailing-lists that appear in vm-mailing-lists in
 their own folder. See also info on function vm-make-mailinglist-regexp.")

(defun vm-make-mailing-list-regexp (listname)
  "This function is used only to construct the variable
 vm-auto-folder-alist. It returns the cons of a regexp and a
 foldername. The regexp is supposed to match the To, Cc, or Sender
 field in the message. The foldername is the LISTNAME prepended with
 \"M-\" and the result is used as the name of the folder to append the
 message to."
  (cons
   (concat
    "\\<" listname
    "\\|" (upcase listname)
    "\\|" listname "-list"
    "\\|" (upcase listname) "-LIST"
    "\\>")
   (concat "M-" listname)))


;;; Another aid to selecting folders in which to save mail is the
;;; variable `vm-auto-folder-alist'.If any part of the contents of
;;; the message header named by HEADER-NAME is matched by the
;;; regular expression REGEXP, VM will evaluate the corresponding
;;; FOLDER-NAME and use the result as the default when prompting for
;;; a folder to save the message in.
(setq
 vm-auto-folder-alist
 (list
  ;; First we check if this is a mailing-list. The name of the
  ;; mailing-list is usually in the To-field, but sometimes in the Cc-
  ;; or Sender-field:


  (cons "To"     (mapcar 'vm-make-mailing-list-regexp vm-ml-ids))
  (cons "Cc"     (mapcar 'vm-make-mailing-list-regexp vm-ml-ids))
  (cons "Sender" (mapcar 'vm-make-mailing-list-regexp vm-ml-ids))
  ;; if it's not a mailing list, then use sender's name as folder name:
  (list "Newsgroups"
        (cons "gnu.emacs.sources"  "emacs")
        )
  (list "Subject"
        (cons ".*[oO]pen ?[lL]ook.*"  "xnews")
        (cons ".*\\(MOTIF\\|X11\\| X \\).*"  "x11")
        (cons ".*\\(OSF\\).*"  "osf1")
        (cons ".*[vV][mM].*"  "vm")
        (cons ".*[cC]\\+\\+.*"  "c++")
        (cons "Returned mail"  "Receipts")
        )
  (list "From"
        (cons my-login-name-regexp
              '(list (list "To"
                           '( "ART" . "gaylord")
                           ;; match id with IN%
                           '( "IN%\"\\([^>@%]+\\)" .
                              (buffer-substring
                               (match-beginning 1) (match-end 1)))
                           ;; match id in <>
                           '( "<\\([^>@%]+\\)" .
                              (buffer-substring
                               (match-beginning 1) (match-end 1)))
                           ;; match id with @
                           '( "\\([^@%:]+\\)[@%]" .
                              (buffer-substring
                               (match-beginning 1) (match-end 1)))
                           ;; match id with ::
                           '("[^:]+\:\:\\(\\w+\\|\\w+\\W\\w+\\)" .
                             (buffer-substring
                              (match-beginning 1) (match-end 1)))
                           ;; match first word
                           '("\\(\\w+\\)" .
                             (buffer-substring
                              (match-beginning 1) (match-end 1)))
                           )

                     ))
        '("IN%\"\\([^>@%]+\\)" .
          (buffer-substring (match-beginning 1) (match-end 1)))
        ;; Kyle's catch-all:
        '( "ART" . "gaylord")
        ;; match id with IN%
        '("<\\([^ \t\n\f@%()<>]+\\)[@%]\\([^ \t\n\f<>()]+\\)>" .
          (buffer-substring (match-beginning 1) (match-end 1)))
        '("<\\([^>]+\\)>" .
          (buffer-substring (match-beginning 1) (match-end 1)))
        ;;	 '("\\([^ \t\n\f@%()<>]+\\)\\([@%]\\([^ \t\n\f<>()]+\\)\\)?"
        ;;	   (buffer-substring (match-beginning 1) (match-end 1)))
        ;; match id in <>
        '("<\\([^>@%]+\\)" .
          (buffer-substring (match-beginning 1) (match-end 1)))
        ;; match id with @
        '("\\([^@%:]+\\)[@%]" .
          (buffer-substring (match-beginning 1) (match-end 1)))
        ;; match id with ::
        '("[^:]+\:\:\\(\\w+\\|\\w+\\W\\w+\\)" .
          (buffer-substring (match-beginning 1) (match-end 1)))
        ;; match first word
        '("\\(\\w+\\)" .
          (buffer-substring (match-beginning 1) (match-end 1)))
        )
  ))

(add-hook 'vm-quit-hook 'vm-expunge-folder)
(add-hook 'vm-quit-hook 'bbdb-save-db)

(defun my-vm-mode-function ()
  "Added quitting, no  backups, and load a few libs."
  (interactive)
  (make-local-variable 'version-control)
  (setq version-control 'never); keep minimal backups
  ;;  (load-library "jwz-vm-summary")
  (require 'sendmail)
  ;;  (load-library "ml-alias")
  ;;  (require 'vm-sort)
  (require 'message)
  (add-hook 'local-write-file-hooks 'bbdb-offer-save)
  (setq fill-column 60
        comment-start "> "
        indent-line-function 'indent-relative-maybe)

  ;; mark lines longer than `fill-column' chars red
  (add-to-list 'mail-font-lock-keywords
               (list (concat "^" (make-string fill-column ?.)
                             "\\(.+$\\)")
                     '(1 font-lock-warning-face t)))
  (font-lock-mode 1)
  (turn-on-auto-fill)
  (turn-on-filladapt-mode)
  (flyspell-mode 1)

  )

(setq vm-mode-hooks 'my-vm-mode-function)

(define-key vm-mode-map "#" 'vm-expunge-folder)

;; Do you like boxquotes?
(require 'boxquote)

(defun boxquote-region-and-edit-title (s e)
  (interactive "r")
  (boxquote-region s e)
  (call-interactively 'boxquote-title))

;; HTML messages can be converted to text or the w3 resp. w3m Emacs viewers
;; can be used for displaying.

(setq  vm-mime-type-converter-alist
       '(("text/html" "text/plain" "lynx -force_html -dump /dev/stdin")
         ("message/delivery-status"  "text/plain")
         ("application/zip"  "text/plain" "listzip")
         ("application/x-zip-compressed"  "text/plain" "zipinfo /dev/stdin")
         ("application/x-www-form-urlencoded"  "text/plain")
         ("message/disposition-notification"  "text/plain")
         ("application/mac-binhex40" "application/octet-stream" "hexbin -s")))



;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-start: ";;; "
;;; End:
