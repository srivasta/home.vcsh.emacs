;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;; (defun maybe-recompile (file)
;;;   "If FILEd exists and is newer than FILE.elc, recompile it."
;;;   (if (file-newer-than-file-p file (concat file ".elc"))
;;;       (let ; I used to have this....
;;;           ; ((mode-line-format "") (mode-line-inverse-video nil))
;;;           ; but it doesn't seem to be necessary any more, so....
;;;           ( )
;;;         (message (concat "please standby: recompiling " file "..."))
;;;         (sit-for 1)
;;;         (byte-compile-file file)
;;;         (message (concat file " recompiled"))
;;;         (sit-for 2))))
(setq epg-debug t)
(require 'dired)

(defvar temp-compatibility-dir
  "/usr/local/share/emacs/site-lisp/site-start.d"
  "*The directory where select debian emacs20 init scripts are kept."
  )
(add-to-list 'load-path "/usr/share/emacs/site-lisp/")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/")
(unless (boundp 'debian-emacs-flavor)
  (defconst debian-emacs-flavor 'emacs25))

(load "debian-startup")
(debian-startup 'emacs24)
(if (not (member temp-compatibility-dir load-path))
    (setq load-path (cons temp-compatibility-dir load-path)))
;;(debian-run-directories temp-compatibility-dir)


;; Replace all occurrences of nil in load-path by "." since nil breaks
;; debian-pkg-add-load-path-item
(if (memq nil load-path)
    (setq load-path (substitute "." nil load-path)))
;;; <(my-emacs-config-dir)>
(defvar my-emacs-config-dir
  (expand-file-name (concat "~" (user-login-name)  "/etc/emacs"))
  "*The directory where Personal emacs config files are kept."
  )
  ;; (maybe-recompile (concat my-emacs-config-dir "/manoj-config.el"))

  ;; On error in init file, just reload this file to see the error
  ;; <(config-file)>
(setq
 custom-file (format "%scustom-emacs%d.el"
                     (concat my-emacs-config-dir "/custom/")
                     emacs-major-version))
(load custom-file)

(let ((debug-on-error t))
  ;;; add our own emacs directory to the path.
  (if (not (member my-emacs-config-dir load-path))
      (setq load-path (cons my-emacs-config-dir load-path)))
  (load-library "manoj-config")
  )

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; End:
;;; Enable RefTeX
