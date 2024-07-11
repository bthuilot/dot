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

(defun iterm()
  "Open the current directory in iterm."
  (interactive)
  (shell-command (concat
		  "open -a iTerm "
		  (file-name-directory (buffer-file-name))))
  )

(defun tasks()
  "Open Org tasks file."
  (interactive)
  (find-file org-task-file))


(defun notes()
  "Open Org tasks file."
  (interactive)
  (find-file org-note-file))

(defun workpad()
  "Open both tasks and notes horizontally."
  (interactive)
  (progn
    (tasks)
    (split-window-right)
    (notes)))

;;; functions.el ends here
