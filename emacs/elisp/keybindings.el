;;; keybindings.el --- Emacs config file for defining keybinds -*- lexical-binding: t; -*-

;; Copyright (C) 2021 Bryce Thuilot

;; Author: Your Name <yourname@example.com>
;; Maintainer: Someone Else <someone@example.com>
;; Created: 14 Jul 2010

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is mapping custom key bindings in Emacs

;;; Code:


;; Control+Enter: Toggle fullscreen
(global-set-key [C-return] 'toggle-fullscreen)

;; Control+C, P: Projectile commands
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(provide 'keybinds)
;;; keybindings.el ends here
