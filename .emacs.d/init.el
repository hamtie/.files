(require 'package)
(add-to-list 'load-path "~/.emacs.d/addon")
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))


(defvar my-packages '(better-defaults paredit idle-highlight-mode ido-ubiquitous
                                      find-file-in-project magit smex scpaste cider package-filter))


;; There is a small bug in Emacs24’s package.el such that the
;; dependency order comes out backwards. The problem is patched by
;; some advice. via http://melpa.org/#/getting-started
(defadvice package-compute-transaction
  (before package-compute-transaction-reverse (package-list requirements) activate compile)
  "reverse the requirements"
  (setq requirements (reverse requirements))
  (print requirements))

;; needs to load before eieio
(load "cedet/cedet-devel-load.el")

;; Don't install groovy from marmalade
(setq package-archive-exclude-alist '(("marmalade" groovy-mode)
                                      ("marmalade" malabar-mode)))

(package-initialize)
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("6a9606327ecca6e772fba6ef46137d129e6d1888dcfc65d0b9b27a7a00a4af20" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(eclim-auto-save t)
 '(eclim-eclipse-dirs (quote ("/opt/eclipse")))
 '(eclim-executable "/opt/eclipse/eclim")
 '(eclimd-default-workspace "/home/hannah/eclipse-luna-workspace")
 '(help-at-pt-display-when-idle t nil (help-at-pt))
 '(help-at-pt-timer-delay 0.1))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'zenburn)
(display-time-mode)
(column-number-mode)


;; environment
(defvar home-dir "/home/hannah")
(setenv "JAVA_HOME" "/usr/lib/jvm/java-7-oracle")
(setenv "GROOVY_HOME" (concat home-dir "/.gvm/groovy/current"))
(setenv "MAVEN_HOME" "/usr/share/maven")
(setenv "PATH" (concat (getenv "PATH")
		       ":" (getenv "JAVA_HOME") "/bin"
		       ":" (getenv "GROOVY_HOME") "/bin"
		       ":" (getenv "MAVEN_HOME") "/bin"))

(push (concat home-dir "/.gvm/groovy/current/bin") exec-path)

(when (equal system-type 'darwin)
  (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:" (getenv "PATH")))
  (push "/opt/local/bin" exec-path)
  (push "/usr/local/bin" exec-path)
  )

(global-set-key (kbd "C-x g") 'magit-status)


;; Extras


;; Not really sure what this does, but testing to see if it fixes my
;; issues with eclim
;; via https://github.com/senny/emacs-eclim/issues/95
(require 'cl-lib)
(require 'cl)

;; Loads keychain so I don't have to type ssh passphrase in magit and shtuff
(load "keychain-environment.el")
(require 'keychain-environment)
(keychain-refresh-environment)

;; Augmented package functionality
;;(require 'package-filter)



;; CIDER (clojure stuff)
(add-hook 'cider-mode-hook #'eldoc-mode)
(setq nrepl-log-messages t)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-tab-command #'indent-for-tab-command)



(load "cedet/contrib/cedet-contrib-load.el")
(require 'cedet)
(require 'semantic)

;; Add further minor-modes to be enabled by semantic-mode.
;; See doc-string of `semantic-default-submodes' for other things
;; you can use here.
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

;; Enable Semantic
(semantic-mode 1)

;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Auto complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;; ECLIM!!
(require 'eclim)
(global-eclim-mode)
(require 'eclimd)

(help-at-pt-set-timer)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)
(setq compilation-skip-threshold 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Command to run a function on marked files in dired mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun dired-mark-cmd (cmd)
  (interactive "CCommand: ")
  (dolist (file (dired-get-marked-files))
    (find-file file)
    (funcall cmd)
    (save-buffer)
    (kill-buffer nil)))



;;;;;;;;;;;;;;;;;
;; Malabar Mode
;;;;;;;;;;;;;;;;;

;; Groovy


;; ;; Groovy bullshit
;; (autoload 'groovy-mode "groovy-mode"
;;   "Mode for editing groovy source files" t)
;; (setq auto-mode-alist
;;       (append '(("\\.groovy\\'" . groovy-mode)) auto-mode-alist))
;; (setq interpreter-mode-alist (append '(("groovy" . groovy-mode))
;;    				     interpreter-mode-alist))

;; (autoload 'groovy-mode "groovy-mode" "Groovy mode." t)
;; (autoload 'run-groovy "inf-groovy" "Run an inferior Groovy process")
;; (autoload 'inf-groovy-keys "inf-groovy" "Set local key defs for inf-groovy in groovy-mode")

;; (add-hook 'groovy-mode-hook
;;           '(lambda ()
;;              (inf-groovy-keys)
;;              ))

;; (require 'groovy-mode)



;; ;; Malabar Stuff
;; (setq malabar-server-jar-version "2.3.2")

;; (require 'malabar-mode)


;; (add-hook 'after-init-hook 
;;       (lambda ()
;;         (message "activate-malabar-mode")
;;         (activate-malabar-mode)
;;         ))

;; (add-hook 'malabar-java-mode-hook 'flycheck-mode)
;; (add-hook 'malabar-java-mode-hook 'java-mode)
;; (add-hook 'malabar-groovy-mode-hook 'flycheck-mode)

;; (add-hook 'malabar-mode-hook
;;      (lambda () 
;;        (add-hook 'after-save-hook 'malabar-http-compile-file-silently
;;                  nil t)))



;; ; via https://github.com/lwiechec/dotfiles/blob/master/etc/emacs.d/el-get-init-files/init-malabar-mode.el
;; ; as the stock 'Run test via maven from malabar' does not work for me, here's a workaround
;; (defun lw/malabar-run-test ()
;;   (interactive)
;;   "runs Maven test for current buffer. Does not perform check if the test is actually a test."
;;   (malabar-run-maven-command (concat "-Dtest=" (car (split-string (buffer-name (current-buffer)) ".java")) " test")))

;; (defun lw/malabar-debug (main-class)
;;   (interactive "sMain class:")
;;   "Run (main) class in debug mode"
;;   (malabar-run-maven-command
;;    (format "exec:exec -Dexec.executable='java' -Dexec.args='-classpath %%classpath -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=1044' %s" main-class)))


;; (malabar-run-groovy)


(put 'scroll-left 'disabled nil)
(put 'upcase-region 'disabled nil)

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2)))
(put 'downcase-region 'disabled nil)
