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

;; Shell
(add-hook 'sh-mode-hook 'flymake-shellcheck-load)

;; Rust
(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))
(add-hook 'rust-mode-hook #'lsp-deferred)
(setq rust-format-on-save t)
(setq lsp-rust-server 'rust-analyzer)

;; OCaml
(add-hook 'tuareg-mode-hook #'merlin-mode)
(add-hook 'caml-mode-hook #'merlin-mode)

;;;; Speed Adjustments ;;;;;

;; Adjust Garbage Collector
(setq gc-cons-threshold 100000000)

(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; Company mode
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)


(provide 'lsp)
;;; lsp.el ends here
