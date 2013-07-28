;;; my-faces.el ---
;;
;; Filename: my-faces.el
;; Description:
;; Author: Manoj Srivastava
;; Maintainer:
;; Created: Fri Apr 25 16:12:34 2014 (-0700)
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
(defgroup manoj-faces nil "Custom faces for Manoj's dark theme." :group 'faces)

 ;; Non-default faces
(defface font-lock-emphasized-face    '((t (:bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-lock-other-emphasized-face '((t (:italic t :bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface gnus-splash '((t (:foreground "#cccccc")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface gnus-splash-face '((t (:foreground "#cccccc")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface gnus-topic-face '((t (:italic t :bold t :foreground "lavender" :background "black" :slant italic :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface fp-topic-face '((t (:italic t :bold t :background "black" :foreground "lavender" :slant italic :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface face-6 '((t (:foreground "pink")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface face-7 '((t (:foreground "steelblue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface face-8 '((t (:foreground "lime green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface my-gnus-direct-fup-face '((t (:bold t :background "NavyBlue" :foreground "#70fc70" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-gnus-indirect-fup-face '((t (:bold t :background "#092109" :foreground "#7fff7f" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-gnus-own-posting-face '((t (:bold t :background "#210909" :foreground "chartreuse3" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface my-group-face-2 '((t (:bold t :foreground "DarkSeaGreen1" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-face-3 '((t (:bold t :foreground "Green1" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-face-4 '((t (:bold t :foreground "LightSteelBlue" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-face-5 '((t (:bold t :foreground "beige" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface my-group-mail-unread-crit-1 '((t (:bold t :foreground "#99FFAA" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-mail-unread-crit-2 '((t (:foreground "#99FF9C" :weight normal)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-mail-unread-crit-3 '((t (:foreground "#A3FF99" :weight normal)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface my-group-mail-unread-high-1 '((t (:bold t :foreground "#B1FF99" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-mail-unread-high-2 '((t (:foreground "#BEFF99" :weight normal)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-mail-unread-high-3 '((t (:foreground "#CCFF99" :weight normal)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface my-group-mail-unread-mod-1 '((t (:bold t :foreground "#DAFF99" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-mail-unread-mod-2 '((t (:foreground "#E7FF99" :weight normal)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface my-group-mail-unread-mod-3 '((t (:foreground "#F5FF99" :weight normal)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface my-group-news-unread-crit-3 '((t (:bold t :foreground "#BFB3FF" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-news-unread-crit-4 '((t (:bold t :foreground "#BAB3FF" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-news-unread-crit-5 '((t (:foreground "#B5B3FF" :weight normal)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-news-unread-crit-6 '((t (:foreground "#B3B5FF" :weight normal)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface my-group-news-unread-high-3 '((t (:bold t :foreground "#B3BAFF" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-news-unread-high-4 '((t (:bold t :foreground "#B3BFFF" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-news-unread-high-5 '((t (:foreground "#B3C4FF" :weight normal)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-news-unread-high-6 '((t (:foreground "#B3C9FF" :weight normal)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface my-group-news-unread-mod-3 '((t (:bold t :foreground "#B3CFFF" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-news-unread-mod-4 '((t (:bold t :foreground "#B3D4FF" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-news-unread-mod-5 '((t (:foreground "#B3D9FF" :weight normal)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface my-group-news-unread-mod-6 '((t (:foreground "#B3DEFF" :weight normal)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface mmm-face '((t (:background "black" :foreground "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface apt-utils-broken-face '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface apt-utils-description-face '((t (:foreground "cadet blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface apt-utils-field-contents-face '((t (:foreground "orange")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface apt-utils-field-keyword-face '((t (:bold t :foreground "purple" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface apt-utils-file-face '((t (:foreground "brown")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface apt-utils-installed-status-face '((t (:italic t :slant italic)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface apt-utils-normal-package-face '((t (:foreground "yellow")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface apt-utils-version-face '((t (:italic t :slant italic)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface apt-utils-virtual-package-face '((t (:foreground "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface blank-space-face '((t (:background "DarkGray")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface blank-tab-face '((t (:foreground "black" :background "cornsilk")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface browse-kill-ring-separator-face '((t (:bold t :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface clearcase-dired-checkedout-face '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface clear-case-mode-string-face '((t (:bold t
                                          :box '(:line-width 2 :color "grey"
                                                             :style released-button)
                                          :foreground "black"
                                          :background "grey" :weight bold
                                          :height 0.9)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface buffer-menu-buffer '((t (:bold t :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface buffers-tab '((t (:background "black" :foreground "LightSkyBlue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface cparen-around-andor-face '((t (:bold t :foreground "burlywood1" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cparen-around-begin-face '((t (:foreground "wheat1")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cparen-around-conditional-face '((t (:bold t :foreground "PaleTurquoise1" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cparen-around-define-face '((t (:bold t :foreground "CadetBlue1" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cparen-around-lambda-face '((t (:foreground "LightGreen")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cparen-around-letdo-face '((t (:bold t :foreground "SeaGreen1" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cparen-around-quote-face '((t (:foreground "SlateGray1")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cparen-around-set!-face '((t (:foreground "LightSalmon1")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cparen-around-syntax-rules-face '((t (:foreground "Magenta1")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cparen-around-vector-face '((t (:foreground "chocolat1")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cparen-binding-face '((t (:foreground "PaleGreen")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cparen-binding-list-face '((t (:bold t :foreground "PaleGreen" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cparen-conditional-clause-face '((t (:foreground "LightSkyBlue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cparen-normal-paren-face '((t (:foreground "grey50")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface cscope-file-face '((t (:foreground "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cscope-function-face '((t (:foreground "magenta")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cscope-line-face '((t (:foreground "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cscope-line-number-face '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cscope-mouse-face '((t (:background "blue" :foreground "white")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface cvs-handled-face '((t (:foreground "pink")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cvs-header-face '((t (:foreground "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cvs-marked-face '((t (:bold t :foreground "green3")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cvs-msg-face '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cvs-need-action-face '((t (:foreground "yellow")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cvs-unknown-face '((t (:foreground "grey")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface darcsum-header-face '((t (:foreground "lemon chiffon")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface darcsum-marked-face '((t (:bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface darcsum-need-action-face '((t (:foreground "orange red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface darcsum-need-action-marked-face '((t (:foreground "orange red" :bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface darcsum-filename-face '((t (:foreground "light sea green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface darcsum-changed-line-face '((t (:background "gray30" :foreground "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface debian-changelog-warning-face '((t (:bold t :foreground "Pink" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface develock-bad-manner '((t (:background "Yellow" :foreground "Black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface develock-lonely-parentheses '((t (:background "PaleTurquoise" :foreground "Blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface develock-long-line-1 '((t (:foreground "Orange")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface develock-long-line-2 '((t (:background "#1a1a42")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface develock-reachable-mail-address '((t (:background "LemonChiffon" :foreground "DarkGreen")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface develock-upper-case-attribute '((t (:background "Wheat" :foreground "Black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface develock-upper-case-tag '((t (:background "PowderBlue" :foreground "Black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface develock-whitespace-1 '((t (:background "Red" :foreground "Black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface develock-whitespace-2 '((t (:background "Orange" :foreground "Black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface develock-whitespace-3 '((t (:background "Yellow" :foreground "Black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface dictionary-button-face '((t (:bold t :weight bold :background "lightgrey"
                                     :foreground "black"
                                     :box '(:line-width 2 :style released-button t))))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface dictionary-reference-face '((t (:foreground "yellow")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface dictionary-word-entry-face '((t (:italic t :slant italic)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface dired-face-boring '((t (:foreground "Gray65")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface dired-face-directory '((t (:bold t :foreground "SkyBlue2")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface dired-face-executable '((t (:foreground "Green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface dired-face-flagged '((t (:background "DarkSlateGray" :foreground "LemonChiffon")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface dired-face-header '((t (:background "grey15" :foreground "OldLace")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface dired-face-marked '((t (:background "PaleVioletRed")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface dired-face-permissions '((t (:background "grey75" :foreground "black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface dired-face-setuid '((t (:foreground "Red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface dired-face-socket '((t (:foreground "magenta")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface dired-face-symlink '((t (:foreground "cyan")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface display-time-mail-balloon-enhance-face '((t (:background "orange")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface display-time-mail-balloon-gnus-group-face '((t (:foreground "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface display-time-time-balloon-face '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface ff-paths-non-existent-file-face '((t (:bold t :foreground "NavyBlue" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface fixed-pitch '((t (:family "courier")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface fl-comment-face '((t (:foreground "pink")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface fl-doc-string-face '((t (:foreground "purple")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface fl-function-name-face '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface fl-keyword-face '((t (:foreground "cyan")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface fl-string-face '((t (:foreground "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface fl-type-face '((t (:foreground "yellow")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface font-latex-bold-face '((t (:bold t :foreground "medium sea green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-italic-face '((t (:slant italic :foreground "medium sea green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-math-face '((t (:foreground "sandy brown")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-sectioning-0-face '((t (:foreground "khaki")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-sectioning-1-face '((t (:foreground "khaki")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-sectioning-2-face '((t (:foreground "khaki")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-sectioning-3-face '((t (:foreground "khaki")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-sectioning-4-face '((t (:foreground "khaki")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-sedate-face '((t (:foreground "Gray85")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-string-face '((t (:foreground "orange")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-warning-face '((t (:foreground "indian red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-title-1-face '((t (:foreground "LightSteelBlue"  :weight bold :height 1.728)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-title-2-face '((t (:foreground "LightSteelBlue"  :weight bold :height 1.44)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-title-3-face '((t (:foreground "LightSteelBlue"  :weight bold :height 1.2)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface font-latex-title-4-face '((t (:foreground "LightSteelBlue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface gdb-arrow-face '((t (:bold t :background "yellow" :foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface green '((t (:foreground "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface gui-button-face '((t (:background "grey75" :foreground "black" :box (:line-width 2 :style released-button))))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface gui-element '((t (:height 1.2 :background "#D4D0C8" :foreground "black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface tinyreplace-:face '((t (:background "darkseagreen2" :foreground "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface vc-mode-face  '((t (:background "darkseagreen2" :foreground "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface highline '((t (:background "darkolivegreen")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface highline-face '((t (:background "darkolivegreen")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface html-helper-bold-face '((t (:bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface html-helper-italic-face '((t (:bold t :foreground "yellow")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface html-helper-underline-face '((t (:underline t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface html-helper-significant-tag-face '((t (:foreground "cadet blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface hyper-apropos-documentation '((t (:foreground "white")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface hyper-apropos-heading '((t (:bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface hyper-apropos-hyperlink '((t (:foreground "sky blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface hyper-apropos-major-heading '((t (:bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface hyper-apropos-section-heading '((t (:bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface hyper-apropos-warning '((t (:bold t :foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface jde-bug-breakpoint-cursor '((t (:background "brown" :foreground "cyan")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-db-active-breakpoint-face '((t (:background "red" :foreground "black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-db-requested-breakpoint-face '((t (:background "yellow" :foreground "black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-db-spec-breakpoint-face '((t (:background "green" :foreground "black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-java-font-lock-api-face '((t (:foreground "light goldenrod")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-java-font-lock-bold-face '((t (:bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-java-font-lock-constant-face '((t (:foreground "Aquamarine")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-java-font-lock-doc-tag-face '((t (:foreground "light coral")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-java-font-lock-italic-face '((t (:italic t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-java-font-lock-link-face '((t (:underline t :foreground "cadetblue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-java-font-lock-modifier-face '((t (:foreground "LightSteelBlue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-java-font-lock-number-face '((t (:foreground "LightSalmon")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-java-font-lock-operator-face '((t (:foreground "medium blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-java-font-lock-package-face '((t (:foreground "steelblue1")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface jde-java-font-lock-underline-face '((t (:underline t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface linemenu-face '((t (:background "gray30")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface list-mode-item-selected '((t (:background "gray68" :foreground "dark green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface magit-section-title '((t :weight bold :inherit diff-index-face))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface magit-branch '((t :weight bold :inherit diff-function-face))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface magit-diff-file-header '((t :inherit diff-file-header))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface magit-diff-hunk-header '((t :slant italic :inherit diff-hunk-header))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface magit-diff-add '((t :inherit diff-added))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface magit-diff-del '((t  :inherit diff-removed))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface magit-item-highlight '((t :inherit diff-header-face))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface magit-item-mark  '((t  :foreground "orange"))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface magit-header '((t (:box 1 :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface magit-section-title '((t (:inherit magit-header :background "dark slate blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface multi-region-face '((t (:background "Navy" :foreground "LightSteelBlue4")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface p4-depot-added-face '((t (:foreground "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface p4-depot-deleted-face '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface p4-depot-unmapped-face '((t (:foreground "grey30")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface p4-diff-change-face '((t (:foreground "dark green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface p4-diff-del-face '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface p4-diff-file-face '((t (:background "gray90")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface p4-diff-head-face '((t (:background "gray95")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface p4-diff-ins-face '((t (:foreground "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface pabbrev-debug-display-label-face '((t (:underline "navy")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface pabbrev-suggestions-face '((t (:foreground "PaleGreen")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface primary-selection '((t (:background "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface qt-classes-face '((t (:foreground "Red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface mm-uu-extract '((t (:background "dark green" :foreground "light yellow")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface modeline-mousable '((t (:background "white" :foreground "magenta")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface modeline-mousable-minor-mode '((t (:background "Gray80" :foreground "green4")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface setnu-line-number-face  '((t (:bold t :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface shell-option-face '((t (:foreground "blue4")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface shell-output-2-face '((t (:foreground "green4")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface shell-output-3-face '((t (:foreground "green4")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface shell-output-face '((t (:bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface shell-prompt-face '((t (:foreground "red4")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface show-block-face1 '((t (:background "gray10")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface show-block-face2 '((t (:background "gray15")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface show-block-face3 '((t (:background "gray20")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface show-block-face4 '((t (:background "gray25")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface show-block-face5 '((t (:background "gray30")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface show-block-face6 '((t (:background "gray35")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface show-block-face7 '((t (:background "gray40")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface show-block-face8 '((t (:background "gray45")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface show-block-face9 '((t (:background "gray50")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)


(defface variable-pitch '((t (:family "helv")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface vc-annotate-face-0046FF '((t (:foreground "wheat" :background "black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface vmpc-pre-sig-face '((t (:foreground "forestgreen")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface vmpc-sig-face '((t (:foreground "steelblue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface x-face '((t (:background "white" :foreground "black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface x-symbol-heading-face '((t (:bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface xrdb-option-name-face '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface xrdb-option-value-face '((t (:bold t :foreground "magenta")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface xref-keyword-face '((t (:background "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface xref-list-pilot-face '((t (:background "navy")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface xref-list-symbol-face '((t (:background "navy")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface blue '((t (:foreground "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cyan-bold '((t (:bold t :foreground "cyan" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface cyan-italic '((t (:italic t :foreground "cyan" :slant italic)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface darkviolet-bold '((t (:bold t :foreground "dark violet" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface darkviolet-italic '((t (:italic t :foreground "dark violet" :slant italic)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface magenta '((t (:foreground "magenta")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface magenta-bold '((t (:bold t :foreground "magenta2" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface midnightblue-bold '((t (:bold t :foreground "midnightblue" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface midnightblue-italic '((t (:italic t :foreground "midnightblue" :slant italic)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface orchid-bold '((t (:bold t :foreground "MediumOrchid1" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface plum '((t (:bold t :foreground "plum" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface red '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface violet-bold '((t (:bold t :foreground "violet" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface violet-italic '((t (:italic t :foreground "violet" :slant italic)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface yellow '((t (:foreground "yellow")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface swbuff-current-buffer-face '((t (:foreground "red" :bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface template-message-face '((t (:bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-black '((t (:foreground "black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-blue '((t (:foreground "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-blue-bold-face '((t (:bold t :foreground "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-blue-face '((t (:foreground "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-blue-inv-face '((t (:background "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-blue-ul-face '((t (:underline t :foreground "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-bluebg '((t (:background "blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-bold '((t (:bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-cyan '((t (:foreground "cyan")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-cyan-bold-face '((t (:bold t :foreground "cyan")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-cyan-face '((t (:foreground "cyan")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-cyan-inv-face '((t (:background "cyan")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-cyan-ul-face '((t (:underline t :foreground "cyan")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-cyanbg '((t (:background "cyan")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-default-bold-face '((t (:bold t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-default-inv-face '((t (:background "peachpuff" :foreground "black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-default-ul-face '((t (:underline t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-green '((t (:foreground "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-green-bold-face '((t (:bold t :foreground "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-green-face '((t (:foreground "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-green-inv-face '((t (:background "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-green-ul-face '((t (:underline t :foreground "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-greenbg '((t (:background "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-magenta '((t (:foreground "magenta")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-magenta-bold-face '((t (:bold t :foreground "magenta")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-magenta-face '((t (:foreground "magenta")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-magenta-inv-face '((t (:background "magenta")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-magenta-ul-face '((t (:underline t :foreground "magenta")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-magentabg '((t (:background "magenta")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-red '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-red-bold-face '((t (:bold t :foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-red-face '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-red-inv-face '((t (:background "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-red-ul-face '((t (:underline t :foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-redbg '((t (:background "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-underline '((t (:underline t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-white '((t (:foreground "white")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-white-bold-face '((t (:bold t :foreground "white")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-white-face '((t (:foreground "white")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-white-ul-face '((t (:underline t :foreground "white")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-whitebg '((t (:background "white")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-yellow '((t (:foreground "yellow")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-yellow-bold-face '((t (:bold t :foreground "yellow")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-yellow-face '((t (:foreground "yellow")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-yellow-inv-face '((t (:background "yellow")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-yellow-ul-face '((t (:underline t :foreground "yellow")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface term-yellowbg '((t (:background "yellow")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface text-cursor '((t (:background "Red3" :foreground "black")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface rcirc-my-nick '((t (:foreground "SpringGreen1" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface rcirc-other-nick '((t (:foreground "dodger blue")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface rcirc-track-keyword '((t (:foreground "DodgerBlue" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface rcirc-track-nick '((t (:background "yellow" :foreground "DodgerBlue" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

 ;; From theme clarity
(defface help-highlight-face '((t (:underline t)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface list-matching-lines-face '((t (:bold t :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface view-highlight-face '((t (:background "darkolivegreen")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface ibuffer-title-face '((t (:foreground "PaleGreen")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface ibuffer-deletion-face '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface ibuffer-marked-face '((t (:foreground "green")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

 ;; From theme hober
(defface completions-annotations '((t (:italic t :slant italic)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface glyphless-char '((t (:height 0.6)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface highlight-changes-face '((t (:foreground "red")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface success '((t (:bold t :foreground "Green1" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface zmacs-region '((t (:background "darkslateblue" :foreground "white")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(defface window-number-face '((t (:foreground "red" :weight bold)))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)
(defface default '((t (:background "black" :foreground "WhiteSmoke")))
  "Custom faces for Manoj's dark theme."
  :group 'manoj-faces)

(provide 'my-faces)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; my-faces.el ends here
