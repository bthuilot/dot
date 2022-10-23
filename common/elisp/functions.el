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
  "Vist init.el in a new buffer"
  (interactive)
  (find-file (string-join `(,dot-dir ,dot-os "init.el") "/")))


(defun dotel ()
  "Visit the common elisp in the dot directory"
  (interactive)
  (let ((commondir (string-join `(,dot-dir "common" "elisp/") "/")))
    (find-file (read-file-name "Enter file name: " commondir))
    ))


;;; functions.el ends here
