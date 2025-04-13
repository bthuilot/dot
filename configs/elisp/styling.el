;;; styling.el --- emacs styling config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021

;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used to configure styling

;;; Code:

;; Font
(set-frame-font "Fira Code Retina 14" nil t)

;; Disable toolbar
(tool-bar-mode -1)

;; Disable toolbar
(menu-bar-mode -1)

;; Show line numbers
(global-display-line-numbers-mode)

;; Disable newline at end of file
(setq require-final-newline nil
      mode-require-final-newline nil)

;; Disable bell sound
(setq ring-bell-function 'ignore)

;; use badger theme
(use-package badger-theme
  :ensure t
  :config (load-theme 'badger t))

;; all-the-icons
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

;; Dashboard
(use-package dashboard
  :ensure t
  :init
  (setq dashboard-startup-banner 'logo
	dashboard-set-navigator t
	dashboard-filter-agenda-entry 'dashboard-no-filter-agenda
	dashboard-match-agenda-entry "TODO=\"TODO\"|TODO=\"IN-PROGRESS\"|TODO=\"WAITING\""
	dashboard-icon-type 'nerd-icons
	dashboard-items '((agenda    . 10)
                          (projects . 10)
			  (recents  . 10))
	dashboard-item-names '(("Agenda for the coming week:" . "Tasks:")))
  :config
  (dashboard-setup-startup-hook))

(provide 'styling)
;;; styling.el ends here
