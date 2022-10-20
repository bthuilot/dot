;;; init.el --- emacs config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021


;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; `init.el` Emacs config file.
;; Used to load in other Emacs config files

;;; Code:

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
 '(custom-enabled-themes '(sanityinc-tomorrow-night))
 '(custom-safe-themes
   '("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "a556e4e6fc62469cd28a57c3b5386807d676a33176659f849fc53fa8763f5955" "f27c3fcfb19bf38892bc6e72d0046af7a1ded81f54435f9d4d09b3bff9c52fc1" "a5956ec25b719bf325e847864e16578c61d8af3e8a3d95f60f9040d02497e408" "62c81ae32320ceff5228edceeaa6895c029cc8f43c8c98a023f91b5b339d633f" "3a5f04a517096b08b08ef39db6d12bd55c04ed3d43b344cf8bd855bde6d3a1ae" default))
 '(package-selected-packages
   '(flymake-yaml yaml-mode color-theme-sanityinc-tomorrow dracula-theme base16-theme majapahit-theme flymake-racket racket-mode treemacs-all-the-icons lsp-treemacs treemacs lsp-ui terraform-mode magit merlin tuareg go-mode dockerfile-mode flycheck-yamllint projectile flycheck-rust exec-path-from-shell rust-mode company lsp-haskell haskell-mode flycheck lsp-mode dashboard gruvbox-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs general settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set directory for temp files
(setq backup-directory-alist `(("." . "~/.emacs_saves")))

;; Set $PATH from shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Set frame size
(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 160))

;; Initialize Packages
(projectile-mode +1)

;; Org mode search
(setq org-agenda-files (list (expand-file-name "/Users/bryce/org")))

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

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line


(provide 'init)
;;; init.el ends here
