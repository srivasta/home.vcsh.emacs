;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-mail.el ---
;; Author           : Manoj Srivastava ( srivasta@tiamat.datasync.com )
;; Created On       : Mon May 18 04:37:22 1998
;; Created On Node  : tiamat.datasync.com
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Sat Oct 27 02:21:14 2007
;; Last Machine Used: anzu.internal.golden-gryphon.com
;; Update Count     : 18
;; Status           : Unknown, Use with caution!
;; HISTORY          :
;; Description      :
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun mailrc-reset ()
  (message "Reset aliases variable")
  (sit-for 1)
  (setq mail-aliases nil)
  (setq write-file-hooks (delete 'mailrc-reset write-file-hooks))
  nil)     ; this is rather important!

(defun alias-check ()
  " Reset mail-aliases to t when ~/.mailrc is written, so that
 mail-aliases will get updated before next send."
    (if (equal ".mailrc" (file-name-nondirectory buffer-file-name))
      (setq mail-aliases t))
    nil)

(defun my-ispell-message ()
  "Do ispell on the subject line and the unquoted body lines."
  (interactive)
  (let ((case-fold-search t)
        start end)
    (message-goto-subject)
    (setq end (point))
    (beginning-of-line)
    (while (memq (char-after) '(?\t ? ))
      (forward-line -1))
    (when (looking-at "subject:[\t\n ]*\\(?:\\(fwd\\|re\\):[\t\n ]*\\)*")
      (setq start (match-end 0)))
    (when (< start end)
      (ispell-region start end))
    (message-goto-body)
    (while (not (eobp))
      (while (and (not (eobp))
                  (or (looking-at message-cite-prefix-regexp)
                      (looking-at "[\t ]*$")))
        (forward-line 1))
      (setq start (point))
      (while (not (or (eobp)
                      (looking-at message-cite-prefix-regexp)
                      (looking-at "[\t ]*$")))
        (forward-line 1))
      (setq end (point-marker))
      (ispell-region start end)
      (goto-char end))
    (when (markerp end)
      (set-marker end nil))))

(defun mail-add-header (HEADER CONTENTS &optional REPLACE)
  "Add the specified HEADER to the current mail message, with the given
 CONTENTS.
 If the header already exists, the contents are left unchanged, unless optional
 argument REPLACE is non-nil."
  (save-excursion
     (let ((header-exists (mail-position-on-field HEADER)))
       ;; Delete old contents if REPLACE is set
       (if (and header-exists REPLACE)
           (let ((end (point))
                 (beg (progn
                        (re-search-backward (concat HEADER ": "))
                        (goto-char (match-end 0)))))
             (delete-region beg end)))
       ;; Add new contents if REPLACE is set, or this is a new header.
       (if (or (not header-exists) REPLACE)
           (progn (insert CONTENTS) CONTENTS)))))


(defvar my-gnus-face-directory "~/media/images/faces")

(defun my-gnus-random-face ()
  "Return Face header data chosen randomly from
`my-gnus-face-directory'."
  (interactive)
  (when (file-exists-p (expand-file-name my-gnus-face-directory))
    (let* ((files (directory-files (expand-file-name my-gnus-face-directory) t "\\.png$"))
           (file (nth (random (length files)) files)))
      (when file
        (gnus-convert-png-to-face file)))))



(defvar xfile (expand-file-name (concat my-gnus-face-directory "/xface")))

(defun insert-xfile ()
  (save-excursion
    (goto-char (point-min))
    (search-forward mail-header-separator)
    (beginning-of-line nil)
    (insert "X-Face: ")
    (insert-file xfile)))

(defun mail-remove-header (HEADER)
   "Remove the specified HEADER from the current mail message."
   (save-excursion
     (if (mail-position-on-field HEADER 'soft)
        (let ((end (point))
              (beg (progn
                     (re-search-backward (concat HEADER ": "))
                     (goto-char (match-beginning 0)))))
          (delete-region beg (1+ end))))))


(setq my-work-group-regexp "^\\(nnml:stdc.\\|nnml:tangram\\|nnml:selinux\\)")

(defun mail-insert-cookie ()
  "Adds a cookie to a newly formatted mail buffer."
  (interactive)
  (when (if gnus-newsgroup-name
            (not
             (string-match
              my-work-group-regexp
              gnus-newsgroup-name))
          t
          )
    (progn
      (require 'cookie1)
      (save-excursion
        (goto-char (point-min))
        (if (not
             (re-search-forward "^-- *$"  (point-max) t))
            (progn
              (message-insert-signature t)
              (goto-char (point-min))
              (re-search-forward "^-- *$"  (point-max)
                                 'max)
              ))
        (newline 1)
        (cookie-insert "/usr/local/lib/cookie" 1 "start" "end")
        ;;(kill-line)
    ))))

(defun my-mail-setup-function ()
  "Set up mail stuff."
  ;;  (setq scroll-in-place t)
  (font-lock-mode 1)
  (flyspell-mode 1)
  (yas-minor-mode 0)
  (smart-tab-mode 0)
  (set (make-local-variable 'indent-line-function) 'indent-relative-maybe)
  )

(defun my-message-setup-function ()
  "Add the Headers X-Organization and X-Time."
  (message-add-header (concat "Organization: " mail-organization-header))
  (message-add-header (concat "Mail-Copies-To: nobody"))
;; X-Fnord: +++ath
;; X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
;; X-Message-Flag: Message text blocked: Message Created by Free Software
;; X-BeenThere: Kathmandu
    ;; Add a "Mailer" pseudo-header, if not defined already:
  (setq scroll-in-place t)
  (flyspell-mode 1)
  (font-lock-mode 1)
  (yas-minor-mode 0)
  (smart-tab-mode 0)
  (set (make-local-variable 'indent-line-function) 'indent-relative-maybe)
  )

(defun setup-mailrc-hook ()
  "Set up so changes to ~/.mailrc aliases are always added to
 current Emacs session."
  (make-local-variable 'write-file-hooks)  ; make it have a separate value here
  (add-hook 'write-file-hooks 'mailrc-reset)
  )

(defun setup-compose-mime ()
  "Allow composing mime messages in mail buffers.  This is not a mime
  viewer, just a mime editor."
  (setq mime-setup-use-sc t
        signature-delete-blank-lines-at-eof nil
        ;;;tm-gnus/decoding-mode nil
        ;;; tm-gnus/automatic-mime-preview nil
       )
  (require 'mime-setup)
  )

(defun grab-mail-adr ()
  "Grab the next email in the buffer"
  (interactive)
  (re-search-forward "[a-z0-9A-Z\_\.]+\@[a-z0-9A-Z\-\.]+")
  (copy-region-as-kill (match-beginning 0) (match-end 0))
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:
