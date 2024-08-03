;;; orgconf.el --- emacs org mode config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2024

;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 15 July 2024

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used to configure org mode

;;; Code:

;; Set Org files locations
(setq-default org-notes-file (concat org-dir "/notes.org"))

;; Set agenda
(setq org-agenda-files `(,org-notes-file))
;; set notes
(setq org-default-notes-file org-notes-file)
;; Set caputre templates
(setq org-capture-templates
      '(
	("t" "🚩 TODO" entry (file+headline org-notes-file "Uncategorized")
         "** TODO %?\n")
	("n" "📝 Note" entry (file+headline org-notes-file "Uncategorized")
         "** %?\n")
	))

;; Styling changes
(setq org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))


(provide 'orgconf)
;;; styling.el ends here
