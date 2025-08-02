;;; styling.el --- emacs styling config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot <bryce@thuilot.io> 2017-2025

;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used to configure styling

;;; Code:

;; set theme
(add-to-list 'custom-theme-load-path dotfiles-config-dir)
(load-theme 'personal t)

;; set default font
(set-frame-font "Fira Code Retina 12" nil t)

;; disable toolbar & menu
(tool-bar-mode -1)
(menu-bar-mode -1)

;; show line numbers
(global-display-line-numbers-mode)

;; frame config
(defvar frame-height 60)
(defvar frame-width 160)

(add-to-list 'default-frame-alist `(height . ,frame-height))
(add-to-list 'default-frame-alist `(width . ,frame-width))

;; ()

(setq initial-frame-alist
      (append initial-frame-alist (frame-alist-center frame-width frame-height)))

;; (add-hook 'emacs-startup-hook
	  ;; (lambda ()  (centerrr)))



;; don't open a new frame when opening a file with emacs
;; (setq ns-pop-up-frames nil)

;; Disable newline at end of file
(setq require-final-newline nil
      mode-require-final-newline nil)

;; disable bell sound & use screenflash instead
(setq ring-bell-function 'ignore)
(setq visible-bell 1)

;; support editorconfig
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

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

;; (custom-set-faces
 ;; '(tab-bar ((t (:background "black"))))
 ;; '(tab-bar-tab ((t (:background "#171717" :foreground "#F6F3E8" :box (:line-width 2 :style released-button)))))
 ;; '(tab-bar-tab-inactive ((t (:background "#171717" :foreground "gray70")))))

(provide 'styling)
;;; styling.el ends here
