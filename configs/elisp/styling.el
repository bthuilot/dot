;;; styling.el --- emacs styling config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot <bryce@thuilot.io> 2017-2025

;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used to configure styling

;;; Code:

;; set theme
(add-to-list 'custom-theme-load-path (concat dotfiles-config-dir "/themes"))
(load-theme 'personal t)

;; set default font
;; (set-frame-font "FiraCode Nerd Font 14" nil t)

;; disable toolbar & menu
(tool-bar-mode -1)
(menu-bar-mode -1)

;; show line numbers
(global-display-line-numbers-mode)

;; frame config
(defvar frame-height 60)
(defvar frame-width 160)


;; (setq initial-frame-alist
      ;; (append initial-frame-alist (frame-alist-center frame-width frame-height)))


(add-to-list 'default-frame-alist '(width  . 160))
(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font 12"))

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

;; nerd icons
(use-package nerd-icons
  :ensure t
  :custom
  (nerd-icons-font-family "FiraCode Nerd Font Mono"))

;; nerd icon support for treemacs
(use-package treemacs-nerd-icons
  :if (and (package-installed-p 'treemacs)
	   (package-installed-p 'treemacs-nerd-icons))
  :after (treemacs lsp-treemacs nerd-icons)
  :config (treemacs-nerd-icons-config))

;; Dashboard
(use-package dashboard
  :ensure t
  :init
  (setq dashboard-startup-banner 'logo
	dashboard-set-navigator t
	dashboard-icon-type 'nerd-icons
	dashboard-items '((projects . 15)
			  (recents  . 15)))
  :config
  (dashboard-setup-startup-hook))


(provide 'styling)
;;; styling.el ends here
