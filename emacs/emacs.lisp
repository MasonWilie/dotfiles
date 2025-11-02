;;; Package Management
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Auto-install packages
(defun ensure-package-installed (package)
  "Install PACKAGE if not already installed."
  (unless (package-installed-p package)
    (package-install package)))

(unless package-archive-contents
  (package-refresh-contents))

(mapc #'ensure-package-installed
      '(sly paredit rainbow-delimiters darcula-theme company which-key projectile))

;;; Lisp Development
(setq inferior-lisp-program "sbcl")

;; Enable paredit for balanced parentheses
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;; Rainbow delimiters for colorful parentheses
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Sly enhancements
(setq sly-complete-symbol-function 'sly-flex-completions)

;;; Editor Settings
;; Disable backup and lock files
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; Indentation
(setq-default indent-tabs-mode nil)
(setq lisp-indent-offset 2)

;; Display line numbers
(global-display-line-numbers-mode t)

;; Show matching parentheses
(show-paren-mode t)
(setq show-paren-delay 0)

;; Highlight current line
(global-hl-line-mode t)

;; Smoother scrolling
(setq scroll-margin 3
      scroll-conservatively 100000
      scroll-preserve-screen-position t)

;; Better default window splits
(setq split-height-threshold nil
      split-width-threshold 160)

;; Yes/no becomes y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Recent files
(recentf-mode t)
(setq recentf-max-saved-items 50)

;; Auto-completion with Company
(add-hook 'after-init-hook 'global-company-mode)

;; Which-key for keybinding hints
(which-key-mode)

;; Projectile for project management
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Auto-indent buffer keybinding
(defun indent-buffer ()
  "Indent the entire buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(global-set-key (kbd "C-c i") 'indent-buffer)

;;; Theme
(load-theme 'darcula t)

;;; Custom Settings
(custom-set-variables
 '(package-selected-packages '(sly rainbow-delimiters paredit darcula-theme company which-key projectile))
 '(warning-suppress-types '((comp))))

(custom-set-faces
 '(font-lock-function-name-face ((t (:foreground "color-39"))))
 '(minibuffer-prompt ((t (:foreground "color-38")))))

;; Auto refresh files
(global-auto-revert-mode 1)
