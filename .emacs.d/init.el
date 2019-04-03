;;--------------------------------------------------------------------------------------------------
;; Packages
;;--------------------------------------------------------------------------------------------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(require 'no-littering)

;;--------------------------------------------------------------------------------------------------
;; Startup
;;--------------------------------------------------------------------------------------------------

; Disable splash screen
(setq inhibit-splash-screen t)
; Empty *scratch* buffer
(setq initial-scratch-message nil)

;;--------------------------------------------------------------------------------------------------
;; Saving
;;--------------------------------------------------------------------------------------------------

; Disable backup files
(setq make-backup-files nil)
; Disable auto save
(setq auto-save-default nil)

;;--------------------------------------------------------------------------------------------------
;; File paths
;;--------------------------------------------------------------------------------------------------

; Customization file
(setq custom-file (no-littering-expand-etc-file-name "custom"))

;;--------------------------------------------------------------------------------------------------
;; General
;;--------------------------------------------------------------------------------------------------

; Always ask for y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)
; Enable all disabled commands
(setq disabled-command-hook nil)
; Disable bell
(setq ring-bell-function 'ignore)
; Save bookmarks file after each bookmark
(setq bookmark-save-flag 1)
; Scroll to top and bottom at end
(setq-default scroll-error-top-bottom t)
; Try to keep position when scrolling
(setq-default scroll-preserve-screen-position t)
; Delete region when insert character
(delete-selection-mode 1)
; Raise display time of suggestions
(setq suggest-key-bindings 4)

;;--------------------------------------------------------------------------------------------------
;; Look and feel
;;--------------------------------------------------------------------------------------------------

; Load theme
(load-theme 'wombat)
; Disable toolbar
(tool-bar-mode 0)
; Disable blinking cursor
(blink-cursor-mode 0)
; Show line numbers in front of each row
(global-linum-mode 1)
; Show column number in mode line
(column-number-mode 1)
; Truncate long lines
(setq-default truncate-lines t)
; Show trailing whitespace
(setq-default show-trailing-whitespace t)
; Cycle through window configurations
(winner-mode 1)
; Disable menu bar
(menu-bar-mode 0)
; Disable scroll bar
(scroll-bar-mode 0)
; Show size in mode line
(size-indication-mode 1)
; Highligh current line
(global-hl-line-mode)
(set-face-attribute hl-line-face nil :underline nil :background "grey10")

;;--------------------------------------------------------------------------------------------------
;; Key bindings
;;--------------------------------------------------------------------------------------------------

(setq my-map (make-sparse-keymap))
(global-set-key (kbd "C-;") my-map)
(global-set-key (kbd "C-ö") my-map)

(define-key my-map (kbd "h h") 'highlight-changes-mode)
(define-key my-map (kbd "h r") 'my-highlight-changes-remove-all)

(defun my-highlight-changes-remove-all ()
  "Remove all changes."
  (interactive)
  (highlight-changes-remove-highlight (point-min) (point-max)))

;;--------------------------------------------------------------------------------------------------
;; Packages
;;--------------------------------------------------------------------------------------------------

(eval-when-compile
  (require 'use-package))

(use-package diminish
  :ensure t)

(use-package no-littering
  :ensure t
  :requires recentf
  :config
  (add-to-list 'recentf-exclude no-littering-etc-directory)
  (add-to-list 'recentf-exclude no-littering-var-directory))

(use-package ido
  :config
  (ido-mode 1)
  (ido-everywhere 1))

(use-package ido-completing-read+
  :after ido
  :ensure t
  :config
  (ido-ubiquitous-mode 1))

(use-package smex
  :after ido
  :ensure t
  :bind (( "M-x" . 'smex)))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

(use-package anzu
  :ensure t
  :config
  (global-anzu-mode 1)
  :custom-face (anzu-mode-line ((t (nil :weight 'normal :foreground "white"))))
  :bind (([remap query-replace] . 'anzu-query-replace)
	 ([remap query-replace-regexp] . 'anzu-query-replace-regexp)
	 :map isearch-mode-map
	 ([remap isearch-query-replace]  . 'anzu-isearch-query-replace)
	 ([remap isearch-query-replace-regexp] . 'anzu-isearch-query-replace-regexp)))

(use-package telephone-line
  :ensure t
  :config
  (telephone-line-mode 1))

(use-package ace-jump-mode
  :ensure t
  :bind (:map my-map
	      ("a j" . 'ace-jump-word-mode)
	      ("a l" . 'ace-jump-line-mode)))

(use-package ace-window
  :ensure t
  :bind (:map my-map ("a w" . 'ace-window)))

(use-package expand-region
  :ensure t
  :bind (:map my-map ("x" . 'er/expand-region)))

(use-package awesome-tab
  :load-path "site-lisp/awesome-tab/"
  :config
  (setq awesome-tab-background-color "grey12")
  (setq awesome-tab-style "bar"))
