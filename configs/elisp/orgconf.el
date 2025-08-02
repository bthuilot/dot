;;; orgconf.el --- emacs org mode config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot <bryce@thuilot.io> 2017-2025

;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 15 July 2024

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used to configure org mode

;;; Code:

;; Set Org files locations
(setq-default org-notes-file (concat org-dir "/notes.org"))

;; Set agenda
(setq-default org-agenda-files `(,org-notes-file))
;; set notes
(setq-default org-default-notes-file org-notes-file)
;; Set caputre templates
(setq-default org-capture-templates
      '(
	("t" "🚩 TODO" entry (file+headline org-notes-file "Uncategorized")
         "** TODO %?\n")
	("n" "📝 Note" entry (file+headline org-notes-file "Uncategorized")
         "** %?\n")
	))

;; Styling changes
(setq-default org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))


(provide 'orgconf)
;;; orgconf.el ends here
