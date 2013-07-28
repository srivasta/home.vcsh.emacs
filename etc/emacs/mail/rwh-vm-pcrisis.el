;;; rwh-vm-pcrisis.el --- wide-ranging auto-setup for replies in VM
;;
;; Copyright (C) 1999 Rob Hodges
;;
;; Package: Personality Crisis for VM
;; Homepage: http://student.uq.edu.au/~s323140/pcrisis/
;; Author: Rob Hodges <s323140@student.uq.edu.au>
;; Maintainer: s323140@student.uq.edu.au
;; Filename: rwh-vm-pcrisis.el
;; Version: 0.71 alpha
;; Status: This is not an official package; it's just something I wrote.
;;
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, you can either send email to this
;; program's maintainer or write to: The Free Software Foundation,
;; Inc.; 59 Temple Place, Suite 330; Boston, MA 02111-1307, USA.


;; DOCUMENTATION:
;; -------------
;;
;; Documentation is now in an Info file!  You should have downloaded
;; it along with this package at the URL above.  To view, use `C-h i'
;; or `M-x info', then hit `v' (`M-x Info-visit-file'), and point it
;; to the file p-crisis.info, wherever you saved it on your disk.


;; -----------------------------------------------------------------
;; Variable definitions:
;; -----------------------------------------------------------------

(defvar rwh-vm-pcrisis-profiles ()
  "*Controls the behaviour of replies with Personality Crisis for VM.
The user is advised to visit the documentation in rwh-vm-pcrisis.el for an
explanation of how to set up this variable.")

(defvar rwh-vm-pcrisis-automorph-profiles ()
  "*Controls the `rwh-vm-pcrisis-automorph' function.
The user is advised to visit the documentation in rwh-vm-pcrisis.el for an
explanation of how to set up this variable.")

(defvar rwh-vm-pcrisis-saved-headers ()
  "*A list of headers and contents created from the last message replied to.
It is of the form (\"header-field-1\" \"Contents of header-field-1\"
\"header-field-2\" \"Contents of header-field-2\" ..... \"header-field-n\"
\"Contents of header-field-n\")
The headers indexed in this list are controlled by the variable
`rwh-vm-pcrisis-headers-to-save.'")

(defvar rwh-vm-pcrisis-headers-to-save ()
  "*A list of names of headers whose contents should be saved in
`rwh-vm-pcrisis-saved-headers'.  For example, if one of your
reply-buffer-functions needs to have access to the
From: and Reply-To: headers in the messages you're replying to, you'll need to
do something like 
(setq rwh-vm-pcrisis-headers-to-save '(\"From\" \"Reply-To\"))")

(defvar rwh-vm-pcrisis-newmail-profiles '(("do nothing" (("pre-signature" ""))))
  "*Controls the behaviour of the vm-mail wraparound feature.
For more information, see the Personality Crisis docs.")

(defvar rwh-vm-pcrisis-use-vm-mail-wraparound nil
  "*Controls whether to use the vm-mail wraparound feature of p-crisis.
If nil, don't; if non-nil, do.  See the Personality Crisis docs for
more information about this function.")

;; -----------------------------------------------------------------
;; Support functions which may be useful to the user:
;; -----------------------------------------------------------------

(defun rwh-vm-pcrisis-change-header (hdrfield hdrcont)
  "*Change the mail header HDRFIELD to contain HDRCONT.
HDRFIELD is a string such as \"To\", \"From\", etc.  If this header
 does not exist, it is inserted.  
HDRCONT is a string representing the new contents of the header."
  (save-excursion
  (mail-position-on-field hdrfield)
  (beginning-of-line)
  (re-search-forward ": ")
  (delete-region (point) (save-excursion (end-of-line) (point)))
  (insert hdrcont)
  )
)


(defun rwh-vm-pcrisis-delete-signature ()
  "*Remove the signature from a mail message in the current buffer.
The position of the signature is determined by searching for a
line which contains only \"-- \".  This and all subsequent lines
are deleted, along with the line above.  If no such line is found,
nothing is done."
  (save-excursion
    (goto-char (point-min))
    (if (re-search-forward "^-- $" (point-max) t)
	(progn
	  (previous-line 1) ;; default sig will have added a line above
	  (beginning-of-line)
	  (delete-region (point) (point-max))
	  ))
    )
)


(defun rwh-vm-pcrisis-add-signature (sig)
  "*Add a signature to the current mail message.
SIG is a string which will be inserted verbatim if it is not the
name of a readable file.  If it is, the contents of the file will
be inserted instead.  To be more precise, a blank line is inserted
at the end of the buffer, then a line containing only \"-- \", and
then SIG is inserted below that."
  (save-excursion
    (goto-char (point-max))
    (open-line 1)
    (insert "\n-- \n")
    (if (and (file-exists-p sig)
	     (file-readable-p sig))
	(insert-file-contents sig)
      (insert sig))
    )
)


(defun rwh-vm-pcrisis-add-pre-signature (pre-sig)
  "*Add a pre-signature to the current mail message.
PRE-SIG is a string which will be inserted verbatim if it is not
the name of a readable file.  If it is, the contents of the file
will be inserted instead.  The position of insertion will be just
above the signature, if one is present.  Otherwise, at the end of 
the message."
  (save-excursion
    (if (re-search-forward "^-- $" (point-max) t)
	(previous-line 1)
      (goto-char (point-max)))
    (open-line 1)
    (insert "\n")
    (if (and (file-exists-p pre-sig)
	     (file-readable-p pre-sig))
	(insert-file-contents pre-sig)
      (insert pre-sig))
    )
)


(defun rwh-vm-pcrisis-get-saved-header (hdrfield)
  "*Get the contents of a header from rwh-vm-pcrisis-saved-headers.  
HDRFIELD would be something like \"From\", \"Reply-To\", etc, and *must* have
been specified in `rwh-vm-pcrisis-headers-to-save'.  The idea is to allow the
user's reply-buffer-functions to have a way of examining the contents of headers 
in the message being replied to."
  (let ((len (length rwh-vm-pcrisis-saved-headers)) (i 0) (retval nil))
    (while (< i len)
      (if (equal (nth i rwh-vm-pcrisis-saved-headers) hdrfield)
	  (progn
	  (setq retval (nth (1+ i) rwh-vm-pcrisis-saved-headers))
	  (setq i len)))
      (setq i (+ i 2))
      )
    retval
    )
)


(defun rwh-vm-pcrisis-get-current-msg-header (hdrfield)
  "*Returns the contents of HDRFIELD in the current mail message.  
Returns nil if the header doesn't exist.
HDRFIELD should be a string such as \"From\" or \"To\".
\(This can NOT be used for obtaining contents of headers in messages 
being replied to; use `rwh-vm-pcrisis-get-saved-header' in a
reply-buffer-function instead.\)"
  (save-excursion
    (if (mail-position-on-field hdrfield t)
	(let ((end (point)))
	  (re-search-backward ": ")
	  (forward-char 2)
	  (buffer-substring (point) end))))
)


;; -----------------------------------------------------------------
;; More support functions (the user should not use these ones):
;; -----------------------------------------------------------------

(defun rwh-vm-pcrisis-create-hdr-list (mp)
  "Creates a list of strings representing headers and their contents.
The list is called rwh-vm-pcrisis-saved-headers.
Uses `rwh-vm-pcrisis-headers-to-save' to decide which headers to 
include in this list."
  (let ((len (length rwh-vm-pcrisis-headers-to-save)) (i 0))
    (while (< i len)
      (add-to-list 'rwh-vm-pcrisis-saved-headers (vm-get-header-contents 
				mp (nth i rwh-vm-pcrisis-headers-to-save)))
      (add-to-list 'rwh-vm-pcrisis-saved-headers 
		       (nth i rwh-vm-pcrisis-headers-to-save))
      (setq i (1+ i))
      ))
)


(defun rwh-vm-pcrisis-sane-filename (filename)
  "Since the empty string is a valid filename but its contents cannot
be included as a signature or pre-signature (it refers to the current
directory; don't ask me why...), we need to make sure that when a user 
specifies it for their (pre-)signature they get the intuitive result
of nothing happening, rather than an error.  So we use this function
to return nil when it's passed the empty string as an argument."
  (if (equal filename "")
      nil
    t)
)



;; -----------------------------------------------------------------
;; The main function for dealing with replies:
;; -----------------------------------------------------------------

(defadvice vm-do-reply (around rwh-vm-pcrisis-reply activate)
  (let 
      ((mp (car (vm-select-marked-or-prefixed-messages 1)))
       (profile-matching-indices) (len (length rwh-vm-pcrisis-profiles))
       (sig nil) (pre-sig nil) (new-to-hdrfield nil))
    
    ;; Build the matches list:
    (let ((n 0))
      (while (< n len)
	(if (string-match (nth 1 (nth 0 (nth n rwh-vm-pcrisis-profiles)))
			    (or (vm-get-header-contents mp (nth 0 (nth 0 (nth n
				  rwh-vm-pcrisis-profiles)))) ""))
	    (add-to-list 'profile-matching-indices n))
	(setq n (1+ n))))

    ;; Save any headers specified in rwh-vm-pcrisis-headers-to-save:
    (rwh-vm-pcrisis-create-hdr-list mp)

    ;; Run the pre-functions:
    (let ((n (- (length profile-matching-indices) 1)))
      (while (>= n 0)
	(let ((max (length (nth (nth n profile-matching-indices) 
				 rwh-vm-pcrisis-profiles))) (m 1))
	  (while (< m max)
	    (let 
		((hdrfield (nth 0 (nth m (nth (nth n profile-matching-indices)
					      rwh-vm-pcrisis-profiles))))
		 (hdrcont (nth 1 (nth m (nth (nth n profile-matching-indices) 
					     rwh-vm-pcrisis-profiles)))))
	      (if (equal "pre-function" hdrfield)
		  (funcall hdrcont))
	      (setq m (1+ m))))
	  (setq n (1- n)))))
    
    ;; Run the code of the original vm-do-reply:
    ad-do-it


    ;; Now vm-do-reply will have dumped us in the reply buffer -- time 
    ;; to do the editing of headers:
      (let ((n (- (length profile-matching-indices) 1)))
	(while (>= n 0)
	  (let ((max (length (nth (nth n profile-matching-indices) 
				  rwh-vm-pcrisis-profiles))) (m 1))
	    (while (< m max)
	      (let 
		  ((hdrfield (nth 0 (nth m (nth (nth n profile-matching-indices)
						rwh-vm-pcrisis-profiles))))
		   (hdrcont (nth 1 (nth m (nth (nth n profile-matching-indices) 
					       rwh-vm-pcrisis-profiles)))))
		(if (equal "signature" hdrfield)
		    (setq sig hdrcont)
		  (if (equal "pre-signature" hdrfield)
		      (setq pre-sig hdrcont)
		    (if (equal "set-to-to" hdrfield)
			(setq new-to-hdrfield hdrcont)
		      (if (not (or (equal "pre-function" hdrfield) 
				   (equal "reply-buffer-function"
					  hdrfield)))
			  (rwh-vm-pcrisis-change-header hdrfield hdrcont)))))
		  (setq m (1+ m))))
	      (setq n (1- n)))))
     
	
      ;; Change the To: field if we need to:
      (if new-to-hdrfield
	  (rwh-vm-pcrisis-change-header "To"
			(rwh-vm-pcrisis-get-saved-header new-to-hdrfield))
	)
      
      ;; Insert the pre-signature, if there is one:
      (if (and pre-sig (rwh-vm-pcrisis-sane-filename pre-sig))
	  (rwh-vm-pcrisis-add-pre-signature pre-sig)
	)
      
      ;; Insert the signature (if there is one), first deleting any sig that may 
      ;; already be present:
      (if (and sig (rwh-vm-pcrisis-sane-filename sig))
	  (progn
	    (rwh-vm-pcrisis-delete-signature)
	    (rwh-vm-pcrisis-add-signature sig)) 
	)

    ;; Leave the cursor on the first line after the mail-header-separator:
    (mail-text)

    ;; Run the reply-buffer-functions:
    (let ((n (- (length profile-matching-indices) 1)))
      (while (>= n 0)
	(let ((max (length (nth (nth n profile-matching-indices) 
				 rwh-vm-pcrisis-profiles))) (m 1))
	  (while (< m max)
	    (let 
		((hdrfield (nth 0 (nth m (nth (nth n profile-matching-indices)
					      rwh-vm-pcrisis-profiles))))
		 (hdrcont (nth 1 (nth m (nth (nth n profile-matching-indices) 
					     rwh-vm-pcrisis-profiles)))))
	      (if (equal "reply-buffer-function" hdrfield)
		  (funcall hdrcont))
	      (setq m (1+ m))))
	  (setq n (1- n)))))
    )
  )


;; -----------------------------------------------------------------
;; The first main function for dealing with new messages:
;; -----------------------------------------------------------------

(defun rwh-vm-pcrisis-automorph ()
  "*Changes contents of the current mail message based on its own headers.
Headers and signatures can be changed; pre-signatures added; functions called.
This is all controlled by `rwh-vm-pcrisis-automorph-profiles'."
  (interactive)
  (let 
      ((profile-matching-indices) 
       (len (length rwh-vm-pcrisis-automorph-profiles))
       (sig nil) (pre-sig nil))
    
    (save-excursion
      ;; Build the matches list:
      (let ((n 0))
	(while (< n len)
	  (if (string-match (nth 1 (nth 0 (nth n rwh-vm-pcrisis-automorph-profiles)))
			    (or (rwh-vm-pcrisis-get-current-msg-header (nth 0 (nth 0 (nth n
				  rwh-vm-pcrisis-automorph-profiles)))) ""))
	      (add-to-list 'profile-matching-indices n))
	  (setq n (1+ n))))
      
      ;; Edit the headers:
      (let ((n (- (length profile-matching-indices) 1)))
	(while (>= n 0)
	  (let ((max (length (nth (nth n profile-matching-indices) 
				  rwh-vm-pcrisis-automorph-profiles))) (m 1))
	    (while (< m max)
	      (let 
		  ((hdrfield (nth 0 (nth m (nth (nth n profile-matching-indices)
						rwh-vm-pcrisis-automorph-profiles))))
		   (hdrcont (nth 1 (nth m (nth (nth n profile-matching-indices) 
					       rwh-vm-pcrisis-automorph-profiles)))))
		(if (equal "signature" hdrfield)
		    (setq sig hdrcont)
		  (if (equal "pre-signature" hdrfield)
		      (setq pre-sig hdrcont)
		    (if (not (equal "message-buffer-function" hdrfield))
			(rwh-vm-pcrisis-change-header hdrfield hdrcont))))
		(setq m (1+ m))))
	    (setq n (1- n)))))
            
      ;; Insert the pre-signature, if there is one:
      (if (and pre-sig (rwh-vm-pcrisis-sane-filename pre-sig))
	  (rwh-vm-pcrisis-add-pre-signature pre-sig)
	)
      
      ;; Insert the signature (if there is one), first deleting any sig that may 
      ;; already be present:
      (if (and sig (rwh-vm-pcrisis-sane-filename sig))
	  (progn
	    (rwh-vm-pcrisis-delete-signature)
	    (rwh-vm-pcrisis-add-signature sig)) 
	)

      ;; Run the message-buffer-functions:
      (let ((n (- (length profile-matching-indices) 1)))
	(while (>= n 0)
	  (let ((max (length (nth (nth n profile-matching-indices) 
				  rwh-vm-pcrisis-automorph-profiles))) (m 1))
	  (while (< m max)
	    (let 
		((hdrfield (nth 0 (nth m (nth (nth n profile-matching-indices)
					      rwh-vm-pcrisis-automorph-profiles))))
		 (hdrcont (nth 1 (nth m (nth (nth n profile-matching-indices) 
					     rwh-vm-pcrisis-automorph-profiles)))))
	      (if (equal "message-buffer-function" hdrfield)
		  (funcall hdrcont))
	      (setq m (1+ m))))
	  (setq n (1- n)))))
      
      ) ;;end of save-excursion
    )
)


;; -----------------------------------------------------------------
;; The second main function for dealing with new messages:
;; -----------------------------------------------------------------

(defadvice vm-mail (around rwh-vm-pcrisis-mail activate)
  (let ((prof) (profidx) (sig nil) (pre-sig nil))
    (if rwh-vm-pcrisis-use-vm-mail-wraparound
	(progn
	  ;; Ask the user what profile to use:
	  (setq prof
		(let ((default (car (car rwh-vm-pcrisis-newmail-profiles))) (choice nil))
		  (setq choice (completing-read (format "Use profile (Default %s):"
					default) rwh-vm-pcrisis-newmail-profiles nil t))
		  (if (equal choice "")
		      default
		    choice)
		  ))

	  ;; Find which number profile that actually is:
	  (let ((n 0) (max (length rwh-vm-pcrisis-newmail-profiles)))
	    (while (< n max)
	      (if (equal prof (car (nth n rwh-vm-pcrisis-newmail-profiles)))
		  (progn
		    (setq profidx n)
		    (setq n max)
		    )
		(setq n (1+ n))))
	    )
    
	  ;; Run the pre-functions:
	  (let ((n 0) (max (length (nth 1 (nth profidx rwh-vm-pcrisis-newmail-profiles)))))
	    (while (< n max)
	      (let ((hdrfield (nth 0 (nth n (nth 1 (nth profidx
				rwh-vm-pcrisis-newmail-profiles))))) 
		    (hdrcont (nth 1 (nth n (nth 1 (nth profidx
				rwh-vm-pcrisis-newmail-profiles))))))
		(if (equal "pre-function" hdrfield)
		    (funcall hdrcont)
		  ))
	      (setq n (1+ n)))
	    )
	  ))
    ;; run the code of the original vm-mail:
    ad-do-it
    
    (if rwh-vm-pcrisis-use-vm-mail-wraparound
	(progn
	  ;; Replace headers:
	  (let ((n 0) (max (length (nth 1 (nth profidx rwh-vm-pcrisis-newmail-profiles)))))
	    (while (< n max)
	      (let ((hdrfield (nth 0 (nth n (nth 1 (nth profidx
		            rwh-vm-pcrisis-newmail-profiles))))) 
		    (hdrcont (nth 1 (nth n (nth 1 (nth profidx
		            rwh-vm-pcrisis-newmail-profiles))))))
		(if (equal "signature" hdrfield)
		    (setq sig hdrcont)
		  (if (equal "pre-signature" hdrfield)
		      (setq pre-sig hdrcont)
		    (if (not (or (equal "message-buffer-function" hdrfield)
				 (equal "pre-function" hdrfield)))
			(rwh-vm-pcrisis-change-header hdrfield hdrcont)
		      ))))
	      (setq n (1+ n)))
	    )
    

	  ;; Insert the pre-signature, if there is one:
	  (if (and pre-sig (rwh-vm-pcrisis-sane-filename pre-sig))
	      (rwh-vm-pcrisis-add-pre-signature pre-sig)
	    )
      
	  ;; Insert the signature (if there is one), first deleting any sig that may 
	  ;; already be present:
	  (if (and sig (rwh-vm-pcrisis-sane-filename sig))
	      (progn
		(rwh-vm-pcrisis-delete-signature)
		(rwh-vm-pcrisis-add-signature sig)) 
	    )

	  ;; Run the message-buffer-functions:
	  (let ((n 0) (max (length (nth 1 (nth profidx rwh-vm-pcrisis-newmail-profiles)))))
	    (while (< n max)
	      (let ((hdrfield (nth 0 (nth n (nth 1 (nth profidx
					rwh-vm-pcrisis-newmail-profiles))))) 
		    (hdrcont (nth 1 (nth n (nth 1 (nth profidx
					rwh-vm-pcrisis-newmail-profiles))))))
		(if (equal "message-buffer-function" hdrfield)
		    (funcall hdrcont)
		  ))
	      (setq n (1+ n)))
	    )
	  )
      ))
)
