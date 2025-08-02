;;; general.el --- emacs general config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot <bryce@thuilot.io> 2017-2025

;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: Oct, 20 2022

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used to configure general settings

;;; Code:

;; set directory for temp files
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; macos bug
(setq image-types (cons 'svg image-types))

;; Set $PATH from shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;;;;;;;;;;;;;;;;;;;

(provide 'general)

;;; general.el ends here
