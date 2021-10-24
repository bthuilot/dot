;;; dashboard_c.el --- emacs dashboard config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021


;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used for config relating to the `dashboard` package

;;; Code:

(require 'dashboard)

(setq dashboard-footer-messages '("TODO: Fix this"))

(setq dashboard-startup-banner 'logo)

(setq dashboard-items '((recents  . 5)
                        (projects . 5)
                        (agenda . 5)))


;; Dashboard
(dashboard-setup-startup-hook)

(provide 'dashboard_c)
;;; dashboard_c.el ends here
