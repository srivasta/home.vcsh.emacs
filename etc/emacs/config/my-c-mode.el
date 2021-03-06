;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-c-mode.el ---
;; Author           : Manoj Srivastava ( srivasta@tiamat.datasync.com )
;; Created On       : Wed Apr  8 14:05:51 1998
;; Created On Node  : tiamat.datasync.com
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Sat Oct  3 01:36:56 2009
;; Last Machine Used: anzu.internal.golden-gryphon.com
;; Update Count     : 10
;; Status           : Unknown, Use with caution!
;; HISTORY          :
;; Description      :
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cc-styles)
(require 'cc-cmds)

(setq-default c-doc-comment-style
              '((java-mode . javadoc)
                (pike-mode . autodoc)
                (c-mode    . doxygen)
                (c++-mode  . doxygen)))

(defun my-c-mode-ps-hook ()
  (require 'ps-print)
  (if (eq (car ps-left-header) 'ps-get-buffer-name)
      (set (make-local-variable 'ps-left-header)
           (cons 'my-ps-c-buffer-function-name
                 (cdr ps-left-header)))))

;; gcc emits "In file included from " once per inclusion chain (indenting the
;; rest) and then the salient file name is last, but clang emits the "In file
;; included from" prefix for every file in the inclusion chain, so we need a
;; special alist element to ignore those lines, which are rarely useful.
(require 'compile)
(add-to-list
 'compilation-error-regexp-alist-alist
 '(clang-include
   "^In file included from \\(.+\\):\\([0-9]+\\):" 1 2 nil 0) nil)
(add-to-list 'compilation-error-regexp-alist 'clang-include nil)

(defun my-common-c-mode-hook-function ()
  "Things to add to all c like modes."
  (interactive)
  (turn-on-auto-fill)
  (c-toggle-auto-hungry-state 1)
  (c-toggle-electric-state 1)
  (setq c-electric-pound-behavior '(alignleft))
  (global-cwarn-mode 1)
  (setq fill-column 80)
  (linum-mode 1)
  (setq compilation-window-height 16)
  (setq compilation-scroll-output t)
  ;; Highlight words such as TODO, FIXME, and BUG
  ;; Modify the regex to also accept parend and email address, then add colon back
  (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\|BUG\\)" 1
				 font-lock-warning-face t)))
  )

(if (require 'irony nil 'noerror)
    (progn
      (add-hook 'c++-mode-hook 'irony-mode)
      (add-hook 'c-mode-hook 'irony-mode)
      ))
(if (require 'modern-cpp-font-lock nil 'noerror)
    (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode))

(if (require 'google-c-style nil 'noerror)
    (progn
      (add-hook 'c-mode-common-hook 'google-set-c-style)
      (add-hook 'c-mode-common-hook 'google-make-newline-indent))
  (progn
    ;; Indent the case expression in
    ;; a switch statement.
    (c-set-offset 'case-label '+)
    (c-set-offset 'statement-cont '--)
    (c-set-offset 'arglist-cont '(c-lineup-ternary-bodies
                                  c-lineup-gcc-asm-reg))
    (c-set-offset 'arglist-cont-nonempty '(c-lineup-ternary-bodies
                                           c-lineup-gcc-asm-reg
                                           c-lineup-arglist))
    (c-set-offset 'statement-cont '(c-lineup-ternary-bodies +))
    (c-set-offset 'innamespace 0)
    (c-set-offset 'inextern-lang 0)

    (setq indent-tabs-mode nil)))

(defun make-command()
  (if   (or (file-exists-p "makefile")
            (file-exists-p "Makefile"))
      "make" )
  (if  (file-exists-p "SConstruct")
      "scons"
    (let ((file (file-name-nondirectory buffer-file-name)))
      (if (equal (file-name-extension buffer-file-name) "cc")
          (progn
            (format "%s %s %s -o %s"
                    (or (getenv "CC") "g++")
                    (or (getenv "CPPFLAGS")"-Wall -g") "*.cc"
                    (file-name-sans-extension file)
                    ))
        (format "%s -o %s %s %s %s %s"
                (or (getenv "CC") "gcc")
                (file-name-sans-extension file)
                (or (getenv "GTKFLAGS") "`pkg-config --cflags --libs gtk+-2.0`")
                (or (getenv "CPPFLAGS")"-DDEBUG=9")
                (or (getenv "CFLAGS") "-std=c99 -pedantic -Wextra  -Wall -Wformat=2 -Wno-format-extra-args -Winit-self  -Wmissing-include-dirs -Wswitch-default -Wswitch-enum -Wunused -Wstrict-overflow=5 -Wfloat-equal -Wundef -Wno-endif-labels -Wshadow -Wunsafe-loop-optimizations  -Wpointer-arith -Wbad-function-cast -Wc++-compat -Wcast-qual -Wcast-align -Wwrite-strings -Wconversion -Wlogical-op -Waggregate-return -Wpacked -Wpadded -Wunreachable-code -Winline -Wvariadic-macros -Wvla -Wvolatile-register-var  -Wstack-protector -Woverlength-strings -Wmissing-declarations -Wmissing-parameter-type -Wmissing-prototypes  -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wstrict-prototypes -Wpointer-sign -fshort-enums -fno-common -fstack-protector")
                file)
        ))))

;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:
