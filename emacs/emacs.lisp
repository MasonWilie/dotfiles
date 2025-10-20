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
      '(sly paredit rainbow-delimiters darcula-theme))

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

;;; Theme
(load-theme 'darcula t)

;;; Custom Settings
(custom-set-variables
 '(package-selected-packages '(sly rainbow-delimiters paredit darcula-theme))
 '(warning-suppress-types '((comp))))

(custom-set-faces
 '(font-lock-function-name-face ((t (:foreground "color-39"))))
 '(minibuffer-prompt ((t (:foreground "color-38")))))
