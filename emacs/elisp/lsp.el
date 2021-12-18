;;; lsp.el --- emacs LSP mode & related package config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021


;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; config for LSP mode and related packages

;;; Code:

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Haskell
(add-hook 'haskell-mode-hook #'lsp-deferred)
(add-hook 'haskell-literate-mode-hook #'lsp-deferred)

;; Go
(add-hook 'go-mode-hook #'lsp-deferred)

;; spell check
(setq ispell-program-name "/usr/local/bin/aspell")
(add-hook 'markdown-mode-hook 'flyspell-mode)


;;;; Speed Adjustments ;;;;;

;; Adjust Garbage Collector
(setq gc-cons-threshold 100000000)

(setq read-process-output-max (* 1024 1024)) ;; 1mb


;; Pandoc
;;(add-hook 'markdown-mode-hook 'pandoc-mode)
;;(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)

;; Company mode
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)


(provide 'lsp)
;;; lsp.el ends here
