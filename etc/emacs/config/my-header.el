;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-header.el ---
;; Author           : Manoj Srivastava ( srivasta@tiamat.datasync.com )
;; Created On       : Wed Apr  8 17:47:35 1998
;; Created On Node  : tiamat.datasync.com
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Tue Sep 19 22:49:34 2006 (-18000 CDT)
;; Last Machine Used: glaurung.internal.golden-gryphon.com
;; Update Count     : 14
;; Status           : Unknown, Use with caution!
;; HISTORY          :
;; Description      :
;;; arch-tag: 37c45f53-02d8-4c68-9ea1-aafc1a27c61d
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'make-header "header")

(eval-when-compile (require 'header))
(require 'header)


(defvar insert-known-extensions-list
      (list
       "\\.tex$" "\\.c$" "\\.idl$" "\\.h$" "\\.cc$" "\\.hh$"
       "[Mm]akefile" "\\.bib$" "\\.pl$" "\\.sh$" "\\.csh$" "\\.html$"
       "\\.el$" "[]>:/]\\..*emacs" )
      "*List of regexps matching filenames for which a header is created."
      )

(defun maybe-make-header ()
  "make header if this is not in the exception list."
  (let ((typelist insert-known-extensions-list)
        (filename buffer-file-name)
        (do-file nil))
    ;; remove backup suffixes from file name
    (setq filename (file-name-sans-versions filename))
    (while (and (not do-file) typelist)
      (if (string-match (car typelist)  filename)
          (setq do-file t)
        (setq typelist (cdr typelist))))
    (if do-file
        (progn
          (make-header)
          ;;(forward-line -2)
          ;;(insert-arch-tag)
          ;;(newline)
          ))))


;;; arch-tag.el --- function for inserting arch-tags to a buffer.

;; Copyright (C) 2004  Martin Thorsen Ranang

;; Author: Martin Thorsen Ranang <mtr@ranang.org>
;; Keywords: convenience, files
;;; Commentary:

;; Just a small hack to save some time when using the GNU Arch
;; revision control system.  To use this function, store this file in
;; a place accessible by Emacs (e.g. in Emacs' load-path) and add the
;; following to your .emacs file:
;;
;; (require 'arch-tag)

;; When Emacs has evaluated that expression, all you have to do is to
;; find the place in the buffer where you want to insert a new tag and
;; type in M-x insert-arch-tag.

;;; Code:

(defun insert-arch-tag ()
  "Insert a new universally unique identifier (UUID) as the file's arch-tag."
  (interactive "*")
  (insert
   ;; Start a comment.
   comment-start
   ;; If there's no trailing space in the comment-start string, add
   ;; one.
   (if (not (string-equal (substring comment-start -1) " "))
       " "
     "")
   ;; Now, write the tag itself, with input from the uuidgen shell
   ;; command (and remove the trailing endline from the shell command
   ;; output).
   "arch-tag: " (substring (shell-command-to-string "uuidgen") 0 -1)
   ;; And end the comment, if it's applicable.
   comment-end))


;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:
