;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-text-mode.el ---
;; Author           : Manoj Srivastava ( srivasta@tiamat.datasync.com )
;; Created On       : Wed Apr  8 18:31:11 1998
;; Created On Node  : tiamat.datasync.com
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Tue May 17 01:59:01 2005
;; Last Machine Used: glaurung.internal.golden-gryphon.com
;; Update Count     : 4
;; Status           : Unknown, Use with caution!
;; HISTORY          :
;; Description      :
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar loaded-my-abbrevs nil)
(defun my-text-mode-function ()
  "Things to do in text-mode hook."
  (if need-auto-fill
      (auto-fill-mode 1))
  (if (not loaded-my-abbrevs)
      (let ((prev-a-c abbrevs-changed))
        (define-abbrev-table 'text-mode-abbrev-table
          '(
            ("teh" "the" nil 0)
            ("nolonger" "no longer" nil 0)
            ("comming" "coming" nil 0)
            ("explicite" "explicit" nil 0)
            ("implicite" "implicit" nil 0)
            ("explicitely" "explicitly" nil 0)
            ("ammount" "amount" nil 0)
            ("fullfils" "fulfils" nil 0)
            ("fulfulls" "fulfils" nil 0)
            ("fullfill" "fulfil" nil 0)
            ("implicitely" "implicitly" nil 0)
            ("expotential" "exponential" nil 0)
            ("fulfill" "fulfil" nil 0)
            ("taht" "that" nil 0)
            ("alright" "all right" nil 0)
            ("litterature" "literature" nil 0)
            ))

        (setq abbrevs-changed prev-a-c
              loaded-my-abbrevs t)
        ))
;;  (abbrev-mode 1)
  (if (functionp 'pabbrev-mode)
      (pabbrev-mode 1))
  (yas-minor-mode 0)
  (smart-tab-mode 0)
  )

;; Add a rectangular area containing numbers
(defun rectangle-add (start end)
  "Add all the lines in the region-rectangle and put the result in the kill ring."
  (interactive "r")
  (let ((sum 0))
    (mapc (lambda (line)
            (string-match "[0-9.]+" line)
            (setq sum (+ sum (string-to-number (match-string 0 line)))))
          (extract-rectangle start end))
    (kill-new (number-to-string sum))
    (message "%s" sum)))

;; Select a region which is numbered and then renumber it
(defun renumber-list (start end &optional num)
  "Renumber the list items in the current START..END region.
    If optional prefix arg NUM is given, start numbering from that number
    instead of 1."
  (interactive "*r\np")
  (save-excursion
    (goto-char start)
    (setq num (or num 1))
    (save-match-data
      (while (re-search-forward "^[0-9]+" end t)
        (replace-match (number-to-string num))
        (setq num (1+ num))))))

;; Prints the ascii table
(setq ascii-unprint-chars-low ["NUL " "SOH " "STX " "ETX " "EOT "
                               "ENQ " "ACK " "BEL " "BS  " "HT  "
                               "LF  " "VT  " "FF  " "CR  " "SO  "
                               "SI  " "DLE " "DC1 " "DC2 " "DC3 "
                               "DC4 " "NAK " "SYN " "ETB " "CAN "
                               "EM  " "SUB " "ESC " "FS  " "GS  "
                               "RS  " "US  "])
(defun ascii-table ()
  "Prints a formatted ASCII table.  With control characters symbolically shown"
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (insert "ASCII Table:\n\n")
  (let ((i 0))
    (let ((j 0))
      ; Start of table.  Print header.
      (insert "    0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F")
      (while (< i 16)
        (setq j 0)
        ; Add in "Not Ascii after this point seperator" if i = 8
        (if (= i 8)
            (insert "\n\nCharacters after 127 aren't defined in the ASCII spec\n
                         but are defined on this computer's locale as\n")
          )
        ; start of new line, insert table index
        (insert (format "\n %X  " i))
        (while (< j 16)
          (let ((char-num (+ (* i 16) j)))
            (if (or (< char-num 32))
                (insert (aref ascii-unprint-chars-low char-num))
              (if (= char-num 127)
                  (insert "DEL ")
                (if (or (< char-num 127) (> char-num 159))
                    (insert (format "%c   " char-num))
                  (insert "    ")
                  )
                )
              )
            )
          (setq j (+ j 1))
          )
        (setq i (+ i 1))
        )
      )
    )
  (goto-char (point-min))
  )

(defun my-insert-markdown-link (link description title)
  "Insert a markdown link."
  (interactive "sLink: \nsDescription: \nsTitle: ")
  (if (string-match "\\S-" title)
      ;; we do have a non-empty title
      (insert (format "[%s](%s \"%s\")" description link title))
    (insert (format "[%s](%s)" description link))))
(define-key  text-mode-map "\C-c\C-l" 'my-insert-markdown-link)
;; (add-hook 'my-markdown-mode-hook
;;           (lambda ()
;;             (define-key (current-local-map) "\C-c\C-l"
;;               'my-insert-markdown-link)))

;;;;;;;;;;;;


;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:
