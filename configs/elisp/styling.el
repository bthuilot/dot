;;; styling.el --- emacs styling config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021

;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used to configure styling

;;; Code:

;; Font
(set-frame-font "Fira Code 12" nil t)

;; Theme
(when (package-installed-p 'color-theme-sanityinc-tomorrow)
  (require 'color-theme-sanityinc-tomorrow))

;; Disable toolbar
(tool-bar-mode -1)

;; Disable toolbar
(menu-bar-mode -1)

;; Show line numbers
(global-display-line-numbers-mode)

;; Disable newline at end of file
(setq require-final-newline nil)
(setq mode-require-final-newline nil)

;; Disable bell sound
(setq ring-bell-function 'ignore)


;; Dashboard
(setq dashboard-startup-banner 'logo)
(setq dashboard-set-navigator t)
(setq dashboard-items '(
                        (projects . 5)
			(recents  . 10)
			))
(dashboard-setup-startup-hook)

;; all-the-icons
(when (display-graphic-p)
  (require 'all-the-icons))

(provide 'styling)
;;; styling.el ends here
