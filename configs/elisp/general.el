;;; general.el --- emacs general config file -*- lexical-binding: t; -*-

;; Copyright (C) 2022 Bryce Thuilot

;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: Oct, 20 2022

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used to configure general settings

;;; Code:
;; Set directory for temp files
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; macos bug
(setq image-types (cons 'svg image-types))

;; Set $PATH from shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Set frame size
(defvar frame-height 60)
(defvar frame-width 160)
(setq git-link-open-in-browser 't)
(add-to-list 'default-frame-alist `(height . ,frame-height))
(add-to-list 'default-frame-alist `(width . ,frame-width))

;; Don't open a new frame when opening a file with emacs
(setq ns-pop-up-frames nil)


;; SHUT UPP EMACS
;;(setq ring-bell-function ignore)
(setq visible-bell 1)


;;;;;;;;;;;;;;;;;;;;

(provide 'general)

;;; general.el ends here
