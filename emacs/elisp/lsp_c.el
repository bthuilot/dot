;;; lsp_c.el --- emacs LSP mode & related package config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021


;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; config for LSP mode and related packages

;;; Code:

(require 'lsp-mode)
(require 'lsp-haskell)
(require 'company)

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Haskell
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

;; Go
(add-hook 'go-mode-hook #'lsp)


;; Company mode
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)


(provide 'lsp_c)
;;; lsp_c.el ends here
