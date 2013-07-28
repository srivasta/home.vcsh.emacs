;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Fundamental -*- ;;;;;;;;;;;;;;;;;;;;;;;;;
;; log-mail.el ---
;; Author           : Manoj Srivastava ( srivasta@pilgrim.umass.edu )
;; Created On       : Thu May 19 17:14:50 1994
;; Created On Node  : pilgrim.umass.edu
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Thu Oct 29 11:12:07 1998
;; Last Machine Used: tiamat.datasync.com
;; Update Count     : 6
;; Status           : Unknown, Use with caution!
;; HISTORY          :
;; Description      :
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; LOG-MAIL.EL - Log outgoing mail.
;;; Copyright (C) 1994 Manoj Srivastava


;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 1, or (at your option)
;;; any later version.

;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.

;;; A copy of the GNU General Public License can be obtained from this
;;; program's author (send electronic mail to
;;; <srivasta@pilgrim.umass.edu>) or from the Free Software
;;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; LCD Archive Entry:
;;; log-mail|Manoj Srivastava|<srivasta@pilgrim.umass.edu>
;;; |Log outgoing mail.
;;; |$Date: 1994/11/04 19:49:58 $|$Revision: 1.1.1.1 $|~/packages/log-mail.el

(defconst log-mail-version (substring "$Revision: 1.1.1.1 $" 11 -2)
  "$Id: log-mail.el,v 1.1.1.1 1994/11/04 19:49:58 srivasta Exp srivasta $

Report bugs to: Manoj Srivastava <srivasta@pilgrim.umass.edu>")


;;{{{ Get a log file

(defun set-log-file-name ()
  (setq log-file
	;;from gnuspost.el
	(let ((date (current-time-string)))
	  (if
	      (string-match
	       "^[^ ]+ \\([^ ]+\\)[ ]+\\([0-9]+\\) \\([0-9]+\\):\\([0-9]+\\):\\([0-9]+\\) \\([0-9][0-9][0-9][0-9]\\)"
	       date)
	      (concat my-log-directory "/"
;;;		    (substring date 0 3)                       ;day of week
		      (substring date (match-beginning 6) (match-end 6));Year
		      (substring date (match-beginning 1) (match-end 1));Month
;;;		    (substring date (match-beginning 2) (match-end 2));Day
;;;		    (substring date (match-beginning 3) (match-end 3));Hour
;;;		    (substring date (match-beginning 4) (match-end 4));Mins
;;;		    (substring date (match-beginning 5) (match-end 5));Secs
		      )
	    (error "Cannot understand current-time-string: %s." date))
	  )))


(defun log-mail-function ()
  (setq initialized-mail-send t)
  (mail-add-header "Mail-Copies-To" "nobody" t)
;;;   (mail-add-header "X-Time" (current-time-string) t)
;;;    (save-window-excursion
;;;      (goto-char (point-min))
;;;      (set-log-file-name)
;;;      (if (mail-position-on-field "To" )
;;;  	(let ((end (point))
;;;   	      (beg (progn
;;;   		     (re-search-backward (concat "To" ": "))
;;;   		     (goto-char (match-beginning 0)))))
;;;  	  (let ((destination-string (buffer-substring beg end))
;;;  		(now (current-time-string)))
;;;  	    (if (mail-position-on-field "Subject" 'soft)
;;;  		(let ((end (point))
;;;  		      (beg (progn
;;;  			     (re-search-backward (concat "Subject" ": "))
;;;  			     (goto-char (match-beginning 0)))))
;;;  		  (let ((subject-string (buffer-substring beg end)))
;;;  		    (find-file log-file)
;;;  		    (goto-char (point-max))
;;; ;;; 		    (insert  destination-string "\n"
;;; ;;; 			     subject-string "\nTime: " now "\n\n")
;;;  		    (save-buffer 0)
;;;  		    (kill-buffer (current-buffer))
;;;  		    )))))
;;;       ))
  )


(defun log-message-function ()
  (setq initialized-mail-send t)
  (message-add-header (concat "Mail-Copies-To: nobody"))
;;;   (message-add-header (concat "X-Time: " (current-time-string)))
;;;    (save-window-excursion
;;;      (goto-char (point-min))
;;;      (set-log-file-name)
;;;      (if (message-position-on-field "To" )
;;;  	(let ((end (point))
;;;   	      (beg (progn
;;;   		     (re-search-backward (concat "To" ": "))
;;;   		     (goto-char (match-beginning 0)))))
;;;  	  (let ((destination-string (buffer-substring beg end))
;;;  		(now (current-time-string)))
;;;  	    (if (message-position-on-field "Subject" 'soft)
;;;  		(let ((end (point))
;;;  		      (beg (progn
;;;  			     (re-search-backward (concat "Subject" ": "))
;;;  			     (goto-char (match-beginning 0)))))
;;;  		  (let ((subject-string (buffer-substring beg end)))
;;;  		    (find-file log-file)
;;;  		    (goto-char (point-max))
;;; ;;; 		    (insert  destination-string "\n"
;;; ;;; 			     subject-string "\nTime: " now "\n\n")
;;;  		    (save-buffer 0)
;;;  		    (kill-buffer (current-buffer))
;;;  		    )))))
;;;        ))
  )

;;}}}

(provide 'log-mail)


;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:

