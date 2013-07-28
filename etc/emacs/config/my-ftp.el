;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-ftp.el ---
;; Author           : Manoj Srivastava ( srivasta@tiamat.datasync.com )
;; Created On       : Wed Apr  8 18:26:09 1998
;; Created On Node  : tiamat.datasync.com
;; Last Modified By : Manoj Srivastava
;; Last Modified On : Wed Apr  8 18:26:33 1998
;; Last Machine Used: tiamat.datasync.com
;; Update Count     : 1
;; Status           : Unknown, Use with caution!
;; HISTORY          :
;; Description      :
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;Here is a small function I found very useful. put it in your ~/.emacs,
;;;then in any ange-ftp buffer, type 'M-x ange-ftp-record-host RET', the
;;;current buffer's hostname. username, password and account (if any)
;;;will be added to your ange-ftp-netrc-filename file (usually ~/.netrc),
;;;you need to save this file manually.
;;;Enjoy --dong.

(defun ange-ftp-record-host ()
  "If current buffer's is a ange-ftp buffer, record the host , username
password and account inthe file ange-ftp-netrc-filename."
  (interactive)
  (let ((file (or (buffer-file-name) default-directory)))
    (if file
        (let ((parsed (ange-ftp-ftp-name (expand-file-name file))))
          (if parsed
              (let* ((host (nth 0 parsed))
                     (user (nth 1 parsed))
                     (passwd (ange-ftp-get-passwd host user))
                     (account (ange-ftp-get-account host user)))
                (if (file-writable-p ange-ftp-netrc-filename)
                    (save-excursion
                      (set-buffer
                       (find-file-noselect ange-ftp-netrc-filename))
                      (goto-char (point-min))
                      (if (search-forward host nil t)
                          (message "Host: %s already been recorded" host)
                        (progn
                          (goto-char (point-max))
                          (insert "machine " host " login " user
                                  " password " passwd)
                          (if account
                              (insert " account " account))
                          (insert "\n")
                          (message "Host: %s recorded." host)))))))))))


;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:
