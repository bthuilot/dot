;;; init.el --- emacs config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021


;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; `init.el` Emacs config file.
;; Used to load in other Emacs config files

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs general settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set directory for temp files
(setq backup-directory-alist `(("." . "~/.emacs_saves")))

;; Set $PATH from shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;;;;;;;;;;;;;
;; Packages ;;
;;;;;;;;;;;;;;

(require 'package)

;; Set up package archives
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Initialize package
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(projectile flycheck-rust exec-path-from-shell rust-mode company lsp-haskell haskell-mode flycheck lsp-mode dashboard gruvbox-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Initialize Packages
(projectile-mode +1)

;;;;;;;;;;;;;;;;;;;;
;; Add load paths ;;
;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/elisp/")

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Function definitions ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "functions")

;;;;;;;;;;;;;;;;;;;;
;; Modes/packages ;;
;;;;;;;;;;;;;;;;;;;;


;; LSP relate config
(load "lsp")

;;;;;;;;;;;;;;;;;;;;
;; Styling config ;;
;;;;;;;;;;;;;;;;;;;;

(load "styling")

;;;;;;;;;;;;;;;;;;
;; Key Bindings ;;
;;;;;;;;;;;;;;;;;;

(load "keybindings")

(provide 'init)
;;; init.el ends here
