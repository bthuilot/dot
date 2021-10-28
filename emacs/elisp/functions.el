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


;;; functions.el ends here
