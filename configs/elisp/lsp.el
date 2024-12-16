;;; lsp.el --- emacs LSP mode & related package config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021


;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; config for LSP mode and related packages

;;; Code:

;; LSP/Language wide settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; enable projectile
(use-package projectile
  :config
  (projectile-mode +1))
  

;; LSP Ui
(use-package lsp-ui
  :init
  (setq-default lsp-ui-doc-position 'at-point
		lsp-ui-flycheck-enable t
		lsp-ui-doc-enable t))

;; Treemacs
(use-package treemacs
  :config
  (lsp-treemacs-sync-mode 1))


;; Company mode
(use-package company
  :init
  (setq-default
   company-idle-delay 0
   company-minimum-prefix-length 1)
  :hook ('after-init . 'global-company-mode))

;; yasnippet ;;
;;;;;;;;;;;;;;;;

(use-package yasnippet
  :config
  (yas-global-mode 1))


;; Flycheck ;;
;;;;;;;;;;;;;;

(use-package flycheck
  :hook
  ('after-init . 'global-flycheck-mode))

;; Haskell ;;
;;;;;;;;;;;;;

(use-package haskell-mode
  :hook
  ('haskell-mode . 'lsp-deferred)
  ('haskell-literate-mode . 'lsp-deferred))


;; JavaScript ;;
;;;;;;;;;;;;;;;;

(use-package js2
  :init
  (setq-default js2-basic-offset 2)
  :mode "\\.js\\'")
  ;; (add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))

;; Go ;;
;;;;;;;;

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(use-package go-mode
  :init
  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t)
     ("gopls.staticcheck" t t)))
  :hook
  ('go-mode . #'lsp-go-install-save-hooks)
  ('go-mode . #'lsp-deferred)
  ('go-mode . #'yas-minor-mode))


;; Shell ;;
;;;;;;;;;;;

(use-package flymake-shellcheck
  :hook
  ('sh-mode . 'flymake-shellcheck-load))

;; Rust ;;
;;;;;;;;;;

(use-package rust-mode
  :init
  (setq rust-format-on-save t
	lsp-rust-server 'rust-analyzer
	indent-tabs-mode nil)
  :hook
  ('flycheck-mode . #'flycheck-rust-setup)
  ('rust-mode #'lsp-deferred))


;; OCaml ;;
;;;;;;;;;;;

;; Major mode for OCaml programming
(use-package tuareg
  :ensure t
  :mode (("\\.ocamlinit\\'" . tuareg-mode)))

;; Major mode for editing Dune project files
(use-package dune
  :ensure t)

;; Merlin provides advanced IDE features
(use-package merlin
  :ensure t
  :init
  (setq-default utop-command "opam config exec -- dune utop . -- -emacs")
  :hook
  ('tuareg-mode . #'merlin-mode)
  ('merlin-mode . #'company-mode)
  ('caml-mode . #'merlin-mode)
  :config
  (setq merlin-error-after-save nil))

(use-package merlin-eldoc
  :ensure t
  :hook ((tuareg-mode) . merlin-eldoc-setup))

;; This uses Merlin internally
(use-package flycheck-ocaml
  :ensure t
  :config
  (flycheck-ocaml-setup))

(use-package utop
  :ensure t
  :config
  (add-hook 'tuareg-mode-hook #'utop-minor-mode))


;; Terraform ;;
;;;;;;;;;;;;;;;

(use-package terraform-mode
  :hook
  ('terraform-mode . #'lsp-deferred)
  ('terraform-mode . #'terraform-format-on-save-mode))


;; Other Languages ;;
;;;;;;;;;;;;;;;;;;;;;

;; rego
(use-package rego
  :mode "\\.rego\\'")

;; paredit
(use-package paredit
  :ensure t
  :config
  (dolist (m '(emacs-lisp-mode-hook
               racket-mode-hook
               racket-repl-mode-hook))
    (add-hook m #'paredit-mode))
  (bind-keys :map paredit-mode-map
             ("{"   . paredit-open-curly)
             ("}"   . paredit-close-curly))
  (unless terminal-frame
    (bind-keys :map paredit-mode-map
               ("M-[" . paredit-wrap-square)
               ("M-{" . paredit-wrap-curly))))

;;;; Speed Adjustments ;;;;;

;; Adjust Garbage Collector
(setq-default gc-cons-threshold 100000000
	      read-process-output-max (* 1024 1024)) ;; 1mb


(provide 'lsp)
;;; lsp.el ends here
