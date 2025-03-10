;;; functions.el --- emacs config functions -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021


;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; File is used to define functions to be used through other config files

;;; Code:


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
  (let ((b (current-buffer)) 
	;; before selecting treemacs windows, check if its currently
	(visible (and (fboundp 'treemacs-current-visibility)
		      (eq 'visible (treemacs-current-visibility)))))
    ; select the treemacs window 
    (treemacs-select-window)
    ; if it was visible already, quit it
    (if visible (treemacs-quit)
      (progn
	;; else, open the current directory and
	;; have treemacs display that
	(switch-to-buffer b)
	(treemacs-add-and-display-current-project-exclusively))
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
