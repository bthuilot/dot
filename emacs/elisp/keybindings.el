;;; keybindings.el --- Emacs config file for defining keybinds -*- lexical-binding: t; -*-

;; Copyright (C) 2021 Bryce Thuilot

;; Author: Your Name <yourname@example.com>
;; Maintainer: Someone Else <someone@example.com>
;; Created: 14 Jul 2010

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is mapping custom key bindings in Emacs

;;; Code:


;; fullscreen
(global-set-key [C-return] 'toggle-fullscreen)

;; Org mode
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(provide 'keybinds)
;;; keybindings.el ends here
