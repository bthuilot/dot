;;; lsp.el --- emacs LSP mode & related package config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021


;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; config for LSP mode and related packages

;;; Code:

(projectile-mode +1)

;; Treemacs
(lsp-treemacs-sync-mode 1)

;; CoPilot ;;
;;;;;;;;;;;;;
(quelpa '(copilot :fetcher github
                 :repo "zerolfx/copilot.el"
                 :branch "main"
                 :files ("dist" "*.el")))
(require 'copilot)
(add-hook 'prog-mode-hook 'copilot-mode)
(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)

(add-to-list 'copilot-major-mode-alist '("go" . "rust"))
;; Flycheck ;;
;;;;;;;;;;;;;;
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Haskell ;;
;;;;;;;;;;;;;
(add-hook 'haskell-mode-hook #'lsp-deferred)
(add-hook 'haskell-literate-mode-hook #'lsp-deferred)

;; Go ;;
;;;;;;;;
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
(add-hook 'go-mode-hook #'lsp-deferred)


;; Shell ;;
;;;;;;;;;;;
(add-hook 'sh-mode-hook 'flymake-shellcheck-load)

;; Rust ;;
;;;;;;;;;;

;; Vars
(setq rust-format-on-save t)
(setq lsp-rust-server 'rust-analyzer)

;; Hooks
(add-hook 'rust-mode-hook #'lsp-deferred)
(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))
(with-eval-after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; OCaml
(add-hook 'tuareg-mode-hook #'merlin-mode)
(add-hook 'caml-mode-hook #'merlin-mode)
(setq utop-command "opam config exec -- dune utop . -- -emacs")

;; Terraform
(add-hook 'terraform-mode-hook #'lsp-deferred)
(add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)

;;;; Speed Adjustments ;;;;;

;; Adjust Garbage Collector
(setq gc-cons-threshold 100000000)

(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; Company mode
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)


(provide 'lsp)
;;; lsp.el ends here
