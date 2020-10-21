;; Initialize the load path
(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "~/.emacs.d/lisp")
; stop creating ~ files
(setq make-backup-files nil)
(setq auto-save-default nil)
; disable startupscreen
(setq inhibit-startup-screen t)
;; lisp autocomplete, disable this for company-mode instead
(add-hook 'lisp-mode-hook 'company-mode)
(add-hook 'lisp-mode-hook 'flycheck-mode)
(add-hook 'lisp-mode-hook 'show-paren-mode)
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
 '(dired-no-confirm (quote (copy)))
 '(dired-recursive-copies (quote always))
 '(elpy-project-ignored-directories
   (quote
    (".eggs" ".bzr" "CVS" ".git" ".hg" ".svn" ".tox" "build" "dist" ".cask")))
 '(elpy-rpc-python-command "python")
 '(erc-log-insert-log-on-open t)
 '(flycheck-display-errors-delay 0.3)
 '(global-flycheck-mode t)
 '(helm-buffer-max-length 32)
 '(magit-save-repository-buffers nil)
 '(package-selected-packages
   (quote
    (k8s-mode jenkinsfile-mode todoist aws-ec2 magit kubernetes-tramp kubernetes-helm whitespace-cleanup-mode company-terraform terraform-mode go-mode scala-mode wgrep-helm virtualenvwrapper vagrant use-package tramp-theme tramp-term tox toggle-quotes timonier ssh-config-mode smartparens skeletor realgud python-pytest py-autopep8 puppet-mode protobuf-mode pip-requirements password-store paredit-menu paredit-everywhere org-jira markdown-mode+ kubernetes keyfreq key-chord js2-refactor jinja2-mode itail importmagic imenu+ icicles highlight-parentheses helm-systemd helm-swoop helm-spotify helm-pydoc helm-projectile helm-make helm-ls-git helm-jira helm-git-grep helm-git helm-aws helm-anything helm-ag groovy-mode gradle-mode git-gutter flymake-shell flycheck-pyflakes evil elpy el-get editorconfig edit-server drag-stuff dockerfile-mode docker-compose-mode docker disable-mouse dired-toggle-sudo dired-k dired+ desktop+ cython-mode cql-mode company-quickhelp company-jedi bookmark+ bash-completion aws-snippets autopair auto-complete-rst ace-jump-mode)))
 '(safe-local-variable-values
   (quote
    ((python-shell-extra-pythonpaths "/home/ejeyapaul/code/bdstalker/")
     (python-shell-extra-pythonpaths "/home/ejeyapaul/code/pulsar/")
     (python-shell-extra-pythonpaths "/home/ejeyapaul/code/python-bddatachannelsdk/")
     (python-shell-extra-pythonpaths "/home/ejeyapaul/code/glutton/")
     (python-shell-extra-pythonpaths "/home/ejeyapaul/code/python-refinery/")
     (pyvenv-workon "python-refinery")))))



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

;; Custom Faces and Settings



;;;

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


