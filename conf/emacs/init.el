;; Required packages.
(setq package-list
      '(alect-themes ac-helm helm-c-yasnippet helm-google better-defaults cedit dired-launch expand-region find-file-in-project helm helm-dired-history helm-dirset helm-package helm-smex helm-themes idle-highlight-mode ido-completing-read+ jdee keychain-environment list-unicode-display log4j-mode magit magit-gh-pulls markdown-mode markdown-mode+ markdown-preview-mode paredit paredit-everywhere paren-completer pug-mode scala-mode smex xterm-color tide web-mode))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'load-path "~/.emacs.d/addon")
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;; Fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; Install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (web-mode alect-themes tide ess ess-R-data-view ess-smart-equals haskell-mode xterm-color scala-mode pug-mode paren-completer paredit-everywhere paredit markdown-preview-mode markdown-mode+ markdown-mode magit-gh-pulls magit log4j-mode list-unicode-display keychain-environment jdee ido-completing-read+ idle-highlight-mode helm-themes helm-smex helm-package helm-dirset helm-dired-history find-file-in-project expand-region dired-launch cedit better-defaults helm-google helm-c-yasnippet ac-helm))))

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
(load-theme 'alect-dark t)

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
;;(require 'ido-completing-read+)
(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

;;
;;(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

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

;; Load default auto-complete configs
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;; Tide setup
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  ;; (company-mode +1)
  )

;; aligns annotation to the right hand side
;;(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;; (add-hook 'js2-mode-hook #'setup-tide-mode)
;; (require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (string-equal "jsx" (file-name-extension buffer-file-name))
;;               (setup-tide-mode))))

(setq tide-format-options '(:indentSize 2 :tabSize 2))
(setq tide-tsserver-executable "/usr/local/bin/tsserver")
