;;; theme.el --- emacs styling config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot <bryce@thuilot.io> 2017-2025

;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used to configure styling

;;; Code:

(deftheme personal
  "Personal theme.")

(custom-theme-set-faces
 'personal
 '(cursor ((t (:background "#fefefe"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((((type w32)) (:foundry "outline" :family "Arial")) (t (:family "Sans Serif"))))
 '(escape-glyph ((t (:foreground "#d75f5f" :weight bold))))
 '(homoglyph ((t (:foreground "#5fafd7"))))
 '(minibuffer-prompt ((t (:foreground "#BF93C3"))))
 '(highlight ((t (:background "#3a3c40"))))
 '(region ((t (:extend t :background "black"))))
 '(shadow ((((class color grayscale) (min-colors 88) (background light)) (:foreground "grey50")) (((class color grayscale) (min-colors 88) (background dark)) (:foreground "grey70")) (((class color) (min-colors 8) (background light)) (:foreground "green")) (((class color) (min-colors 8) (background dark)) (:foreground "yellow"))))
 '(secondary-selection ((((class color) (min-colors 88) (background light)) (:extend t :background "yellow1")) (((class color) (min-colors 88) (background dark)) (:extend t :background "SkyBlue4")) (((class color) (min-colors 16) (background light)) (:extend t :background "yellow")) (((class color) (min-colors 16) (background dark)) (:extend t :background "SkyBlue4")) (((class color) (min-colors 8)) (:extend t :foreground "black" :background "cyan")) (t (:inverse-video t))))
 '(trailing-whitespace ((((class color) (background light)) (:background "red1")) (((class color) (background dark)) (:background "red1")) (t (:inverse-video t))))
 '(font-lock-bracket-face ((t (:inherit (font-lock-punctuation-face)))))
 '(font-lock-builtin-face ((t (:foreground "#c975d1"))))
 '(font-lock-comment-delimiter-face ((default (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:foreground "#656565"))))
 '(font-lock-constant-face ((t (:foreground "#df5953"))))
 '(font-lock-delimiter-face ((t (:inherit (font-lock-punctuation-face)))))
 '(font-lock-doc-face ((t (:inherit font-lock-string-face))))
 '(font-lock-doc-markup-face ((t (:inherit (font-lock-constant-face)))))
 '(font-lock-escape-face ((t (:inherit (font-lock-regexp-grouping-backslash)))))
 '(font-lock-function-call-face ((t (:inherit font-lock-function-name-face))))
 '(font-lock-function-name-face ((t (:foreground "#518ce3"))))
 '(font-lock-keyword-face ((t (:foreground "#ae48b6"))))
 '(font-lock-negation-char-face ((t nil)))
 '(font-lock-number-face ((t (:foreground "#C7b299"))))
 '(font-lock-misc-punctuation-face ((t (:inherit font-lock-punctuation-face))))
 '(font-lock-operator-face ((t (:foreground "#d7af5f"))))
 '(font-lock-preprocessor-face ((t (:foreground "#ae48b6"))))
 '(font-lock-property-name-face ((t (:foreground "#87af5f"))))
 '(font-lock-property-use-face ((t (:inherit font-lock-property-name-face))))
 '(font-lock-punctuation-face ((t nil)))
 '(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "#87af5f"))))
 '(font-lock-type-face ((t (:foreground "#d7af5f"))))
 '(font-lock-variable-name-face ((t (:foreground "#df5953"))))
 '(font-lock-variable-use-face ((t (:foreground "#d7af5f"))))
 '(font-lock-warning-face ((t (:foreground "#f5f566" :weight bold))))
 '(button ((t (:underline (:color foreground-color :style line :position nil)))))
 '(link ((t (:foreground "#4da5c9" :underline (:color foreground-color :style line :position nil) :weight bold))))
 '(link-visited ((t (:inherit link :foreground "#c975d1"))))
 '(fringe ((t (:background "#1d1d1d" :foreground "#cccccc"))))
 '(header-line ((t (:box nil :foreground "grey90" :background "grey20" :inherit mode-line))))
 '(tooltip ((((class color)) (:inherit (variable-pitch) :foreground "black" :background "lightyellow")) (t (:inherit (variable-pitch)))))
 '(mode-line ((t (:background "#3a3c40" :foreground "#e0e0e0"))))
 '(mode-line-buffer-id ((t (:foreground "#d75f5f"))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((((supports :box t) (class color grayscale) (min-colors 88)) (:box (:line-width (2 . 2) :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 '(mode-line-inactive ((t (:box nil :foreground "black" :background "#2F2F2F"))))
 '(isearch ((t (:weight extra-bold :foreground "black" :background "cyan"))))
 '(isearch-fail ((((class color) (min-colors 88) (background light)) (:background "RosyBrown1")) (((class color) (min-colors 88) (background dark)) (:background "red4")) (((class color) (min-colors 16)) (:background "red")) (((class color) (min-colors 8)) (:background "red")) (((class color grayscale)) (:foreground "grey")) (t (:inverse-video t))))
 '(lazy-highlight ((t (:weight extra-bold :foreground "black" :background "#E0D063"))))
 '(match ((((class color) (min-colors 88) (background light)) (:background "khaki1")) (((class color) (min-colors 88) (background dark)) (:background "RoyalBlue3")) (((class color) (min-colors 8) (background light)) (:foreground "black" :background "yellow")) (((class color) (min-colors 8) (background dark)) (:foreground "white" :background "blue")) (((type tty) (class mono)) (:inverse-video t)) (t (:background "gray"))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch)))))
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#1d1d1d" :foreground "#cccccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 120 :width normal :foundry "nil" :family "Fira Code")))))

(provide-theme 'personal)

;;; theme.el ends here
