;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-irc.el ---
;; Author           : Manoj Srivastava ( srivasta@golden-gryphon.com )
;; Created On       : Fri Sep 29 23:43:28 2006
;; Created On Node  : glaurung.internal.golden-gryphon.com
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Fri May  2 09:46:39 2008
;; Last Machine Used: anzu.internal.golden-gryphon.com
;; Update Count     : 26
;; Status           : Unknown, Use with caution!
;; HISTORY          :
;; Description      :
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IRC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;-----------------------------------------------------------------------------
;;(load "my-zenirc")
(require 'tls)
(require 'erc)
(require 'erc-goodies)
(setq  erc-hide-list
       '(
         "324"
         "329"
;;         "332" ;;; This prevents one from seeing topic changes
         "333"
         ;;         "353"   ;;; User list at start
         "JOIN"
         "MODE"
         "NICK"
         "PART"
         "QUIT"
         ;;       "TOPIC"
         ))

(setq erc-modules
      '(autoaway autojoin button completion fill
                 irccontrols log list match menu move-to-prompt
                 netsplit networks noncommands notify
                 notifications page readonly replace ring
                 services smiley sound spelling
                 sound stamp track unmorse))

(erc-update-modules)
(defun erc-log-all-but-server-buffers (buffer)
  (with-current-buffer buffer
    (not (erc-server-buffer-p))))


(setq erc-server "irc.oftc.net"
      erc-port 6667
      erc-nick "Manoj"
      erc-auto-set-away t
      erc-interpret-mirc-color t
      ;;erc-away-nickname "Manoj_away"
      erc-away-nickname nil
      erc-auto-discard-away t
      erc-autoaway-idle-method 'irc
      erc-auto-query 'window-noselect
      ;;      erc-timestamp-format "%H:%M "
      erc-timestamp-format "[%R-%m/%d]"
      erc-hide-timestamps nil
      erc-echo-timestamps nil
      erc-minibuffer-notice nil
      erc-paranoid t
      erc-prompt "ERC>"
      erc-mode-line-format "%s"
      ;;erc-mode-line-format "%s %a"
      ;;erc-mode-line-away-status-format "(AWAY since %a %b %d %H:%M) "
      erc-prompt-for-nickserv-password nil
      erc-truncate-buffer-on-save t
      erc-save-buffer-on-part t
      erc-netsplit-show-server-mode-changes-flag t
      erc-user-name (user-full-name)
      erc-email-userid "srivasta@ieee.org"
      erc-use-info-buffers t
      erc-whowas-on-nosuchnick t
      erc-track-exclude-types '("NICK" "JOIN" "PART" "QUIT")
      ;; rejoining
      erc-part-reason 'erc-part-reason-zippy
      erc-quit-reason 'erc-quit-reason-zippy
      erc-server-reconnect-timeout 3
      erc-server-reconnect-attempts 3
      erc-server-send-ping-timeout 120
      ;;erc-track-use-faces t
      erc-prompt-for-channel-key t
      erc-track-priority-faces-only 'all
      ;; logging:
      erc-log-channels t
      erc-log-channels-directory (concat home-directory "/var/log/IRC")
      erc-log-insert-log-on-open nil
      erc-save-buffer-on-part t
      )

;; end logging
;; Truncate buffers so they don't hog core.
(setq erc-max-buffer-size 800000)
(defvar erc-insert-post-hook)
(add-hook 'erc-insert-post-hook 'erc-truncate-buffer)
(add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)
(setq erc-truncate-buffer-on-save t)
(add-hook 'erc-insert-modify-hook 'erc-fill)
(add-hook 'erc-send-modify-hook 'erc-fill)

(add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)


;; when exiting emacs, save all logs without confirmation
(defadvice save-buffers-kill-emacs (before save-logs (&rest args) activate)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (eq major-mode 'erc-mode)
        (erc-save-buffer-in-logs)))))

;; (defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
;;   (save-some-buffers t (lambda () (when (and (eq major-mode 'erc-mode)
;;                                      (not (null buffer-file-name)))))))


(defun erc-generate-log-file-name-manoj (buffer target nick server port)
  "Generates a log-file name in the way ERC always did it.
#channel!nick@server:port.txt)"
  (concat erc-log-channels-directory "/"
          (format-time-string "%Y") "_"
          (format-time-string "%m") "_"
          (format-time-string "%d") "_"
          (if target
              (concat (replace-regexp-in-string "\\(#|&\\)" "" target) "_"))
          nick "_" server "-" (cond ((stringp port) port)
                                    ((numberp port)
                                     (number-to-string port))) ".txt"))

(setq erc-generate-log-file-name-function 'erc-generate-log-file-name-manoj)




(require 'easymenu)
(easy-menu-add-item  nil '("tools")
                     ["IRC" erc-select t])




;(add-to-list 'erc-replace-list erc-replace-lefthanded-smiley-re)
;(add-to-list 'erc-replace-list erc-replace-righthanded-smiley-re)


(autoload 'erc-complete "erc-complete" "Complete nick at point." t)

(require 'erc-ring)
;;(erc-ring-mode t)
(require 'erc-menu)
(require 'erc-replace)
;;(require 'erc-nets)
(require 'erc-netsplit)
(require 'erc-fill)
(require 'erc-button)
(require 'erc-replace)
(require 'erc-stamp)
(require 'erc-autoaway)
(erc-autojoin-mode 1)

(require 'erc-pcomplete)
(require 'erc-dcc)
(require 'erc-ezbounce)

(erc-button-mode 1)

(require 'erc-track)
(erc-track-mode 1)
;;(erc-track-modified-channels-mode t)

(require 'erc-match)
(setq
 erc-keywords
 '(
   "[mM]anoj" "srivasta"
   ("selinux" bg:erc-color-face2)
   ;;("dilinger"  bg:erc-color-face3)
   ))
(erc-match-enable)
(erc-match-mode 1)

;;(require 'erc-auto)
(require 'erc-list)
;; (setq erc-autojoin-channels-alist
;;           '(("freenode.net" "#emacs" "#gentoo" "#latex" "#python"
;;                  "#fnr" "#ducttape" "#hitchpool" "#tengwar"
;;                  "#carvux" "#unit-e" "#code-hell" "#quixote")))


;; Clears out annoying erc-track-mode stuff for when we don't care.
;; Useful for when ChanServ restarts :P
(defun reset-erc-track-mode ()
  (interactive)
  (setq erc-modified-channels-alist nil)
  (erc-modified-channels-update))


(setq erc-current-nick-highlight-type 'nick-or-keyword)


;; after starting erc
(setq erc-mode-hook nil)
(add-hook
 'erc-mode-hook
 (lambda ()
   ;;"Set fill column according to `window-width'
   (set (make-local-variable 'erc-fill-column) (- (window-width) 10))
   (set (make-local-variable 'erc-timestamp-right-column)
      (1+ erc-fill-column))
   (setq default-directory "~/")
   (erc-timestamp-mode 1)
   (erc-button-mode t)                   ;slow
   (erc-show-timestamps)
   (erc-completion-mode 1)
   (erc-replace-mode 1)
   (erc-fill-mode 1)
   (erc-netsplit-mode 1)
   (erc-ring-mode t)
   ;;(erc-track-mode 1)
   (flyspell-mode 1)
   (pcomplete-erc-setup)
   (erc-completion-mode 1)
   ;; turn off fill mode in erc - erc has its own fill features
   (auto-fill-mode 0)
   (if (fboundp 'filladapt-mode)
       (filladapt-mode 0))))

;;;; Login to IRC.
; This should probably be last, because if I kill the call to
; erc-select, wanting not to connect, it seems the rest of the file
; doesn't get executed.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (add-hook 'erc-after-connect                                          ;;
;;           '(lambda (SERVER NICK)                                      ;;
;;              (erc-message "PRIVMSG" "NickServ identify Talwsatgig"))) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'erc-after-connect 'erc-autojoin-channels)


;; My timestamp routines

(make-variable-buffer-local
 (defvar erc-timestamp-last-left nil))
(make-variable-buffer-local
 (defvar erc-timestamp-last-right nil))

(defvar erc-timestamp-format-left "\n[%a %b %e %Y]\n")
(defvar erc-timestamp-format-right " [%H:%M]")

(defun my-erc-timestamp-insert-left (string)
  "Insert a timestamp on the left if the previous timestamp is
different from this one."
  (unless (string-equal string erc-timestamp-last-left)
    (goto-char (point-min))
    (erc-put-text-property 0 (length string) 'field 'erc-timestamp string)
    (insert string)
    (setq erc-timestamp-last-left string)))

(defun my-erc-timestamp-left-and-right (string)
  "This is another function that can be assigned to
`erc-insert-timestamp-function'.  If the date is changed, it will
print a blank line, the date, and another blank line.  If the time is
changed, it will then print it off to the right."
  (let* ((ct (current-time))
         (ts-left (erc-format-timestamp
                   ct erc-timestamp-format-left))
         (ts-right (erc-format-timestamp
                    ct erc-timestamp-format-right)))
    (my-erc-timestamp-insert-left ts-left)
    (let ((erc-timestamp-only-if-changed-flag t)
          (erc-timestamp-last-inserted erc-timestamp-last-right))
      (erc-insert-timestamp-right ts-right)
      (setq erc-timestamp-last-right ts-right))))

(defun my-erc-timestamp-reset ()
  "Force a timestamp to be written on the next erc command.  This is
not called by any function in my sample setup, but you could bind it
to a key in order to force a timestamp to be written upon the next erc
command."
  (setq erc-timestamp-last-left nil)
  (setq erc-timestamp-last-right nil))
(setq erc-insert-timestamp-function 'my-erc-timestamp-left-and-right)
;;;


(defun erc-global-get-channel-buffer-list ()
  "Return a list of the ERC-channel-buffers"
  (erc-buffer-filter
   '(lambda()
      (if (string-match "^[^#].*:\\([0-9]*\\|ircd\\)$"
                        (buffer-name (current-buffer))) nil t)) nil))

(defun switch-to-irc ()
  "Switch to an IRC channel buffer, or run `erc-select'.
   When called repeatedly, cycle through the buffers."
  (interactive)
  (let ((buffers (erc-global-get-channel-buffer-list)))
    (when (eq (current-buffer) (car buffers))
      (bury-buffer)
      (setq buffers (cdr buffers)))
    (if buffers
        (switch-to-buffer (car buffers))
      (erc-select))))

;; conference mode
(setq erc-conference-p nil)

(defun erc-cmd-CONFERENCE (&optional force)
  (if (and (boundp 'erc-conference-p)
           erc-conference-p)
      (progn
        (setq erc-conference-p nil
              erc-hide-list (default-value erc-hide-list))
        (erc-display-line (erc-make-notice "Conference mode is OFF.")
                          'active))
    (progn
      (make-local-variable 'erc-hide-list)
      (make-local-variable 'erc-conference-p)
      (setq erc-conference-p t
            erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
      (erc-display-line (erc-make-notice "Conference mode is ON.")
                        'active)))
  t)


;;; (defun erc-cmd-EMMS (&rest ignore)
;;;   "Display the current emms track to the current ERC buffer."
;;;   (emms-player-mpd-show nil (lambda (buffer desc)
;;;                               (with-current-buffer buffer
;;;                                 (erc-send-message desc)))))

;;; (defalias 'erc-cmd-NP 'erc-cmd-EMMS)

(defun erc-cmd-UNAME (&rest ignore)
  "Display the result of running `uname -a' to the current ERC
buffer."
  (let ((uname-output
         (replace-regexp-in-string
          "[ \n]+$" "" (shell-command-to-string "uname -a"))))
    (erc-send-message
     (concat "{uname -a} [" uname-output "]"))))

(defun erc-cmd-UPTIME (&rest ignore)
  "Display the uptime of the system, as well as some load-related
stuff, to the current ERC buffer."
  (let ((uname-output
         (replace-regexp-in-string
          ", load average: " "] {Load average} ["
          ;; Collapse spaces, remove
          (replace-regexp-in-string
           " +" " "
           ;; Remove beginning and trailing whitespace
           (replace-regexp-in-string
            "^ +\\|[ \n]+$" ""
            (shell-command-to-string "uptime"))))))
    (erc-send-message
     (concat "{Uptime} [" uname-output "]"))))

(defun erc-cmd-XMMS (&rest ignore)
  "Display the current xmms track to the current ERC buffer."
  (let* ((xmms-output (shell-command-to-string
                       "xmms-shell -e current-track"))
         (case-fold-search t)
         (current-track
          (replace-regexp-in-string
           "[ \n]+$" "" (mapconcat
                         'identity
                         (nthcdr 3 (split-string xmms-output " "))
                         " "))))
    (if (null (string-match "current" xmms-output))
        (message xmms-output)
      (erc-send-message
       (concat "NP: [" current-track "]")))))

;;; (defun erc-cmd-YOW (&rest ignore)
;;;   "Display some pinhead wisdom into the current ERC buffer.  I'd
;;; rather not see it messaged to me, just sent out."
;;;   (let ((yow-msg (replace-regexp-in-string "\n" "" (yow nil nil))))
;;;     (erc-send-message
;;;      (concat "{Pinhead wisdom} "
;;;              yow-msg))))



(setq
 erc-prompt
 (lambda ()
   (if (and (boundp 'erc-default-recipients)
            (erc-default-target))
       (erc-propertize
        (concat (erc-default-target) ">") 'read-only t 'rear-nonsticky t
        'front-nonsticky t)
     (erc-propertize
      (concat "__>") 'read-only t 'rear-nonsticky t 'front-nonsticky t))))


(setq erc-autojoin-channels-alist
      '(
;;        ("oftc.net" "#debian-devel")
        ("localhost" "&bitlbee")
        ("freenode.net" "#debian")
        ;;("freenode.net" "#nlug" "#selinux" "#linux-india")
        ))

(defun add-autojoin (server channel)
  (require 'erc-join)
  (when (and erc-autojoin-domain-only
             (string-match "[^.\n]+\\.\\([^.\n]+\\.[^.\n]+\\)$" server))
    (setq server (match-string 1 server)))
  (let ((elem (assoc server erc-autojoin-channels-alist)))
    (if elem
        (unless (member channel (cdr elem))
          (setcdr elem (cons channel (cdr elem))))
      (setq erc-autojoin-channels-alist
            (cons (list server channel) erc-autojoin-channels-alist)))))

(defmacro define-chat-command (function server channel &optional port tls password)
  `(defun ,function ()
     (interactive)
     (add-autojoin ,server ,channel)
     (funcall (if ,tls 'erc-tls 'erc)
              :server ,server :port ,(or port 6667) :nick (getenv "USER") :password ,password)))

(define-chat-command abcl-chat "irc.freenode.net" "#abcl")
(define-chat-command go-chat "irc.freenode.net" "#go-nuts")
(define-chat-command org-tools-chat "irc.corp.google.com" "#org-tools")
(define-chat-command ita-integration-chat
  "ita5prattle1.itasoftware.com" "#integration" 6601 t "XXXXXXXXXX")
(define-chat-command lisp-chat "irc.freenode.net" "#lisp")
(define-chat-command sbcl-chat "irc.freenode.net" "#sbcl")
(define-chat-command ubuntu-chat "irc.freenode.net" "#ubuntu")
(define-chat-command bitlbee-start "localhost" 6667)


(defun my-irc ()
  "Start to waste time on IRC with ERC."
  (interactive)
;;  (erc-select :server "irc.freenode.net" :port 6667 :nick "Manoj"
;;              :password "Talwsatgig" :full-name "Manoj Srivastava")
;;  (sit-for 10)
;;  (erc-autojoin-channels "irc.freenode.net" "Manoj")
  (if (file-exists-p
       (concat real-home-directory "/etc/emacs/config/Manoj.pem"))
      (let ((tls-program
             (list
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
                      "/etc/emacs/config/Manoj.pem  -p %p %h")
              )))
        (erc-tls :server "irc.oftc.net" :port 6697
                 :nick "Manoj" :full-name "Manoj Srivastava"))
    (erc-select :server "irc.oftc.net" :port 6667 :nick "Manoj"
                :password oftc-password  :full-name "Manoj Srivastava"))
  (sit-for 10)
  (erc-autojoin-channels "irc.oftc.net" "Manoj")
  (sit-for 10)
  (erc-select :server "localhost" :port 6667 :nick "Manoj"
              :password bitlbee-password :full-name "Manoj Srivastava")
  )

;; (defun irc-newframe ()
;;   "Start to waste time on IRC with ERC."
;;   (interactive)
;;   (select-frame (make-frame '((name . "Emacs IRC")
;;                               (minibuffer . t))))
;;   (call-interactively 'erc-freenode)
;;   (sit-for 1)
;;   (call-interactively 'erc-oftc)
;;   )
(defun irc-newframe ()
  "Start to waste time on IRC with ERC."
  (interactive)
  (select-frame (make-frame '((name . "Emacs IRC")
                              (width . 120)
                              (height . 25)
                              (minibuffer . t))))
  ;;; (call-interactively 'erc-freenode)
  ;;; (sit-for 1)
  ;;; (call-interactively 'erc-oftc)
  (setq erc-join-buffer 'frame)
  (call-interactively 'my-irc)
  )
(provide 'my-irc)



;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:
