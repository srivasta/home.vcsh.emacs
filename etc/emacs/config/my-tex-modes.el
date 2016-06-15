;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-tex-modes.el ---
;; Author           : Manoj Srivastava ( srivasta@tiamat.datasync.com )
;; Created On       : Wed Apr  8 14:30:33 1998
;; Created On Node  : tiamat.datasync.com
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Thu Apr  6 02:45:02 2006
;; Last Machine Used: glaurung.internal.golden-gryphon.com
;; Update Count     : 8
;; Status           : Unknown, Use with caution!
;; HISTORY          :
;; Description      :
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when-compile (load "tex-site"))
(defun my-TeX-mode-function ()
  "Things to do in TeX mode."
  (interactive)
  (setq ispell-extra-args "-t" )
  (setq scroll-in-place t)
  ;;(insert-mode-line)
  ;; Disable parsing on saving, instead, type C-c C-n (M-x
  ;; TeX-normal-mode) when you need to parse the buffer.
  (setq ispell-parser 'tex)
  (setq TeX-parse-self t ; Enable parse on load.
	TeX-auto-save nil ; Disable parse on save.
	TeX-electric-escape t
	)
  (setq-default TeX-master nil) ; Query for master file.
  (setq-default TeX-auto-regexp-list 'TeX-auto-full-regexp-list)
  (if (boundp 'filladapt-function-table)
      (setq auto-fill-function
	    (cdr (assoc 'do-auto-fill
			filladapt-function-table))))
  )

(defun my-LaTeX-mode-function ()
  "Things to do in LaTeX mode."
  (interactive)
  (setq scroll-in-place t)
  (require 'bib-cite)
  (define-key help-map "\C-l" 'latex-help)
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:
