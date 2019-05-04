;;--------------------------------------------------------------------------------------------------
;; Packages (early)
;;--------------------------------------------------------------------------------------------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(use-package benchmark-init
  :ensure t
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package diminish
  :ensure t)

(use-package no-littering
  :ensure t)

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
; Raise display time of suggestions
(setq suggest-key-bindings 4)
; Enable drag and drop text via mouse
(setq mouse-drag-and-drop-region t)
; Tab width
(setq-default tab-width 4)
; Always use spaces
(setq-default indent-tabs-mode nil)
; Indent four spaces
(setq tab-stop-list '(0 4))
; Increase left fringe width
(setq-default left-fringe-width 16)
; Increase right fringe width
(setq-default right-fringe-width 16)

;;--------------------------------------------------------------------------------------------------
;; Look and feel
;;--------------------------------------------------------------------------------------------------

; Disable toolbar
(tool-bar-mode 0)
; Disable blinking cursor
(blink-cursor-mode 0)
; Show column number in mode line
(column-number-mode 1)
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
; Automatically close parens
(electric-pair-mode 1)
; No dialog boxes
(setq use-dialog-box nil)
; Disable GTK tooltips
(setq x-gtk-use-system-tooltips nil)

;;--------------------------------------------------------------------------------------------------
;; Packages
;;--------------------------------------------------------------------------------------------------

(use-package recentf
  :after no-littering
  :config
  (add-to-list 'recentf-exclude no-littering-etc-directory)
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude "COMMIT_EDITMSG")
  (recentf-mode 1))

(use-package eldoc
  :diminish eldoc-mode)

(use-package abbrev
  :diminish abbrev-mode)

(use-package ibuffer
  :config
  (setq ibuffer-use-other-window t)
  :bind (([remap list-buffers] . 'ibuffer)))

(use-package exec-path-from-shell
  :ensure t
  :config
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize))

(use-package try
  :ensure t
  :commands try)

(use-package ido
  :defer 1
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil))

(use-package ido-vertical-mode
  :after ido
  :init
  (setq ido-vertical-indicator " >")
  :config
  (ido-vertical-mode)
  (setq ido-vertical-define-keys 'C-n-C-p-up-and-down))

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
  :commands smex
  :bind (( "M-x" . 'smex)))

(use-package which-key
  :ensure t
  :defer 1
  :diminish which-key-mode
  :config
  (which-key-mode 1))

(use-package anzu
  :ensure t
  :defer 1
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
  :commands (ace-jump-word-mode ace-jump-line-mode))

(use-package ace-window
  :ensure t
  :commands ace-windw)

(use-package expand-region
  :ensure t
  :commands expand-region)

(use-package multiple-cursors
  :ensure t
  :commands mc/mark-all-like-this)

(use-package hungry-delete
  :ensure t
  :commands hungry-delete-backward
  :diminish hungry-delete-mode)

(use-package undo-tree
  :ensure t
  :defer 1
  :diminish undo-tree-mode
  :config
  (setq undo-tree-visualizer-relative-timestamps nil)
  (global-undo-tree-mode)
  :bind (:map undo-tree-map ("C-x u" . 'undo)))

(use-package all-the-icons
  :ensure t)

(use-package doom-themes
  :ensure t
  :after all-the-icons
  :config
  (load-theme 'doom-one 1)
  (doom-themes-treemacs-config))

(use-package dashboard
  :ensure t
  :config
  (setq dashboard-items '((recents . 5) (bookmarks . 5) (projects . 5)))
  (dashboard-setup-startup-hook))

(use-package eyebrowse
  :ensure t
  :defer 1
  :config
  (setq eyebrowse-mode-line-left-delimiter "")
  (setq eyebrowse-mode-line-right-delimiter "")
  (setq eyebrowse-mode-line-separator " ")
  (setq eyebrowse-new-workspace t)
  (eyebrowse-mode))

(use-package telephone-line
  :ensure t
  :config
  (setq telephone-line-rhs
        '((nil . (telephone-line-misc-info-segment))
          (nil . ( telephone-line-flycheck-segment))
          (accent . (telephone-line-major-mode-segment))
          (nil . (telephone-line-minor-mode-segment))
          (evil . (telephone-line-airline-position-segment))))
  (telephone-line-mode 1))

(use-package awesome-tab
  :load-path "site-lisp/awesome-tab/"
  :commands awesome-tab-mode
  :config
  (setq awesome-tab-background-color "grey12")
  (setq awesome-tab-style "bar"))

(use-package projectile
  :ensure t
  :defer 1
  :diminish projectile-mode
  :config
  (projectile-global-mode)
  (setq projectile-globally-ignored-buffers '("\\*.*"))
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package treemacs
  :ensure t
  :commands treemacs
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
  :hook (treemacs-mode . (lambda () (linum-mode 0)))
  :hook (treemacs-mode . (lambda () (setq mode-line-format "")))
  :bind (:map treemacs-mode-map ([mouse-1] . 'treemacs-single-click-expand-action)))

(use-package treemacs-projectile
  :ensure t
  :after treemacs projectile)

(use-package company
  :ensure t
  :defer 1
  :diminish company-mode
  :config
  (global-company-mode 1)
  (setq company-minimum-prefix-length 1)
  (setq company-show-numbers t)
  (setq company-idle-delay 0.2)
  :hook (company-mode . company-quickhelp-mode)
  :bind (:map company-active-map
              ("M-f" . 'company-flx-mode)
              ("C-n" . 'company-select-next)
              ("C-p" . 'company-select-previous)))

(use-package company-flx
  :ensure t
  :after company)

(use-package company-quickhelp
  :ensure t
  :after company
  :config
  (setq company-quickhelp-delay 1.2)
  (setq company-quickhelp-max-lines 20)
  (setq company-quickhelp-use-propertized-text t))

(use-package yasnippet
  :ensure t
  :after company
  :diminish yas-minor-mode
  :config
  (setq yas-verbosity 2)
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

(use-package flycheck
  :ensure t
  :defer 1
  :diminish flycheck-mode
  :config
  (global-flycheck-mode))

(use-package flycheck-pos-tip
  :ensure t
  :after flycheck
  :config
  (flycheck-pos-tip-mode))

(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :config
  (require 'git-gutter-fringe)
  (global-git-gutter-mode +1)
  ; Show line numbers in front of each row
  (global-linum-mode 1))

(use-package git-gutter-fringe
  :ensure t
  :defer t)

(use-package maven-test-mode
  :ensure t
  :diminish maven-test-mode
  :hook (java-mode . maven-test-mode))

(use-package rainbow-delimiters
  :ensure t
  :commands rainbow-delimiters-mode)

(use-package auto-yasnippet
  :ensure t
  :commands (aya-create aya-expand))

(use-package google-this
  :ensure t
  :commands google-this)

(use-package magit
  :commands magit-status)

;;--------------------------------------------------------------------------------------------------
;; Packages (lsp)
;;--------------------------------------------------------------------------------------------------

(use-package lsp-mode
  :ensure t
  :commands lsp
  :config
  (setq lsp-auto-configure nil)
  (require 'lsp-ui-flycheck)
  (lsp-ui-flycheck-enable t))

(use-package company-lsp
  :ensure t
  :after lsp-mode company
  :config
  (add-to-list 'company-backends 'company-lsp)
  (setq company-lsp-cache-candidates 'auto))

(use-package lsp-ui
  :ensure t
  :after lsp-mode)

(use-package lsp-java
  :ensure t
  :after lsp-mode
  :config
  (setq lsp-java-auto-build nil)
  (setq lsp-java-progress-report nil)
  (setq lsp-eldoc-enable-signature-help nil)
  (setq lsp-java-server-install-dir (no-littering-expand-var-file-name "eclipse.jdt.ls/server"))
  (setq lsp-java-workspace-dir (no-littering-expand-var-file-name "workspace"))
  (setq lsp-java-workspace-cache-dir (no-littering-expand-var-file-name "workspace/cache")))

;;--------------------------------------------------------------------------------------------------
;; Key bindings
;;--------------------------------------------------------------------------------------------------

(setq my-map (make-sparse-keymap))
(global-set-key (kbd "C-;") my-map)
(global-set-key (kbd "C-ö") my-map)

(define-key my-map (kbd "f i") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
(define-key my-map (kbd "g d") 'git-gutter:popup-hunk)
(define-key my-map (kbd "g n") 'git-gutter:next-hunk)
(define-key my-map (kbd "g p") 'git-gutter:previous-hunk)
(define-key my-map (kbd "g r") 'git-gutter:revert-hunk)
(define-key my-map (kbd "g s") 'magit-status)
(define-key my-map (kbd "g t") 'git-gutter:toggle)
(define-key my-map (kbd "G") 'google-this)
(define-key my-map (kbd "h h") 'highlight-changes-mode)
(define-key my-map (kbd "h r") 'my-highlight-changes-remove-all)
(define-key my-map (kbd "j c") 'ace-jump-word-mode)
(define-key my-map (kbd "j i") 'imenu)
(define-key my-map (kbd "j l") 'ace-jump-line-mode)
(define-key my-map (kbd "j w") 'ace-window)
(define-key my-map (kbd "l d") 'lsp-describe-thing-at-point)
(define-key my-map (kbd "l f") 'lsp-format-buffer)
(define-key my-map (kbd "l o") 'lsp-organize-imports)
(define-key my-map (kbd "l x") 'lsp-execute-code-action)
(define-key my-map (kbd "m") 'mc/mark-all-like-this)
(define-key my-map (kbd "s c") 'aya-create)
(define-key my-map (kbd "s e") 'aya-expand)
(define-key my-map (kbd "t t") 'treemacs)
(define-key my-map (kbd "t p") 'treemacs-add-and-display-current-project)
(define-key my-map (kbd "t o") 'treemacs-select-window)
(define-key my-map (kbd "u") 'undo-tree-visualize)
(define-key my-map (kbd "v l") 'my-toggle-truncate-line)
(define-key my-map (kbd "v t") 'awesome-tab-mode)
(define-key my-map (kbd "v w") 'whitespace-mode)
(define-key my-map (kbd "x") 'er/expand-region)
(define-key my-map (kbd "DEL") 'hungry-delete-backward)
(define-key my-map (kbd "SPC") 'company-complete)
(define-key my-map (kbd "TAB") 'company-yasnippet)

(defun my-highlight-changes-remove-all ()
  "Remove all changes."
  (interactive)
  (highlight-changes-remove-highlight (point-min) (point-max)))

(defun my-toggle-truncate-line ()
  "Toggle trunacte line."
  (interactive)
  (setq truncate-lines (if (not truncate-lines) t nil)))

;;--------------------------------------------------------------------------------------------------
;; Fixes
;;--------------------------------------------------------------------------------------------------

(require 'ansi-color)
(defun my-colorize-compilation ()
  "Colorize compilation output"
  (ansi-color-apply-on-region compilation-filter-start (point)))

(add-hook 'compilation-filter-hook 'my-colorize-compilation)
