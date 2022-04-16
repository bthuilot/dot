;;; styling.el --- emacs styling config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021

;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used to configure styling

;;; Code:

;; Gruvbox
(load-theme 'gruvbox t)

;; Disable toolbar
(tool-bar-mode -1)

;; Disable toolbar
(menu-bar-mode -1)

;; Show line numbers
(global-display-line-numbers-mode)

;; Disable bell sound
(setq ring-bell-function 'ignore)


;; Dashboard
(setq dashboard-startup-banner 'logo)
(setq dashboard-set-navigator t)
(setq dashboard-items '(
                        (projects . 5)
			(recents  . 10)
			))
;; Dashboard
(dashboard-setup-startup-hook)


(provide 'styling)
;;; styling.el ends here
