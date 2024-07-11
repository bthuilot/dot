;;; general.el --- emacs general config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2022

;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 20 Oct 2022

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used to configure general settings

;;; Code:
;; Set directory for temp files
(setq backup-directory-alist `(("." . "~/.emacs_saves")))

;; macos bug
(setq image-types (cons 'svg image-types))

;; Set $PATH from shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Set frame size
(defvar frame-height 60)
(defvar frame-width 160)
(add-to-list 'default-frame-alist `(height . ,frame-height))
(add-to-list 'default-frame-alist `(width . ,frame-width))

;; Don't open a new frame when opening a file with emacs
(setq ns-pop-up-frames nil)

;; Set Org agenda location
(setq org-task-file (concat org-dir "/tasks.org"))
(setq org-note-file (concat org-dir "/notes.org"))
(setq org-agenda-files `(,org-task-file))
(setq org-default-notes-file org-note-file)
(setq org-capture-templates
      '(
	("t" "🚩 TODO" entry (file+headline org-task-file "Uncategorized")
         "** TODO %?\n")
	("n" "📝 Note" entry (file+headline org-task-file "Uncategorized")
         "** %?\n")
	))

;; SHUT UPP EMACS
;;(setq ring-bell-function ignore)
(setq visible-bell 1)


;;;;;;;;;;;;;;;;;;;;

(provide 'general)
;;; styling.el ends here
