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

;;;; PATH settings
;; Add custom paths to PATH
(let ((ghcPath (expand-file-name "~/.ghcup/bin"))
      (goPath (expand-file-name ""))
      (aspell "/usr/local/bin/aspell")
      )
  (mapc (lambda (path)
	  (setenv "PATH" (concat (getenv "PATH") (concat ":" path)))
	  )
	(list ghcPath goPath aspell)))

;; Add PATH to exec path
(setq exec-path (split-string (getenv "PATH") ":"))

;; Set directory for temp files
(setq backup-directory-alist `(("." . "~/.emacs_saves")))

;;;;;;;;;;;;;;
;; Packages ;;
;;;;;;;;;;;;;;

(require 'package)

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Set up package archives
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/"))

;; Initialize package
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(exec-path-from-shell bison-mode racket-mode yaml-mode flycheck-yamllint markdown-preview-mode markdown-mode pandoc-mode highlight-parentheses company flycheck sml-mode lsp-ui lsp-mode lsp-haskell all-the-icons haskell-mode dashboard go-complete gruvbox-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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

;; Dashboard related config
(load "dash")


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
