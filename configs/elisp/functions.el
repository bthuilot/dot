;;; functions.el --- emacs config functions -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021


;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; File is used to define functions to be used through other config files

;;; Code:

(require 'seq)

;; helper functions ;;

(defun visible-file-buffers ()
  "Return a list of buffers that are visible and visiting real files."
  (let ((visible-bufs (mapcar #'window-buffer (window-list))))
    (seq-filter (lambda (buf) (buffer-file-name buf))
                visible-bufs)))


(defun last-edited-visible-file-buffer ()
  "Return the last-used buffer among all visible buffers visiting real files.
This uses `buffer-list`’s ordering (most recent first) as a proxy for
'last edited.'"
  (let ((candidate-bufs (visible-file-buffers)))
    ;; `buffer-list` returns buffers from most recently used to least.
    ;; The first buffer it finds that is in `candidate-bufs` is
    ;; effectively “last edited” among the visible-file-buffers.
    (seq-find (lambda (buf) (memq buf candidate-bufs))
              (buffer-list))))


;; Toggle fullscreen
(defun toggle-fullscreen ()
  "Toggle fullscreen for Emacs."
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))


;; Go to previous buffer
(defun goto-previous-buffer ()
  "Switch to previous open buffer."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; Visit init.el in a new buffer
(defun initel ()
  "Vist init.el in a new buffer."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun emacs-config ()
  "List all Emacs config files in dot-dir and open the selected."
  (interactive)
  (let* ((directory (concat dot-dir "/configs/elisp/"))
         (files (delete "." (delete ".." (directory-files directory))))
         (file (completing-read "Select a file: " files)))
    (find-file (expand-file-name file directory))))

(defun treemacs-toggle ()
  "Toggle treemacs in a similar nature to JetBrains/VScode."
  ; if treemacs isnt activated, activate it and select it
  (interactive)
  (let (;; get the last edited "real file" buffer
	(b (last-edited-visible-file-buffer))
	;; before selecting treemacs windows, check if its currently
	(visible (and (fboundp 'treemacs-current-visibility)
		      (eq 'visible (treemacs-current-visibility)))))
    ; select the treemacs window
    (cond
     ;; if it was visible already, quit it
     (visible  (progn (treemacs-select-window) (treemacs-quit)))
     ;; if the current buffer is treemacs
     ((null b) (message "no directory found to open in treemacs"))
     (t        (progn (switch-to-buffer b)
		      (treemacs-add-and-display-current-project-exclusively)))
     )))

(defun iterm()
  "Open the current directory in iterm."
  (interactive)
  (shell-command
   (concat "open -a iTerm " (file-name-directory (buffer-file-name)))))

(defun tasks()
  "Open Org tasks file."
  (interactive)
  (find-file org-notes-file))


(defun notes()
  "Open Org tasks file."
  (interactive)
  (find-file org-notes-file))

;;; functions.el ends here
