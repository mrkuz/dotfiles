;;--------------------------------------------------------------------------------------------------
;; Packages (early)
;;--------------------------------------------------------------------------------------------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(require 'use-package)

(use-package benchmark-init
  :ensure t
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package diminish
  :ensure t)

(use-package recentf
  :config
  (recentf-mode 1))

(use-package no-littering
  :ensure t
  :after recentf
  :config
  (add-to-list 'recentf-exclude no-littering-etc-directory)
  (add-to-list 'recentf-exclude no-littering-var-directory))

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
; Cycle through window configurations
(winner-mode 1)
; Disable menu bar
(menu-bar-mode 0)
; Disable scroll bar
(scroll-bar-mode 0)
; Show size in mode line
(size-indication-mode 1)
; Highligh current line
(global-hl-line-mode 1)
; Show matching parens
(show-paren-mode 1)

;;--------------------------------------------------------------------------------------------------
;; Key bindings
;;--------------------------------------------------------------------------------------------------

(setq my-map (make-sparse-keymap))
(global-set-key (kbd "C-;") my-map)
(global-set-key (kbd "C-ö") my-map)

(define-key my-map (kbd "h h") 'highlight-changes-mode)
(define-key my-map (kbd "h r") 'my-highlight-changes-remove-all)
(define-key my-map (kbd "v w") 'whitespace-mode)

(defun my-highlight-changes-remove-all ()
  "Remove all changes."
  (interactive)
  (highlight-changes-remove-highlight (point-min) (point-max)))

;;--------------------------------------------------------------------------------------------------
;; Packages
;;--------------------------------------------------------------------------------------------------

(use-package eldoc
  :defer t
  :diminish eldoc-mode)

(use-package ido
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (setq ido-enable-flex-matching t))

(use-package ido-completing-read+
  :ensure t
  :after ido
  :config
  (ido-ubiquitous-mode 1))

(use-package flx-ido
  :ensure t
  :after ido
  :config
  (flx-ido-mode 1))

(use-package smex
  :ensure t
  :after ido
  :bind (( "M-x" . 'smex)))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode 1))

(use-package anzu
  :ensure t
  :diminish anzu-mode
  :config
  (global-anzu-mode 1)
  :custom-face (anzu-mode-line ((t (nil :weight 'normal :foreground "white"))))
  :bind (([remap query-replace] . 'anzu-query-replace)
	 ([remap query-replace-regexp] . 'anzu-query-replace-regexp)
	 :map isearch-mode-map
	 ([remap isearch-query-replace]  . 'anzu-isearch-query-replace)
	 ([remap isearch-query-replace-regexp] . 'anzu-isearch-query-replace-regexp)))

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

(use-package all-the-icons
  :ensure t)

(use-package doom-themes
  :ensure t
  :after all-the-icons
  :config
  (load-theme 'doom-one 1)
  (doom-themes-treemacs-config))

(use-package telephone-line
  :ensure t
  :config
  (telephone-line-mode 1))

(use-package awesome-tab
  :load-path "site-lisp/awesome-tab/"
  :defer 1
  :config
  (setq awesome-tab-background-color "grey12")
  (setq awesome-tab-style "bar")
  :bind (:map my-map ("v t" . 'awesome-tab-mode)))

(use-package projectile
  :ensure t
  :defer 1
  :config
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (add-hook 'treemacs-mode-hook (lambda () (linum-mode 0)))
  (add-hook 'treemacs-mode-hook (lambda () (setq mode-line-format "")))
  :config
  (setq treemacs-python-executable (executable-find "python3"))
  (set-face-attribute 'treemacs-root-face nil :height 1.0 :underline nil)
  (setq treemacs-icon-root-png
	(concat " "
		(all-the-icons-octicon "repo" :v-adjust -0.1 :height 1.2 :face 'font-lock-string-face)
                " "))
  (setq treemacs-collapse-dirs 10)
  (setq treemacs-width 30)
  (setq treemacs-is-never-other-window t)
  (setq treemacs-persist-file (no-littering-expand-var-file-name "treemacs-persist"))
  :bind (:map treemacs-mode-map ([mouse-1] . 'treemacs-single-click-expand-action))
  :bind (:map my-map ("t t" . 'treemacs))
  :bind (:map my-map ("t p" . 'treemacs-add-and-display-current-project))
  :bind (:map my-map ("t o" . 'treemacs-select-window)))

(use-package treemacs-projectile
  :ensure t
  :after treemacs projectile)
