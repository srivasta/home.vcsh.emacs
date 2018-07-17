;;; my-org.el ---
;;
;; Filename: my-org.el
;; Description:
;; Author: Manoj Srivastava
;; Maintainer:
;; Created: Fri Jan  3 15:27:30 2014 (-0800)
;; Version:
;; Last-Updated:
;;           By:
;;     Update #: 0
;; URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:



;;;;;;;;;;;;;;
;; Org Mode ;;
;;;;;;;;;;;;;;
;;; http://orgmode.org/worg/org-configs/org-customization-survey.html
;;; http://doc.norang.ca/org-mode.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Needs to be set before loading org!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq
 org-enforce-todo-checkbox-dependencies t
 org-enforce-todo-dependencies          t
 org-return-follows-link                t
)

(setq org-modules '(org-bbdb org-bibtex org-gnus org-info org-indent
                             org-jsinfo org-irc org-vm org-w3m
                             org-wl org-agenda
                             org-habit org-docview ))
(add-to-list 'org-modules 'org-crypt)
(add-to-list 'org-modules 'org-id)
(add-to-list 'org-modules 'org-habit)
(add-to-list 'org-modules 'org-protocol)
(add-to-list 'org-modules 'org-mouse)

(require 'org)
(require 'org-table)

;; Org-mouse adds various clickable menus to org-mode constructs.
(require 'org-agenda)
;;(require 'org-latex)
(require 'org-protocol)
(require 'org-habit)

(add-to-list 'org-export-backends 'beamer)
(add-to-list 'org-export-backends 'man)
(add-to-list 'org-export-backends 'md)
(add-to-list 'org-export-backends 'odt)
(add-to-list 'org-export-backends 'texinfo)
(add-to-list 'org-export-backends 'org)

;; The following lines are always needed.  Choose your own keys.

;; I want files with the extension ".org" to open in org-mode.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Some basic keybindings.

(global-set-key (kbd "C-c o a") 'org-agenda-list)
(global-set-key (kbd "C-c o b") 'org-iswitchb)
(global-set-key (kbd "C-c o f") 'org-footnote-action)
(global-set-key (kbd "C-c o l") 'org-store-link)
(global-set-key (kbd "C-c o L") 'org-insert-link-global)
(global-set-key (kbd "C-c o o") 'org-open-at-point-global)
(global-set-key (kbd "C-c o t") 'org-todo-list)
(global-set-key (kbd "C-c o p") 'org-insert-property-drawer)
(global-set-key (kbd "C-c o d") 'org-date)
(global-set-key (kbd "C-c o j") 'org-journal-entry)
(global-set-key (kbd "C-c o ,") 'org-priority)
(global-set-key (kbd "C-c o +") 'org-priority-up)
(global-set-key (kbd "C-c o -") 'org-priority-down)
(global-set-key (kbd "C-c r")   'org-capture)
(global-set-key (kbd "C-c a")   'org-agenda)
(global-set-key (kbd "<f7> a") 'org-agenda)
(global-set-key (kbd "<f7> b") 'bbdb)
(global-set-key (kbd "<f7> c") 'calendar)
(global-set-key (kbd "<f7> f") 'boxquote-insert-file)
(global-set-key (kbd "<f7> g") 'gnus)
(global-set-key (kbd "<f7> i") (lambda ()
                                 (interactive)
                                 (info "~/git/org-mode/doc/org.info")))
(global-set-key (kbd "<f7> o") 'org-occur)
(global-set-key (kbd "<f7> r") 'boxquote-region)
(global-set-key (kbd "<f7> t") 'boxquote-title)
(global-set-key (kbd "<f7> u") (lambda ()
                                 (interactive)
                                 (untabify (point-min) (point-max))))
(global-set-key (kbd "<f7> v") 'visible-mode)
(global-set-key (kbd "C-<f7>") 'previous-buffer)
(global-set-key (kbd "C-c C-a") 'org-capture)
(global-set-key [(f6)] 'org-capture)

(setq org-speed-commands-user
      '(("A" . (let ((org-archive-default-command
                      'org-archive-to-archive-sibling))
                 (org-archive-subtree-default-with-confirmation)))
        ("y" . (progn
                 (delete-other-windows)
                 (recenter-top-bottom 0)))
        ("S" . (if (y-or-n-p "Archive this subtree or entry? ")
                   (call-interactively 'org-archive-subtree)
                 (error "Abort")))
        ("j" org-speed-move-safe 'outline-next-visible-heading)
        ("k" org-speed-move-safe 'outline-previous-visible-heading)
        ("h" org-speed-move-safe 'org-backward-same-level)
        ("l" org-speed-move-safe 'org-forward-same-level)
        ("," . (progn (org-cycle-agenda-files)
                      (when (not (and (bolp) (org-on-heading-p)))
                        (outline-previous-visible-heading 1)
                        (or (and (bolp) (org-on-heading-p))
                            (outline-next-visible-heading 1)))))
        ))

(eval-after-load "org"
  '(progn
     (define-prefix-command 'org-todo-state-map)
     (define-key org-mode-map "\C-cx" 'org-todo-state-map)
     (define-key org-todo-state-map "x"
       #'(lambda nil (interactive) (org-todo "CANCELLED")))
     (define-key org-todo-state-map "d"
       #'(lambda nil (interactive) (org-todo "DONE")))
     (define-key org-todo-state-map "f"
       #'(lambda nil (interactive) (org-todo "DEFERRED")))
     (define-key org-todo-state-map "l"
       #'(lambda nil (interactive) (org-todo "DELEGATED")))
     (define-key org-todo-state-map "s"
       #'(lambda nil (interactive) (org-todo "STARTED")))
     (define-key org-todo-state-map "w"
       #'(lambda nil (interactive) (org-todo "WAITING")))
     (define-key org-todo-state-map "s"
       #'(lambda nil (interactive) (org-todo "SOMEDAY")))
     (define-key org-todo-state-map "n"
       #'(lambda nil (interactive) (org-todo "NOTE")))
     ))

;;; (add-hook 'org-insert-heading-hook (lambda () (org-id-get-create)))
(add-hook 'org-mode-hook
          (lambda ()
            (setq local-abbrev-table text-mode-abbrev-table)
            (imenu-add-to-menubar "Imenu")
            (local-set-key [f5]
                           (lambda ()
                             (interactive)
                             (org-table-recalculate 16)))))

;;before-save-hook	                (quote (org-update-all-dblocks))
;;org-after-todo-state-change-hook	(quote (org-clock-out-if-current))

(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)
 ;; Save the running clock and all clock history when exiting Emacs,
 ;; load it on startup
(setq org-clock-persist t)
(org-clock-persistence-insinuate)

(setq
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; List your org files: typically these are your personal files and
 ;; files of projects & groups you participate in. You can also set
 ;; this through M-x org-customize or typing C-c[ in each org file.
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 org-agenda-files
 (append
  (directory-files (concat real-home-directory "/lib/org/") t ".org$" t)
  (directory-files (concat real-home-directory "/lib/journal/") t ".org$" t)
  ))

(setq
 org-agenda-add-entry-text-maxlines 3
 org-agenda-include-diary           t  ;; Include Emacs diary entries into Org-mode agenda
 ;; org-agenda-window-setup            'other-frame
 ;; org-agenda-restore-windows-after-quit t
 org-journal-dir                     (concat real-home-directory "/lib/journal/")

 ; Set default column view headings: Task Effort Clock_Summary
 ;; org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM"

 ;; Use IDO for target completion
 org-completion-use-ido              t

 org-clock-in-switch-to-state        "STARTED"
 ;; Save clock data and notes in the LOGBOOK drawer
 org-clock-into-drawer               t
 ;; Sometimes I change tasks I'm clocking quickly - this removes
 ;; clocked tasks with 0:00 duration
 org-clock-out-remove-zero-time-clocks t
 ;; set idle time to 10 minutes
 org-clock-idle-time                 10

 org-default-notes-file              "~/lib/org/refile.org"
 org-directory                       "~/lib/org"
 org-export-with-LaTeX-fragments     t ;;; Do MathJax preprocessing if there is at least on math snippet,
 org-export-latex-import-inbuffer-stuff t
 org-fast-tag-selection-single-key   t
 org-footnote-auto-adjust            t
 org-gnus-prefer-web-links           t
 org-indirect-buffer-display         'current-window
 org-icalendar-include-bbdb-anniversaries t
 org-icalendar-use-scheduled         '(todo-due event-if-todo event-if-not-todo)
 org-icalendar-use-deadline          '(todo-due event-if-todo event-if-not-todo)
 ;      org-icalendar-timezone nil
 org-insert-mode-line-in-empty-file  t
 org-log-done                        'time
 org-id-link-to-org-use-id           'create-if-interactive-and-no-custom-id

 org-link-abbrev-alist               '(("bugzilla" . "http://10.1.2.9/bugzilla/show_bug.cgi?id=")
                                       ("google"   . "http://www.google.com/search?q=")
                                       ("tt"       . "https://tt.amazon.com/%s")
                                       ("bugnum" . "http://bugs.debian.org/cgi-bin/bugreport.cgi?bug='%s'"))

 org-read-date-prefer-future         'time
 org-pretty-entities                 t
 ;;; Targets include this file and any file contributing to the agenda -
 ;;; up to 6 levels deep
 org-refile-targets                  '((org-agenda-files :maxlevel . 6) (nil :maxlevel . 6))
 org-refile-use-outline-path         'file
 ;;; Targets complete directly with IDO
 org-outline-path-complete-in-steps  nil
 ;;; Allow refile to create parent tasks with confirmation
 org-refile-allow-creating-parent-nodes 'confirm
 ;;; Exclude DONE state tasks from refile targets
 org-refile-target-verify-function   (lambda ()
                                       (not (or
                                             (member "ARCHIVE" (org-get-tags))
                                             (member (nth 2 (org-heading-components))
                                                     org-done-keywords))))


 org-return-follows-link             t
; org-show-following-heading         t
 org-special-ctrl-a/e                t
 org-special-ctrl-k                  t
 org-startup-align-all-tables        t
 org-startup-indented                t
 org-startup-folded                  nil

 ; Tags with fast selection keys
 org-tag-persistent-alist            '((:startgroup)
                                       ("@InTown" . ?t)
                                       ("@AWAY" . ?a)
                                       ("@Work" . ?w)
                                       ("@Home" . ?h)
                                       ("@Phone" . ?p)
                                       ("@Errand" . ?e)
                                       (:endgroup)
                                       ("DEBIAN" . ?D)
                                       ("HOLD" . ?H)
                                       ("EDUCATION" . ?E)
                                       ("FINDJOB" . ?F)
                                       ("JOB" . ?J)
                                       ("KEYRESULT" ?K)
                                       ("MAIL" . ?M)
                                       ("PLAY" . ?P)
                                       ("INFRASTRUCTURE" . ?I)
                                       ("CANCELLED" . ?C)
                                       ("NEXT" . ?N)
                                       ("Task" ?T)
                                       ("WAITING" . ?W)
                                       )
 ; Allow setting single tags without the menu
 org-fast-tag-selection-single-key    'expert

 ;;Though most of my org files start off with per file keywords, these
 ;;are not bad defaults.
 org-todo-keywords                  '((sequence "TODO(t)" "STARTED(s!)" "|" "DONE(d!/!)")
                                      (sequence "WAITING(w@/!)" "HOLD(h@/!)" "SOMEDAY(S!)" "ONGOING(O@)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING")
                                      (sequence "NEXT" "DELEGATED" "APPT"  "|" "DEFERRED" "NOTE")
;;                                    (sequence "DESIGN" "CODING" "PACKAGING" "|" "COMPLETE" "CANCELLED")
                                      )
 org-todo-state-tags-triggers       '(("CANCELLED" ("CANCELLED" . t)) ;;; Add waiting tag
                                      ("WAITING" ("WAITING" . t) ("NEXT")) ;;; add waiting, remove next
                                      ("SOMEDAY" ("WAITING" . t) ("NEXT"))
                                      ("HOLD" ("WAITING" . t) ("HOLD" . t))
                                      (done ("NEXT") ("WAITING") ("HOLD")) ;;; remove waiting and next
                                      ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
                                      ("STARTED" ("WAITING") ("NEXT" . t))
                                      ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
                                      ("DONE" ("WAITING") ("CANCELLED") ("HOLD"))
                                      )
 org-todo-keyword-faces             '(("TODO"      . (:foreground "red"          :weight bold))
                                      ("NEXT"      . (:foreground "red"          :weight bold))
                                      ("STARTED"   . (:foreground "blue"         :weight bold))
                                      ("ONGOIN"    . (:foreground "magenta2"     :weight bold))
                                      ("WAITING"   . (:foreground "orange"       :weight bold))
                                      ("SOMEDAY"   . (:foreground "magenta"      :weight bold))
                                      ("DELEGATED" . (:foreground "yellow"       :weight bold))
                                      ("APPT"      . (:foreground "blue"         :weight bold :underline t))
                                      ("DONE"      . (:foreground "forest green" :weight bold))
                                      ("NOTE"      . (:foreground "forest green" :weight bold))
                                      ("DEFERRED"  . (:foreground "forest green" :weight bold))
                                      ("CANCELLED" . (:foreground "forest green" :weight bold)))
 ;; allows changing todo states with S-left and S-right skipping all
 ;; of the normal processing when entering or leaving a todo
 ;; state. This cycles through the todo states but skips setting
 ;; timestamps and entering notes which is very convenient when all
 ;; you want to do is fix up the status of an entry.
 org-treat-S-cursor-todo-selection-as-state-change nil
 org-use-fast-todo-selection        t
 org-use-speed-commands             t
 org-use-sub-superscripts           "{}"
 org-yank-adjusted-subtrees         t
 outline-blank-line                 t
 )
(setq org-journal-file-format "%Y%m%d.org")

(setq org-archive-mark-done nil)
(setq org-archive-location "archive/%s::datetree/* Finished Tasks")

(defun org-skip-non-archivable-tasks ()
  "Skip trees that are not available for archiving"
  (save-restriction
    (widen)
    ;; Consider only tasks with done todo headings as archivable candidates
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
          (subtree-end (save-excursion (org-end-of-subtree t))))
      (if (member (org-get-todo-state) org-todo-keywords-1)
          (if (member (org-get-todo-state) org-done-keywords)
              (let* ((daynr (string-to-number (format-time-string "%d" (current-time))))
                     (a-month-ago (* 60 60 24 (+ daynr 1)))
                     (last-month (format-time-string "%Y-%m-" (time-subtract (current-time) (seconds-to-time a-month-ago))))
                     (this-month (format-time-string "%Y-%m-" (current-time)))
                     (subtree-is-current (save-excursion
                                           (forward-line 1)
                                           (and (< (point) subtree-end)
                                                (re-search-forward (concat last-month "\\|" this-month) subtree-end t)))))
                (if subtree-is-current
                    subtree-end ; Has a date in this month or last month, skip it
                  nil))  ; available to archive
            (or subtree-end (point-max)))
        next-headline))))

;;  #+LaTeX_CLASS: beamer
;;  #+LaTeX_HEADER: \titlegraphic{\includegraphics{foo.png}}
;;  #+BIND: org-export-latex-image-default-option "width=1cm"
;;  #+AUTHOR: Manoj Srivastava \\ $<$\href{mailto:srivasta@golden-gryphon.com}{srivasta@golden-gryphon.com}$>$

;;o Level 1 headlines become slide titles.
;;o Level 2 headlines become items in the slide and the text under the level
;;  2 headlines ends up as text in the item.
;;o Level 3 headlines (not shown in the sample document) were supposed to
;;  become notes, but this obviously will not work this way. I don't know
;;  how to make it work. In the end, I edited the tex file by hand in
;;  order to get the notes right.
;;o Moreover (and I think this is a bug in the latex exporter), I had to
;;  rearrange the notes by hand: they ended up in the wrong slides.
;;  I have had zero time to chase this however, so I am not really sure
;;  why this happened.
;;o There was a problem with the table of contents (it's empty and it pushes
;;  the title of the first slide down), so I manually zapped it from
;;  the tex file.
;;o Latex had some peculiar objections to the labels and I did not care
;;  about them, so I preprocessed them out of existence in the tex file.

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      '(("t" "todo" entry
         (file+headline "~/lib/org/refile.org" "Tasks")
         "* TODO %?\n  %u\n  %i\n  %a" :clock-in t :clock-resume t)
        ("r" "respond" entry (file "~/lib/org/refile.org")
         "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
        ("n" "note" checkitem
         (file+headline "~/lib/org/refile.org" "Notes"))
        ("w" "org-protocol" entry (file "~/lib/org/refile.org")
         "* TODO Review %c\n%U\n" :immediate-finish t)
        ("m" "Meeting" entry (file "~/lib/org/refile.org")
         "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
        ("p" "Phone call" entry
         (file "~/lib/org/refile.org")
         "* PHONE %:name - %:company - :PHONE:\n  Contact Info: %a\n  %u\n  %?" :clock-in t :clock-resume t)
        ("j" "jira" entry
         (file+datetree "~/lib/org/Jira.org")
         "* TODO [[%x][JIRA %x]] %? :WORK:\n  %u\n" :immediate-finish t :clock-in t :clock-resume t :unnarrowed t )
        ("o" "oncall" entry
         (file+datetree "~/lib/org/Oncall.org")
         "* TODO %^{Entry} %? :WORK:\n  %u\n  %i\n  %a" :immediate-finish t :clock-in t :clock-resume t)
        ("d" "Diary" entry (file+datetree "~/lib/org/diary.org")
         "* %?\n%U\n" :clock-in t :clock-resume t)
        ("h" "Habit" entry (file "~/lib/org/refile.org")
         "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")
        ("b" "bug" entry
         (file+datetree "~/lib/org/tickets.org")
         "* TODO [[tt:%x][Ticket %x]] :TICKET:\n:PROPERTIES:\n\t:CREATED: %U\n:END:\n\n  %i\n  %a\n - Status: %?" :immediate-finish t :clock-in t :clock-resume t :unnarrowed t )
        ))

;;; Publishing
(require 'ox-publish)
(setq
 org-publish-project-alist
 '(("manoj" :components ("landing"))
   ("landing"
    :base-directory "~/lib/org/"
    :base-extension "org"
    :publishing-directory "~/public_html/"
    :recursive t
    :publishing-function org-html-publish-to-html
    :export-with-tags t
    :headline-levels 4             ; Just the default for this project.
    :table-of-contents t
    :timestamp t
    :exclude-tags ("noexport")
    :auto-preamble t
    )
   ("time-report"
    :base-directory "~/lib/org/"
    :base-extension "org"
    :style "This is raw html for stylesheet <link>'s"
    :html-preamble "blog header goes here"
    :html-postamble nil
    :section-numbers nil
    :sub-superscript nil
    :todo-keywords nil
    :author nil
    :creator-info nil
    :publishing-directory "~/public_html/"
    :recursive t
    :publishing-function org-publish-org-to-html
    )
   ("notes"
    :base-directory "~/lib/org/"
    :base-extension "org"
    :publishing-directory "~/public_html/"
    :recursive t
    :publishing-function org-publish-org-to-html
    )
   ))

;;;
;;; Clocking
;;;

;; Save the running clock and all clock history when exiting Emacs,
;; load it on startup
(setq org-clock-persist t)
(org-clock-persistence-insinuate)
(defvar org-keep-clock-running nil
  "*Whether or not to keep the clock running ion org mode."
  )
(require 'org-clock)

(setq
 ;; Show lot of clocking history so it's easy to pick items off the C-F11 list
 org-clock-history-length            23
 org-clock-in-switch-to-state        "STARTED"
 ;; Save clock data and notes in the LOGBOOK drawer
 org-clock-into-drawer               t
 ;; Sometimes I change tasks I'm clocking quickly - this removes
 ;; clocked tasks with 0:00 duration
 org-clock-out-remove-zero-time-clocks t
 ;; set idle time to 10 minutes
 org-clock-idle-time                 10
 ;; Resume clocking task on clock-in if the clock is open
 org-clock-in-resume t
 ;; Change tasks to NEXT when clocking in
 org-clock-in-switch-to-state 'org-clock-in-to-next
 ;; Separate drawers for clocking and logs
 org-drawers (quote ("PROPERTIES" "LOGBOOK"))
 ;; Clock out when moving task to a done state
 org-clock-out-when-done t
 ;; Do not prompt to resume an active clock
 org-clock-persist-query-resume nil
 ;; Enable auto clock resolution for finding open clocks
 org-clock-auto-clock-resolution 'when-no-clock-is-running
 ;; Include current clocking task in clock reports
 org-clock-report-include-clocking-task t
 )


(defun org-clock-in-to-next (kw)
  "Switch a task from TODO to NEXT when clocking in.
Skips capture tasks, projects, and subprojects.
Switch projects and subprojects from NEXT back to TODO"
  (when (not (and (boundp 'org-capture-mode) org-capture-mode))
    (cond
     ((and (member (org-get-todo-state) (list "TODO"))
           (org-is-task-p))
      "NEXT")
     ((and (member (org-get-todo-state) (list "NEXT"))
           (org-is-project-p))
      "TODO"))))

(defun org-find-project-task ()
  "Move point to the parent (project) task if any"
  (save-restriction
    (widen)
    (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
      (while (org-up-heading-safe)
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq parent-task (point))))
      (goto-char parent-task)
      parent-task)))

(defun org-punch-in (arg)
  "Start continuous clocking and set the default task to the
selected task.  If no task is selected set the Organization task
as the default task."
  (interactive "p")
  (setq org-keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
      ;;
      ;; We're in the agenda
      ;;
      (let* ((marker (org-get-at-bol 'org-hd-marker))
             (tags (org-with-point-at marker (org-get-tags-at))))
        (if (and (eq arg 4) tags)
            (org-agenda-clock-in '(16))
          (org-clock-in-organization-task-as-default)))
    ;;
    ;; We are not in the agenda
    ;;
    (save-restriction
      (widen)
      ; Find the tags on the current task
      (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
          (org-clock-in '(16))
        (org-clock-in-organization-task-as-default)))))

(defun org-punch-out ()
  (interactive)
  (setq org-keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out))
  (org-agenda-remove-restriction-lock))

(defun org-clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))

(defun org-clock-in-parent-task ()
  "Move point to the parent (project) task if any and clock in"
  (let ((parent-task))
    (save-excursion
      (save-restriction
        (widen)
        (while (and (not parent-task) (org-up-heading-safe))
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq parent-task (point))))
        (if parent-task
            (org-with-point-at parent-task
              (org-clock-in))
          (when org-keep-clock-running
            (org-clock-in-default-task)))))))

(defvar org-organization-task-id "eb155a82-92b2-4f25-a3c6-0304591af2f9")

(defun org-clock-in-organization-task-as-default ()
  (interactive)
  (org-with-point-at (org-id-find org-organization-task-id 'marker)
    (org-clock-in '(16))))

(defun org-clock-out-maybe ()
  (when (and org-keep-clock-running
             (not org-clock-clocking-in)
             (marker-buffer org-clock-default-task)
             (not org-clock-resolving-clocks-due-to-idleness))
    (org-clock-in-parent-task)))

(add-hook 'org-clock-out-hook 'org-clock-out-maybe 'append)


;; Remove empty LOGBOOK drawers on clock out
(defun remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (while (re-search-forward org-drawer-regexp nil t)
      (org-remove-empty-drawer-at (point)))))

(add-hook 'org-clock-out-hook 'remove-empty-drawer-on-clock-out 'append)


(defun org-task-hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading 'invisible-ok)
    (outline-hide-other)
    (org-cycle)
    (org-cycle)
    (org-cycle)))

;;; These steal [tab]
;; (add-hook 'message-mode-hook 'turn-on-orgtbl)
;; (add-hook 'message-mode-hook 'turn-on-orgstruct)

(add-hook 'message-mode-hook
          (lambda nil
            (setq fill-column 72)
            ;; (flyspell-mode 1)
            ;; (orgstruct++-mode 1)
            (turn-on-auto-fill)
            ))

;;
;; Phone capture template handling with BBDB lookup
;; Adapted from code by Gregory J. Grubbs
(defun org-phone-call ()
  "Return name and company info for caller from bbdb lookup"
  (interactive)
  (let* (name rec caller)
    (setq name (completing-read "Who is calling? "
                                (bbdb-hashtable)
                                'bbdb-completion-predicate
                                'confirm))
    (when (> (length name) 0)
      ; Something was supplied - look it up in bbdb
      (setq rec
            (or (first
                 (or (bbdb-search (bbdb-records) name nil nil)
                     (bbdb-search (bbdb-records) nil name nil)))
                name)))

    ; Build the bbdb link if we have a bbdb record, otherwise just return the name
    (setq caller (cond ((and rec (vectorp rec))
                        (let ((name (bbdb-record-name rec))
                              (company (bbdb-record-company rec)))
                          (concat "[[bbdb:"
                                  name "]["
                                  name "]]"
                                  (when company
                                    (concat " - " company)))))
                       (rec)
                       (t "NameOfCaller")))
    (insert caller)))

;;iimage
(require 'iimage)
(setq iimage-mode-image-search-path (expand-file-name "~/"))

;;Match org file: links
(add-to-list 'iimage-mode-image-regex-alist
             (cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex
                           "\\)\\]")  1))
(define-key org-mode-map [(control c) ?i] 'iimage-mode)

;;;;
;;;; org agenda
;;;;

(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
;; Agenda clock report parameters
(setq org-agenda-clockreport-parameter-plist
      (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 90)))
;;; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)
(defun org-auto-exclude-function (tag)
  "Automatic task exclusion in the agenda with / RET"
  (and (cond
        ((string= tag "hold")
         t)
        ((string= tag "farm")
         t))
       (concat "-" tag)))

(setq org-agenda-auto-exclude-function 'org-auto-exclude-function)

(defun org-is-project-p ()
  "Any task with a todo keyword subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task has-subtask))))

(defun org-is-project-subtree-p ()
  "Any task with a todo keyword that is in a project subtree.
Callers of this function already widen the buffer view."
  (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
                              (point))))
    (save-excursion
      (org-find-project-task)
      (if (equal (point) task)
          nil
        t))))

(defun org-is-task-p ()
  "Any task with a todo keyword and no subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task (not has-subtask)))))

(defun org-is-subproject-p ()
  "Any task which is a subtask of another project"
  (let ((is-subproject)
        (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
    (save-excursion
      (while (and (not is-subproject) (org-up-heading-safe))
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq is-subproject t))))
    (and is-a-task is-subproject)))

(defun org-list-sublevels-for-projects-indented ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels 'indented)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defun org-list-sublevels-for-projects ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels t)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defvar org-hide-scheduled-and-waiting-next-tasks t)

(defun org-toggle-next-task-display ()
  (interactive)
  (setq org-hide-scheduled-and-waiting-next-tasks (not org-hide-scheduled-and-waiting-next-tasks))
  (when  (equal major-mode 'org-agenda-mode)
    (org-agenda-redo))
  (message "%s WAITING and SCHEDULED NEXT Tasks" (if org-hide-scheduled-and-waiting-next-tasks "Hide" "Show")))

(defun org-skip-stuck-projects ()
  "Skip trees that are not stuck projects"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (org-is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                nil
              next-headline)) ; a stuck project, has subtasks but no next task
        nil))))

(defun org-skip-non-stuck-projects ()
  "Skip trees that are not stuck projects"
  (org-list-sublevels-for-projects-indented)
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (org-is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                next-headline
              nil)) ; a stuck project, has subtasks but no next task
        next-headline))))

(defun org-skip-non-projects ()
  "Skip trees that are not projects"
  (org-list-sublevels-for-projects-indented)
  (if (save-excursion (org-skip-non-stuck-projects))
      (save-restriction
        (widen)
        (let ((subtree-end (save-excursion (org-end-of-subtree t))))
          (cond
           ((and (org-is-project-p)
                 (marker-buffer org-agenda-restrict-begin))
            nil)
           ((and (org-is-project-p)
                 (not (marker-buffer org-agenda-restrict-begin))
                 (not (org-is-project-subtree-p)))
            nil)
           (t
            subtree-end))))
    (save-excursion (org-end-of-subtree t))))

(defun org-skip-project-trees-and-habits ()
  "Skip trees that are projects"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((org-is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun org-skip-projects-and-habits-and-single-tasks ()
  "Skip trees that are projects, tasks that are habits, single non-project tasks"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((org-is-habit-p)
        next-headline)
       ((and org-hide-scheduled-and-waiting-next-tasks
             (member "WAITING" (org-get-tags-at)))
        next-headline)
       ((org-is-project-p)
        next-headline)
       ((and (org-is-task-p) (not (org-is-project-subtree-p)))
        next-headline)
       (t
        nil)))))

(defun org-skip-project-tasks-maybe ()
  "Show tasks related to the current restriction.
When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
When not restricted, skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (next-headline (save-excursion (or (outline-next-heading) (point-max))))
           (limit-to-project (marker-buffer org-agenda-restrict-begin)))
      (cond
       ((org-is-project-p)
        next-headline)
       ((org-is-habit-p)
        subtree-end)
       ((and (not limit-to-project)
             (org-is-project-subtree-p))
        subtree-end)
       ((and limit-to-project
             (org-is-project-subtree-p)
             (member (org-get-todo-state) (list "NEXT")))
        subtree-end)
       (t
        nil)))))

(defun org-skip-projects-and-habits ()
  "Skip trees that are projects and tasks that are habits"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((org-is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun org-skip-non-subprojects ()
  "Skip trees that are not projects"
  (let ((next-headline (save-excursion (outline-next-heading))))
    (if (org-is-subproject-p)
        nil
      next-headline)))

;;; The Agenda is:
;;; - A calendar view of dates (single day, week, month)            (C-c a a)
;;; - A list of todo items collected from multiple org-agenda-files (C-c a t)
;;; - A general search tool through all of your org-agenda-files    (C-c a /)
;;; - A list of things matching tags                                (C-c a m)
;; Custom agenda command definitions
(setq org-agenda-custom-commands
      '(
        (" " "Agenda"
         ((agenda "" nil)
          (tags "REFILE"
                ((org-agenda-overriding-header "Tasks to Refile")
                 (org-tags-match-list-sublevels nil)))
          (tags-todo "-CANCELLED/!"
                     ((org-agenda-overriding-header "Stuck Projects")
                      (org-agenda-skip-function 'org-skip-non-stuck-projects)
                      (org-agenda-sorting-strategy
                       '(priority-down category-keep))))
          (tags-todo "-HOLD-CANCELLED/!"
                     ((org-agenda-overriding-header "Projects")
                      (org-agenda-skip-function 'org-skip-non-projects)
                      (org-agenda-sorting-strategy
                       '(priority-down category-keep))))
          (tags-todo "-CANCELLED/!NEXT"
                     ((org-agenda-overriding-header "Project Next Tasks")
                      (org-agenda-skip-function 'org-skip-projects-and-habits-and-single-tasks)
                      (org-tags-match-list-sublevels t)
                      (org-agenda-todo-ignore-scheduled org-hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-todo-ignore-deadlines org-hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-todo-ignore-with-date org-hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-sorting-strategy
                       '(priority-down todo-state-down effort-up category-keep))))
          (tags-todo "-REFILE-CANCELLED-WAITING/!"
                     ((org-agenda-overriding-header (if (marker-buffer org-agenda-restrict-begin) "Project Subtasks" "Standalone Tasks"))
                      (org-agenda-skip-function 'org-skip-project-tasks-maybe)
                      (org-agenda-todo-ignore-scheduled org-hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-todo-ignore-deadlines org-hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-todo-ignore-with-date org-hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-sorting-strategy
                       '(category-keep))))
          (tags-todo "-CANCELLED+WAITING/!"
                     ((org-agenda-overriding-header "Waiting and Postponed Tasks")
                      (org-agenda-skip-function 'org-skip-stuck-projects)
                      (org-tags-match-list-sublevels nil)
                      (org-agenda-todo-ignore-scheduled 'future)
                      (org-agenda-todo-ignore-deadlines 'future)))
          (tags "-REFILE/"
                ((org-agenda-overriding-header "Tasks to Archive")
                 (org-agenda-skip-function 'org-skip-non-archivable-tasks)
                 (org-tags-match-list-sublevels nil))))
         nil)
        ("c" "comlpleted tasks"           todo "DONE|DEFERRED|CANCELLED" nil)
        ("s" "Started Tasks"              todo "STARTED" ((org-agenda-todo-ignore-with-date nil)))
        ("o" "Others are doing it"        todo "DELEGATED" nil)
        ("w" "Tasks waiting on something" tags "WAITING/!" ((org-use-tag-inheritance nil)))
        ("r" "Refile New Notes and Tasks" tags "LEVEL=1+REFILE" ((org-agenda-todo-ignore-with-date nil)))
        ("n" "Next"                       tags "NEXT-WAITING-CANCELLED/!" nil)
        ("f" "FIXME items"                occur-tree "FIXME")
        ("d" "Due today"                  agenda ""
         ((org-deadline-warning-days 0)
          (org-agenda-skip-scheduled-if-deadline-is-shown t)
          (org-agenda-skip-function
           (lambda ()
             (let* ((dl (org-entry-get nil "DEADLINE")))
               (if (or (not dl)
                       (equal dl "")
                       (org-time> dl (org-time-today)))
                   (progn (outline-next-heading) (point))))))))
        ("D" . "Deadlines after various days") ;;; Describe prefix
        ("D2" agenda "X-Agenda 1 days deadline preview" ((org-deadline-warning-days  1)))
        ("D2" agenda "X-Agenda 2 days deadline preview" ((org-deadline-warning-days 2)))
        ("D3" agenda "X-Agenda 3 days deadline preview" ((org-deadline-warning-days 3)))
        ("D7" agenda "X-Agenda 7 days deadline preview" ((org-deadline-warning-days 7)))
        ("D8" agenda "X-Agenda 14 days deadline preview" ((org-deadline-warning-days 14)))
        ("DL" agenda "" ((org-agenda-ndays 21)))
        ("N" "Notes" tags "NOTE"
         ((org-agenda-overriding-header "Notes")
          (org-tags-match-list-sublevels t)))
        ("h" "Habits" tags-todo "STYLE=\"habit\""
         ((org-agenda-overriding-header "Habits")
          (org-agenda-sorting-strategy
           '(todo-state-down effort-up category-keep))))
        ;;; print my agenda for the day, but including data, not just the
        ;;; heading.
        ("x" "Export Agenda"             agenda ""
         ((org-agenda-before-write-hook '(org-agenda-add-entry-text))
          (org-agenda-add-entry-text-maxlines 5)) ("agenda.txt"))
        ))

;;;
;;; Publishing
;;;

(setq org-list-allow-alphabetical t)

;; Explicitly load required exporters
(require 'ox-html)
(require 'ox-latex)
(require 'ox-ascii)


(setq
 org-html-head
 "
<style type=\"text/css\">
  html { font-family: Times, serif; font-size: 12pt; }
  body {
    color: LightSlateGray;
    background-color: #000000;
    font-family: Palatino, \"Palatino Linotype\", \"Times New Roman\", Times, Georgia, Utopia, serif;
  }
  .timestamp { color: grey }
  .timestamp-kwd { color: CadetBlue }
  pre {
        border: 1pt solid #AEBDCC;
        color: gainsboro;
        background-color: DarkSlateGrey;
        font-family: \"Courier New\", courier, monospace;
        font-size: 90%;
        overflow:auto;
        margin: 1.2em;
  }
  table {
        border-collapse: collapse; /*separate; */
        border: outset 3pt;
        border-spacing: 0pt;
        /* border-spacing: 5pt; */
        }
  div.figure { padding: 0.5em; }
  div.figure p { text-align: center; }
  .linenr { font-size:smaller }
  .code-highlighted {background-color:#ffff00;}
  .org-info-js_info-navigation { border-style:none; }
  #org-info-js_console-label { font-size:10px; font-weight:bold;
                               white-space:nowrap; }
  .org-info-js_search-highlight {background-color:#ffff00; color:#000000;
                                 font-weight:bold; }

  .org-agenda-date          { color: #87cefa;    }
  .org-agenda-structure     { color: #87cefa;    }
  .org-scheduled            { color: #98fb98;    }
  .org-scheduled-previously { color: #ff7f24;    }
  .org-scheduled-today      { color: #98fb98;    }
  .org-tag                  { font-weight: bold; }
  .org-todo                 {
    color: #ffc0cb;
    font-weight: bold;
  }

  a {
    color: inherit;
    background-color: inherit;
    font: inherit;
    text-decoration: underline;
  }
  a:hover { text-decoration: underline; }
  .TODO { color:red; }
  .WAITING { color:orange; }
  .DONE { color:green; }
  .target { font-weight:bold; color: lightsteelblue3; }

tt, code, kbd, samp { font-family: \"Courier New\", Courier, monospace }

dd {margin-bottom: 0.66em;}

<script =\"text/javascript\" language=\"JavaScript\" src=\"/styles/org-info.js\"></script>
<script type=\"text/javascript\" language=\"JavaScript\">
/* <![CDATA[ */
             org_html_manager.set(\"LOCAL_TOC\", 0);
             org_html_manager.set(\"VIEW_BUTTONS\", 1);
             org_html_manager.set(\"VIEW\", \"info\");
             org_html_manager.set(\"TOC\", 1);
             org_html_manager.set(\"MOUSE_HINT\", \"underline\"); // could be a background-color like #eeeeee
             org_html_manager.setup ();
             /* ]]> */
</script>
</style>
")

(require 'ob)

;;; (org-babel-do-load-languages
;;;  'org-babel-load-languages
;;;  '((sh . t)))

(defun my-toggle-off-babel (backend)
  (when (org-export-derived-backend-p backend 'icalendar)
    (org-set-local 'org-confirm-babel-evaluate nil)
    (org-set-local 'org-export-babel-evaluate nil)))

(add-hook 'org-export-before-processing-hook #'my-toggle-off-babel)


;; To use:
;;
;; Assumes that you have an N level categorisation of tasks using specific
;; properties.
;;
;; Insert two lines like this in an org-mode buffer:
;;
;; #+BEGIN: clocktable :maxlevel 9 :properties ("CATEGORY" "Project") :scope agenda :block lastweek :link nil :formatter nik/org-clocktable-snippets
;; #+END:
;;
;; Put the cursor on the BEGIN line and C-c C-c. That should fetch
;; items from all files known to your agenda that had activity in the
;; previous week and produce roughly Markdown formatted output useful
;; for pasting in to snippets. Only entries with a keyword that
;; matches one of your org-todo-keywords are included.
;;
;; The ":properties" section is a list of properties that will be used
;; as headings in the Markdown output. Each task in a tree in a file
;; that has a property named after this will have these headings set
;; first.
;;
;; # [:CATEGORY:] (e.g., "Main project")
;;
;; ## [:Project:] (e.g., "Sub project 1")
;;
;; - Item 1
;; - Item 2
;; - Item 3
;;
;; # [:CATEGORY:] (e.g., "20% project")
;;
;; ## [:Project:] (e.g., "20% sub project 1")
;;
;; - Item 1
;; - Item 2
;; - Item 3
;;
;; Known issues:
;;
;; - If you re-use a property value across multiple files then the headings
;;   will appear in the output multiple times, and must be manually cleaned
;;   up.


(defun nik/org-clocktable-snippets (ipos tables params)
  (let* ((properties (plist-get params :properties))
         (todo-regexp (concat "\\<" (regexp-opt org-todo-keywords-1 t) "\\>"))
         tbl total-time file-time entries entry headline level)

    (setq total-time (apply '+ (mapcar 'cadr tables)))
    (goto-char ipos)

    (when (and total-time (> total-time 0))
      (while (setq tbl (pop tables))
        ;; now tbl is the table resulting from one file.
        (setq file-time (nth 1 tbl))
        ;; Iterate over all entries that have time associated with them.
        (when (and file-time (> file-time 0))
          (setq entries (nth 2 tbl))
          (while (setq entry (pop entries))
            (setq level (car entry)
                  headline (nth 1 entry))

            (setq heading-level 1)
            ;; Insert all the property values that apply to these tasks
            ;; as Markdown headings (of increasing level)
            (dolist (p properties)
              (setq prop-val (cdr (assoc p (nth 4 entry))))
              (setq heading-level (1+ heading-level))
              (when prop-val
                (insert "\n")
                (insert (concat (make-string heading-level ?#) " " prop-val "\n"))
                ))
            ;; Insert the headline, preceeded by 0-n spaces (in
            ;; multiples of 4) depending on the task level.
            (when (string-match-p todo-regexp (nth 1 entry))
              (insert (concat
                       ;;; (make-string (* (- level 1) 4) ?\s)
                       "- " headline "\n"))
              )))))))

(provide 'my-org)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; my-org.el ends here

;;; Local Variables:
;;; mode: emacs-lisp
;;; comment-column: 0
;;; comment-start: ";;; "
;;; after-save-hook: ((lambda () (byte-compile-file buffer-file-name)))
;;; End:
