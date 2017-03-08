;; Initialize the load path
(add-to-list 'load-path "~/elisp/")
(add-to-list 'load-path "~/.emacs.d/lisp")

; stop creating ~ files
(setq make-backup-files nil)
(setq auto-save-default nil)
; disable startupscreen
(setq inhibit-startup-screen t)
;; lisp autocomplete, disable this for company-mode instead
(add-hook 'lisp-mode-hook 'company-mode)
(add-hook 'lisp-mode-hook 'flycheck-mode)
;; Initialise all packages
(package-initialize)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; Custom Faces and Settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(company-idle-delay 0.3)
 '(company-quickhelp-delay 0.3)
 '(custom-enabled-themes (quote (tango-dark)))
 '(desktop-clear-preserve-buffers
   (quote
    ("\\*scratch\\*" "\\*Messages\\*" "\\*server\\*" "\\*tramp/.+\\*" "\\*Warnings\\*" "\\*kafka\\*" "\\*consumer\\*" "\\*producer\\*" "\\*local-shell\\*" "\\*shell\\*" "\\*zookeeper\\*" "\\*celery-worker\\*" "\\*redis-server\\*" "\\*Python\\*" "\\*mock-server\\*")))
 '(erc-log-insert-log-on-open t)
 '(flycheck-display-errors-delay 0.3)
 '(global-flycheck-mode t)
 '(python-shell-completion-native-enable nil)
 '(safe-local-variable-values
   (quote
    ((python-shell-completion-native-enable quote nil)
     (python-shell-prompt-detect-enabled quote nil)
     (python-shell-virtualenv-root . "/home/ebby/code/node-admin/django/env/")
     (python-shell-completion-native-disabled-interpreters . "python")
     (python-shell-completion-native-disabled-interpreters quote
							   ("python"))
     (python-shell-completion-native quote nil)
     (python-shell-virtualenv-path . "/home/ebby/code/interview-occupancy-service/env/")
     (python-shell-interpreter . "/home/ebby/code/interview-occupancy-service/env/bin/python")
     (python-shell-virtualenv-path . "/home/ebby/code/web-monitoring/env/")
     (python-shell-interpreter-args . "/home/ebby/code/web-monitoring/manage.py shell")
     (python-shell-interpreter . "/home/ebby/code/web-monitoring/env/bin/python")
     (python-shell-virtualenv-path . "/home/ebby/code/myscypho/myscypho/env/")
     (python-shell-interpreter-args . "/home/ebby/code/myscypho/myscypho/manage.py shell")
     (python-shell-interpreter . "/home/ebby/code/myscypho/myscypho/env/bin/python")
     (python-shell-virtualenv-path . "/home/ebby/code/node-admin/django/env/")
     (python-shell-interpreter-args . "/home/ebby/code/node-admin/django/admin-root/manage.py shell")
     (python-shell-interpreter . "/home/ebby/code/node-admin/django/env/bin/python"))))
 '(tramp-default-method "ssh" nil (tramp)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Highlight Active Buffer / Must be after themes
