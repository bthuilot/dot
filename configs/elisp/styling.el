;;; styling.el --- emacs styling config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021

;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used to configure styling

;;; Code:

;; Font
(set-frame-font "Fira Code 14" nil t)

;; Theme
(when (package-installed-p 'badger-theme)
  (load-theme 'badger t))


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
(setq dashboard-filter-agenda-entry 'dashboard-no-filter-agenda)
(setq dashboard-match-agenda-entry
      "TODO=\"TODO\"|TODO=\"IN-PROGRESS\"|TODO=\"WAITING\"")
(setq dashboard-items '(
			(agenda    . 10)
                        (projects . 10)
			(recents  . 5)
			))
(setq dashboard-item-names '(
                             ("Agenda for the coming week:" . "Tasks:")
			     ))
(dashboard-setup-startup-hook)

;; all-the-icons
(when (display-graphic-p)
  (require 'all-the-icons))

(provide 'styling)
;;; styling.el ends here