(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; Dired Settings
(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding to current buffer." t)
(autoload 'dired-jump-other-window "dired-x"
  "Like \\[dired-jump] (dired-jump) but in other window." t)
(define-key global-map "\C-x\C-j" 'dired-jump)
(define-key global-map "\C-x\C-j" 'dired-jump-other-window)
;; dired omit mode
(add-hook 'dired-load-hook '(lambda () (require 'dired-x)))
(setq dired-omit-mode t)

;; Enables highlight-parentheses-mode on all buffers:
;;(define-globalized-minor-mode global-highlight-parentheses-mode
;;  highlight-parentheses-mode
;;  (lambda ()
;;    (highlight-parentheses-mode t)))
;;(global-highlight-parentheses-mode t)


;;Bookmarks+
;(require 'bookmark+)

;; Docker
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; Python/Elpy
(require 'package)
(add-to-list 'package-archives
	     '("elpy" . "https://jorgenschaefer.github.io/packages/"))

(elpy-enable)
(setq elpy-rpc-backend "jedi")
(setq jedi:complete-on-dot t)
(add-to-list 'company-backends 'company-jedi)
(add-hook 'python-mode-hook 'elpy-mode)
(require 'whitespace-cleanup-mode)
(add-hook 'python-mode-hook 'whitespace-cleanup-mode)

;; this is to override whatever python-mode-does to c-right
;; find a way to override this in the mode
(global-set-key (kbd "C->") 'paredit-forward-slurp-sexp)

;(require 'ws-butler)
;(add-hook 'python-mode-hook 'ws-butler-mode)
;; documentation popups, for jedin
(company-quickhelp-mode 1)

;; Emacs Kafka
;(add-to-list 'load-path "~/elisp/emacs-kafka")
;(require 'kafka-cli)


;; coverage
;(load-file "/home/ebby/code/pycoverage.el-master/pycoverage.el")
;(require 'linum)
;(require 'pycoverage)

;; Company Mode (global)
;(add-hook 'after-init-hook 'global-company-mode)

;; Markdown
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
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


(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(use-package dired-x)

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.jinja\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
  '(lambda ()
     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; fiplr / subsitute with helm-projectile
(global-set-key (kbd "C-x C-y"
) 'helm-projectile)


;;(setq fiplr-ignored-globs '((directories (".git" ".svn" "build" "node_modules" "env" "venv"))
;;(files ("*.jpg" "*.png" "*.zip" "*~" "*.log" "*.pyc"))))

;; js2mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jinja\\'" . jinja2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(require 'js2-refactor)
(add-hook 'js2-mode-hook 'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")

;; handlebar mode
(add-to-list 'auto-mode-alist '("\\.hbs\\'". handlebars-mode))
;(setq auto-mode-alist (rassq-delete-all 'handlebars-mode auto-mode-alist))


;; disabling this because of frequent git locks?
;; dired-k
;; (require 'dired-k)
;(define-key dired-mode-map (kbd "K") 'dired-k)
;; You can use dired-k alternative to revert-buffer
;(define-key dired-mode-map (kbd "g") 'dired-k)
;; always execute dired-k when dired buffer is opened
;(add-hook 'dired-initial-position-hook 'dired-k)
					;(add-hook 'dired-after-readin-hook #'dired-k-no-revert)


;; Evil
;(add-to-list 'load-path "~/.emacs.d/lisp/evil")
(require 'evil)
(global-set-key (kbd "C-*") 'evil-search-symbol-forward)
(global-set-key (kbd "C-#") 'evil-search-symbol-backward)
(global-set-key (kbd "C-z") 'find-grep)
(global-set-key (kbd "M-C-z") 'find-grep-dired)


;; Always enable editor config
(require 'editorconfig)
(editorconfig-mode 1)

;; Do we need this ? 10Jan2007 after finding it interfering with tramp/shell
;;(autoload 'bash-completion-dynamic-complete
;;  "bash-completion"
;;  "BASH completion hook")
;; (add-hook 'shell-dynamic-complete-functions 'bash-completion-dynamic-complete)

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
(global-set-key (kbd "C-m") 'newline-and-indent)
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
(require 'dired-k)
(define-key dired-mode-map (kbd "C-j") 'other-window)

;; helm.el steals these keys
(require 'helm)
(define-key helm-map (kbd "C-h") 'backward-delete-char)

(progn
  (define-key isearch-mode-map (kbd "C-?") isearch-help-map)
  (define-key isearch-mode-map (char-to-string help-char) 'isearch-delete-char))

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
      '("/home/ebby/" "/home/ebby/code/librdkafka/"))

(defun find-tag-no-prompt ()
  "Jump to the tag at point without prompting"
  (interactive)
  (find-tag (find-tag-default)))
;; don't prompt when finding a tag


;; Enable git gutter
(setq git-gutter-mode 1)

;;; org
;(setq org-agenda-files '("/home/ebby/org/"))


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
(require 'tramp)





;(add-to-list 'load-path "/home/ebby/code/tramp/lisp")


;; Tautles - My extensions
;(load "tautles")
;(load "tautles-skeletons")
(load "myalias")
(global-set-key (kbd "C-*") 'isearch-yank-symbol)

(global-set-key (kbd "<f1>") 'magit-status)
(global-set-key (kbd "<f2>") 'helm-semantic-or-imenu)
;; f3, f4 macros
;(global-set-key (kbd "<f3>") 'describe-variable)
(global-set-key (kbd "<f3>") 'ffap-other-window)
(global-set-key (kbd "<f4>") 'describe-function)
(global-set-key (kbd "<f5>") 'helm-buffers-list)
(global-set-key (kbd "<f6>") 'helm-M-x)
(global-set-key (kbd "<f7>") 'helm-swoop)
(global-set-key (kbd "<f8>") 'helm-git-grep-at-point)
(global-set-key (kbd "<f9>") 'helm-multi-swoop-all)
(global-set-key (kbd "<f10>") 'helm-mark-ring)
(global-set-key (kbd "<f11>") 'hb)
(global-set-key (kbd "<f12>") 'undo)
(global-set-key (kbd "C-;") 'ace-jump-word-mode)
(global-set-key (kbd "<home>") 'previous-buffer)
(global-set-key (kbd "<end>") 'next-buffer)



;; might hamper with space/tab / jinja files

(setq-default whitespace-style ' (face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark newline-mark))

(add-hook 'before-save-hook 'wc)
;; (remove-hook 'before-save-hook 'wc)

(put 'upcase-region 'disabled nil)

(setq x-select-enable-clipboard t)
(setq x-select-enable-primary t)


;; Unicode output for shell mode
(add-hook 'term-exec-hook
	  (function
	   (lambda ()
	     (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))

(display-time-mode 1)

;; this is experimental
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))
(add-to-list 'auto-mode-alist '("\\syslog\\'" . auto-revert-mode))


;; Improve this script to tail based on input response of glutton
(defun tail-glutton0 ()
  (interactive)
  (itail "/ssh:ubuntu@10.65.143.59:/var/log/syslog"))

(defun tail-syslog ()
  (interactive)
  (beginning-of-line)
  (re-search-forward "10.")  ; Take point to ip address
  (let ((ip (thing-at-point 'filename)))
    (itail (format "/ssh:ubuntu@%s:/var/log/syslog" ip))))

(defun aws-shell ()
  (interactive)
  (beginning-of-line)
  (re-search-forward "10.6")  ; Take point to ip address
  (let (
	(default-directory (format "/ssh:ubuntu@%s:" (thing-at-point 'filename)))
	)
    (shell default-directory)))


;; required for bash / docker
(set-terminal-coding-system 'utf-8)

(require 'bash-completion)

(setq helm-boring-buffer-regexp-list
	'("\\` " "\\*helm" "\\*helm-mode" "\\*magit" "\\*grep" "\\*Echo Area" "\\*tramp" "\\*Minibuf" "\\*epc"))


(bind-key "M-*" 'pop-tag-mark)

;; Ignores all annoying dired folders in helm buffers list
(defun my-filter-dired-buffers (buffer-list)
  (delq nil (mapcar
	     (lambda (buffer)
	       (if (eq (with-current-buffer buffer major-mode)  'dired-mode)
		   nil
		 buffer))
	     buffer-list)))

(advice-add 'helm-skip-boring-buffers :filter-return 'my-filter-dired-buffers)

;; Forbidden to access JIRA talk to infra
;; (setq jiralib-url "https://jira.ihs.demonware.net")
;;  (setq request-message-level 'debug)
;;  (setq request-log-level 'debug)

;(require 'org-jira)

(require 'pyvenv)

;; https://elpy.readthedocs.io/en/latest/customization_tips.html
(defun elpy-goto-definition-or-rgrep ()
  "Go to the definition of the symbol at point, if found. Otherwise, run `elpy-rgrep-symbol'."
  (interactive)
  (ring-insert find-tag-marker-ring (point-marker))
  (condition-case nil (elpy-goto-definition)
    (error (elpy-rgrep-symbol
	    (concat "\\(def\\|class\\)\s" (thing-at-point 'symbol) "(")))))

(define-key elpy-mode-map (kbd "M-.") 'elpy-goto-definition-or-rgrep)


(setq echo-keystrokes 0.01)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Untested to hide emacs buffers
;; TODO hide dired as well
(defun hide-buffer (buffer)
;; Enable this for debug
;;    (message "Emacs visiting: %s" (symbol-name (buffer-local-value 'major-mode buffer)))
    (if (or
	 (string-match "Shell" (symbol-name (buffer-local-value 'major-mode buffer)))
	 (string-match "Jinja2" (symbol-name (buffer-local-value 'major-mode buffer)))
	 (string-match "Java" (symbol-name (buffer-local-value 'major-mode buffer)))
	 (string-match "Terraform" (symbol-name (buffer-local-value 'major-mode buffer)))
	 (string-match "Scala" (symbol-name (buffer-local-value 'major-mode buffer)))
	 (string-match "sh-mode" (symbol-name (buffer-local-value 'major-mode buffer)))
	 (string-match "yaml" (symbol-name (buffer-local-value 'major-mode buffer)))
	 (string-match "python-mode" (symbol-name (buffer-local-value 'major-mode buffer)))
	 (string-match "c-mode" (symbol-name (buffer-local-value 'major-mode buffer)))
	 (string-match "markdown" (symbol-name (buffer-local-value 'major-mode buffer)))
	 (string-match "makefile" (symbol-name (buffer-local-value 'major-mode buffer)))
	 (string-match "lisp" (symbol-name (buffer-local-value 'major-mode buffer)))
	 (string-match "Docker" (symbol-name (buffer-local-value 'major-mode buffer)))
	 )
	t
      nil)
  )
(set-frame-parameter nil 'buffer-predicate 'hide-buffer)


(type-of (buffer-local-value 'major-mode (current-buffer)))

(eval-after-load "tramp"
  '(progn
     (defvar sudo-tramp-prefix
       "/sudo::"
       (concat "Prefix to be used by sudo commands when building tramp path "))

     (defun sudo-file-name (filename) (concat sudo-tramp-prefix filename))

     (defun sudo-find-file (filename &optional wildcards)
       "Calls find-file with filename with sudo-tramp-prefix prepended"
       (interactive "fFind file with sudo ")
       (let ((sudo-name (sudo-file-name filename)))
	 (apply 'find-file
		(cons sudo-name (if (boundp 'wildcards) '(wildcards))))))

     (defun sudo-reopen-file ()
       "Reopen file as root by prefixing its name with sudo-tramp-prefix and by clearing buffer-read-only"
       (interactive)
       (let*
	   ((file-name (expand-file-name buffer-file-name))
	    (sudo-name (sudo-file-name file-name)))
	 (progn
	   (setq buffer-file-name sudo-name)
	   (rename-buffer sudo-name)
	   (setq buffer-read-only nil)
	   (message (concat "Set file name to " sudo-name)))))

     (global-set-key "\C-x+" 'sudo-find-file)
     (global-set-key "\C-x!" 'sudo-reopen-file)))


(defadvice text-scale-increase (around all-buffers (arg) activate)
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
	ad-do-it)))



(setq company-minimum-prefix-length 1)
