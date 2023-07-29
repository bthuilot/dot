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

;; Set $PATH from shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Set frame size

(defvar frame-height 60)
(defvar frame-width 160)
(add-to-list 'default-frame-alist `(height . ,frame-height))
(add-to-list 'default-frame-alist `(width . ,frame-width))

;;;;;;;;;;;;;;;;;;;;

(provide 'general)
;;; styling.el ends here
