;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'load-path "~/.emacs.d/addon")
;; (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (anti-zenburn-theme ac-helm helm-c-yasnippet helm-google better-defaults cedit dired-launch expand-region find-file-in-project helm helm-dired-history helm-dirset helm-package helm-smex helm-themes idle-highlight-mode ido-at-point ido-load-library ido-ubiquitous jdee keychain-environment list-unicode-display log4j-mode magit magit-gh-pulls markdown-mode markdown-mode+ markdown-preview-mode paredit paredit-everywhere paren-completer pug-mode scala-mode smex xterm-color))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;;;;
;;; CUSTOM
;;;;;;;;;;;;;;;;;;;;;;
;; Main theme
(load-theme 'anti-zenburn t)

;; Highlight matching parentheses
(show-paren-mode)

;; Disable menu-bar
(menu-bar-mode -1)

;; Disable tool-bar
(tool-bar-mode -1)

;; Disable scroll-bar
(scroll-bar-mode -1)

;; Show columns
(column-number-mode)

;; Startup screen
(setq inhibit-splash-screen t)

;;Set hooks for dired-launch-mode
(add-hook 'dired-mode-hook
          'dired-launch-mode)

;; History
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(savehist-mode 1)

;; remove all trailing whitespace and trailing blank lines before saving the file
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Ido
(require 'ido)
(require 'ido-ubiquitous)
(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

;;Set up helm-mode
(require 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)
(helm-autoresize-mode 1)
(setq helm-split-window-in-side-p t)

;; Enable magit everywhere
(setq magit-completing-read-function 'magit-ido-completing-read)
(global-set-key (kbd "C-x g") 'magit-status)

;; Tabs
(setq-default indent-tabs-mode nil)
(setq tab-width 4) ; or any other preferred value
(setq-default c-basic-offset 4)

;; creating, editing, debugging, and documenting Java applications
;; https://github.com/jdee-emacs/jdee
(require 'jdee)
(add-hook 'jdee-mode-hook (lambda ()
                            (setq c-basic-offset 2)))
(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2)))

(jdee-abbrev-mode)
(setq jdee-server-dir "~/Code/z/jdee-server/target/jdee-1.1-SNAPSHOT.jar")

;; Load default auto-complete configs
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
