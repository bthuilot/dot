;;; keybindings.el --- Emacs config file for defining keybinds -*- lexical-binding: t; -*-

;; Copyright (C) 2021 Bryce Thuilot

;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Maintainer:  Bryce Thuilot <bryce@thuilot.io>
;; Created: Oct 24, 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is mapping custom key bindings in Emacs

;;; Code:


;; Global
;; ------

;; Control+Enter: Toggle fullscreen
(global-set-key [C-return] 'toggle-fullscreen)

;; Ctrl+C t: Goto Treemacs buffer
(global-set-key (kbd "C-c t") #'treemacs-select-window)

;; Ctrl+C s: Goto LSP Treemac symbols
(global-set-key (kbd "C-c s") #'lsp-treemacs-symbols)

;; Mouse 4: Return to previous buffer
(global-set-key (kbd "<mouse-4>") #'goto-previous-buffer)

;;; Org Mode
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Ctrl+C j: join lines
(global-set-key (kbd "C-c j") #'join-line)

;; git link
(global-set-key (kbd "C-c g l") 'git-link)

;; OS specific ;;

(if (eq system-type 'darwin)
    ; macOS
    (progn
      (global-set-key (kbd "C-c T") #'iterm)
      (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
      )
  )

;; Mode Specific
;; ------------

;; Control+C, P: Projectile commands
(when (package-installed-p 'projectile)
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  )

(provide 'keybinds)
;;; keybindings.el ends here
