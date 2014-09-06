;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manoj-config.el ---
;; Author           : Emacs Test User ( emacstest@glaurung.green-gryphon.com )
;; Created On       : Mon Nov 27 14:16:14 2000
;; Created On Node  : glaurung.green-gryphon.com
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Sat Oct  3 00:54:37 2009
;; Last Machine Used: anzu.internal.golden-gryphon.com
;; Update Count     : 438
;; Status           : Unknown, Use with caution!
;; HISTORY          :
;; Description      :
;; arch-tag: 0e75c713-e0dd-4929-9c90-460977e767d0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;-----------------------------------------------------------------------------
;; Macros
(load-file (concat my-emacs-config-dir "/lisp/emacs-vers.el"))
(defmacro GNUEmacs-23 (&rest body)
  `(when (= emacs-major-version 23)
     ,@body))

(defmacro GNUEmacs-24 (&rest body)
  `(when (= emacs-major-version 24)
     ,@body))

(defmacro Linux (&rest x)
  (list 'if (string-match "linux" (prin1-to-string system-type))
        (cons 'progn x)))

(defmacro Windows (&rest x)
  (list 'if (string-match "windows" (prin1-to-string system-type))
        (cons 'progn x)))

(defmacro WindowSystem (&rest body)
  `(when (not (equal window-system nil))
     ,@body))

(defmacro Console (&rest body)
  `(when (equal window-system nil)
     ,@body))

(defmacro Console-XTerm (&rest body)
  `(when (and (not window-system)
              (equal (getenv "TERM") "xterm"))
     ,@body))

;;-----------------------------------------------------------------------------
(defvar ulocal-lisp-subdirs
  (list "bbdb" "auctex" "dictionary" "functions" "org" "vm" "w3m")
  "*The list of subdirtectories we want in the path.")
;;; Add the subdirs to the load path
(let ((subdirs (mapcar
                (function
                 (lambda (x)
                   (expand-file-name
                    (concat
                     "/usr/local/share/emacs/site-lisp/"  x))))
                ulocal-lisp-subdirs)))
  (while subdirs
    (let ((subdir (car subdirs)))
      (if (not (member subdir load-path))
          (setq load-path (cons subdir load-path))))
    (setq subdirs (cdr subdirs))))

;; "nhxhtml"
(defvar manoj-lisp-subdirs (list "bbdb" "config" "lisp" "mail" "news"
                                 (format "emacs%d/gnus" (emacs-major-version))
                                 (format "emacs%d" (emacs-major-version))
                                 )
  "*The list of subdirtectories we want in the path.")

;;; Add the subdirs to the load path
(let ((subdirs (mapcar
                (function
                 (lambda (x)
                   (expand-file-name
                    (concat
                     my-emacs-config-dir "/"  x))))
                manoj-lisp-subdirs)))
  (while subdirs
    (let ((subdir (car subdirs)))
      (if (not (member subdir load-path))
          (setq load-path (cons subdir load-path))))
    (setq subdirs (cdr subdirs))))

;;; (if (and (file-exists-p "/usr/local/src//org-mode/EXPERIMENTAL")
;;;          (not (member "/usr/local/src//org-mode/EXPERIMENTAL" load-path)))
;;;     (progn
;;;       (add-to-list  'load-path "/usr/local/src//org-mode/EXPERIMENTAL/")
;;;       ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   Common variables used later                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar home-directory (expand-file-name (concat "~" (user-real-login-name)))
  "*The effective home directory of the user (changes when the user
 has su'd).")
(defvar real-home-directory (expand-file-name (concat "~" (user-login-name)))
  "*The Real home directory of the user.")
(defvar my-emacs-config-dir (concat real-home-directory "/etc/emacs")
  "*The directory where emacs config files are kept.")
(defvar my-diary-file (concat my-emacs-config-dir "/my-diary")
  "*The name of your diary file.")
(defvar my-mail-dir (concat real-home-directory "/mail")
  "*vm-folder-directory is set from this var.")
(defvar my-log-directory (concat my-mail-dir "/log")
  "*The directory that all mail traffic is logged")
(defvar my-login-name-regexp
  (concat "\\<" (user-login-name) "\\|" (upcase (user-login-name)) "\\>")
  "* The users login name as a regular expression")
(defvar BiBTeX-file-list '( (concat real-home-directory "/tex/mybib.bib"))
  "*Default bibliography database.")
(defvar mail-organization-header "Manoj Srivastava's Home"
  "*The name of the organization.")
(defvar mail-personal-alias-file (expand-file-name "~/.mailrc")
  "* File where mail aliases are kept.")
(defvar need-auto-fill t)
(defvar debian-mailing-address "srivasta@debian.org"
  "*Mailing address used i Debian contexts.")

(defvar my-emacs-var-dir (concat real-home-directory "/var/run/emacs")
  "Emacs' var directory")
(defvar my-emacs-state-dir (concat real-home-directory "/var/state/emacs")
  "Emacs' state directory")
;;(defvar buf my-emacs-state-dir "Temporary file name")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Identity                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq
 add-log-mailing-address debian-mailing-address
 add-log-time-zone-rule t
 debian-changelog-mailing-address debian-mailing-address
 gnus-local-organization mail-organization-header
 mail-host-address "golden-gryphon.com"
 mail-self-address (concat "<" user-mail-address ">")
 message-user-organization mail-organization-header
 message-user-organization-file "/etc/news/organization"
 ecomplete-database-file   "~/etc/emacs/ecompleterc"
 vm-mail-header-from (concat (user-full-name) " <" user-mail-address ">")
 bbdb-file (concat real-home-directory "/var/lib/contacts/bbdb")
;; S/MIME
 smime-keys '(("manoj.srivastava@stdc.com" "~/certs/usercert.pem"
               ("~/certs/thawte_cert.pem"))
              ("srivasta@golden-gryphon.com" "~/certs/manoj_cert.pem"
               ("~/certs/thawte_cert.pem"))
              ("srivasta@acm.org" "~/certs/manoj_cert.pem"
               ("~/certs/thawte_cert.pem"))
              ("srivasta@debian.org" "~/certs/manoj_cert.pem"
               ("~/certs/thawte_cert.pem"))
              ("srivasta@ieee.org" "~/certs/manoj_cert.pem"
               ("~/certs/thawte_cert.pem"))
              ("srivasta@computer.org" "~/certs/manoj_cert.pem"
               ("~/certs/thawte_cert.pem")))
 smime-CA-directory  "~/certs/CA-CERTS"
;; diary
 diary-file (concat real-home-directory "/var/lib/diary")
;; Store everything here...
 temporary-file-directory (concat real-home-directory "/var/tmp")
;; The directory where cache files should be stored;
 url-cache-directory (concat real-home-directory "/var/cache")
 w3-configuration-directory "~/etc/w3"
 )


(defvar identica-username "USER"
  "*The username for identica.")
(defvar       identica-password "PASSWORD"
  "*The username for identica.")
(defvar       laconica-server "identi.ca"
  "*The name of the identica server.")
(defvar       oftc-password "PASSWORD"
  "*The password for the oftc irc server.")
(defvar       bitlbee-password "PASSWORD"
  "*The password for the local bitlbee server.")


;;; Load all the encrypted secrets
(if (file-readable-p (concat (getenv-internal "GNUPGHOME") "/secring.gpg"))
    (require 'secrets)
    )


;;------------------------------------------------------------------------
;; locations of various changing files
(defvar my-diary-file (concat my-emacs-config-dir "/custom")
  "*The name of your diary file.")

(setq
 ;; eshell dump
 eshell-directory-name (concat my-emacs-var-dir "eshell/")
 ;; where to put autosaved files
 auto-save-list-file-prefix (concat my-emacs-var-dir "autosave/")
 ;; where to put backups
 ;; backup-directory-alist (list (cons "." (concat my-emacs-var-dir "backup")))
 ;; custom file
 custom-file (format "%scustom-emacs%d.el"
                     (concat my-emacs-config-dir "/custom/")
                     emacs-major-version))
(load custom-file)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   General Settings                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(menu-bar-mode  t)                       ;; show the menu...
(tool-bar-mode -1)                       ;; turn-off toolbar
(setq fringe-mode '(8 . 8))              ;; emacs 22+
(delete-selection-mode 1)                ;; delete the sel with a keyp
(set-scroll-bar-mode 'left)

;; Basic customization

(put 'narrow-to-region 'disabled nil)
(put 'eval-expression 'disabled nil)
(put 'erase-buffer 'disabled nil)        ;; ... useful things
(file-name-shadow-mode t)                ;; be smart about filenames in mbuf

(setq
 comment-style 'multi-line
 find-file-visit-truename t
 highlight-nonselected-windows t
 backup-by-copying-when-linked t
 backup-by-copying-when-mismatch t
 history-delete-duplicates t
 max-lisp-eval-depth 10000
 max-specpdl-size 10000
 initial-scratch-message ";; scratch buffer created -- happy hacking\n"
 initial-buffer-choice  'remember-notes
 visual-order-cursor-movement t
 )

;; Set up recentf so I can get a list of recent files when I start
(recentf-mode 1)
;;(recentf-open-files nil "*Recent Files*")
(setq recentf-max-saved-items 1200)

(setq isearch-allow-scroll t)
(setq search-highlight t                 ;; highlight when searching...
      query-replace-highlight t)             ;; ...and replacing

(setq fill-column 80)            ;;when to split lines
(setq split-width-threshold nil) ;;;  Do not split window horizontally
(when (require 'winner nil 'noerror)
  (winner-mode 1))
(windmove-default-keybindings)
;; (desktop-save-mode 1)

(setq savehist-file (concat real-home-directory "/var/cache/emacs-history"))
(savehist-mode 1)

;;Whether to add a newline automatically at the end of the file.
;;A value of t means do this only when the file is about to be saved.
;;A value of `visit' means do this right after the file is visited.
;;A value of `visit-save' means do it at both of those times.
;;Any other non-nil value means ask user whether to add a newline, when saving.
;;nil means don't add newlines.
(setq require-final-newline 'visit-save)

;; Make emacs faster by having less frequent garbage collection.
;; Default is 400000 bytes.
;;(setq gc-cons-threshhold 2000000)

;;-----------------------------------------------------------------------------
;; Language environment

;;(standard-display-european t)
;;
;; ISO characters
;;
(setq input-method-highlight-flag t
      input-method-verbose-flag t
      )
;; (set-language-environment "Latin-9")
;; (setq default-input-method "latin-9-prefix")

;; for displaying utf-8 encoded files
(prefer-coding-system 'utf-8)
(set-coding-system-priority 'utf-8)

;; key board / input method settings
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-language-environment "UTF-8")       ; prefer utf-8 for language settings
(set-input-method nil)                   ; no funky input for normal editing;
(setq read-quoted-char-radix 10)         ; use decimal, not octal


;;; Diary
;; (load-library "cal-desk-calendar")
;; (add-hook 'diary-display-hook 'sort-diary-entries)
;; (add-hook 'diary-display-hook
;;         'fancy-schedule-display-desk-calendar t)
;; (setq
;;  diary-default-schedule-start-time  500
;;  diary-default-schedule-stop-time  2200
;;  diary-morning-times '(500 1200)
;;  )

;;
;; Calendar
;;
(setq calendar-location-name "Mercer Island, WA"
      calendar-latitude    47.587772
      calendar-longitude -122.228428
      ;;; calendar-latitude 35.838782
      ;;; calendar-longitude -86.077012
      calendar-standard-time-zone-name "PST"
      calendar-daylight-time-zone-name "PDT"
      ;; week starts on Sunday
      calendar-week-start-day 0
      calendar-view-holidays-initially-flag t
      ;; mark holidays
      calendar-mark-holidays-flag t
      ;; and diary entries
      calendar-mark-diary-entries-flag t
      calendar-mark-diary-entries-flag t
      diary-number-of-entries '[0 2 2 2 2 4 1]
      appt-display-duration 30
      ;; 5 minute warnings
      appt-message-warning-time '15
      appt-display-interval '5

      appt-audible t
      appt-display-mode-line t
      )
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

;;Here is some code to get rid of the ugly equal signs under the date:

(add-hook 'fancy-diary-display-mode-hook
          '(lambda ()
             (alt-clean-equal-signs)))



;; don't use tabs anywhere
;;
;; Emacs normally uses both tabs and spaces to indent lines. If you
;; prefer, all indentation can be made from spaces only. To request this,
;; set `indent-tabs-mode' to `nil'. This is a per-buffer variable;
;; altering the variable affects only the current buffer, but it can be
;; disabled for all buffers.
(setq-default indent-tabs-mode nil)
;; ===== Set standard indent to 2 rather that 4 ====
(setq standard-indent 2)

;;; For some file types indent-tabs-mode should always be t (e.g. for
;;; ChangeLog and Makefile) and for others it should always be nil
;;; (e.g. for LaTeX and TeXinfo). Look at the file to see if
;;; indentation is done with tabs or not.
(add-hook
 'find-file-hook
 (lambda ()
   (if (and (null indent-tabs-mode)
            (local-variable-p 'indent-tabs-mode) ; Trust the major mode.
            (save-excursion
              (goto-char (point-min))
              ;; If there are at least 10 lines with a leading TAB, use TABs.
              (re-search-forward "^    " (+ (point) 100000) t 10)))
       (set (make-local-variable 'indent-tabs-mode) t))))

(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))
(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))

(defun cleanup-region (beg end)
  "Remove tmux artifacts from region."
  (interactive "r")
  (dolist (re '("\\\\│\·*\n" "\W*│\·*"))
    (save-excursion
      (goto-char beg)
      (re-search-forward re  end)
      (replace-match "")
      )))

(set-default 'ispell-skip-html t)
(setq-default ispell-program-name "aspell")

(setq
 ispell-use-framepop-p  (and window-system (condition-case () (require 'framepop) (error nil)))
 ispell-dictionary "american"
 ispell-local-dictionary "american"
 ispell-silently-savep t
 ispell-parser 'tex
 flyspell-sort-corrections nil
 )

(eval-when-compile (require 'flyspell))
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mode-map (kbd "C-+") 'flyspell-check-previous-highlighted-word)
     (define-key flyspell-mode-map (kbd "C-#") 'flyspell-auto-correct-previous-word)))

(setq which-function-modes
      '(actionscript-mode
        python-mode emacs-lisp-mode
        c-mode c++-mode perl-mode cperl-mode makefile-mode
        sh-mode fortran-mode java-mode))
(which-function-mode t)
(recentf-mode 1)
(setq recentf-max-saved-items 500)
(setq recentf-max-menu-items 60)
(setq recentf-exclude (append recentf-exclude '(".ftp:.*" ".sudo:.*")))
(setq recentf-keep '(file-remote-p file-readable-p))

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")))

(add-to-list 'package-archives
             '("ELPA" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

;; CUA mode indications
;; --------------------
;; You can choose to let CUA use different cursor colors to indicate
;; overwrite mode and read-only buffers.  For example, the following
;; setting will use a RED cursor in normal (insertion) mode in
;; read-write buffers, a YELLOW cursor in overwrite mode in read-write
;; buffers, and a GREEN cursor read-only buffers:
;;
(eval-after-load "cua-base"
  '(progn
     (setq cua-normal-cursor-color "red")
     (setq cua-overwrite-cursor-color "yellow")
     (setq cua-read-only-cursor-color "green")))
(require 'cua-rect)
;;; cua
(setq
 cua-enable-cua-keys  nil  ;; only for rectangles
 cua-remap-control-v  nil
 cua-remap-control-z  nil
 cua-delete-selection nil
 cua-enable-region-auto-help t
 cua-enable-modeline-indications t
 )
(cua-mode t)


(setq indicate-empty-lines t)
(enable-flow-control-on "vt200" "vt300" "vt101" "vt131")
(auto-compression-mode t)

(autoload 'insert-box                          "insert-box")

;; Markdown mode
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.mdwn$" . markdown-mode) auto-mode-alist))
(add-hook 'markdown-mode-hook 'flyspell-mode)
(setq auto-mode-case-fold t)



(setq ditaa-cmd (concat "java -jar " real-home-directory "/lib/ditaa0_6b.jar"))
(defun djcb-ditaa-generate ()
  (interactive)
  (shell-command
   (concat ditaa-cmd " " buffer-file-name)))

(eval-when-compile (require 'wikipedia-mode))
(autoload 'wikipedia-mode
  "wikipedia-mode"
  "Major mode for editing documents in Wikipedia markup." t)

;; (add-to-list 'auto-mode-alist
;;    '("\\.wiki\\'" . wikipedia-mode))

(eval-after-load "wikipedia-mode"
  '(setq wikipedia-mode-directory "~/var/state/wiki"))

;; ViewSourceWith is better, it has the site name in the file name
(add-to-list 'auto-mode-alist '("wiki\\.boozallenet\\.com_" . wikipedia-mode))
(setq auto-mode-alist
      (cons '("\\.wiki\\'" . wikipedia-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("mozex.\\.*" . wikipedia-mode))
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; * You may want to enable `wikipedia-turn-on-eldoc-mode' for
;;   `wikipedia-mode-hook'.  This way you will always see where a
;;   particular link leads to.
;;
;; * Similarly, enabling `wikipedia-turn-on-longlines-mode' will
;;   automatically and transparently break lines in articles.
;;
;; * If you include `wikipedia-mode' into `which-func-modes' list, you
;;   will see the current article subsection name in the mode line.
;;   In any case you can use `imenu'.
;;(add-hook 'wikipedia-mode-hook 'wikipedia-turn-on-eldoc-mode)
(add-hook 'wikipedia-mode-hook 'flyspell-mode)
(add-to-list 'which-func-modes 'wikipedia-mode)


(require 'whitespace)
(setq whitespace-style
      '(trailing lines-tail empty indentation space-after-tab
                 space-before-tab ))
(setq whitespace-action  '(report-on-bogus warn-if-read-only cleanup))
;; Show trailing space/tabs in makefile mode (so space after \ is very
;; visible)
(add-hook 'makefile-mode-hook
          (lambda()
            (setq show-trailing-whitespace t)))



;;;One can pretty much replace longlines-mode with this:

;;;    (visual-line-mode 1)
;;;    (whitespace-newline-mode 1)
;;;    (setq fill-column 999999)


(add-to-list 'auto-mode-alist '("mozex.\\.*" . wikipedia-mode))
(add-to-list 'auto-mode-alist '("mozex.\\.*" . wikipedia-mode))

;; C-k kills whole line and newline if at beginning of line
(setq kill-whole-line t)


(require 'header2)
(add-hook 'emacs-lisp-mode-hook 'auto-make-header)
(add-hook 'c-mode-common-hook   'auto-make-header)


(autoload 'make-header                         "header")
;; (autoload 'make-header                         "header2")
(autoload 'maybe-make-header                   "my-header")


(defun header-arch-tag ()
  "Insert a new universally unique identifier (UUID) as the file's arch-tag."
  (insert "arch-tag: " (substring (shell-command-to-string "uuidgen") 0 -1)
          "\n"))

(eval-after-load "header"
  '(setq make-header-hook
         '(
           ;;header-mode-line
           header-title
           header-blank
           header-file-name
           header-description
           ;;header-status
           header-author
           header-maintainer
           header-copyright
           header-creation-date
           ;;header-rcs-id
           header-version
           ;;header-sccs
           header-modification-date
           header-modification-author
           header-update-count
           header-url
           header-keywords
           header-compatibility
           header-blank
           header-lib-requires
           header-end-line
           header-commentary
           header-blank
           header-blank
           header-blank
           header-end-line
           header-history
           header-blank
           header-blank
           ;; header-rcs-log
           header-end-line
           header-free-software
           header-code
           header-arch-tag
           header-eof
           )))

;; Update file headers when write files.
;;(add-hook 'write-file-hooks 'update-file-header)

(autoload 'working-message      "working")
(autoload 'working-temp-message "working")


(require 'tramp)
(require 'tramp-sh)

;; edit files as root in remote servers
(add-to-list 'tramp-default-proxies-alist
	     '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
	     '((regexp-quote (system-name)) nil nil))
;;(setq tramp-default-method "ssh") ; already had this, didn't work by itself
;;(add-to-list 'tramp-remote-path 'tramp-own-remote-path) ; seems to be the key




(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq comint-prompt-read-only t)
(add-hook 'comint-mode-hook
          (lambda ()
            (define-key comint-mode-map "\C-w" 'comint-kill-region)
            (define-key comint-mode-map [C-S-backspace]
              'comint-kill-whole-line)))



(add-hook 'find-file-not-found-hooks 'set-auto-mode 'append)
;; (add-hook 'find-file-not-found-hooks 'maybe-make-header 'append)
;;; *NOTE* Trailing slash important
(setq auto-insert-directory
      (concat real-home-directory "/etc/emacs/templates/"))

(require 'autoinsert)
 ;;; If you don't want to be prompted before insertion
(setq auto-insert-query nil)
(setq auto-insert-copyright (user-full-name))

(define-auto-insert "\\.pl$" 'perl-auto-insert)
(defun perl-auto-insert ()
  (progn
    (insert "#! /usr/bin/perl -w\n")
    (insert "# File: " (file-name-nondirectory buffer-file-name) "\n")
    (insert "# Time-stamp: <>\n#\n")
    (insert "# Copyright (C) " (substring (current-time-string) -4)
            " by " auto-insert-copyright "\n#\n"
            "# Author: "(user-full-name) "\n#\n")
    (insert "# Description:\n# \nuse warnings;\nuse strict;\n")
    (insert "use Carp;\n\n")
    (insert "use FindBin ();\n")
    (insert "use Data::Dumper;\n$Data::Dumper::Indent   = 1;\n")
    (insert "$Data::Dumper::Sortkeys = 1;\n\n")
    (progn (save-buffer)
           (shell-command (format "chmod +x %s" (buffer-file-name)))
           "")
    )
  )


(define-auto-insert "\\.cgi$" 'cgi-auto-insert)
(defun cgi-auto-insert ()
  (progn
    (insert "#! /usr/bin/perl -w\n")
    (insert "# File: " (file-name-nondirectory buffer-file-name) "\n")
    (insert "# Time-stamp: <>\n#\n")
    (insert "# Copyright (C) " (substring (current-time-string) -4)
            " by " auto-insert-copyright "\n#\n"
            "# Author: "(user-full-name) "\n#\n")
    (insert "# Description:\n# \n\nuse warnings;\nuse strict;\n")
    (insert "use CGI ();\n")
    (insert "use CGI::Carp qw(fatalsToBrowser);\n")
    (insert "use HTML::Template::Compiled;\n")
    (insert "use FindBin ();\n")
    (insert "use lib $FindBin::Bin;\n\n")
    (insert "my $filename = 'template.tmpl';\n")
    (insert "my $cssUrl   = 'style.css';\n\n");
    (insert "my $cgi    = CGI->new();\nmy %params = $cgi->Vars();\n\n")
    (insert "print $cgi->header( -type => 'text/html', -expires => '+3s' );\n")
    (insert "my $constructorParams = { filename => $filename,\n")
    (insert "                          path     => \"$FindBin::Bin/templates\",\n")
    (insert "                          # die_on_bad_params => 0,\n")
    (insert "                         };\n\n")
    (insert "my $template = &Template\n")
    (insert "    ( $cgi, $constructorParams,\n")
    (insert "      {\n       SELF_URL => $ENV{SCRIPT_NAME},\n")
    (insert "       CSS_URL => $cssUrl,\n   } );\n\n")
    (insert "print $template->output();\n\n")
    (insert "# print $cgi->start_html('title');\n\n\n")
    (insert "# print $cgi->end_html();\n\n")
    (insert "# ------------------------------------------------------------\n")
    (insert "sub Template {\n")
    (insert "    my( $cgi, $constructorParams, $htmlParams ) = @_;\n\n")
    (insert "    my $template = HTML::Template::Compiled->new( %$constructorParams );\n")
    (insert "    $template->param( %$htmlParams ) if ref $htmlParams;\n\n")
    (insert "    return $template;\n")
    (insert "} # Template\n")
    (insert "# ------------------------------------------------------------\n")
    )
  )


(define-auto-insert "\\.pm$" 'pm-auto-insert)
(defun pm-auto-insert ()
  (progn
    (insert "# File: " (file-name-nondirectory buffer-file-name) "\n")
    (insert "# Time-stamp: <>\n#\n")
    (insert "# Copyright (C) " (substring (current-time-string) -4)
            " by " auto-insert-copyright "\n#\n"
            "# Author: "(user-full-name) "\n#\n")
    (insert "# Description:\n# \n")
    (insert "package ")
    ;;    (insert (file-name-nondirectory buffer-file-name))
    (insert (substring (file-name-nondirectory buffer-file-name) 0 -3))
    (insert ";\nuse warnings;\nuse strict;\n")
    (insert "use Carp;\n\n")
    (insert "use Readonly;\n\n\n")
    (insert "# ------------------------------------------------------------\n\n")
    (insert "sub {\n\n\n} #\n")
    (insert "# ------------------------------------------------------------\n")
    (insert "1; # modules have to return a true value\n")
    )
  )

(defun tidy-html ()
  "Tidies the HTML content in the buffer using `tidy'"
  (interactive)
  (shell-command-on-region
   ;; beginning and end of buffer
   (point-min)
   (point-max)
   ;; command and parameters
   "tidy -config ~/etc/tidy.conf -access  -c -i -w 120 -q"
   ;; output buffer
   (current-buffer)
   ;; replace?
   t
   ;; name of the error buffer
   "*Tidy Error Buffer*"
   ;; show error buffer?
   t))


(defun insert-sgml-header ()
  "Inserts the header for a LinuxDoc document"
  (interactive)
  (let (title author email home translator email-translator home-translator date
              starting-point)
    (setq title (read-from-minibuffer "Title: "))
    (if (> (length title) 0)
        (progn
          (setq date (read-from-minibuffer "Date: ")
                author (read-from-minibuffer "Author: ")
                email (read-from-minibuffer "Author e-mail: ")
                home (read-from-minibuffer "Author home page: http://")
                translator (read-from-minibuffer "Translator: "))
          (insert "<!doctype linuxdoc system>\n<article>\n<title>")
          (insert title)
          (insert "</title>\n<author>\nAuthor: ") (insert author) (insert "<newline>\n")
          (if (> (length email) 0)
              (progn
                (insert "<htmlurl url=\"mailto:")
                (insert email) (insert "\" name=\"") (insert email)
                (insert "\"><newline>\n")))
          (if (> (length home) 0)
              (progn
                (insert "<htmlurl url=\"http://")
                (insert home) (insert "\" name=\"") (insert home)
                (insert "\">\n<newline>")))
          (if (> (length translator) 0)
              (progn
                (setq email-translator (read-from-minibuffer "Translator e-mail: ")
                      home-translator (read-from-minibuffer "Translator home page: http://"))
                (insert "Translator : ")
                (insert translator)
                (insert "<newline>\n")
                (if (> (length email-translator) 0)
                    (progn
                      (insert "<htmlurl url=\"mailto:")
                      (insert email-translator) (insert "\" name=\"")
                      (insert email-translator)
                      (insert "\"><newline>\n")))
                (if (> (length home-translator) 0)
                    (progn
                      (insert "<htmlurl url=\"http://")
                      (insert home-translator) (insert "\" name=\"")
                      (insert home-translator)
                      (insert "\"><newline>\n")))))
          (insert "</author>\n<date>\n")
          (insert date)
          (insert "\n</date>\n\n<abstract>\n")
          (defvar point-beginning)
          (setq point-beginning (point))
          (insert "\n</abstract>\n<toc>\n\n<sect>\n<p>\n\n\n</sect>\n\n</article>\n")
          (goto-char point-beginning)
          ))))
(setq auto-insert-alist
      (append '(((sgml-mode .  "SGML Mode") . insert-sgml-header))
              auto-insert-alist))


(add-hook 'find-file-hook 'auto-insert)
(add-hook 'before-save-hook 'time-stamp)



;; ===== Make Text mode the default mode for new buffers =====
;;; These need to be incorporated
(autoload 'my-text-mode-function               "my-text-mode")
(add-hook 'text-mode-hook 'my-text-mode-function)
(setq major-mode 'paragraph-indent-text-mode )
(add-hook 'text-mode-hook 'paragraph-indent-minor-mode)
(add-hook 'text-mode-hook 'flyspell-mode)

(load-library "insert-box")

;; Should allow me to fill nested quoted messages properly.  Has
;; zillions of options that can be set.
(require 'filladapt)
(setq-default filladapt-mode t)
(setq filladapt-prefix-table nil)
(add-to-list 'filladapt-token-table '("To: " bullet))
(add-to-list 'filladapt-token-table '("Cc: " bullet))

(add-hook 'text-mode-hook 'turn-on-filladapt-mode)
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (featurep 'filladapt)
	      (c-setup-filladapt))))
 ;;; (add-hook 'c-mode-hook 'turn-off-filladapt-mode)

;; combination of following two variables finally makes Emacs scroll
;; nicely. scroll-conservatively is a variable that says Scroll up to
;; this many lines, to bring point back on screen.If you set it to
;; 10000, then moving point 10000 lines below the lowest screen edge
;; will scroll so as to bring the point's line to the last line of
;; the window.  If you move more than 10000 lines, the point's line
;; will be centered (by default, unless you also change
;; scroll-*-aggressively).
(setq scroll-step 0
      scroll-conservatively most-positive-fixnum
      scroll-preserve-screen-position t
      scroll-up-aggressively 0.0
      scroll-down-aggressively 0.0
      track-eol t
      line-move-visual nil
      )

;; imenu needs to be set up yet
(autoload 'my-set-shell-imenu-expression  "my-imenu")
(autoload 'my-imenu-create-lisp-index     "my-imenu")
(autoload 'my-imenu-create-c-index        "my-imenu")
(add-hook 'sh-mode-hook 'my-set-shell-imenu-expression)


;; handle command line arguments when you resume an existing Emacs job.
(add-hook 'suspend-hook 'resume-suspend-hook)
(add-hook 'suspend-resume-hook 'resume-process-args)

(if (emacs-type-eq 'fsf)
    (if (emacs-version=  21)
        (if (emacs-minor-version= 3)
            (if (featurep 'outline)
                (require 'foldout)
              (eval-after-load "outline" '(require 'foldout)))
          )))

;; (add-hook 'after-save-hook 'byte-compile-after-save-function)
(defun byte-compile-after-save-function ()
  (and (> (length buffer-file-truename) 2)
       (string= ".el" (substring buffer-file-truename -3 nil))
       (y-or-n-p (format "Byte compile %s? " buffer-file-truename))
       (byte-compile-file buffer-file-truename)))

;; Shut off compiler error pop-up warning about
;;    save-excursion defeated by set-buffer
(setq byte-compile-warnings '(not suspicious))

;; This is a global minor mode that reverts any buffer associated with
;; a file when the file changes on disk.
(defun turn-on-auto-revert-mode ()
  (interactive)
  (auto-revert-mode 1))
(add-hook 'dired-mode-hook 'turn-on-auto-revert-mode)
(add-hook 'doc-view-mode-hook 'turn-on-auto-revert-mode)
(global-auto-revert-mode 1)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                      Functions for Key Bindings                          ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; First define a variable which will store the previous column position
(defvar previous-column nil "Save the column position")

;; ===== Function to delete a line =====

;; Define the nuke-line function. The line is killed, then the newline
;; character is deleted. The column which the cursor was positioned at is then
;; restored. Because the kill-line function is used, the contents deleted can
;; be later restored by usibackward-delete-char-untabifyng the yank commands.
(defun nuke-line()
  "Kill an entire line, including the trailing newline character"
  (interactive)

  ;; Store the current column position, so it can later be restored for a more
  ;; natural feel to the deletion
  (setq previous-column (current-column))

  ;; Now move to the end of the current line
  (end-of-line)

  ;; Test the length of the line. If it is 0, there is no need for a
  ;; kill-line. All that happens in this case is that the new-line character
  ;; is deleted.
  (if (= (current-column) 0)
      (delete-char 1)

    ;; This is the 'else' clause. The current line being deleted is not zero
    ;; in length. First remove the line by moving to its start and then
    ;; killing, followed by deletion of the newline character, and then
    ;; finally restoration of the column position.
    (progn
      (beginning-of-line)
      (kill-line)
      (delete-char 1)
      (move-to-column previous-column))))

;;(pc-bindings-mode)      ; fix HOME/END, etc
;;(pc-selection-mode)     ; use shift-arrows
;; ctrl-up and ctrl-down scroll w/o moving cursor.
(defun scroll-down-keep-cursor ()
  ;; Scroll the text one line down while keeping the cursor.
  (interactive)
  (scroll-down 1))

(defun scroll-up-keep-cursor ()
  ;; Scroll the text one line up while keeping the cursor.
  (interactive)
  (scroll-up 1))
;; Bind the functions.
;; *These are the console mode versions of C-up and C-down.
;;(global-set-key "\eOa" 'scroll-down-keep-cursor)
;;(global-set-key "\eOb" 'scroll-up-keep-cursor)
;; Set the X versions, too, just in case we ever use those.
;;(global-set-key [C-up] 'scroll-down-keep-cursor)
;;(global-set-key [C-down] 'scroll-up-keep-cursor)

(setq highlight-changes-visibility-initial-state nil); initially hide

;;; Make sure we use a font that makes non-breaking spaces very
;;; visible
;;; (set-fontset-font (face-attribute 'default :fontset)
;;;                  '(160 . 160)
;;;                  "-*-fixed-medium-r-normal-*-16-*-*-*-*-*-iso8859-2")


 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;;                          Key Bindings                          ;;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key global-map [home]            'beginning-of-buffer)
(define-key global-map [end]             'end-of-buffer)
(define-key global-map [XF86Forward]     'forward-page)
(define-key global-map [XF86Back]        'backward-page)
(global-set-key (kbd "RET")         'newline-and-indent)


;; C-pgup goes to the start, C-pgdw goes to the end
(global-set-key (kbd "<C-prior>")
                (lambda()(interactive)(goto-char(point-min))))
(global-set-key (kbd "<C-next>")
                (lambda()(interactive)(goto-char(point-max))))

(require 'linum)
(global-linum-mode 1)
;;(global-set-key (kbd "<f3>") 'linum-mode)

(global-set-key (kbd "C-<f4>")      'kill-buffer-and-window)
(global-set-key (kbd "C-<f6>") 'magit-status)               ;; ...git mode
(global-set-key (kbd "C-<f7>") 'compile)                     ;; compile
(global-set-key (kbd "C-<f8>") 'comment-or-uncomment-region) ;; (un)comment

(global-set-key (kbd "<f8>")      'highlight-changes-visible-mode) ;; changes
(global-set-key (kbd "<M-down>")  'highlight-changes-next-change)
(global-set-key (kbd "<M-up>")    'highlight-changes-previous-change)
(global-set-key [?\^?] 'backward-delete-char-untabify)
;; Now bind the delete line function to the F9 key
(global-set-key [f9] 'nuke-line)

(require 'gse-number-rect)
(global-set-key "\C-xru" 'gse-number-rectangle)


(global-set-key (kbd "C-x 4 k") (lambda ()
                                  (interactive)
                                  (kill-buffer (current-buffer))
                                  (other-window 1)
                                  (delete-other-windows)))

(global-set-key "\C-c\C-z." 'browse-url-at-point)
(global-set-key "\C-c\C-zb" 'browse-url-of-buffer)
(global-set-key "\C-c\C-zr" 'browse-url-of-region)
(global-set-key "\C-c\C-zu" 'browse-url)
(global-set-key "\C-c\C-zv" 'browse-url-of-file)

(global-set-key (kbd "C-x m") 'compose-mail-other-frame)
(global-set-key (kbd "C-x 5 m") 'compose-mail)

(global-set-key (kbd "C-c r") 'revert-buffer)

(global-set-key (kbd "C-c /")
                '(lambda()
                   "Refine display of unified diff hunks"
                   (interactive)
                   (save-excursion
                     (goto-char (point-min))
                     (while (re-search-forward
                             diff-hunk-header-re-unified
                             nil t)
                       (diff-refine-hunk)))))


;; Mouse gestures
(require 'mouse-copy)
;;     (global-set-key [M-down-mouse-1] 'mouse-drag-secondary-pasting)
;;     (global-set-key [M-S-down-mouse-1] 'mouse-drag-secondary-moving)
;;(appmenu-mode 0)
(global-set-key [mouse-3]         'mouse-save-then-kill)

(autoload 'set-mouse-shape                     "my-x-setup")
(autoload 'mouse-line-to-top                   "my-x-setup")
(autoload 'mouse-line-to-center                "my-x-setup")
(autoload 'mouse-line-to-bottom                "my-x-setup")
(autoload 'mouse-yank-drag                     "my-x-setup")
(autoload 'mouse-save-drag                     "my-x-setup")
(autoload 'mouse-kill-drag                     "my-x-setup")
(autoload 'mouse-kill-and-yank-drag            "my-x-setup")
(autoload 'manoj-scroll-bar-scroll-down        "my-x-setup")
(autoload 'mouse-yank-at-point                 "my-x-setup")
(autoload 'perform-x-setup                     "my-x-setup")
(define-key global-map [C-S-mouse-1]    'mouse-line-to-top)
(define-key global-map [C-S-mouse-2]    'mouse-line-to-center)
(define-key global-map [C-S-mouse-3]    'mouse-line-to-bottom)
(define-key global-map [drag-mouse-2]   'mouse-save-drag)
(define-key global-map [drag-mouse-3]   'mouse-yank-drag)
(define-key global-map [S-drag-mouse-2] 'mouse-kill-drag)
(define-key global-map [S-drag-mouse-3] 'mouse-kill-and-yank-drag)

;; Increase or decrease font size
(global-set-key [(control mouse-4)] (lambda () (interactive)
                                      (text-scale-increase 1)))
(global-set-key [(control mouse-5)] (lambda () (interactive)
                                      (text-scale-decrease 1)))

;;; If mouse-drag-copy-region is t _and_ x-select-enable-primary is
;;; t, then mouse-selection will set primary as well as putting the
;;; selection on the kill-ring.

;;; If mouse-drag-copy-region is nil and x-select-enable-primary is
;;; nil and select-active-regions is t, then both mouse/keyboard
;;; selection will set primary, but _without_ putting it on kill
;;; ring.
(global-set-key [mouse-2] 'mouse-yank-at-click) ;;; Also needed
(setq
 transient-mark-mode   t                  ;show the marked region
 ;; mark-even-if-inactive t
 ;;; Behave like other X applications. This is confusing.

 ;; after copy Ctrl+c in X11 apps, you can paste by `yank' in emacs
 x-select-enable-clipboard t    ;;; cut/paste use clipboard

 interprogram-paste-function  'x-cut-buffer-or-selection-value
 select-active-regions     nil      ;;; This could be nill too
 mouse-drag-copy-region    t      ;;; copy dragged region to kill ring

 ;; after mouse selection in X11, you can paste by `yank' in emacs
 x-select-enable-primary   t
 delete-active-region      nil ;;; Whether single-char deletion
 ;;; commands delete an active region.
 )


;; Make dealing with faces in list-faces-display easier
;;(require 'face-list)

;;; Make sure we use a font that makes non-breaking spaces very
;;; visible
;;; (set-fontset-font (face-attribute 'default :fontset)
;;;                  '(160 . 160)
;;;                  "-*-fixed-medium-r-normal-*-16-*-*-*-*-*-iso8859-2")




;;
;; Blink parens
;;
(require 'paren)
(setq blink-matching-paren t
      show-paren-style 'mixed
      show-paren-ring-bell-on-mismatch t
      )
(show-paren-mode t)
(setq show-paren-delay 0)           ; how long to wait?

;; activate scrolling using mouse wheel
(mouse-wheel-mode t)
(setq mouse-autoselect-window -1
      focus-follows-mouse t
      mouse-1-click-follows-link  450
      mouse-1-click-in-non-selected-windows t
      ;; x-mouse-click-focus-ignore-position t
      )
;(if (display-mouse-p) (mouse-avoidance-mode 'proteus))
;(if (display-mouse-p) (mouse-avoidance-mode 'exile))
;(if (display-mouse-p) (mouse-avoidance-mode 'jump))

(global-set-key (kbd "C-x _") 'shrink-window)

;; fix some keys for the terminal
(Console-XTerm
 (global-set-key (kbd "C-c h") 'help-command)
 (add-hook 'term-setup-hook
           (lambda ()
             (define-key function-key-map "\e[3~" [delete])
             (define-key function-key-map "\e[1~" [home])
             (define-key function-key-map "\e[4~" [end])
             (define-key function-key-map "\eO2C" [S-right])
             (define-key function-key-map "\eO2D" [S-left])
             (define-key function-key-map "\eO2A" [S-up])
             (define-key function-key-map "\eO2B" [S-down]))))


;; load auto-show (shows lines when cursor moves to right of long line)
;(require 'auto-show)
;(auto-show-mode 1)
;(setq-default auto-show-mode t)

;; position cursor to end of output in shell mode
;; (auto-show-make-point-visible)




(add-hook 'dired-mode-hook
          (lambda ()
            (local-set-key "\C-c\C-zf" 'browse-url-of-dired-file)))
;;
;; GNUscape
;;
(setq shr-color-visible-distance-min 15
      shr-color-visible-luminance-min 60)

;; Use the Emacs w3 browser when not running under X11:
(if (eq window-system 'x)
    (setq browse-url-browser-function 'browse-url-firefox)
  (setq browse-url-browser-function 'eww-browse-url))

(setq
 browse-url-new-window-flag          t
 ;;; open up new windows in a tab
 browse-url-firefox-new-window-is-tab t
 url-be-asynchronous                 t
 url-honor-refresh-requests          nil
 )
;; This appears to turn off all cookies
(setq url-cookie-untrusted-urls '(".*"))

;; This handles:  type application/x-httpd-php3
(setq url-mime-accept-string "*")


;; You have a choice of using regular Emacs `dired' rather than W3
;; formatting; this loses hypertext properties but gives you a nicer
;; format.  An advantage of the hypertext is you can easily view a gif
;; by clicking on it.
;; If nil, w3 uses dired
;; If t,   w3 converts to hypertext.
;;(setq url-use-hypertext-dired nil)
(setq url-use-hypertext-dired t)
;; newframe   -- put the w3 page in its own frame
;; bully      -- make the w3 page the current buffer and only window
;; semibully  -- make the w3 page the current buffer in the same window
;; aggressive -- make the w3 page the current buffer in the other window
;; friendly   -- display  w3page in other window but don't make current
;; polite     -- don't display w3 page, but prints message when ready (beeps)
;; quiet      -- like `polite', but don't beep
;; meek       -- make no indication that page is ready
;; default, already: (setq  w3-notify 'semibully)

;; Automatically save everything...
;; But works only if in synchronous mode,
;; not when downloading in background!
(setq url-automatic-caching t)

;; 24 May 1998, William Perry says `Do not use
;; url-cache-create-filename-human-readable for this.
;; It is a can of worms.'  (Makes reading RISKS impossible.)
(setq url-cache-creation-function
      'url-cache-create-filename-using-md5)

;; Keep a history
(setq url-keep-history t)

;; Set how much information you want sent to place you visit.
;; none     -- Send all information
;; low      -- Don't send the last location
;; high     -- Don't send the email address or last location
;; paranoid -- Don't send anything
;; evaluate following to update: (url-setup-privacy-info)
(setq-default url-privacy-level (quote paranoid))

;; Tell about cookies
(setq-default url-cookie-confirmation t)

;; google-region: select some text and enter a key command to search
;; for that text on google
(defun google-region (&optional flags)
  "Google the selected region"
  (interactive)
  (let ((query (buffer-substring (region-beginning) (region-end))))
    (browse-url (concat "http://www.google.com/search?ie=utf-8&oe=utf-8&q=" query))))
;; press control-c g to google the selected region
(global-set-key (kbd "C-c g") 'google-region)

(defun wc nil
  "Count words in buffer"
  (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))
(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR."
  (interactive "DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn
        (copy-file filename newname 1)
        (delete-file filename)
        (set-visited-file-name newname)
        (set-buffer-modified-p nil)     t))))

;; ==========================

(add-hook 'dns-mode-hook
          (lambda ()
            (add-hook 'before-save-hook
                      'dns-mode-soa-increment-serial
                      nil t)))

;; prefer imagemagick over the jpg loader
(setq image-type-header-regexps nil)


;; load color-theme and choose one of my favorites at random, but only
;; if the emacs is a windowed variety
;;; (require 'color-theme)
;;; (require 'manoj-colors)
;;; (color-theme-manoj-dark)
;;; (eval-after-load "gnus"
;;;   '(progn
;;;      (color-theme-manoj-gnus)))
;;; (eval-after-load "gnus-art"
;;;   '(progn
;;;      (color-theme-manoj-gnus)
;;;      ))
;;; (eval-after-load "message"
;;;   '(progn
;;;      (color-theme-manoj-message)))
;;; (eval-after-load "erc"
;;;   '(progn
;;;      (color-theme-manoj-erc)))
;;; (eval-after-load "org"
;;;   '(progn
;;;      (color-theme-manoj-org)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defvar current-color-theme                                                        ;;
;;   "the current color-theme")            ;this is defined so I can                  ;;
;;                                         ;always tell what color-theme              ;;
;;                                         ;I am using                                ;;
;;                                                                                    ;;
;; (if (not window-system)                                                            ;;
;;     nil                                                                            ;;
;;   (progn                                                                           ;;
;;         (setq favorite-color-themes                                                ;;
;;           '(                                                                       ;;
;;             ;;(color-theme-arjen)                 ;red mode line                   ;;
;;             ;;(color-theme-goldenrod)     ; Brown, complete                        ;;
;;             (color-theme-comidia)               ;steel blue                        ;;
;;             (color-theme-jsc-dark)                                                 ;;
;;             (color-theme-tty-dark)      ; foreground too white                     ;;
;;             (color-theme-taming-mr-arneson) ;complete; comments are too bright red ;;
;;             (color-theme-billw)                 ;cornsilk (complete?)              ;;
;;             (color-theme-clarity)               ;white, purple mode line           ;;
;;             (color-theme-dark-laptop)                                              ;;
;;             (color-theme-hober)                                                    ;;
;;             ;; (color-theme-ld-dark)                                               ;;
;;             (color-theme-lethe)         ;Needs X resources?                        ;;
;;             ;;(color-theme-matrix)                                                 ;;
;;             ;;(color-theme-midnight)                                               ;;
;;             ;;(color-theme-oswald)                                                 ;;
;;             ;;(color-theme-pok-wob)                                                ;;
;;             ;;(color-theme-simple-1)                                               ;;
;;             (color-theme-taylor)                                                   ;;
;;             ))                                                                     ;;
;;     (random t)                          ;set the seed according to the             ;;
;;                                         ;system clock                              ;;
;;     (setq current-color-theme                                                      ;;
;;           (nth (random (length favorite-color-themes))                             ;;
;;                favorite-color-themes))                                             ;;
;;     ;;(eval current-color-theme)                                                   ;;
;;     ))                                                                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Light themes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (color-theme-aalto-light)  ;;
;; (color-theme-digital-ofs1) ;;
;; (color-theme-fischmeister) ;;
;; (color-theme-gray1)        ;;
;; (color-theme-gray30)       ;;
;; (color-theme-infodoc)      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; Themes I do not like
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (color-theme-aalto-dark)       ;;
;; (color-theme-aliceblue)        ;;
;; (color-theme-andreas)          ;;
;; (color-theme-bharadwaj)        ;;
;; (color-theme-bharadwaj-slate)  ;;
;; (color-theme-black-on-gray)    ;;
;; (color-theme-blippblopp)       ;;
;; (color-theme-blue-mood)        ;;
;; (color-theme-blue-sea)         ;;
;; (color-theme-calm-forest)      ;;
;; (color-theme-charcoal-black)   ;;
;; (color-theme-classic)          ;;
;; (color-theme-dark-blue)        ;;
;; (color-theme-dark-blue2)       ;;
;; (color-theme-dark-green)       ;;
;; (color-theme-deep-blue)        ;;
;; (color-theme-emacs-21)         ;;
;; (color-theme-emacs-nw)         ;;
;; (color-theme-euphoria)         ;;
;; (color-theme-feng-shui)        ;;
;; (color-theme-gnome)            ;;
;; (color-theme-gnome2)           ;;
;; (color-theme-greiner)          ;;
;; (color-theme-gtk-ide)          ;;
;; (color-theme-high-contrast)    ;;
;; (color-theme-jb-simple)        ;;
;; (color-theme-jedit-grey)       ;;
;; (color-theme-jonadabian)       ;;
;; (color-theme-jonadabian-slate) ;;
;; (color-theme-jsc-light)        ;;
;; (color-theme-jsc-light2)       ;;
;; (color-theme-katester)         ;;
;; (color-theme-kingsajz)         ;;
;; (color-theme-late-night)       ;;
;; (color-theme-lawrence)         ;;
;; (color-theme-marine)           ;;
;; (color-theme-marquardt)        ;;
;; (color-theme-mistyday)         ;;
;; (color-theme-montz)            ;;
;; (color-theme-parus)            ;;
;; (color-theme-pierson)          ;;
;; (color-theme-pok-wog)          ;;
;; (color-theme-ramangalahy)      ;;
;; (color-theme-raspopovic)       ;;
;; (color-theme-resolve)          ;;
;; (color-theme-retro-green)      ;;
;; (color-theme-retro-orange)     ;;
;; (color-theme-robin-hood)       ;;
;; (color-theme-rotor)            ;;
;; (color-theme-ryerson)          ;;
;; (color-theme-scintilla)        ;;
;; (color-theme-shaman)           ;;
;; (color-theme-sitaramv-nt)      ;;
;; (color-theme-sitaramv-solaris) ;;
;; (color-theme-snow)             ;;
;; (color-theme-snowish)          ;;
;; (color-theme-standard)         ;;
;; (color-theme-subtle-blue)      ;;
;; (color-theme-subtle-hacker)    ;;
;; (color-theme-vim-colors)       ;;
;; (color-theme-whateveryouwant)  ;;
;; (color-theme-word-perfect)     ;;
;; (color-theme-xemacs)           ;;
;; (color-theme-xp)               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hippie expand.  Groovy vans with tie-dyes.
(require 'hippie-exp)

;; Change the default hippie-expand order and add yasnippet to the front.
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-list-all-buffers
        try-expand-line-all-buffers
        try-complete-file-name
        try-complete-lisp-symbol
        try-complete-file-name-partially
        try-complete-lisp-symbol-partially
        ))
(global-set-key (kbd "M-/") 'hippie-expand)

;; Helps when debugging which try-function expanded
(setq hippie-expand-verbose t)

;; Enables tab completion in the `eval-expression` minibuffer
(define-key read-expression-map [(tab)] 'hippie-expand)
(define-key read-expression-map [(shift tab)] 'unexpand)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                          Programming                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Enable EDE (Project Management) features
(global-ede-mode 1)
(ede-enable-generic-projects)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")
(setq
 ede-project-placeholder-cache-file (concat real-home-directory
                                            "/var/cache/projects.ede")
 ede-simple-save-directory          (concat real-home-directory
                                            "/var/state/ede")
 ;; Directory name where semantic cache files are stored.
 semanticdb-default-save-directory   (concat my-emacs-var-dir "/semanticdb")
 ;; ede-locate-setup-options
 ede-locate-setup-options '(ede-locate-global
                            ede-locate-idutils
                            ede-locate-cscope
                            ede-locate-locate
                            ede-locate-base)
 semantic-default-submodes '(global-semantic-idle-scheduler-mode
                             global-semanticdb-minor-mode
                             semantic-highlight-func-mode
                             semantic-decoration-mode
                             semantic-stickyfunc-mode
                             ;;                             semantic-idle-completions-mode
                             semantic-mru-bookmark-mode
                             ))


;;(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;;(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-show-unmatched-syntax-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-edits-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-show-parser-state-mode)
;;(add-to-list 'semantic-default-submodes ')

(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

;;;
(require 'cedet-cscope)

(require 'semantic)
(require 'semantic/sb)

(require 'srecode)
(require 'ede/speedbar)

(require 'semantic/ia)
(require 'semantic/db)
(require 'semantic/db-global)
(require 'ede/proj)

(require 'semantic/senator)

(require 'semantic/bovine/gcc)
(require 'semantic/ia)
(require 'semantic/decorate/include)
(require 'semantic/lex-spp)
(require 'ede/dired)

;;; One of:
;;; semantic-format-tag-name
;;; semantic-format-tag-canonical-name
;;; semantic-format-tag-abbreviate
;;; semantic-format-tag-summarize
;;; semantic-format-tag-summarize-with-file
;;; semantic-format-tag-short-doc
;;; semantic-format-tag-prototype
;;; semantic-format-tag-concise-prototype
;;; semantic-format-tag-uml-abbreviate
;;; semantic-format-tag-uml-prototype
;;; semantic-format-tag-uml-concise-prototype
;;; semantic-format-tag-prin1
(setq semantic-idle-summary-function 'semantic-format-tag-short-doc)

(semantic-mode 1)
(global-srecode-minor-mode 1)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-decoration-mode 1)
(global-semantic-highlight-func-mode 1)
(global-semantic-stickyfunc-mode 1)
(global-semantic-idle-summary-mode 1)
(global-semantic-mru-bookmark-mode 1)
(global-semantic-show-unmatched-syntax-mode t)

(global-semantic-idle-completions-mode t)
(semantic-gcc-setup)


(when (cedet-gnu-global-version-check t)
  (require 'semantic/db-global)
  (semanticdb-enable-gnu-global-databases 'c-mode)
  (semanticdb-enable-gnu-global-databases 'c++-mode))
(set-default 'semantic-case-fold t)

(defun semantic-enable-other-helpers ()
  (semantic-idle-completions-mode 1)
  (semantic-idle-summary-mode 1)
  (semantic-idle-local-symbol-highlight-mode 1)
  (semantic-auto-parse-mode 1)
  (semantic-stickyfunc-mode 1)
  (semantic-mru-bookmark-mode 1)
  (semanticdb-minor-mode 1))

(defun lisp-semantic-hook ()
  (semantic-enable-other-helpers))

(defun c-like-semantic-hook ()
  (semantic-enable-other-helpers)
  (complete-instance-variables-and-methods)
  (when (cedet-gnu-global-version-check t)
    (semanticdb-enable-gnu-global-databases 'c-mode)
    (semanticdb-enable-gnu-global-databases 'c++-mode))
  (when (cedet-ectag-version-check)
    (semantic-load-enable-primary-exuberant-ctags-support)))

(add-hook 'c-mode-common-hook 'c-like-semantic-hook)


(setq
;;; semantic-displayor-tooltip-mode 'verbose
 ;;; semantic-complete-inline-analyzer-displayor-class      'semantic-displayor-traditional-with-focus-highlight
 ;;; semantic-complete-inline-analyzer-idle-displayor-class 'semantic-displayor-traditional-with-focus-highlight
;;; semantic-displayor-tooltip-initial-max-tags             5
;;; semantic-displayor-tooltip-max-tags                    25
;;; semantic-complete-inline-analyzer-displayor-class      'semantic-displayor-tooltip
;;; semantic-complete-inline-analyzer-idle-displayor-class 'semantic-displayor-tooltip

 semantic-completion-displayor-format-tag-function 'semantic-format-tag-concise-prototype
)


;; ecb
(setq stack-trace-on-error nil) ;WA for void-variable error
;;;(require 'ecb)

;;; (ede-cpp-root-project "DeitelCPlusPlus"
;;;                       :name "Deitel C++ Examples"
;;;                       :file "~/examples/cplusplus/Doxyfile"
;;;                       :system-include-path '("/usr/include"))
;;semantic key bindings

(defun DE-imply-includes-in-directory (dir)
  "Add all header files in DIR to `semanticdb-implied-include-tags'."
  (let ((files (directory-files dir t "^.+\\.h[hp]*$" t)))
    (defvar-mode-local c++-mode semanticdb-implied-include-tags
      (mapcar (lambda (header)
                (semantic-tag-new-include
                 header
                 nil
                 :filename header))
              files))))

;; customisation of modes
(defun manoj-cedet-hook ()
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  ;;
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (local-set-key (kbd "C-c <left>") 'semantic-tag-folding-fold-block)
  (local-set-key (kbd "C-c <right>") 'semantic-tag-folding-show-block)
  ;;  (define-key cedet-m3-mode-map "\C-cm" 'cedet-m3-menu-kbd)
  ;; (add-to-list 'ac-sources 'ac-source-semantic)
  )
;; (add-hook 'semantic-init-hooks 'alexott/cedet-hook)
(add-hook 'c-mode-common-hook 'manoj-cedet-hook)
(add-hook 'lisp-mode-hook 'manoj-cedet-hook)
(add-hook 'scheme-mode-hook 'manoj-cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'manoj-cedet-hook)
(add-hook 'erlang-mode-hook 'manoj-cedet-hook)

(setq
 add-log-keep-changes-together t
 add-log-version-info-enabled t
 change-log-version-info-enabled t
 )

;; We like to see more message history in the *Messages* buffer
;; than the default 50 lines.
(setq message-log-max 200)
;; Don't split large messages.
(setq message-send-mail-partially-limit nil)


;;
;; C
;;
(require 'hideshow)

(defun manoj-c-mode-cedet-hook ()
  ;; (local-set-key "." 'semantic-complete-self-insert)
  ;; (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-xt" 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref)
  (local-set-key (kbd "RET") 'newline-and-indent)
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "\C-c+" 'semantic-tag-folding-show-block)
  (local-set-key "\C-c-" 'semantic-tag-folding-fold-block)
  (local-set-key "\C-c\C-c+" 'semantic-tag-folding-show-all)
  (local-set-key "\C-c\C-c-" 'semantic-tag-folding-fold-all)
  ;; (add-to-list 'ac-sources 'ac-source-etags)
  ;; (add-to-list 'ac-sources 'ac-source-gtags)
  (linum-mode t)
  (semantic-mode t)
  (c-toggle-auto-newline 1)
  (c-toggle-hungry-state 1)
  (c-toggle-auto-newline 1)
  (hs-minor-mode 1)
  )

(autoload 'my-common-c-mode-hook-function "my-c-mode")
(add-hook 'c-mode-common-hook 'manoj-c-mode-cedet-hook)
(add-hook 'c-mode-common-hook
 	  (lambda () (subword-mode 1)))
(add-hook 'c-mode-common-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))
(subword-mode 1)
(which-function-mode 1)
(electric-indent-mode 1)
(electric-layout-mode 1)

(setq require-final-newline t)


(add-hook 'c++-mode-hook
          '(lambda ()
             (c-set-offset 'stream-op 'c-lineup-streamop)))

;;allow compile window to vanish if no errors.
(add-hook 'compilation-finish-functions
          (lambda (buf str)
            (if (string-match "exited abnormally" str)
                (next-error)
              ;;no errors, make the compilation window go away in a few seconds
              (run-at-time "2 sec" nil 'delete-windows-on
                           (get-buffer-create "*compilation*"))
              (message "No Compilation Errors!")
              )
            ))



(setq
 c-cleanup-list (list 'scope-operator 'list-close-comma 'empty-defun-braces
                      'defun-close-semi )
 c-hanging-braces-alist
 '((brace-list-open . (before after))
   (substatement-open . (before after))
   (block-open . (before after))
   (block-close . (before after))
   (brace-list-close . (before after))
   (defun-open . (before after))
   (defun-close . (before after))
   (class-open . (before after))
   (class-close . (before after))
   (inline-open . (before after))
   (inline-close . (before after))
   )
 c-offsets-alist '(
                   (statement . c-lineup-runin-statements)
                   (statement-cont . c-lineup-math)
                   (substatement-open . 1)
                   (arglist-close . c-lineup-arglist)
                   (substatement-open . 0)
                   (case-label        . 4)
                   (block-open        . 0)
                   (knr-argdecl-intro . -)
                   )
 c-hanging-colons-alist '((member-init-intro before)
                          (inher-intro)
                          (case-label after)
                          (label after)
                          (access-label after))
 arglist-close '(c-lineup-arglist-close-under-paren c-lineup-close-paren)
 arglist-cont-nonempty '(c-lineup-arglist)
 arglist-intro '(c-lineup-arglist-intro-after-paren)
 block-close  '(c-lineup-arglist-close-under-paren c-lineup-close-paren)
 brace-list-close  '(c-lineup-arglist-close-under-paren c-lineup-close-paren)
 brace-list-intro '(c-lineup-arglist-intro-after-paren)
 c '(c-lineup-C-comments)
 c-auto-newline t
 c-cleanup-list '(scope-operator list-close-comma defun-close-semi)
 c-default-style "gnu"
 c-electric-pound-behavior '(alignleft)
 c-hanging-colons-alist '((case-label .(after)) (label .(after)))
 class-close '(c-lineup-arglist-close-under-paren c-lineup-close-paren)
 comment-edged  t
 commen-intro '(c-lineup-comment)
 comment-multi-line t
 defun-block-intro '(c-lineup-arglist-intro-after-paren)
 defun-close  '(c-lineup-arglist-close-under-paren c-lineup-close-paren)
 elec-c-brace-on-same-line nil
 extern-lang-close  '(c-lineup-arglist-close-under-paren c-lineup-close-paren)
 func-decl-cont '(c-lineup-java-throws)
 inlambda '(c-lineup-inexpr-block)
 inexpr-statement '(c-lineup-inexpr-block)
 inexpr-class '(c-lineup-inexpr-block)
 inher-cont '(c-lineup-multi-inher c-lineup-java-inher)
 inline-close '(c-lineup-arglist-close-under-paren c-lineup-close-paren)
 member-init-cont '(c-lineup-multi-inher)
 namespace-close '(c-lineup-arglist-close-under-paren c-lineup-close-paren)
 statement-block-intro '(c-lineup-arglist-intro-after-paren)
 statement-case-intro '(c-lineup-arglist-intro-after-paren)
 statement-cont '(c-lineup-math)
 stream-op '(c-lineup-streamop)
 template-args-cont '(c-lineup-template-args)
 )

(setq
 skeleton-pair t
 cssm-indent-function 'cssm-c-style-indenter
 )


;;
;; Emacs lisp
;;

;; Add documentation of functions
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)

;; Automatically indents the new line.
(add-hook 'lisp-mode-hook
          '(lambda ()
             (local-set-key (kbd "RET") 'newline-and-indent)))
;;;     (define-key global-map (kbd "RET") 'newline-and-indent)
;;; (add-hook 'f90-mode-hook
;;;  (lambda () (local-set-key (kbd "RET") 'reindent-then-newline-and-indent)))

(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
;; advice
(setq ad-start-advice-on-load t)

;;
;; XSL keyboard aliases
;;
(defun get-value-from-minibuffer (display format-string)
  (let ((input (read-from-minibuffer display)))
    (if (string= input "")
        ""
      (format format-string input))))


;;-----------------------------------------------------------------------------
;; diff with associated file

(defun diff-buffer-with-associated-file ()
  "View the differences between BUFFER and its associated file.
This requires the external program \"diff\" to be in your `exec-path'."
  (interactive)
  (let ((buf-filename buffer-file-name)
        (buffer (current-buffer)))
    (unless buf-filename
      (error "Buffer %s has no associated file" buffer))
    (let ((diff-buf (get-buffer-create
                     (concat "*Assoc file diff: "
                             (buffer-name)
                             "*"))))
      (with-current-buffer diff-buf
        (setq buffer-read-only nil)
        (erase-buffer))
      (let ((tempfile (make-temp-file "buffer-to-file-diff-")))
        (unwind-protect
            (progn
              (with-current-buffer buffer
                (write-region (point-min) (point-max) tempfile nil 'nomessage))
              (if (zerop
                   (apply #'call-process "diff" nil diff-buf nil
                          (append
                           (when (and (boundp 'ediff-custom-diff-options)
                                      (stringp ediff-custom-diff-options))
                             (list ediff-custom-diff-options))
                           (list buf-filename tempfile))))
                  (message "No differences found")
                (progn
                  (with-current-buffer diff-buf
                    (goto-char (point-min))
                    (if (fboundp 'diff-mode)
                        (diff-mode)
                      (fundamental-mode)))
                  (display-buffer diff-buf))))
          (when (file-exists-p tempfile)
            (delete-file tempfile)))))
    nil))

;; When file is killed, remove associated diff buffer

(defun kill-associated-diff-buf ()
  "tidy up diffs when closing the file"
  (let ((buf (get-buffer (concat "*Assoc file diff: "
                                 (buffer-name)
                                 "*"))))
    (when (bufferp buf)
      (kill-buffer buf))))

(add-hook 'kill-buffer-hook 'kill-associated-diff-buf)

;; ediff:
;; (setq ediff-diff-options "--minimal -w")

;;
;; Setup for ediff.
;;
(require 'ediff)

(defvar ediff-after-quit-hooks nil
  "* Hooks to run after ediff or emerge is quit.")

(defadvice ediff-quit (after edit-after-quit-hooks activate)
  (run-hooks 'ediff-after-quit-hooks))

(setq git-mergetool-emacsclient-ediff-active nil)


(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; Useful for ediff merge from emacsclient.
(defun git-mergetool-emacsclient-ediff (local remote base merged)
  (setq git-mergetool-emacsclient-ediff-active t)
  (if (file-readable-p base)
      (ediff-merge-files-with-ancestor local remote base nil merged)
    (ediff-merge-files local remote nil merged))
  (recursive-edit))

(defun git-mergetool-emacsclient-ediff-after-quit-hook ()
  (exit-recursive-edit))

(add-hook 'ediff-after-quit-hooks 'git-mergetool-emacsclient-ediff-after-quit-hook 'append)



;;
;; CVS
;;
(setq
 cvs-diff-flags '("-u")
 cvs-program "/usr/bin/cvs"
 dvc-log-edit-other-frame (eq 'x  window-system)
 xgit-mail-notification-sign-off-p t
 xgit-use-index 'ask
 )

(autoload 'magit-status "magit" nil t)
;;; (eval-after-load "magit"
;;;   (progn
;;;     (set-face-attribute 'magit-diff-add nil
;;;                         :inherit 'diff-added)
;;;     (set-face-attribute 'magit-diff-del nil
;;;                         :inherit 'diff-removed)))

;; (require 'dvc-autoloads)

(setq same-window-buffer-names
      (append '("*Occur*")
              same-window-buffer-names))

;;; advice for yank and yank-pop to indent whatever they just
;;; pasted. This is useful if, for example, you copy some code from
;;; another file at a different indentation level than you want to
;;; paste it at. With these advice, the code will be indented properly
;;; relative to wherever you paste it.
(defadvice yank (after indent-region activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode
                                latex-mode plain-tex-mode))
      (let ((mark-even-if-inactive t))
        (indent-region (region-beginning) (region-end) nil))))

(defadvice yank-pop (after indent-region activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode
                                latex-mode plain-tex-mode))
      (let ((mark-even-if-inactive t))
        (indent-region (region-beginning) (region-end) nil))))

;;; Normally, if you kill a newline and the next line is indented, you
;;; will have to execute just-one-space or something similar to get
;;; rid of all the extra indentation. This will do that automatically
;;; for you, saving some time. I just rebind it to C-k, overriding
;;; kill-line, since this is almost always the behavior I want.

;;; (defun kill-and-join-forward (&optional arg)
;;;   "If at end of line, join with following; otherwise kill line.
;;;     Deletes whitespace at join."
;;;   (interactive "P")
;;;   (if (and (eolp) (not (bolp)))
;;;       (delete-indentation t)
;;;     (kill-line arg)))
;;; (global-set-key (kbd "C-k") 'kill-and-join-forward)

(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (delete-indentation t)
        )))




;;
;; bookmarks
(eval-when-compile (require 'bookmark))
(eval-after-load  "bookmark"
  '(progn
     (setq bookmark-default-file (concat my-emacs-var-dir "/bookmarks"))
     (if (not (equal (user-login-name) (user-real-login-name)))
         (setq bookmark-save-flag nil))))


(defun alt-clean-equal-signs ()
  "This function makes lines of = signs invisible."
  (goto-char (point-min))
  (let ((state buffer-read-only))
    (when state (setq buffer-read-only nil))
    (while (not (eobp))
      (search-forward-regexp "^=+$" nil 'move)
      (add-text-properties (match-beginning 0)
                           (match-end 0)
                           '(invisible t)))
    (when state (setq buffer-read-only t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; (setq appt-display-format 'popup)                                          ;;;
;;; (defvar zendisp "zenity --info --title='Appointment' ")                    ;;;
;;; (defun appt-display-message (string mins)                                  ;;;
;;;   "Display a reminder about an appointment.                                ;;;
;;; The string STRING describes the appointment, due in integer MINS minutes.  ;;;
;;; The format of the visible reminder is controlled by `appt-display-format'. ;;;
;;; The variable `appt-audible' controls the audible reminder."                ;;;
;;;   ;; let binding for backwards compatability. Remove when obsolete         ;;;
;;;   ;; vars appt-msg-window and appt-visible are dropped.                    ;;;
;;;   (let ((appt-display-format                                               ;;;
;;;          (if (eq appt-display-format 'ignore)                              ;;;
;;;              (cond (appt-display-format 'window)                           ;;;
;;;                    (appt-display-format 'echo))                            ;;;
;;;            appt-display-format)))                                          ;;;
;;;     (cond ((eq appt-display-format 'window)                                ;;;
;;;            (funcall appt-disp-window-function                              ;;;
;;;                     (number-to-string mins)                                ;;;
;;;                     ;; TODO - use calendar-month-abbrev-array rather       ;;;
;;;                     ;; than %b?                                            ;;;
;;;                     (format-time-string "%a %b %e " (current-time))        ;;;
;;;                     string)                                                ;;;
;;;            (run-at-time (format "%d sec" appt-display-duration)            ;;;
;;;                         nil                                                ;;;
;;;                         appt-delete-window-function))                      ;;;
;;;           ((eq appt-display-format 'echo)                                  ;;;
;;;            (message "%s" string))                                          ;;;
;;;           ((eq appt-display-format 'popup)                                 ;;;
;;;            (shell-command (concat zendisp                                  ;;;
;;;                                   " --text='"                              ;;;
;;;                                   string                                   ;;;
;;;                                   "'"                                      ;;;
;;;                                   )))                                      ;;;
;;;                                                                            ;;;
;;;           )                                                                ;;;
;;;     (if appt-audible (beep 1))))                                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(autoload 'icalendar-import-buffer "icalendar"
  "Import iCalendar data from current buffer" t)

;;;;;;;;;;;;;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;;;
;;; Printing
;;;

;; postscript
;;(setq ps-paper-type 'letter
;;      ps-header-font-size 10
;;      ps-print-color-p nil)
;; Use ps-print for printing.
;;(setq w3-use-ps-print nil)

(defvar have-color-printer-p t)
(setq ps-use-face-background t
      ps-always-build-face-reference t
      )
;;      (setq ps-bold-faces '(my-blue-face))
;;      (setq ps-italic-faces '(my-red-face))
;;      (setq ps-underlined-faces '(my-green-face))
(if have-color-printer-p
    (setq ps-print-color-p t)
  (setq ps-print-color-p 'black-white))

(require 'printing)
(if have-color-printer-p
    (progn
      (ps-extend-face '(default "grey10" "WhiteSmoke" nil) 'MERGE)
      (ps-extend-face '(region "blue3" "snow" nil) 'MERGE)
      (ps-extend-face '(scroll-bar "orchid" "OldLace" nil) 'MERGE)
      (ps-extend-face '(gnus-emphasis-highlight-words "black" "yellow" nil) 'MERGE)
      (ps-extend-face '(mode-line-inactive "grey30" "grey90" nil) 'MERGE)
      (ps-extend-face '(header-line "grey20" "grey90" italic strikeout) 'MERGE )
      (ps-extend-face '(highlight "darkolivegreen" "ivory" nil) 'MERGE)
      (ps-extend-face '(secondary-selection "MediumBlue" "honeydew" nil) 'MERGE)
      (ps-extend-face '(custom-rogue-face "maroon" "grey90" nil) 'MERGE)
      (ps-extend-face '(custom-modified-face "blue" "grey90" nil) 'MERGE)
      (ps-extend-face '(custom-set-face "DarkSlateBlue" "AliceBlue" nil) 'MERGE)
      (ps-extend-face '(custom-changed-face "Blue4" "AliceBlue" nil) 'MERGE)
      (ps-extend-face '(custom-modified-face "blue" "grey90" nil) 'MERGE)
      (ps-extend-face '(custom-comment-tag-face "grey10" "grey80" nil) 'MERGE)
      (ps-extend-face '(semantic-dirty-token-face "grey10" "grey90" nil) 'MERGE)
      (ps-extend-face '(ecb-directory-face "magenta" "LightCyan" nil) 'MERGE)
      (ps-extend-face '(ecb-source-face "magenta" "LightCyan" nil) 'MERGE)
      (ps-extend-face '(ecb-method-face "magenta" "LightCyan" nil) 'MERGE)
      (ps-extend-face '(ecb-history-face "magenta" "LightCyan" nil) 'MERGE)
      (ps-extend-face '(ecb-token-header-face "SeaGreen1" "LightCyan" nil) 'MERGE)
      (ps-extend-face '(ecb-type-token-group-face "DarkGreen" "grey90" nil) 'MERGE)
      (ps-extend-face '(show-paren-match-face "dark slate blue" "LemonChiffon" nil) 'MERGE)
      (ps-extend-face '(show-paren-mismatch-face "purple" "LemonChiffon" nil) 'MERGE)
      (ps-extend-face '(gnus-summary-cancelled-face "IndianRed" "GhostWhite" nil) 'MERGE)
      (ps-extend-face '(face-6 "pink" "cornsilk" nil) 'MERGE)
      (ps-extend-face '(face-7 "steelblue" "cornsilk" nil) 'MERGE)
      (ps-extend-face '(face-8 "lime green" "cornsilk" nil) 'MERGE)
      (ps-extend-face '(gnus-cite-face-1 "SaddleBrown3" "seashell" italic) 'MERGE)
      (ps-extend-face '(gnus-cite-face-2 "IndianRed" "seashell" italic bold) 'MERGE)
      (ps-extend-face '(gnus-cite-face-3 "DodgerBlue" "seashell" italic) 'MERGE)
      (ps-extend-face '(gnus-cite-face-4 "OrangeRed" "seashell" italic bold) 'MERGE)
      (ps-extend-face '(gnus-cite-face-5 "SteelBlue" "seashell" italic) 'MERGE)
      (ps-extend-face '(gnus-cite-face-6 "LimeGreen" "seashell" italic bold) 'MERGE)
      (ps-extend-face '(gnus-cite-face-7 "Tomato" "seashell" italic) 'MERGE)
      (ps-extend-face '(gnus-cite-face-8 "DarkGoldenrod4" "seashell" italic bold) 'MERGE)
      (ps-extend-face '(gnus-cite-face-9 "tan3" "seashell" italic) 'MERGE)
      (ps-extend-face '(gnus-cite-face-10 "DeepPink3" "seashell" italic bold) 'MERGE)
      (ps-extend-face '(gnus-cite-face-11 "FireBrick" "seashell" italic) 'MERGE)
      (ps-extend-face '(ediff-even-diff-face-B "salmon3" "seashell" nil) 'MERGE)
      (ps-extend-face '(ediff-even-diff-face-Ancestor "DarkOrchid3" "seashell" nil) 'MERGE)
      (ps-extend-face '(ediff-odd-diff-face-A "Purple4" "seashell" nil) 'MERGE)
      (ps-extend-face '(ediff-odd-diff-face-C "firebrick1" "seashell" nil) 'MERGE)
      (ps-extend-face '(cperl-array-face "navy" "seashell" nil) 'MERGE)
      ))
;; Code browsing
;;(require 'ecb-autoloads)




;;
;; Ange FTP
;;
;;(autoload 'ange-ftp-record-host                "my-ftp")
;;(setq ange-ftp-default-user "anonymous"
;;      ange-ftp-default-password user-mail-address
;;      ange-ftp-nslookup-program "nslookup"
;;      )

;;
;; Font Lock
;;
(setq font-lock-maximum-decoration t)
;;(add-hook 'font-lock-mode-hook 'turn-on-lazy-lock)
(global-font-lock-mode t)               ;Enable syntax highlighting.
(setq font-lock-global-modes '(not magit-mode w3m-mode speedbar-mode))

(setq  jit-lock-stealth-time nil
       jit-lock-stealth-nice 0.5
       jit-lock-stealth-verbose t
       jit-lock-defer-contextually t)

;; ===== Set the highlight current line minor mode =====

;; In every buffer, the line which contains the cursor will be fully
;; highlighted

;; (global-hl-line-mode 1)


;;
;; EUDC
;;
;; (eval-after-load
;;     "message"
;;   '(define-key message-mode-map [(control ?c) (tab)] 'eudc-expand-inline))
;; (eval-after-load
;;     "mail"
;;   '(define-key mail-mode-map [(control ?c) (tab)] 'eudc-expand-inline))
;;


;; ;;
;; ;; dmacro
;; ;;
;; (autoload 'setup-dmacro             "my-dmacro")
;; (autoload 'dm-set-latex-hooks       "my-dmacro")
;; (autoload 'dm-set-lisp-hooks        "my-dmacro")

;; (defvar dmacro-macro-dir (expand-file-name "~/etc/emacs/dmacro")
;;   "*Library where dmacro files are to be found.")
;; (setq  dmacro-macro-dir (expand-file-name "~/etc/emacs/dmacro"))
;; (add-hook 'TeX-mode-hook 'dm-set-latex-hooks)
;; (add-hook 'emacs-lisp-mode-hook 'dm-set-lisp-hooks)
;; (setup-dmacro)


;; Dynamic abbreviations
;;

;; ===== Automatically load abbreviations table =====

;; Note that emacs chooses, by default, the filename
;; "~/.abbrev_defs", so don't try to be too clever
;; by changing its name

(setq-default abbrev-mode t)
(read-abbrev-file "~/.abbrev_defs")
(setq save-abbrevs t)

(defvar loaded-my-abbrevs nil)
(setq
 dabbrev-abbrev-char-regexp "\\sw\\|\\s_"
 dabbrev-upcase-means-case-search t
 )




;;;
;;; uniquify
;;;
(setq
 uniquify-after-kill-buffer-p t
 uniquify-buffer-name-style   'post-forward-angle-brackets
 uniquify-ignore-buffers-re   "^\\*"
 )
(require 'uniquify)

(require 'sasl)
;;;
;;; News reading (most stuff is in the gnusrc file)

(setq
 gnus-home-directory         "~/etc/emacs/news"
 gnus-directory              "~/var/spool/news"
 message-directory           "~/var/spool/mail"
 gnus-startup-file           (concat gnus-home-directory "/newsrc")
 gnus-init-file              (concat gnus-home-directory "/gnusrc")
 news-directory              (concat gnus-directory      "/articles/")
 gnus-cache-directory        (concat gnus-directory      "/cache")
 gnus-agent-directory        (concat gnus-directory      "/agent")
 message-auto-save-directory (concat gnus-directory      "/drafts")
 nndraft-directory           (concat gnus-directory      "/drafts")
 gnus-dribble-directory      gnus-cache-directory
 nnml-directory              (concat gnus-directory      "/nnml/")
 nnmail-message-id-cache-file (concat gnus-cache-directory "/nnmail-cache")
 )

(setq gnus-startup-file-coding-system 'utf-8)
;;(add-hook 'gnus-startup-hook 'rfc2015-setup)
(add-hook 'mail-setup-hook 'bbdb-insinuate-sendmail)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
(setq x-face-mule-highlight-x-face-position 'x-face)
;;;
;;; mail
;;;
(autoload 'mailrc-reset                      "my-mail")
(autoload 'alias-check                       "my-mail")
(autoload 'mail-add-header                   "my-mail")
(autoload 'mail-remove-header                "my-mail")
(autoload 'mail-insert-cookie                "my-mail")
(autoload 'my-mail-setup-function            "my-mail")
(autoload 'my-message-setup-function         "my-mail")
(autoload 'setup-mailrc-hook                 "my-mail")
(autoload 'setup-compose-mime                "my-mail")
(autoload 'my-message-mode-hook-mail-aliases "my-bbdb")
(autoload 'insert-xfile                      "my-mail")

(setq message-subject-re-regexp "^[ \t]*\\(\\([Aa][Nn][Tt][Ww]\\.?\\|[Aa][Ww]\\|[Ff][Ww][Dd]?\\|[Oo][Dd][Pp]\\|[Rr][Ee]\\|[Rr][Éé][Ff]\\.?\\|[Ss][Vv]\\)\\(\\[[0-9]*\\]\\)*:[ \t]*\\)*[ \t]*")

; Don't include attachments in messages I Fcc
(setq message-fcc-externalize-attachments t)
(setq message-dont-reply-to-names
      (list
       "\\(emacs-pretest-bug\\|bug-gnu-emacs\\)@gnu\\.org"
       "\\(\\(submit\\|control\\|owner\\)@emacsbugs\\.\\|bug-submit-list@\\)donarmstrong\\.com"
       "srivasta@\\(ieee\\|acm\\|computer\\|debian\\)\\.org"
       "srivasta@golden-gryphon\\.com"
       "manoj\\.srivastava@stdc\\.com"
       ))
(setq message-wash-forwarded-subjects t)
;;(setq message-make-forward-subject-function 'message-forward-subject-fwd)

(eval-when-compile (require 'vm))
(defvar mail-personal-alias-file (expand-file-name "~/.mailrc")
  "* File where mail aliases are kept.")
(add-hook 'write-file-hooks 'alias-check)
;;(add-hook 'message-send-hook 'insert-xfile)
(setq-default mail-signature t)
(setq mm-inline-text-html-with-images t)

(require 'mm-util)                      ;for sneding mail
(require 'sendmail)                     ;for mail-header-end
;(setq message-required-news-headers (nconc message-required-news-headers
;                                          (list '(X-Face . x-face-insert))))
(when (boundp 'message-required-headers)
  (setq message-required-headers
        (remove '(Face . my-gnus-random-face)
                message-required-headers)))
(eval-after-load "message"
  '(setq message-required-headers
         (nconc message-required-headers
                '((Face . my-gnus-random-face)))))

;; (setq message-required-news-headers
;;      (nconc message-required-news-headers
;;             (list '(X-Face . (lambda ()
;;                                (gnus-x-face-from-file
;;                                 "~/My-face.gif"))))))

(require 'message)
(require 'gnus-msg)
;;(require 'gnus-load)

(require 'gnus-dired)
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)
(define-key dired-mode-map "a" 'gnus-dired-attach)


(require 'hashcash)
(add-hook 'message-send-hook 'mail-add-payment)
(setq message-generate-hashcash 'opppurtunistic)
(setq hashcash-default-payment 25)
;(setq message-sendmail-envelope-from 'header)


(define-mail-user-agent 'gnus-user-agent
  'gnus-mail 'message-send-and-exit
  'message-kill-buffer 'message-send-hook)


(defun gnus-mail (&rest args)
  "Start editing a mail message to be sent gnus style.
  Use message mode as the underlying agent."
  ; (unless (and (fboundp 'gnus-alive-p) (gnus-alive-p))
  ;   (gnus-no-server)
  ;   (gnus-group-suspend))
  (gnus-setup-message 'message (apply 'message-mail args)))

;;; message-tab-body-function may be indent-relative, tab-to-tab-stop,
;;; or indent-for-tab-command

(setq
 mhl-formfile t
 mh-recursive-folders t
 vm-folder-directory my-mail-dir
 mail-self-blind t
 mail-user-agent 'gnus-user-agent
 message-directory my-mail-dir
 message-signature-before-forwarded-message nil
 message-from-style 'default
 ;; message-tab-body-function 'indent-for-tab-command
 message-tab-body-function 'tab-to-tab-stop
 message-x-body-function 'tab-to-tab-stop
 initialized-mail-send nil
 send-mail-function 'message-send-mail
 message-mail-alias-type 'ecomplete
 my-mail-dir (concat real-home-directory "/mail")
 my-log-directory (concat real-home-directory "/var/log")
 signature-insert-at-eof t
 ;; signature-delete-blank-lines-at-eof t
 ;; mc-pgp-alternate-keyring "/usr/local/lib/pubkring.pgp"
 mc-encrypt-for-me t
 mc-pgp-fetch-keyring-list '("/usr/local/lib/pubkring.pgp")
 mail-source-directory (concat real-home-directory "/var/tmp")
 mail-source-delete-incoming 1
 message-directory (concat real-home-directory "/mail")
 mime-ignore-preceding-spaces t
 mime-ignore-trailing-spaces t
 mime-setup-use-sc t
 mime-signature-file (concat real-home-directory "~/etc/mail/signature")
 vm-highlighted-header-face 'font-lock-function-name-face
 vm-init-file (concat real-home-directory "/etc/emacs/vm-config.el")
 vm-options-file (concat real-home-directory "/etc/emacs/vm.options")
 vm-popup-menu-on-mouse-3 t
 vm-window-configuration-file (concat real-home-directory "/etc/emacs/vm.windows")
 vm-summary-highlight-face 'font-lock-function-name-face
 vm-highlight-url-face 'font-lock-comment-face
 )

;;; verify hostnames and errors
(setq gnutls-verify-error t)
;;; '((".*\\.gmail.com" . (:verify-hostname-error t :verify-error t))
;;;  (".*\\.yahoo.com" . t) ; everything
;;;  (".*" . nil)) ; nothing

;;; Argh. we still do not preset client certs. fall back to external means
(if (fboundp 'gnutls-available-p)
    (fmakunbound 'gnutls-available-p))

(if (file-exists-p
     (concat real-home-directory "/etc/emacs/config/Manoj.pem"))
    (setq tls-program
          '(
            (concat
             "openssl s_client -connect %h:%p -no_ssl2 -ign_eof -CAfile "
             real-home-directory
             "/etc/emacs/config/spi_ca.pem -cert "
             real-home-directory
             "/etc/emacs/config/Manoj.pem  -p %p %h")
            (concat "gnutls-cli --priority secure256 --x509cafile "
                    real-home-directory
                    "/etc/emacs/config/spi_ca.pem --x509certfile "
                    real-home-directory
                    "/etc/emacs/config/Manoj.pem  -p %p %h")))
  (setq tls-program
        '(
          "gnutls-cli --priority secure256 -p %p %h"
          "gnutls-cli --insecure -p %p %h"
          "gnutls-cli --insecure -p %p %h --protocols ssl3"
          "openssl s_client -connect %h:%p -no_ssl2 -ign_eof"
          )))
(require 'gnutls)

;;; (setq tls-program
;;;       '(
;;;         "gnutls-cli -p %p %h"
;;;         "gnutls-cli -p %p %h --protocols ssl3"
;;;         "openssl s_client -connect %h:%p -no_ssl2 -ign_eof"
;;;         (concat
;;;          "gnutls-cli --priority SECURE256 --kx DHE-DSS DHE-RSA"
;;;          "  -p %p --x509cafile" real-home-directory  "/certs/certs.pem %h"
;;;         )

;; If you are using message-mode to compose and send mail, feedmail will
;; probably work fine with that (someone else tested it and told me it worked).
;; Follow the directions above, but make these adjustments instead:
;;
;; (setq
;;  feedmail-confirm-outgoin 'immediate
;;  message-send-mail-function 'feedmail-send-it
;;  send-mail-function 'message-send-mail
;;  feedmail-buffer-eating-function 'feedmail-buffer-to-sendmail
;;  feedmail-nuke-bcc nil
;;  feedmail-nuke-resent-bcc nil
;;  )
;; (add-hook 'message-mail-send-hook 'feedmail-mail-send-hook-splitter)

;; To use smtp auth
(setq send-mail-function 'smtpmail-send-it) ; if you use `mail'
(setq message-send-mail-function 'smtpmail-send-it) ; if you use message/Gnus
(setq smtpmail-default-smtp-server "localhost")
(setq smtpmail-local-domain "internal.golden-gryphon.com")
(setq smtpmail-sendto-domain "golden-gryphon.com")
;;(setq smtpmail-debug-info t) ; only to debug problems
;;(setq smtpmail-auth-credentials  ; or use ~/.authinfo
;;      '(("YOUR SMTP HOST" 25 "username" "password")))
;;(setq smtpmail-starttls-credentials
;;      '(("YOUR SMTP HOST" 25 "~/.my_smtp_tls.key" "~/.my_smtp_tls.cert")))

;; (require 'message-x)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun my-gnus-insert-special-ml-headers-maybe ()                     ;;
;;   (when (save-excursion                                               ;;
;;           (set-buffer (gnus-summary-buffer-name gnus-newsgroup-name)) ;;
;;           gnus-mailing-list-mode)                                     ;;
;;     (message-add-header (concat "Mail-Followup-To: "                  ;;
;;                                 (gnus-group-get-parameter             ;;
;;                                  gnus-newsgroup-name 'to-list))       ;;
;;                         "Mail-Copies-To: never")))                    ;;
;;                                                                       ;;
;; (add-hook 'message-setup-hook                                         ;;
;;           'my-gnus-insert-special-ml-headers-maybe)                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq sendmail-coding-system 'utf-8)
(setq mime-editor/split-message nil)
(add-hook 'mail-setup-hook 'mail-abbrevs-setup)
(add-hook 'message-setup-hook 'mail-abbrevs-setup)
(add-hook 'message-setup-hook
          (lambda nil
            (if (fboundp 'mail-aliases-setup)
                (mail-aliases-setup))))

(add-hook 'mail-setup-hook 'bbdb-define-all-aliases)
(add-hook 'message-setup-hook 'bbdb-define-all-aliases)

(add-hook 'mail-setup-hook 'my-mail-setup-function)
(add-hook 'message-setup-hook 'my-message-setup-function)

(add-hook 'message-mode-hook 'my-message-mode-hook-mail-aliases)
(add-hook 'mail-mode-hook 'my-message-mode-hook-mail-aliases)

(add-hook 'message-header-hook 'canlock-insert-header t)

;; Sign messages by default.
(add-hook 'message-setup-hook 'mml-secure-message-sign-pgpmime)

;(add-hook 'mail-send-hook 'bbdb/sendmail-update-records)
;(add-hook 'message-send-hook 'bbdb/sendmail-update-records)

;(add-hook 'mh-show-mode-hook 'goto-address-mode)
;(add-hook 'rmail-show-message-hook 'goto-address-mode)

; don't use add-hook since we are overriding the default hook.
(setq
 message-citation-line-function 'message-insert-formatted-citation-line
 )

;;; Mail-Followup-To headersqqq
(setq message-subscribed-regexps
      '(
        ".*@lists\\.debian\\.org"
        ".*@lists\\.debconf\\.org"
        ".*@lists\\.allioth\\.debian\\.org"
        ".*@lists\\.sourceforge\\.net"
        ".*@lists\\.madduck\\.net"
        ".*@lists\\.math\\.uh\\.edu"
        ".*@linuxlists\\.org"
        "selinux@tycho\\.nsa\\.gov"
        "tangram.*@boozallenet\\.com"
        ;;         "\\(ding@gnus\\)\\|\\(.*@lists\\.debian\\)\\.org"
        ))

;; (setq message-subscribed-address-functions
;;       '(gnus-find-subscribed-addresses))

(setq message-use-followup-to 'use)

;;; add cookie
(add-hook 'mail-setup-hook 'mail-insert-cookie)
(add-hook 'message-setup-hook 'mail-insert-cookie)


;; Log all mail
(autoload 'log-mail-function "log-mail")
(autoload 'log-message-function "log-mail")

(add-hook 'mail-send-hook 'log-mail-function);
(add-hook 'message-send-hook 'log-message-function)

                     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                     ;;; Email signing and encryption ;;;
                     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq mml2015-use 'epg)
;; mml2015-signers

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq user-id-to-key-id-alist                                         ;;
;;        '(("[EMAIL PROTECTED]" "9283AA3F")))                           ;;
;;                                                                       ;;
;; (add-hook 'message-send-hook                                          ;;
;;          (lambda ()                                                   ;;
;;            (let ((entry (assoc (cadr (mail-extract-address-components ;;
;;                                       (message-field-value "from")))  ;;
;;                                user-id-to-key-id-alist)))             ;;
;;              (if entry                                                ;;
;;                  (setq mml2015-signers (cdr entry))))))               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(require 'epa)
(require 'epa-dired)
(require 'epa-file)
(require 'epg-config)
(epa-file-enable)


(setq
 epg-user-id "C5779A1C"
 mml2015-signers '("C5779A1C")

 mm-decrypt-option 'never
 mm-verify-option 'never

 mml-secure-cache-passphrase t
 mml-secure-passphrase-cache-expiry 36000
 mml-secure-verbose t

 mml2015-always-trust nil
 mml2015-cache-passphrase t
 mml2015-encrypt-to-self t
 mml2015-passphrase-cache-expiry '36000
 mml2015-sign-with-sender t
 mml2015-use 'epg
 mml2015-verbose t

 gnus-message-replyencrypt t
 gnus-message-replysign t
 gnus-message-replysignencrypted t
 gnus-treat-x-pgp-sig 'head
 gnus-buttonized-mime-types
 '(
   "multipart/signed"
   "multipart/encrypted"
   "multipart/alternative"
   )
 mm-discouraged-alternatives '("text/html" "text/richtext")

 mml-default-sign-method "pgpmime"
 mml-default-encrypt-method "pgpmime"
)

(define-key message-mode-map [f7] 'mml-secure-sign-pgpmime)
(define-key message-mode-map [f8] 'mml-secure-encrypt-pgpmime)
(setq
 crypt-confirm-password t
 crypt-encoded-disable-auto-save t
 crypt-no-extension-implies-plain t
 crypt-encryption-type 'gpg
 crypt-encryption-file-extension "\\(\\.gpg\\)$"
 ;      crypt-ignored-filenames ... ; this could be useful
 )

(add-hook
 'mail-setup-hook
 '(lambda ()
    (substitute-key-definition
     'end-of-buffer 'mail-abbrev-end-of-buffer
     mail-mode-map global-map)
    ))
;;
;; gpg
;;
(setq
 gpg-command-program "gpg2"
 )

;;; What vertsion of gpg/pgp to use? For Xemacs only
; (cond ((locate-file "gpg" exec-path)
;        (setq mc-default-scheme 'mc-scheme-gpg))
;       ((locate-file "pgpe" exec-path)
;        (setq mc-default-scheme 'mc-scheme-pgp5))
;       ((locate-file "pgp" exec-path)
;        (setq mc-default-scheme 'mc-scheme-pgp))
;       )
;; We promote gpg!!
;;(mc-setversion "gpg"); for gpg (default); also "5.0" and "2.6"


;;(require 'crypt++)
;;(modify-coding-system-alist 'file "\\.gpg\\'" 'no-conversion)
;;(modify-coding-system-alist 'file "\\.gz\\'" 'no-conversion)
;;(modify-coding-system-alist 'file "\\.Z\\'" 'no-conversion)
;;(modify-coding-system-alist 'file "\\.bz\\'" 'no-conversion)
;;(modify-coding-system-alist 'file "\\.bz2\\'" 'no-conversion)
(defun nxml-custom-keybindings ()
  (define-key nxml-mode-map "\C-c\C-c" 'nxml-complete)
  )
(defun nxml-reset-indent-line-function ()
  (setq indent-line-function 'nxml-indent-line))
(add-hook 'nxml-mode-hook 'nxml-custom-keybindings)
(add-hook 'nxml-mode-hook 'nxml-reset-indent-line-function)

(setq
 nxml-child-indent 2
 nxml-outline-child-indent 2
 nxml-slash-auto-complete-flag t
 nxml-auto-insert-xml-declaration-flag t
 )
(setq magic-mode-alist
      (cons '("<＼＼?xml " . nxml-mode)
            magic-mode-alist))
(fset 'xml-mode 'nxml-mode)
(fset 'html-mode 'nxml-mode)
;;;(add-to-list 'flyspell-prog-text-faces 'nxml-text-face)


(defun nxml-where ()
  "Display the hierarchy of XML elements the point is on as a path."
  (interactive)
  (let ((path nil))
    (save-excursion
      (save-restriction
        (widen)
        (while (and (< (point-min) (point)) ;; Doesn't error if point is at beginning of buffer
                    (condition-case nil
                        (progn
                          (nxml-backward-up-element) ; always returns nil
                          t)
                      (error nil)))
          (setq path (cons (xmltok-start-tag-local-name) path)))
        (if (called-interactively-p t)
            (message "/%s" (mapconcat 'identity path "/"))
          (format "/%s" (mapconcat 'identity path "/")))))))
;;--
;; Load nxml-mode for files ending in .xml, .xsl, .rng, .xhtml
;;--
(setq auto-mode-alist
      (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
            auto-mode-alist))

;;(while (rassoc 'html-mode  auto-mode-alist)
;;  (setcdr (rassoc 'html-mode  auto-mode-alist) 'sgml-html-mode))
;; (defalias 'html-mode 'sgml-html-mode)

(setq-default sgml-indent-data t)
(setq
 sgml-always-quote-attributes t
 sgml-auto-insert-required-elements t
 sgml-auto-activate-dtd t
 sgml-data-directory "/usr/share/sgml/declaration/"
 sgml-indent-data t
 sgml-indent-step             2
 sgml-minimize-attributes     nil
 sgml-omittag                 nil
 sgml-shortag                 nil
 sgml-custom-markup
 '(("Version1" "<![%Version1[\r]]>")
   ("New page"  "<?NewPage>"))
 sgml-xml-declaration "/usr/share/sgml/declaration/xml.dcl"
 sgml-display-char-list-filename "/usr/share/sgml/charsets/iso88591.map"
 sgml-live-element-indicator t
 sgml-public-map '("%S"  "/usr/share/sgml/%S" "/usr/share/sgml/%o/%c/%d"
                   "/usr/local/lib/sgml/%o/%c/%d")
 sgml-system-path '("/usr/share/sgml" "/usr/share/sgml/cdtd"
                    "/usr/local/lib/sgml")
 sgml-tag-region-if-active t

 )
(setq-default sgml-use-text-properties t)
(setq-default sgml-markup-faces
              '((start-tag . font-lock-keyword-face)
                (end-tag . font-lock-keyword-face)
                (ignored . font-lock-string-face)
                (ms-start . font-lock-constant-face)
                (ms-end . font-lock-constant-face)
                (shortref . bold)
                (entity . font-lock-type-face)
                (comment . font-lock-comment-face)
                (pi . font-lock-builtin-face)
                (sgml . font-lock-function-name-face)
                (doctype . font-lock-variable-name-face)))
(eval-after-load "psgml"
  '(lambda ()
     (if (boundp 'global-font-lock-mode)
         (if global-font-lock-mode
             (setq-default sgml-set-face t)
           (setq-default sgml-set-face nil))
       (setq-default sgml-set-face (eq 'x  window-system)))

     (when (default-value 'sgml-set-face)
       (require 'font-lock))
     ;; Lots of overlays in a buffer is bad news since they have to
     ;; be relocated on changes, with typically quadratic
     ;; behaviour.
     ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                          DIRED stuff                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'dired-x)
(require 'wdired)
(setq wdired-allow-to-change-permissions 'advanced)
(autoload 'wdired-change-to-wdired-mode "wdired")
(add-hook 'dired-load-hook
          '(lambda ()
             (define-key dired-mode-map (kbd "r") 'wdired-change-to-wdired-mode)
             (define-key dired-mode-map
               [menu-bar immediate wdired-change-to-wdired-mode]
               '("Edit File Names" . wdired-change-to-wdired-mode))))
(setq wdired-allow-to-change-permissions t)

;;; A better buffer-menu; with dired like functionality in the buffer
(require 'ibuffer)
(setq ibuffer-default-sorting-mode 'major-mode)
(setq ibuffer-always-show-last-buffer t)
(setq ibuffer-view-ibuffer t)
(global-set-key  (kbd "C-x C-b")        'ibuffer-other-window)





(add-hook 'nroff-mode-hook
          '(lambda ()
             (flyspell-mode 1)))
;;
;; Environement Variables
;;
(or (getenv "ORGANIZATION")
    (getenv "ORGANISATION")
    (setenv "ORGANIZATION" mail-organization-header))
(or (getenv "PILGRIMTOP")
    (setenv "PILGRIMTOP"   "/usr/local/src/")
    )
(setq
 env::DOMAIN            (getenv "DOMAIN")
 env::HOSTTYPE  (getenv "HOSTTYPE")
 env::SYSTEM            (getenv "SYSTEM")
 env::HOME              (getenv "HOME")
 env::SHELL             (getenv "SHELL")
 env::TERM              (getenv "TERM")
 env::CVSROOT         (getenv "CVSROOT")
 env::ORGANIZATION    (getenv "ORGANIZATION")
 env::PILGRIMTOP      (getenv "PILGRIMTOP")
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (defun show-available-image-types ()
;;   (interactive)
;;   (message "%s"
;;         (mapconcat 'identity
;;                    (list
;;                     (and (image-type-available-p 'jpeg) "JPEG")
;;                     (and (image-type-available-p 'gif) "GIF")
;;                     (and (image-type-available-p 'tiff) "TIFF")
;;                     (and (image-type-available-p 'png) "PNG")
;;                     (and (image-type-available-p 'xpm) "XPM")
;;                     (and (image-type-available-p 'pbm) "PBM")
;;                     (and (image-type-available-p 'xbm) "XBM"))
;;                    " ")))

(setq display-time-24hr-format t
      display-time-use-mail-icon t
      )

;; ========== Enable Line and Column Numbering ==========
(line-number-mode t)            ; show line numbers
(column-number-mode t)          ; show columns
(size-indication-mode t)        ; show file size (emacs 22+)
(auto-compression-mode t)       ; automatically (un)compress files

(if (eq window-system 'x)
    (setq frame-auto-hide-function 'delete-frame))

;;;(if (require 'sml-modeline nil 'noerror)    ;; use sml-modeline if available
;;;    (progn (sml-modeline-mode 1)))           ;; show buffer pos in the mode line

;;; Whether `display-buffer' should make a separate frame.
(add-to-list
 'display-buffer-alist
 '("\\`\\*Help\\*\\'" . ; make *Help* pop up in a new frame when not already displayed
   ((display-buffer-reuse-window display-buffer-pop-up-frame) .
    ((reusable-frames . t)))))
(add-to-list
 'display-buffer-alist
 '("\\*\\(shell\\|unsent mail\\|mail\\|inferior-lisp\\|ielm\\)\\*" .
   ((display-buffer-reuse-window display-buffer-pop-up-frame) .
    ((reusable-frames . t)))))

(setq
 ;; pop-up-frames 'graphic-only
 display-buffer-fallback-alist
 '("\\*\\(shell\\|unsent mail\\|mail\\|inferior-lisp\\|ielm\\)\\*"
   (display-buffer-method reuse-window same-frame)
   (reuse-window-window same))
 )

;; user@machine:file-name
;;; (setq-default
;;;  frame-title-format
;;;  '(:eval
;;;    (format "%s@%s:%s"
;;;            (or (file-remote-p default-directory 'user) user-login-name)
;;;            (or (file-remote-p default-directory 'host) system-name)
;;;            (file-name-nondirectory (or (buffer-file-name) default-directory)))))

; Frame title bar formatting to show full path of file
(setq-default
 frame-title-format
 (list
  '((buffer-file-name
     " %f" (dired-directory
            dired-directory
            (revert-buffer-function
             " %b" ("%b - Dir:  " default-directory)))))))

(setq-default
 icon-title-format
 (list
  '((buffer-file-name " %f" (dired-directory
                             dired-directory
                             (revert-buffer-function
                              " %b"  ("%b - Dir:  " default-directory)))))))

(setq
 ;; no messages
 inhibit-startup-message nil
 inhibit-startup-echo-area-message (user-real-login-name)
 ;; don't inform about garbage
 garbage-collection-messages nil
 ;; disable beep
 visible-bell t
 ;; paste where cursor is, not pointer
 mouse-yank-at-point nil
 ;; recursive minibuffers
 enable-recursive-minibuffers t
 minibuffer-scroll-window     t
 ;; do not add more lines when past end of the file
 next-line-add-newlines nil
 ;; Have emacs keep lots in the *Messages* buffer
 message-log-max 1024
 ;;; '(multiple-frames "%b"
 ;;;       ("" invocation-name "@" system-name))
 )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq
 ido-everywhere         t
 ido-max-directory-size 100000
 )
(require 'ido)
(ido-mode t)
(setq
 ido-ignore-buffers ;; ignore these guys
 '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
   "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
 ;;; iDO becomes very hectic when creating a new file. If you don't
 ;;; type the new file name fast enough, it searches for existing
 ;;; files in other directories with the same name and opens them
 ;;; instead. The following setting disables that feature.
 ido-auto-merge-work-directories-length -1

 ido-case-fold  t                 ; be case-insensitive
 ido-enable-last-directory-history t ; remember last used dirs
 ido-max-work-directory-list 30   ; should be enough
 ido-max-work-file-list      50   ; remember many
;; ido-use-filename-at-point nil    ; don't use filename at point (annoying)
;; ido-use-url-at-point nil         ; don't use url at point (annoying)
 ido-enable-flex-matching nil     ; don't try to be too smart
 ido-max-prospects 8              ; don't spam my minibuffer
 ido-use-virtual-buffers 'auto
 )

;; when using ido, the confirmation is rather annoying...
(setq confirm-nonexistent-file-or-buffer nil)

;;; Completion in the mini buffer
(setq  completion-styles '(partial-completion))
(setq completion-word-extra-chars '(" " "-"))
;; Loading this package implements a more fine-grained minibuffer
;; completion feedback scheme.  Prospective completions are concisely
;; indicated within the minibuffer itself, with each successive
;; keystroke.
(require 'icomplete)
(icomplete-mode 1)

(require 'table)
(add-hook 'text-mode-hook 'table-recognize)

;; Align command !!!

;; from http://stackoverflow.com/questions/3633120/emacs-hotkey-to-align-equal-signs
;; another information: https://gist.github.com/700416
;; use rx function http://www.emacswiki.org/emacs/rx
(defun align-to-colon (begin end)
  "Align region to colon (:) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ":") 1 1 ))

(defun align-to-comma (begin end)
  "Align region to comma signs"
  (interactive "r")
  (align-regexp begin end
                (rx "," (group (zero-or-more (syntax whitespace))) ) 1 1 ))


(defun align-to-equals (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) "=") 1 1 ))

(defun align-to-hash (begin end)
  "Align region to hash ( => ) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) "=>") 1 1 ))

;; work with this
(defun align-to-comma-before (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ",") 1 1 ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs-goodies
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; (require 'align-string)
;;; (require 'ff-paths)
;;; (ff-paths-install)
;;; (require 'highlight-beyond-fill-column)
;;; ;; (require 'highlight-completion)
;;; ;; (highlight-completion-mode 1)
;;; (require 'htmlize)
;;; (require 'pack-windows)
;;; (require 'perldoc)
;;; (require 'setnu)

(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))
(autoload 'ascii-on        "ascii" "Turn on ASCII code display."   t)
(autoload 'ascii-off       "ascii" "Turn off ASCII code display."  t)
(autoload 'ascii-display   "ascii" "Toggle ASCII code display."    t)
(autoload 'ascii-customize "ascii" "Customize ASCII code display." t)
(autoload 'cfengine-mode "cfengine" "" t nil)
(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode"
  "Major mode for editing comma-separated value files." t)
(defun my-activate-ctypes () (require 'ctypes))
(add-hook 'c-mode-hook 'my-activate-ctypes)
(add-hook 'c++-mode-hook 'my-activate-ctypes)

(autoload 'map-lines "map-lines"
  "Map COMMAND over lines matching REGEX."
  t)
(autoload 'sys-apropos "sys-apropos" nil t)
(autoload 'tld "tld" "Perform a TLD lookup" t)
(autoload 'todoo "todoo" "TODO Mode" t)
(add-to-list 'auto-mode-alist '("TODO$" . todoo-mode))
(autoload 'toggle-option "toggle-option"
  "Easily toggle frequently toggled options." t)
(autoload 'underline-hat "under" "Underline the region" t)
(autoload 'xrdb-mode "xrdb-mode" "Mode for editing X resource files" t)
(setq auto-mode-alist
      (append '(("\\.Xdefaults$"    . xrdb-mode)
                ("\\.Xenvironment$" . xrdb-mode)
                ("\\.Xresources$"   . xrdb-mode)
                ("*.\\.ad$"         . xrdb-mode)
                )
              auto-mode-alist))


(require 'apt-sources nil 'noerror)
(require 'apt-utils nil 'noerror) ;;; apt-utils-show-package
(require 'debian-bug nil 'noerror)
(require 'debian-el nil 'noerror)
(require 'my-irc)

(autoload 'deb-find            "deb-view" "Debian Archive File Finder" t)
(autoload 'deb-view-mode       "deb-view" "Debian Archive File Mode" t)
(autoload 'deb-view            "deb-view" "Debian Archive File Viewer" t)
(autoload 'deb-view-dired-view "deb-view" "Debian Archive File Viewer" t)
(setq auto-mode-alist (append '(("\\.deb$" . deb-view-mode)) auto-mode-alist))
(define-key dired-mode-map     "\C-d"     'deb-view-dired-view)


;; If you want Emacs to defer loading the JDE until you open a
;; Java file,
(setq defer-loading-jde t)
(setq jde-enable-abbrev-mode t)
(setq jde-jdk-registry
      '(("1.5.0" . "/usr/lib/jvm/java-1.5.0-sun")
        ("1.6.0" . "/usr/lib/jvm/java-6-sun"))
      jde-jdk '("1.6.0")
      )

(if defer-loading-jde
    (progn
      (autoload 'jde-mode "jde" "JDE mode." t)
      (setq interpreter-mode-alist
            (cons '("java" . java-mode)
                  interpreter-mode-alist))
      (setq auto-mode-alist
            (append
             '(("\\.java\\'" . jde-mode))
             auto-mode-alist)))
  (require 'jde))


;; Sets the basic indentation for Java source files
;; to two spaces.
(defun my-jde-mode-hook ()
  ;;don't indent braces
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'statement-case-open 0)
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'case-label '+)
  (setq tab-width 4
        c-auto-newline t
        ;; make sure spaces are used instead of tabs
        indent-tabs-mode nil)
  (eval-after-load "cc-vars" '(setq c-basic-offset 2)))

(add-hook 'jde-mode-hook 'my-jde-mode-hook)

(if (and (not (featurep 'xemacs))
         window-system
         (>= emacs-major-version 20))
    (display-time-mode 1) ; show time
  )



 ;;; If language-environment is Devanagari, then select
 ;;; devanagari-itrans as input method

;;  (defun my-devanagari-setup ()
;;    "Set up my private Devanagari environment."
;;    (if (equal current-language-environment "Devanagari")
;;        (setq default-input-method "devanagari-itrans")))
;;  (add-hook 'set-language-environment-hook 'my-devanagari-setup)
;;  ;;; to see malayalam
;;  (if (eq 'x window-system)
;;      (let ((fontset (query-fontset (frame-parameter nil 'font))))
;;        (when (not fontset)
;;      (setq fontset "fontset-default")
;;      (set-default-font fontset))
;;        (set-fontset-font fontset
;;                      (cons (decode-char 'ucs #x0D00)
;;                            (decode-char 'ucs #x0D7f))
;;                      (cons "misc-malayalam" "iso10646-1"))))


;; Setup cdac fonts to be the ones we use for devanagari
;;(load-library "quail/indian")
;;(set-fontset-font
;; "fontset-standard"
;; (cons (decode-char 'ucs ?\x0900) (decode-char 'ucs ?\x097F))
;; "-freetype-untitled-medium-r-normal--33-240-100-100-p-163-iso10646.indian-1")
;;(set-fontset-font
;; "fontset-standard"
;; (cons (indian-glyph-char 0 'devanagari) (indian-glyph-char 255 'devanagari))
;; "-freetype-dv ttsuresh-medium-r-normal-33-240-100-100-p-119-devanagari-cdac")


;;(set-fontset-font
;; "fontset-default"
;; (cons (decode-char 'ucs ?\x0900) (decode-char 'ucs ?\x097F))
;; "-freetype-untitled-medium-r-normal--33-240-100-100-p-163-iso10646.indian-1")
;;(set-fontset-font
;; "fontset-default"
;; (cons (indian-glyph-char 0 'devanagari) (indian-glyph-char 255 'devanagari))
;; "-freetype-dv ttsuresh-medium-r-normal-33-240-100-100-p-119-devanagari-cdac")

;;(set-fontset-font
;; "fontset-startup"
;; (cons (decode-char 'ucs ?\x0900) (decode-char 'ucs ?\x097F))
;; "-freetype-untitled-medium-r-normal--33-240-100-100-p-163-iso10646.indian-1")
;;(set-fontset-font
;; "fontset-startup"
;; (cons (indian-glyph-char 0 'devanagari) (indian-glyph-char 255 'devanagari))
;; "-freetype-dv ttsuresh-medium-r-normal-33-240-100-100-p-119-devanagari-cdac")



;; (set-fontset-font "fontset-default"
;;                (cons (decode-char 'ucs ?\x0900)
;;                      (decode-char 'ucs ?\x097f))
;;                "Lohit Hindi-10")
;; (set-fontset-font "fontset-startup"
;;                (cons (decode-char 'ucs ?\x0900)
;;                      (decode-char 'ucs ?\x097f))
;;                "Lohit Hindi-10")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (set-fontset-font                                                              ;;
;;  "fontset-default"                                                             ;;
;;  (cons (decode-char 'ucs ?\x0900) (decode-char 'ucs ?\x097f))                  ;;
;;  "-freetype-dv ttsuresh-medium-r-normal-33-240-100-100-p-119-devanagari-cdac") ;;
;;                                                                                ;;
;; (set-fontset-font                                                              ;;
;;  "fontset-startup"                                                             ;;
;;  (cons (decode-char 'ucs ?\x0900) (decode-char 'ucs ?\x097f))                  ;;
;;  "-freetype-dv ttsuresh-medium-r-normal-33-240-100-100-p-119-devanagari-cdac") ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq ps-multibyte-buffer 'bdf-font-except-latin)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                           BBDB stuff                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (autoload 'bbdb-fontify-buffer              "bbdb-display" "")
;; (autoload 'bbdb-maybe-fontify-buffer        "bbdb-display" "")
;; (autoload 'bbdb-menu                        "bbdb-display" "")
;; (load-library "bbdb-hooks.el")
;; (require 'bbdb)                         ;needs a debian package
;; (require 'bbdb-com)                             ;needs a debian package
;;(require 'bbdb-hooks)                         ;needs a debian package
;;(load "bbdb-autoloads")
(autoload 'bbdb-define-all-aliases          "bbdb-com"     "")
(autoload 'bbdb/sc-default                  "bbdb-sc"      "")

(autoload 'my-bbdb-canonicalize-net-hook      "my-bbdb")
(autoload 'bbdb/pgp-key                       "my-bbdb")
(autoload 'my--message-mode-hook-mail-aliases "my-bbdb")
(autoload 'bbdb/sendmail-update-records       "my-bbdb")
;;; Avoid BBDB getting confused by 8 bit characters:
(setq bbdb-file-coding-system 'utf-8-unix)
(add-hook 'bbdb-load-hook
          (lambda () (setq bbdb-file-coding-system 'utf-8-unix)))
;; define the coding system
;; http://bbdb.sourceforge.net/faq.html
(setq file-coding-system-alist
      (cons '("\\.bbdb" utf-8 . utf-8)
            file-coding-system-alist))
;;(add-to-list 'file-coding-system-alist
;;             '("/\\.bbdb\\'" iso-8859-1 . iso-8859-1))

(setq
 bbdb/sms-mobile-field "Cell"
 bbdb-csv-export-type 'outlook
 )
(require 'bbdb-snarf)
(require 'bbdb-rf)
(require 'country-info)

(setq
 bbdb-always-add-addresses             t
 bbdb-auto-notes-alist
 (append
  (list
   (append '("From")
           ;; Recognize the country names implicit in the address
           (mapcar (function
                    (lambda (x)
                      (list (concat "@[^<>, ()]*\\."
                                    (car x) "\\([<>, ()].*\\)?$")
                            'country
                            (nth 1 x))))
                   domain-country-list)
           )
   )
  '(
    ("Newsgroups" ("[^,]+" newsgroups 0 t))
    ("X-URL" (".*" url 0 t))
    ("X-www" (".*" url 0 t))
    ("X-Organisation" (".*" company 0))
    ("X-Organization" (".*" company 0))
    ("Organization" (".*" company 0))
    ("Organisation" (".*" company 0))
    ("User-Agent"   (".*" mailer 0))
    ("X-Mailer"     (".*" mailer 0))
    ("X-Newsreader" (".*" mailer 0))
    ("Web" (".*" url 0))
    ("X-WWW-Homepage" (".*" url 0))
    ;; This is what Netscape puts in when sending a URL reference
    ("X-Url" (".*" last-url 0))
    ("From"
     (".*@debian.org>" debian-developer "\\&" t))
    ("Date" (".*" lastmessage "\\&" t))
    ("Subject" (".*" re "\\&" t))
    ;;("Sender"
    ;;  ("owner-bbdb" mail-list "bbdb")
    ;;  ("soc-anz-discuss" mail-list "soc-anz-discuss")
    ;;  ("dsch-l" mail-list "DSCH-L"))
    ))
 bbdb-auto-notes-ignore
 '(("Organization" . "^Gatewayed from\\|^Source only"))
 bbdb-canonicalize-redundant-nets-p    t
 bbdb-complete-name-allow-cycling t
 ;; No popup on autocomplete
 bbdb-completion-display-record        nil
 bbdb-default-area-code                334
 bbdb-dwim-net-address-allow-redundancy t
 bbdb-electric-p                       t
 bbdb-file (concat real-home-directory "/etc/bbdb")
 bbdb-ignore-some-messages-alist
 '(("From" . "mailer.daemon")
   ("From" . "daemon")
   ("From" . "delivery system")
   ("From" . "postmaster")
   ("From" . "listmaster")
   ("From" . "post office")
   ("From" . "root")
   ("From" . "operator")
   ("From" . "delivery")
   ("From" . "administ")
   ("X-CU-Spam"      . "Yes")
   ("X-Spam-Status"  . "Yes")
   )
 bbdb-letter-directory-name            "~/tex/letter/"
 bbdb-message-caching-enabled          t
 bbdb-new-nets-always-primary          'never
 bbdb-north-american-phone-numbers-p   nil
 bbdb-notice-auto-save-file            t
 bbdb-offer-save                       'just-do-it
 ;; Popup uses this many lines
 bbdb-pop-up-target-lines 5
 bbdb-print-require                 '(and name (or address phone))
 bbdb-print-alist
 '((omit-area-code . "(334)")
   (phone-on-first-line . "^[ \t]*$")
   (ps-fonts . nil)
   (font-size . 6)
   (quad-hsize . "3.15in")
   (quad-vsize . "4.5in"))
 bbdb-print-full-alist
 '((columns . 3)
   (separator . 2)
   (include-files "bbdb-print" "bbdb-cols"))
 bbdb-print-brief-alist
 '((columns . 1)
   (separator . 1)
   (n-phones . 2)
   (n-addresses . 1)
   (include-files "bbdb-print-brief" "bbdb-cols"))
 ;; bbdb-silent-running t
 ;; Be quiet if a name doesn't match a previous name
 bbdb-quiet-about-name-mismatches      nil
 bbdb-use-alternate-names              t
 bbdb-user-mail-names                  (user-real-login-name)
 ;; Use a nifty popup
 bbdb-use-pop-up                       nil
 ;; bbdb/mail-auto-create-p              'bbdb-ignore-some-messages-hook
 bbdb/mail-auto-create-p               nil
 )
;; display-layout
;;
;; Currently there are three different layout types, which are
;; `one-line', `multi-line' and `full-multi-line'. You can use `t' and
;; `T' to toggle the display-layout.
;;
;;
;; My current setting (`bbdb-display-layout-alist'):
;;
;; ((one-line   (order     . (phones mail-alias net notes))
;;              (name-end  . 24)
;;              (toggle    . t))
;;  (multi-line (omit      . (creation-date timestamp))
;;              (toggle    . t))
;;  (full-multi-line))
;;
;; (describe-variable 'bbdb-display-layout-alist)
(setq bbdb-display-layout 'multi-line
      bbdb-pop-up-display-layout 'one-line)

(add-hook 'bbdb-notice-hook 'ulmer:bbdb-trim-subjects)

;; Die N letzten Subjects in der BBDB halten
(defvar ulmer:bbdb-subject-limit 25
  "*Maximum number of subject records for
ulmer:bbdb-trim-subjects to retain.")

(defun ulmer:delete-duplicates (list)
  "Remove duplicate elements from a list."
  (let (result head)
    (while list
      (setq head (car list))
      (setq list (delete head list))
      (setq result (cons head result)))
    (nreverse result)))

(defun ulmer:bbdb-trim-subjects (record)
  "Remove all but the first ulmer:bbdb-subject-limit subject
 records from the subjects in the notes field of a BBDB record.
 Also squished duplicate subjects. Meant to be run from
 bbdb-change-hook."
  (let* ((sep (get 'subjects 'field-separator))
         (foo (reverse
               (split-string
                (or (bbdb-record-getprop record 'subjects) "")
                sep)))
         (num-to-keep ulmer:bbdb-subject-limit)
         (new-subj ""))
    (setq foo (ulmer:delete-duplicates foo))
    (while (and (> num-to-keep 0) (> (length foo) 0))
      (if (> (length (car foo)) 0)
          (setq new-subj (concat (car foo)
                                 (if (> (length new-subj) 0)
                                     (concat sep new-subj)
                                   ""))
                num-to-keep (- num-to-keep 1)))
      (setq foo (cdr foo)))
    (bbdb-record-putprop record 'subjects new-subj)))

;;(setq bbdb-print-elide
;;      (append bbdb-print-elide
;;            '(pgp-mail attribution signature x-mailer x-newsreader
;;                       x-face timestamp creation-date)))

(setq bbdb-auto-notes-alist
      (append bbdb-auto-notes-alist
              (list
               (list "x-face"
                     (list (concat "[ \t\n]*\\([^ \t\n]*\\)"
                                   "\\([ \t\n]+\\([^ \t\n]+\\)\\)?"
                                   "\\([ \t\n]+\\([^ \t\n]+\\)\\)?"
                                   "\\([ \t\n]+\\([^ \t\n]+\\)\\)?"
                                   )
                           'face
                           "\\1\\3\\5\\7")))))

;;(setq bbdb-canonicalize-net-hook 'my-bbdb-canonicalize-net-hook)
;;(add-hook 'bbdb-change-hook 'bbdb-delete-redundant-nets)
(add-hook 'bbdb-change-hook   'bbdb-timestamp-hook)
(add-hook 'bbdb-create-hook   'bbdb-creation-date-hook) ; creation date field
(add-hook 'bbdb-notice-hook   'bbdb-auto-notes-hook) ; see -auto-notes-alist


(require 'my-org)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(remove-hook 'minibuffer-setup-hook 'tla-minibuffer-setup)
;; Using code from Tassilo Horn so a server started on first emacs
;; only The code should remove the file when the server ends.
;; Sometimes the file remains (why?).
(eval-when-compile (require 'server))
(defvar manoj-server-lock-file "~/var/run/emacs/lock"
  "Emacs server lock file.")

(defun manoj-server-start ()
  (interactive)
  (shell-command (concat "touch " manoj-server-lock-file))
  (server-start)
  (message "Emacs Server started..."))

(defun manoj-server-remove-lock-file ()
  (interactive)
  (when (boundp 'server-process)
    (shell-command (concat "rm " manoj-server-lock-file))))

(if (file-directory-p "/usr/local/share/emacs/site-lisp/dvc")
    (progn
      (if (not (member "/usr/local/share/emacs/site-lisp/dvc" load-path))
          (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/dvc"))
      (require 'dvc-autoloads)))

;; If we leave Emacs running overnight - reset the appointments one
;; minute after midnight
(run-at-time "24:01" nil 'my-org-agenda-to-appt)

(global-highlight-changes-mode -1)


(add-hook 'compilation-mode-hook (lambda () (setenv "TERM" "emacs")))
;; jabber
(setq jabber-nickname "ManojSrivastava"
      jabber-username (user-real-login-name)
      jabber-connection-type (quote ssl)
      jabber-network-server "jabber.org"
      jabber-port 5223
      jabber-server "jabber.org"
      )

;; If idle for 60 seconds, we seem to get booted. So to fix this, set
;; the keepalive interval for 55 seconds and then start it up after connecting
(setq jabber-keepalive-interval 55)
(require 'tls)
;;(require 'jabber)
;;(add-hook 'jabber-post-connect-hook 'jabber-keepalive-start)

;; Optionally connect automatically when starting Emacs
;;(jabber-connect)


(require 'server)
(if (and (not (file-exists-p manoj-server-lock-file))
         (not (string-equal "root" (getenv "USER")))
         (or (not server-process)
             (not (boundp 'server-process))
             (not (eq (process-status server-process)  'listen)))
         (not noninteractive))
    (manoj-server-start)
  (message "Emacs Server NOT started."))

;; Remove lock file when emacs server ends
(add-hook 'kill-emacs-hook
          'manoj-server-remove-lock-file)

(delete-selection-mode -1)
(setq mouse-region-delete-keys '([delete]))

(add-hook 'org-mode-hook
          (lambda ()
            (imenu-add-to-menubar "Imenu")
            (local-set-key (kbd "\M-\C-n") 'outline-next-visible-heading)
            (local-set-key (kbd "\M-\C-p") 'outline-previous-visible-heading)
            (local-set-key (kbd "\M-\C-u") 'outline-up-heading)
            ;; flyspell mode to spell check everywhere
            (flyspell-mode 1)))

(add-hook 'xgit-log-edit-mode-hook
          (lambda ()
            ;; flyspell mode to spell check everywhere
            (flyspell-mode 1)))

(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))


(require 'my-faces)
(setq custom-enabled-themes '(manoj-dark))
(load-theme  'manoj-dark)
(setq bbdb-canonicalize-net-hook nil)

(defun insert-date (prefix)
  "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%d.%m.%Y")
                 ((equal prefix '(4)) "%Y-%m-%d")
                 ((equal prefix '(16)) "%A, %d. %B %Y")))
        (system-time-locale "en_US"))
    (insert (format-time-string format))))

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  )

(electric-pair-mode 1)
;;; (require 'autopair)
;;; (autopair-global-mode 1) ;; to enable in all buffers
;;; ;; Disables autopair mode in JavaScript mode (js-mode) and C mode buffers.
;;; (dolist (this-hook (list 'js-mode-hook 'c-mode-common-hook 'cperl-mode-hook
;;;                          'erc-mode-hook))
;;;   (add-hook this-hook
;;;             #'(lambda ()
;;;                 (setq autopair-dont-activate t)
;;;                 (autopair-mode -1))))
;;; (add-hook 'emacs-lisp-mode-hook
;;;           #'(lambda ()
;;;               (push '(?` . ?')
;;;                     (getf autopair-extra-pairs :comment))
;;;               (push '(?` . ?')
;;;                     (getf autopair-extra-pairs :string))))
;;; (setq autopair-autowrap t)

(require 'member-function)
(setq mf--source-file-extension "cpp")

(require 'ecb)
;; (setq ecb-compile-window-height 12)
;;; activate and deactivate ecb
(global-set-key (kbd "C-c C-;") 'ecb-activate)
(global-set-key (kbd "C-c C-'") 'ecb-deactivate)
;;; show/hide ecb window
(global-set-key (kbd "C-;") 'ecb-show-ecb-windows)
(global-set-key (kbd "C-'") 'ecb-hide-ecb-windows)

(require 'smart-tab)
(setq smart-tab-using-hippie-expand t)
(global-smart-tab-mode 1)

;; Set up the debian-chagelog mode
(load-library "debian-changelog-mode")
(add-hook 'debian-changelog-mode-hook
          '(lambda ()
             (make-local-variable 'add-log-mailing-address)
             (flyspell-mode 1)
             (auto-fill-mode 1)
             (setq add-log-mailing-address debian-mailing-address)))
(setq debian-changelog-local-variables-maybe-remove nil)

;;
;; Perl
;;

;;; cperl-mode is preferred to perl-mode
;;; "Brevity is the soul of wit" <foo at acm.org>
;;; (defalias 'perl-mode 'cperl-mode)

(require 'compile)
(require 'perlcritic)
(require 'perltidy-mode)
;; Autoloading perlcritic
(autoload 'perlcritic        "perlcritic" "" t)
(autoload 'perlcritic-region "perlcritic" "" t)
(autoload 'perlcritic-mode   "perlcritic" "" t)

(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))
(setq  interpreter-mode-alist
       (append interpreter-mode-alist
               '(("miniperl" . perl-mode)))
       ;;; Turns on most of the CPerlMode options
       cperl-hairy t
       face-list (if (fboundp 'face-list)
                     (face-list)
                   nil)
       ;;; Non-nil means automatically newline before and after braces,
       cperl-auto-newline t

       ;;; Not-nil means not overwrite C-h f.
       cperl-clobber-lisp-bindings t
       ;;;  if, elsif, while, until, else, for, foreach have open
       ;;;  braces on same line
       cperl-extra-newline-before-brace nil

       cperl-merge-trailing-else t
       ;;; Indentation of CPerl statements with respect to containing block
       cperl-indent-level 2
       ;;; Non-nil means indent statements in if/etc block relative brace,
       ;;; not if/etc
       cperl-indent-wrt-brace nil
       ;;; on-nil means automatically indent after insertion of (semi)colon.
       cperl-autoindent-on-semi t
       cperl-indent-parens-as-block t
       cperl-close-paren-offset     -2

       cperl-auto-indent-on-semi t
       cperl-tab-always-indent t
       ;;; expands for keywords such as foreach, while, etc...
       cperl-electric-keywords t
       cperl-electric-lbrace-space nil
       cperl-electric-linefeed t
       cperl-electric-parens nil
       cperl-font-lock t
       cperl-highlight-variables-indiscriminately t
       cperl-indent-parens-as-block t
       cperl-indent-region-fix-constructs nil
       cperl-info-on-command-no-prompt t
       cperl-lazy-help-time 5
       cperl-invalid-face nil
       )

;;; (defface cperl-my-trailing-spaces-face
;;;   '((((class color))
;;;      ;; blah, blah
;;;      ;; define your tastes (background, foreground)
;;;      ))
;;;   "My face for trailing spaces in cperl mode"
;;;   :group 'cperl-mode) ; Here is the most important part. It says to add
;;;                           ; this face to the customizable group cperl-mode
;;;     ;; now you can "bind" this face to cperl-invalid-face
;;;     (set-default 'cperl-invalid-face 'cperl-my-trailing-spaces-face)

(eval-when-compile (require 'cperl-mode))
(defun my-cperl-eldoc-documentation-function ()
  "Return meaningful doc string for `eldoc-mode'."
  (car
   (let ((cperl-message-on-help-error nil))
     (cperl-get-help))))

(add-hook 'cperl-mode-hook
          (lambda ()
            (set (make-local-variable 'eldoc-documentation-function)
                 'my-cperl-eldoc-documentation-function)))
(add-hook 'cperl-mode-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))


(setq cperl-extra-newline-before-brace-multiline
      cperl-extra-newline-before-brace)
(setq
 ;; Non-nil means TAB in Perl mode should always indent the current
 ;; line, regardless of where in the line point is when the TAB
 ;; command is used.
 perl-tab-always-indent t

 ;; Non-nil means that for lines which don't need indenting, TAB will
 ;; either delete an empty comment, indent an existing comment, move
 ;; to end-of-line, or if at end-of-line already, create a new comment.
 perl-tab-to-comment t

 ;; Indentation of Perl statements within surrounding block.
 ;; The surrounding block's indentation is the indentation
 ;; of the line on which the open-brace appears.
 perl-indent-level  2

 ;; Extra indentation given to a substatement, such as the
 ;; then-clause of an if or body of a while.
 perl-continued-statement-offset 2

 ;; Extra indentation given to a brace that starts a substatement.
 ;; This is in addition to `perl-continued-statement-offset'.
 perl-continued-brace-offset -2

 ;; Extra indentation for line if it starts with an open brace.
 perl-brace-offset 0

 ;; An open brace following other text is treated as if it were
 ;; this far to the right of the start of its line.
 perl-brace-imaginary-offset 0

 ;; Extra indentation for line that is a label.
 perl-label-offset -2
 ;; Offset of argument lines relative to usual indentation.
 perl-indent-continued-arguments 2
 ;;
 ;; Various indentation styles:       K&R  BSD  BLK  GNU  LW
 ;; perl-indent-level                5    8    0    2    4
 ;; perl-continued-statement-offset  5    8    4    2    4
 ;; perl-continued-brace-offset      0    0    0    0   -4
 ;; perl-brace-offset               -5   -8    0    0    0
 ;; perl-brace-imaginary-offset      0    0    4    0    0
 ;; perl-label-offset               -5   -8   -2   -2   -2

 )

;;;(eval-after-load "cperl-mode" '(add-hook 'cperl-mode-hook #'perl-syntax-mode))
;;;(eval-after-load "perl-mode"  '(add-hook 'perl-mode-hook  #'perl-syntax-mode))
                                        ; Makes perltidy-mode automatic for cperl-mode
(eval-after-load "cperl-mode" '(add-hook 'cperl-mode-hook 'perltidy-mode))
(eval-after-load "perl-mode" '(add-hook 'perl-mode-hook 'perltidy-mode))

                                        ; Makes perlcritic-mode automatic for cperl-mode
(eval-after-load "cperl-mode" '(add-hook 'cperl-mode-hook #'perlcritic-mode))
(eval-after-load "perl-mode"  '(add-hook 'perl-mode-hook  #'perlcritic-mode))

                                        ; Makes linum-mode automatic for cperl-mode
(eval-after-load "cperl-mode" '(add-hook 'cperl-mode-hook 'linum-mode))
(eval-after-load "perl-mode" '(add-hook 'perl-mode-hook 'linum-mode))


(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
                  (perltidy (point) (mark))))



(defun perl-interpreter (&rest interpreter-else)
  (save-restriction
    (widen)
    (save-excursion
      (goto-char (point-min))

      (if (looking-at auto-mode-interpreter-regexp)
          (match-string 2)
        (car interpreter-else)))))

(defun perl (start end)
  "Runs the current region or buffer with perl"
  (interactive (if (if (boundp 'mark-active) mark-active (mark))
                   (list "r")
                 (setq start (point-min))
                 (setq end   (point-max))
                 (list "i")))
  (shell-command-on-region
   start end (perl-interpreter "perl")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                Pod
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'pod-mode "pod-mode" nil t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         Associate pod-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.[Pp][Oo][Dd]$" . pod-mode))

(add-hook 'cperl-mode-hook 'flyspell-prog-mode)
(add-hook 'cperl-mode-hook 'which-func-mode)
(add-hook 'perl-mode-hook 'flyspell-prog-mode)
(add-hook 'perl-mode-hook 'which-func-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; flymake minor mode
;; insure flymake errors get plopped into the *Messages* buffer
;; Setup for Flymake code checking.
(require 'flycheck)
(require 'flymake)
(setq flymake-log-level 0)
(require 'flymake-shell)
(require 'flymake-perlcritic)
(require 'flymake-yaml) ;; Not necessary if using ELPA package
(add-hook 'find-file-hook 'flymake-find-file-hook)
(add-hook 'sh-set-shell-hook 'flymake-shell-load)
(add-hook 'yaml-mode-hook 'flymake-yaml-load)
;;(add-hook 'find-file-hook 'flymake-find-file-hook)
;;(add-hook 'cperl-mode-hook 'flymake-mode)
;;(add-hook 'perl-mode-hook 'flymake-mode)
;;(add-hook 'c-mode-common-hook 'flymake-mode)
(defun flymake-get-tex-args (file-name)
  (list "pdflatex" (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))


(eval-after-load "message"
  '(require 'boxquote))
(autoload 'boxquote-region                     "boxquote")
(autoload 'boxquote-buffer                     "boxquote")
(autoload 'boxquote-insert-file                "boxquote")
(autoload 'boxquote-title                      "boxquote")
(autoload 'boxquote-kill-ring-save             "boxquote")
(autoload 'boxquote-yank                       "boxquote")
(autoload 'boxquote-defun                      "boxquote")
(autoload 'boxquote-paragraph                  "boxquote")
(autoload 'boxquote-boxquote                   "boxquote")
(autoload 'boxquote-describe-function          "boxquote")
(autoload 'boxquote-describe-variable          "boxquote")
(autoload 'boxquote-describe-key               "boxquote")
(autoload 'boxquote-shell-command              "boxquote")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                Identica Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'identica-mode)
;;(global-set-key "\C-cip" 'identica-update-status-interactive)
;;(global-set-key "\C-cid" 'identica-direct-message-interactive)


(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

(require 'all)
(require 'dedicated)

;; dict support
;;(require 'dictionary)
;;(global-set-key (kbd "C-c C-d s") 'dictionary-search)
;;(global-set-key (kbd "C-c C-d m") 'dictionary-match-words)

;; show everything in kill ring
(require 'browse-kill-ring)
(global-set-key (kbd "C-c k") 'browse-kill-ring)

;; Tex Stuff

(setq TeX-auto-save t)
(setq TeX-parse-self t)

(autoload 'my-TeX-mode-function             "my-tex-modes")
(autoload 'my-LaTeX-mode-function           "my-tex-modes")
;; NB:invoking (la)tex-mode also runs text-mode-hook
(add-hook 'TeX-mode-hook     'my-TeX-mode-function)
(add-hook 'LaTeX-mode-hook   'my-LaTeX-mode-function)
;;(add-hook 'LaTeX-mode-hook   'cite-it-mode)
;;(add-hook 'TeX-mode-hook     'cite-it-mode)
;;(add-hook 'latex-mode-hook   'turn-on-bib-cite)

;;; (add-hook 'latex-mode-hook 'turn-on-font-lock 'append)
;;; (add-hook 'LaTeX-mode-hook 'turn-on-font-lock 'append)
;;; (add-hook 'TeX-mode-hook   'turn-on-font-lock 'append)
;;; (add-hook 'context-mode-hook 'turn-on-font-lock 'append)

(require 'font-latex)
(require 'tex-fold)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'latex-mode-hook 'turn-on-reftex)

(setq-default TeX-master nil)
(setq
 TeX-newline-function 'reindent-then-newline-and-indent
 LaTeX-indent-level 2
 LaTeX-item-indent 2
 TeX-brace-indent-level 2
 LaTeX-syntactic-comments t
 )
(setq LaTeX-section-hook
      '(LaTeX-section-heading
        LaTeX-section-title
        LaTeX-section-toc
        LaTeX-section-section
        LaTeX-section-label))
;;  bib-cite is a minor-mode, so you could invoke it in a LaTeX-mode hook.
;;  e.g. If you are using AUCTeX (http://www.gnu.org/software/auctex/), you
;;  could use:
;;(autoload 'turn-on-bib-cite "bib-cite")
;;(add-hook 'LaTeX-mode-hook 'turn-on-bib-cite)
;;(setq bib-cite-use-reftex-view-crossref t)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)

(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t);; To compile documents to PDF by default

;;(add-hook 'LaTeX-mode-hook '(lambda () (imenu-add-to-menubar "Imenu")))
(setq
 TeX-electric-escape t
 TeX-macro-private (list (concat real-home-directory "/include/"))
 TeX-auto-private (concat real-home-directory "/include/auto/")
 )
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode) ;turn on math-mode by
                                             ;default


(add-hook `LaTeX-mode-hook
          '(lambda ()
             (define-key LaTeX-mode-map "\C-cn" 'TeX-next-error)
             (define-key LaTeX-mode-map [tab] 'LaTeX-indent-line)
             (auto-fill-mode t)
             (flyspell-mode t)
             ))

(eval-when-compile (require 'reftex))
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)
(setq reftex-plug-into-AUCTeX '(t t t t))
(setq bib-cite-use-reftex-view-crossref t)
(autoload 'reftex-mode     "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex  "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex" "Do citation with RefTeX" t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(require 'ess-site)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; YASnippet
;; Replace yasnippets's TAB
(add-hook 'yas/minor-mode-hook
          (lambda ()
            (define-key yas-minor-mode-map (kbd "TAB") 'smart-tab)
            (define-key yas-minor-mode-map  [(tab)] 'smart-tab))
          ) ; was yas/expand

(when (require 'yasnippet nil 'noerror) ;; not: yasnippet-bundle
  (yas-global-mode 1)
  (require 'dropdown-list)
  (setq yas-prompt-functions
        '(yas-dropdown-prompt yas-ido-prompt yas-completing-prompt))
  (define-key yas-keymap [tab] 'yas-next-field)
  (add-to-list 'auto-mode-alist '("yas/.*" . snippet-mode))
  )

;;(yas-minor-mode-on)
;;(add-hook 'c-mode-common-hook 'yas-minor-mode-on)
;;(add-hook 'lisp-mode-hook     'yas-minor-mode-on)
;;(add-hook 'cperl-mode-hook    'yas-minor-mode-on)
;; Make TAB the yas trigger key in the org-mode-hook and turn on flyspell mode



;; Autocomplete
(require 'auto-complete)
(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\M-n" 'ac-next)
(define-key ac-complete-mode-map "\M-p" 'ac-previous)
(setq
 ac-auto-start 2
 ac-auto-show-menu 0.5
 )
(setq ac-dwim t)                        ;Do what i mean

;;; if you want enable auto-complete at org-mode, uncomment this line
;; (add-to-list 'ac-trigger-commands 'org-self-insert-command)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             (expand-file-name
              "~/.emacs.d/el-get/auto-complete/dict"))
(setq ac-comphist-file (expand-file-name
                        "~/.emacs.d/ac-comphist.dat"))

(ac-config-default)
(setq-default ac-sources
              (append
               '(
                 ac-source-semantic-raw
                 ac-source-semantic
                 ac-source-gtags
                 ) ac-sources))
;;(setq-default ac-sources (append '(ac-source-semantic) ac-sources))

;;; use cycling as soon as there are less than 5 options available
(setq completion-cycle-threshold 5)
(add-to-list 'completion-styles 'substring)

(if (not (member 'org-mode ac-modes))
    (add-to-list 'ac-modes 'org-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Lisp mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(dolist (hook (list
               'emacs-lisp-mode-hook
               'lisp-interaction-mode
               ))
  (add-hook hook '(lambda ()
                    (add-to-list 'ac-sources 'ac-source-symbols))))



(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(ac-set-trigger-key "TAB")




(require 'edit-server)
(edit-server-start)


(global-set-key [?\e ?\[ ?1 ?~] 'beginning-of-buffer)
(global-set-key [?\e ?\[ ?4 ?~] 'end-of-buffer)

;;;(require 'org-journal)
(setq org-agenda-file-regexp "\\`[^.].*\\.org\\'\\|[0-9]+")
(add-to-list 'org-agenda-files org-journal-dir)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(perform-x-setup )
;; Stop Cursor Going into Minibuffer Prompt
(setq minibuffer-prompt-properties
      '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt))

;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:
