;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-imenu.el ---
;; Author           : Manoj Srivastava ( srivasta@tiamat.datasync.com )
;; Created On       : Mon May 18 01:55:54 1998
;; Created On Node  : tiamat.datasync.com
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Mon May 18 02:10:12 1998
;; Last Machine Used: tiamat.datasync.com
;; Update Count     : 2
;; Status           : Unknown, Use with caution!
;; HISTORY          :
;; Description      :
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-set-shell-imenu-expression ()
  (setq imenu-generic-expression
	(cons
	 (concat
	  "\\(^[a-zA-Z_-]+\\)" ; This is what we want.
	  "\\([ \t]*(\\)")
	 (list 1))))   ; Use first sub expression to form index.

;; Return the current/previous sexp and the location of the sexp (its
;; beginning) without moving the point.
(defun my-imenu-name-and-position ()
  (save-excursion
    (forward-sexp -1)
    (let ((beg (point))
          (end (progn (forward-sexp) (point)))
          (marker (make-marker)))
      (set-marker marker beg)
      (cons (buffer-substring beg end)
            marker))))

;;;
;;; Lisp
;;;

(defun my-imenu-lisp-extract-index-name ()
  ;; Example of a candidate for `imenu-extract-index-name-function'.
  ;; This will generate a flat index of definitions in a lisp file.
  (save-match-data
    (and (looking-at "(def")
         (condition-case nil
             (progn
               (down-list 1)
               (forward-sexp 2)
               (let ((beg (point))
                     (end (progn (forward-sexp -1) (point))))
                 (buffer-substring beg end)))
           (error nil)))))
(defun my-imenu-create-lisp-index ()
  ;; Example of a candidate for `imenu-create-index-function'.
  ;; It will generate a nested index of definitions.
  (let ((index-alist '())
        (index-var-alist '())
        (index-type-alist '())
        (index-unknown-alist '())
        prev-pos)
    (goto-char (point-max))
    (imenu-progress-message prev-pos 0)
    ;; Search for the function
    (while (beginning-of-defun)
      (imenu-progress-message prev-pos nil t)
      (save-match-data
        (and (looking-at "(def")
             (save-excursion
               (down-list 1)
               (cond
                ((looking-at "def\\(var\\|const\\)")
                 (forward-sexp 2)
                 (push (my-imenu-name-and-position)
                       index-var-alist))
                ((looking-at "def\\(un\\|subst\\|macro\\|advice\\)")
                 (forward-sexp 2)
                 (push (my-imenu-name-and-position)
                       index-alist))
                ((looking-at "def\\(type\\|struct\\|class\\|ine-condition\\)")
                 (forward-sexp 2)
                 (if (= (char-after (1- (point))) ?\))
                     (progn
                       (forward-sexp -1)
                       (down-list 1)
                       (forward-sexp 1)))
                 (push (my-imenu-name-and-position)
                       index-type-alist))
                (t
                 (forward-sexp 2)
                 (push (my-imenu-name-and-position)
                       index-unknown-alist)))))))
    (imenu-progress-message prev-pos 100)
    (and index-var-alist
         (push (cons "Variables" index-var-alist)
               index-alist))
    (and index-type-alist
         (push (cons "Types" index-type-alist)
               index-alist))
    (and index-unknown-alist
         (push (cons "Syntax-unknown" index-unknown-alist)
               index-alist))
    index-alist))

;; Regular expression to find C functions
(defvar my-imenu-function-name-regexp-c
  (concat
   "^[a-zA-Z0-9]+[ \t]?"                ; type specs; there can be no
   "\\([a-zA-Z0-9_*]+[ \t]+\\)?"        ; more than 3 tokens, right?
   "\\([a-zA-Z0-9_*]+[ \t]+\\)?"
   "\\([*&]+[ \t]*\\)?"                 ; pointer
   "\\([a-zA-Z0-9_*]+\\)[ \t]*("        ; name
   ))

(defun my-imenu-create-c-index (&optional regexp)
  (let ((index-alist '())
        prev-pos char)
    (goto-char (point-min))
    (imenu-progress-message prev-pos 0)
    ;; Search for the function
    (save-match-data
      (while (re-search-forward
              (or regexp my-imenu-function-name-regexp-c)
              nil t)
        (imenu-progress-message prev-pos)
        (backward-up-list 1)
        (save-excursion
          (goto-char (scan-sexps (point) 1))
          (setq char (following-char)))
        ;; Skip this function name if it is a prototype declaration.
        (if (not (eq char ?\;))
            (push (my-imenu-name-and-position) index-alist))))
    (imenu-progress-message prev-pos 100)
    (nreverse index-alist)))


;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:
