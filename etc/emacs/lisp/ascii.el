;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ascii.el --- 
;; Author           : Manoj Srivastava ( srivasta@glaurung.green-gryphon.com ) 
;; Created On       : Wed Jul 18 10:51:47 2001
;; Created On Node  : glaurung.green-gryphon.com
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Wed Jul 18 10:54:06 2001
;; Last Machine Used: glaurung.green-gryphon.com
;; Update Count     : 2
;; Status           : Unknown, Use with caution!
;; HISTORY          : 
;; Description      : 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; show ascii table
;;; Based on a defun by Alex Schroeder <asc@bsiag.com>
;;; it was hardly a "table" before, so I fixed that
;;; -- Michael Lamoureux <lamour@uu.net>
(defun ascii-table ()
  "Print the ascii table."
  (interactive)
  (switch-to-buffer "*ASCII*")
  ;; have to regen the buffer every time, because we don't know if
  ;; the window width has changed (or even if it's the same frame)
  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 255))
  (let ((i 1)
	;; number of rows we think we can fit on a line
	(rows (- (/ (window-width) 10) 1)))
    (while (< i 256)
 ; (or (<= 1 (mod i rows)) (newline)) ;; this behaves oddly for rows>8
      (or (<= 1 (mod i rows)) (insert "\n")) ;; but this works fine (?!)
      (cond
       ((= i 9) (insert " 9 ^I ")) ;; cheat ;-)
       ((= i 10) (insert " 10 ^J "))
       ((or (and (>= i 128) (< i 160)))
	(insert (format "%4d %c " i i)))
       ((or (and (>= i 32) (< i 127))
	    (>= i 160)) (insert (format "%4d %c " i i)))
       (t (insert (format "%4d %c " i i))))
      (setq i (+ i 1))))
  (newline)
  (beginning-of-buffer))

