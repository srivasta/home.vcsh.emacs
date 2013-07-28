;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-x-setup.el ---
;; Author           : Manoj Srivastava ( srivasta@tiamat.datasync.com )
;; Created On       : Wed Apr  8 17:50:25 1998
;; Created On Node  : tiamat.datasync.com
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Tue Apr 15 00:24:21 2008
;; Last Machine Used: anzu.internal.golden-gryphon.com
;; Update Count     : 3
;; Status           : Unknown, Use with caution!
;; HISTORY          :
;; Description      :
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun set-frame-name (S)
  (interactive "sName: ")
  (modify-frame-parameters (selected-frame)
                           (list (cons 'name S))))
(defun set-mouse-shape (form)
  "Sets the mouse shape to FORM.
The names for the shapes are defined in x-win.el."
  (interactive
   (let (formato)
     (setq formato
           (completing-read "Shape: " obarray 'boundp t "x-pointer-"))
     (list (intern formato))))
  (setq x-pointer-shape (symbol-value form))
  )

(defun mouse-line-to-top (click)
  "move current line to top of window."
  (interactive "e")
  (save-excursion
    (mouse-set-point click)
    (recenter 0)))

(defun mouse-line-to-center (click)
  "move current line to top of window."
  (interactive "e")
  (save-excursion
    (mouse-set-point click)
    (recenter)))

(defun mouse-line-to-bottom (click)
  "move current line to bottom of window."
  (interactive "e")
  (save-excursion
    (mouse-set-point click)
    (recenter -1)))

(defun mouse-yank-drag (click arg)
  "Yank the region the mouse was dragged at at point"
  (interactive "e\nP")
  (save-excursion
    (let* ((start-posn (posn-point (event-start click)))
           (end-posn (posn-point (event-end click)))
           (start-window (posn-window (event-start click)))
           )
      (save-window-excursion
       (select-window start-window)
       (kill-new (buffer-substring start-posn end-posn))
       )))
  (yank arg))


(defun mouse-save-drag (click)
  "kill the region the mouse was dragged at at point"
  (interactive "e")
  (save-excursion
    (let* ((start-posn (posn-point (event-start click)))
           (end-posn (posn-point (event-end click)))
           (start-window (posn-window (event-start click)))
           )
      (save-window-excursion
       (select-window start-window)
       (kill-new (buffer-substring start-posn end-posn))
       )))
  )

(defun mouse-kill-drag (click)
  "kill the region the mouse was dragged at at point"
  (interactive "e")
  (save-excursion
    (let* ((start-posn (posn-point (event-start click)))
           (end-posn (posn-point (event-end click)))
           (start-window (posn-window (event-start click)))
           )
      (save-window-excursion
        (select-window start-window)
        (kill-new (buffer-substring start-posn end-posn))
        (delete-region   start-posn end-posn)
        ))))

(defun mouse-kill-and-yank-drag (click arg)
  "kill the region the mouse was dragged at at point"
  (interactive "e\nP")
  (save-excursion
    (let* ((start-posn (posn-point (event-start click)))
           (end-posn (posn-point (event-end click)))
           (start-window (posn-window (event-start click)))
           )
      (save-window-excursion
       (select-window start-window)
       (kill-new (buffer-substring start-posn end-posn))
       (delete-region   start-posn end-posn)
       )))
  (yank arg))


(defun manoj-scroll-bar-scroll-down (event)
  "Scroll the line next to the scroll bar click to the bottom of the window.
EVENT should be a scroll bar click."
  (interactive "e")
  (let ((old-selected-window (selected-window)))
    (unwind-protect
        (progn
          (let* ((end-position (event-end event))
                 (window (nth 0 end-position))
                 (portion-whole (nth 2 end-position)))
            (select-window window)
            (scroll-down
             (- (window-height) 1
                (scroll-bar-scale portion-whole (window-height))))))
      (select-window old-selected-window))))

(defun mouse-yank-at-point (click arg)
  "Insert the last stretch of killed text at the current point.
Prefix arguments are interpreted as with \\[yank]."
  (interactive "e\nP")
  (yank arg))

; Erase all reminders and rebuilt reminders for today from the agenda
(defun my-org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))


(defun perform-x-setup ()
  "Do various X windows related this."
  (interactive)
  (cond (window-system
         ;;     (require 'font-latex)
         (if (eq window-system 'x)
             (progn
               (require 'my-irc)
               ;;
               ;; Browse URLS
               ;;
               (setq browse-url-browser-function 'browse-url-firefox)
               (setq browse-url-new-window-flag t
                     browse-url-firefox-new-window-is-tab t
                     browse-url-browser-function '(("^mailto:" . browse-url-mail)
                                                   ("." . browse-url-firefox)))
               (setq
                     lpr-command "xpp"
                     ps-lpr-command "xpp"
                     )
               (setq x-select-enable-clipboard t)
               (setq dvc-log-edit-other-frame t)
               (setq-default sgml-set-face (eq 'x  window-system))
           ; Rebuild the reminders everytime the agenda is displayed
           (add-hook 'org-finalize-agenda-hook 'my-org-agenda-to-appt)
           ;;; This is at the end of my .emacs - so appointments
           ;;; are set up when Emacs starts
           ;; ; Activate appointments so we get notifications
           (my-org-agenda-to-appt)
           )))))
;;
;; (if (eq window-system 'x)
;;     (progn
;;       (setq browse-url-new-window-flag t)
;;       (setq browse-url-browser-function '(("^mailto:" . browse-url-mail)
;;                                           ("." . browse-url-mozilla))))
;;   (if (fboundp 'w3-fetch)
;;       (setq browse-url-browser-function 'browse-url-w3)
;;     (setq browse-url-browser-function 'browse-url-lynx-emacs)))

;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:
