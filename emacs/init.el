;; Require ;;
(require 'package)
(require 'dashboard)

;;;;;;;;;;;;;;
;; Packages ;;
;;;;;;;;;;;;;;

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(haskell-mode dashboard go-complete gruvbox-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;
;; Variables ;;
;;;;;;;;;;;;;;;

(setq dashboard-footer-messages '("Dashboard is pretty cool!"))

(setq org-agenda-files (list "~/.org/neu.org"))

;;;;;;;;;;;;;;;
;; Hook/load ;;
;;;;;;;;;;;;;;;

;; Gruvbox
(load-theme 'gruvbox t)
;; Dashboard
(dashboard-setup-startup-hook)
;; Disable toolbar
(tool-bar-mode -1) 

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Function definitions ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Toggle fullscreen
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;;;;;;;;;;;;;;;;;;
;; Key Bindings ;;
;;;;;;;;;;;;;;;;;;

;; fullscreen
(global-set-key [C-return] 'toggle-fullscreen)
;; Org mode
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

