;; Initialiae the load path
(add-to-list 'load-path "~/.emacs.d/lisp")
; stop creating ~ files
(setq make-backup-files nil)
(setq auto-save-default nil)
; disable startupscreen
(setq inhibit-startup-screen t)
;; lisp autocomplete, disable this for company-mode instead
(add-hook 'lisp-mode-hook 'company-mode)
;; Initialise all packages
(package-initialize)

;; Themes
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(safe-local-variable-values
   (quote
    ((python-shell-virtualenv-path . "/home/ebby/code/node-admin/django/env/")
     (python-shell-interpreter-args . "/home/ebby/code/node-admin/django/admin-root/manage.py shell")
     (python-shell-interpreter . "/home/ebby/code/node-admin/django/env/bin/python")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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

;; Python/Elpy
(elpy-enable)
(setq elpy-rpc-backend "jedi")  
(setq jedi:complete-on-dot t)
(add-to-list 'company-backends 'company-jedi)
(add-hook 'python-mode-hook 'elpy-mode)
(require 'ws-butler)
(add-hook 'python-mode-hook 'ws-butler-mode)
;; documentation popups, for jedi
(company-quickhelp-mode 1)

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
(use-package markdown-mode
   :ensure t
   :commands (markdown-mode gfm-mode)
   :mode (("README\\.md\\'" . gfm-mode)
          ("\\.md\\'" . markdown-mode)
          ("\\.markdown\\'" . markdown-mode))
   :init (setq markdown-command "multimarkdown"))

;; Scala/Ensime
(add-hook 'scala-mode-hook 'ensime-mode)
(require 'ensime)

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
  '(lambda ()
     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; fiplr
(global-set-key (kbd "C-x C-y") 'fiplr-find-file)
(setq fiplr-ignored-globs '((directories (".git" ".svn" "build" "node_modules" "env" "venv"))
                            (files ("*.jpg" "*.png" "*.zip" "*~" "*.log" "*.pyc"))))

;; js2mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(require 'js2-refactor)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")

;; dired-k
(require 'dired-k)
(define-key dired-mode-map (kbd "K") 'dired-k)
;; You can use dired-k alternative to revert-buffer
(define-key dired-mode-map (kbd "g") 'dired-k)
;; always execute dired-k when dired buffer is opened
(add-hook 'dired-initial-position-hook 'dired-k)
(add-hook 'dired-after-readin-hook #'dired-k-no-revert)

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

(autoload 'bash-completion-dynamic-complete
  "bash-completion"
  "BASH completion hook")
(add-hook 'shell-dynamic-complete-functions
	  'bash-completion-dynamic-complete)

;; Key Chord
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "jj" 'other-window)

;; Neo Tree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

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

;; macros start myscypho
(fset 'myscypho-runserver
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 98j 42 115 104 101 108 108 42 return 99 100 32 47 104 111 109 101 47 101 98 98 121 47 99 111 100 101 47 109 121 115 99 121 112 104 111 47 109 121 115 99 121 112 104 111 47 return 115 111 117 114 99 101 32 46 47 101 110 118 47 98 105 110 47 97 99 116 105 118 97 116 101 return 32 backspace 46 32 46 46 47 101 110 118 46 115 104 return 46 47 109 97 110 97 103 101 46 112 121 32 114 117 110 115 101 114 118 101 114 return] 0 "%d")) arg)))

;; Helm
(global-set-key (kbd "M-x") 'helm-M-x)
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
(load-file "/home/ebby/.emacs.d/lisp/tautles.el")
(global-set-key (kbd "C-*") 'isearch-yank-symbol)
(global-set-key (kbd "<f10>") 'desktop-dir)
(global-set-key (kbd "<f1>") 'magit-status)
(global-set-key (kbd "<f2>") 'ffap)
(global-set-key (kbd "<f5>") 'helm-buffers-list)


;; Minibuffer-fu
(defun stop-using-minibuffer ()
  "kill the minibuffer"
  (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
    (abort-recursive-edit)))

(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)


;; Always, always have a shell
(defun start-shell ()
  "Start shell process"
  ;; todo try to customize the shell(dir, venv)
  ;; based on the desktop
  (shell))
(add-hook 'desktop-after-read-hook 'start-shell)
