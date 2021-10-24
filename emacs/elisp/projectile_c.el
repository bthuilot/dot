;;; projectile_c.el --- emacs projectile mode config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021


;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; config for projectile mode

;;; Code:

(require 'projectile)

;; Projectile
(projectile-mode)


;; Set project search path
(setq projectile-project-search-path '("~/fall_21/" "~/github/"))

;; Set project sort order
(setq projectile-sort-order 'recentf)


(provide 'projectile_c)
;;; projectile_c.el ends here