;; (set-face-attribute  'mode-line
;;                  nil 
;;                  :foreground "gray30"
;;                  :background "gray80" 
;;                  :box '(:line-width 1 :style released-button))
(set-face-attribute  'mode-line-inactive
                 nil 
                 :foreground "gray30"
                 :background "gray80"
                 :box '(:line-width 1 :style released-button))

(load "myalias")
;; Dired Settings
(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding too current buffer." t)
(autoload 'dired-jump-other-window "dired-x"
  "Like \\[dired-jump] (dired-jump) but in other window." t)
(define-key global-map "\C-x\C-j" 'dired-jump)
(define-key global-map "\C-x4\C-j" 'dired-jump-other-window)
;; dired omit mode
(add-hook 'dired-load-hook '(lambda () (require 'dired-x)))
(setq dired-omit-mode t)

;; Enables highlight-parentheses-mode on all buffers:
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)


;;Bookmarks+
(require 'bookmark+)

;; Python/Elpy
(elpy-enable)
(setq elpy-rpc-backend "jedi")  
(setq jedi:complete-on-dot t)
(add-to-list 'company-backends 'company-jedi)
(add-hook 'python-mode-hook 'elpy-mode)
(add-hook 'python-mode-hoook 'autopair-mode)
(require 'ws-butler)
(add-hook 'python-mode-hook 'ws-butler-mode)
;; documentation popups, for jedin
(company-quickhelp-mode 1)

;; Emacs Kafka
(add-to-list 'load-path "~/code/emacs-kafka")
(require 'kafka-cli)

;; coverage
(load-file "/home/ebby/code/pycoverage.el-master/pycoverage.el")
(require 'linum)
(require 'pycoverage)

;; Company Mode (global)
(add-hook 'after-init-hook 'global-company-mode)

;; Markdown
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives 
                     '("melpa" . "http://melpa.milkbox.net/packages/")
                     'APPEND)

(use-package markdown-mode
   :ensure t
   :commands (markdown-mode gfm-mode)
   :mode (("README\\.md\\'" . gfm-mode)
          ("\\.md\\'" . markdown-mode)
          ("\\.markdown\\'" . markdown-mode))
   :init (setq markdown-command "multimarkdown"))


;; Scala/Ensime
(use-package ensime
  :ensure t
  :pin melpa-stable)
(add-hook 'scala-mode-hook 'ensime-mode)
(require 'ensime)

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
  '(lambda ()
     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; fiplr / subsitute with helm-projectile
(global-set-key (kbd "C-x C-y") 'helm-projectile)
;;(setq fiplr-ignored-globs '((directories (".git" ".svn" "build" "node_modules" "env" "venv"))
;;(files ("*.jpg" "*.png" "*.zip" "*~" "*.log" "*.pyc"))))

;; js2mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(require 'js2-refactor)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")

;; handlebar mode
(add-to-list 'auto-mode-alist '("\\.hbs\\'". handlebars-mode))
;(setq auto-mode-alist (rassq-delete-all 'handlebars-mode auto-mode-alist))


;; disabling this because of frequent git locks?
;; dired-k 
;(require 'dired-k)
;(define-key dired-mode-map (kbd "K") 'dired-k)
;; You can use dired-k alternative to revert-buffer
;(define-key dired-mode-map (kbd "g") 'dired-k)
;; always execute dired-k when dired buffer is opened
;(add-hook 'dired-initial-position-hook 'dired-k)
;(add-hook 'dired-after-readin-hook #'dired-k-no-revert)

;; Evil
(add-to-list 'load-path "~/.emacs.d/lisp/evil")
(require 'evil)
;(global-set-key (kbd "C-*") 'evil-search-symbol-forward)
(global-set-key (kbd "C-#") 'evil-search-symbol-backward)
(global-set-key (kbd "C-z") 'find-grep)
(global-set-key (kbd "M-C-z") 'find-grep-dired)


;; Always enable editor config
(require 'editorconfig)
(editorconfig-mode 1)		 

;; Do we need this ? 10Jan2007 after finding it interfering with tramp/shell
;; (autoload 'bash-completion-dynamic-complete
;;   "bash-completion"
;;   "BASH completion hook")
;; (add-hook 'shell-dynamic-complete-functions
;; 	  'bash-completion-dynamic-complete)

;; Key Chord
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "jj" 'other-window)

;; Navigation
;; thrown when windows are missing
(defun ignore-error-wrapper (fn)
  "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
  (lexical-let ((fn fn))
    (lambda ()
      (interactive)
      (ignore-errors
        (funcall fn)))))
;; windmove windows navigation
(global-set-key [S-left] (ignore-error-wrapper 'windmove-left))
(global-set-key [S-right] (ignore-error-wrapper 'windmove-right))
(global-set-key [S-up] (ignore-error-wrapper 'windmove-up))
(global-set-key [S-down] (ignore-error-wrapper 'windmove-down))
;; drag stuff
(drag-stuff-global-mode 1)

;; toolbar mode disable
(setq tool-bar-mode -1)

;; Icicile / Before Helm
(setq icicle-mode 1)

;; Helm
(global-set-key (kbd "M-x") 'helm-M-x)
(require 'helm-config)
(setq helm-mode 1)
; open helm buffer inside current window, not occupy whole other window
(setq helm-split-window-in-side-p t)

      
;; experimental, this causes some programs to fail, when they write to buffers
;(defun eb-find-file-readonly ()
;  (progn
;    (message "current buffer %s" (buffer-name (current-buffer)))
;    (read-only-mode)))

;(add-hook 'find-file-hook 'eb-find-file-readonly)

;; etags of el.gz files
(require 'jka-compr)
(defun create-tags (dir-name filetype)
  "Create tags file."
  (interactive "DDirectory: \nsFiletype: ")
  (or filetype (setq filetype "ch"))
  (shell-command 
   (format "find %s -type f -name \"*.%s\" | etags -" dir-name filetype)))


;; Tautles - My extensions
(load "tautles")
(load "tautles-skeletons")
(global-set-key (kbd "C-*") 'isearch-yank-symbol)

(global-set-key (kbd "<f1>") 'magit-status)
(global-set-key (kbd "<f2>") 'ffap)
;; f3, f4 macros
(global-set-key (kbd "<f3>") 'describe-variable)
(global-set-key (kbd "<f4>") 'describe-function)
(global-set-key (kbd "<f5>") 'helm-buffers-list)
(global-set-key (kbd "<f6>") 'helm-M-x)
(global-set-key (kbd "<f7>") 'helm-swoop)
(global-set-key (kbd "<f8>") 'helm-locate)
(global-set-key (kbd "<f9>") 'helm-semantic-or-imenu)
(global-set-key (kbd "<f10>") 'desktop-dir)
(global-set-key (kbd "<f11>") 'hb)
(global-set-key (kbd "<f12>") 'undo)
(global-set-key (kbd "C-;") 'ace-jump-word-mode)
(global-set-key (kbd "C-M-<backspace>") 'backward-kill-sexp)
(global-set-key (kbd "<home>") 'previous-buffer)
(global-set-key (kbd "<end>") 'next-buffer)

;; Minibuffer-fu
(defun stop-using-minibuffer ()
  "kill the minibuffer"
  (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
    (abort-recursive-edit)))

(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)

(require 'filenotify)
(defun alert-git-locks ()
  "Show me alert when index.lock is created"
  (interactive)
  (file-notify-add-watch
   "/home/ebby/code/myscypho/.git/index.lock"
   '(attribute-change)
   (lambda (event)
     (pos-tip-show (format "git lock: %s" event)))))


;; we don't need the mouse pointer
(require 'disable-mouse)
(global-disable-mouse-mode)


;; very important keybindings get used to them
;; to avoid RSI injuries to right hand twists

(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph) ; need this?
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-j") 'other-window)
(global-set-key (kbd "C-M-h") 'backward-kill-sexp)
(global-set-key (kbd "C-M-y") 'mark-defun)

;;; Start paredit with lisp mode
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)

(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

;; Redefine company keymaps
(progn
  (define-key company-active-map (kbd "C-h") 'backward-delete-char)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

;; Redefine lisp keymap
(require 'paredit)
(progn
  (define-key lisp-mode-map (kbd "C-j") 'other-window)
  (define-key paredit-mode-map (kbd "C-j") 'other-window)
  (define-key lisp-interaction-mode-map (kbd "C-j") 'other-window))

;; Dired (stolen by bookmark+)
(define-key dired-mode-map (kbd "C-j") 'other-window)

;; helm.el steals these keys
(require 'helm)
(define-key helm-map (kbd "C-h") 'backward-delete-char)

(progn
  (define-key isearch-mode-map (kbd "C-?") isearch-help-map)
  (define-key isearch-mode-map (char-to-string help-char) 'isearch-delete-char))
p
(require 'flymake-shell)
(add-hook 'sh-set-shell-hook 'flymake-shell-load)
;(add-hook 'after-init-hook 'global-flycheck-mode)  ; makes python slow
(add-hook 'inferior-python-mode-hook 'python-shell-completion-native-turn-off)

;; Etags

(defun create-tags (dir-name)
     "Create tags file."
     (interactive "DDirectory: ")
     (eshell-command 
      (format "find %s -type f -name \"*.el\" | etags -" dir-name)))

(setq tags-table-list
      '("/home/ebby/"))

(defun find-tag-no-prompt ()
  "Jump to the tag at point without prompting"
  (interactive)
  (find-tag (find-tag-default)))
;; don't prompt when finding a tag
(global-set-key (kbd "M-.") 'find-tag-no-prompt)


;; Enable git gutter
(setq git-gutter-mode 1)

(require 'edit-server)

;;; org
(setq org-agenda-files '("/home/ebby/org/"))


;; slack
;(add-to-list 'load-path "~/.emacs.d/lisp/emacs-slack/")

;;; tramp Why is it so fucking slow?
;; (add-to-list 'backup-directory-alist
;;              (cons tramp-file-name-regexp nil))
;; (setq tramp-backup-directory-alist backup-directory-alist)
;; (add-to-list 'backup-directory-alist
;;              (cons "." "~/.emacs.d/backups/"))
;; (setq tramp-verbose 6)
;; (setq vc-ignore-dir-regexp
;;       (format "\\(%s\\)\\|\\(%s\\)"
;;               vc-ignore-dir-regexp
;;               tramp-file-name-regexp))

;; (setq tramp-completion-reread-directory-timeout 'nil)
;; (setq projectile-mode-line "Projectile")
;; (message "%s" tramp-remote-path)


(add-to-list 'load-path "/home/ebby/code/tramp/lisp")

;;; .emacs ends here
