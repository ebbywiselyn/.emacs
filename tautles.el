;;; package -- Summary
;;; Commentary:

;;; Code:
;;;###autoload
(defun ffap-delete ()
  "Delete file at point."
  (interactive)
  (progn
    (ffap-copy-string-as-kill)
    (let ((f (current-kill 0)))
      (if (yes-or-no-p (format "Really delete? %s" f))
	  (delete-file (current-kill 0))
	(message "just copied to kill ring")))))

;;;###autoload
(defun show-buffer-header ()
  "Show the contents of the buffers header."
  (interactive)
  ;; Rewrite this with pos-tip-show()
  (beginning-of-buffer-other-window (split-window-right)))

;;;###autoload
(defun show-buffer-head-postip (line-num)
  "Show the buffer head postip at (LINE-NUM) ."
  (interactive "p")
  (let ((start)
	(end))
    (save-excursion
      (goto-char (point-min))
      (setq start (line-beginning-position))
      (line-move (or line-num 5))
      (setq end (line-end-position)))
    (pos-tip-show (buffer-substring start end))))

;;;###autoload
(defun isearch-yank-symbol ()
  "Copy symbol at point."
  (interactive)
  (let ((sym (symbol-at-point)))
    (if sym
	(progn
	  (setq isearch-string (concat "" (symbol-name sym) "")
		isearch-message (mapconcat 'isearch-text-char-description isearch-string "")))
	  (ding)))
  (isearch-search-and-update)
  (isearch-edit-string))

(defvar current-desktop-name)

;;;###autoload
(defun get-desktop-name ()
  "Return the name of the current desktop."
  (interactive)
  (message (format "Desktop: %s" current-desktop-name)))


(defun start-shell (switch)
  "Start shell process, switch to shell if SWITCH is non nil."
  (if switch
      (shell)
    (let ((buffer (current-buffer)))
      (shell)
      (switch-to-buffer buffer))))

;;;###autoload
(defadvice shell
    (after shell-after ())
  "Switch to the current directory of the desktop."
  (shell-cd-desktop))

;;;###autoload
(defun desktop-dir (dir-name)
  "TODO see if you can use def-advice (advising functions instead) load the current desktop (DIR-NAME)."
  (interactive
   (list
    (read-directory-name "Change To Directory: " "/home/ebby/.emacs.d/desktop/")))
  (progn
    (desktop-change-dir dir-name)
    (cond ((string-match "nodeadmin" dir-name)
	   (progn
	     (pyvenv-activate "/home/ebby/code/node-admin/django/env/")
	     (setq current-desktop-name 'nodeadmin)
	     (message "starting node-admin")
	     ))
	   ((string-match "myscypho" dir-name)
	    (progn
	      (pyvenv-activate "/home/ebby/code/myscypho/myscypho/env/")
	      (setq current-desktop-name 'myscypho)
	      (message "starting myscypho")
	      ))
	   ((string-match "interview" dir-name)
	    (progn
	      (pyvenv-activate "/home/ebby/code/interview-occupancy-service/env/")
	      (setq current-desktop-name 'interview)
	      (message "starting interview")
	      ))
	   ((string-match "monitoring" dir-name)
	    (progn
	      (pyvenv-activate "/home/ebby/code/web-monitoring/env/")
	      (setq current-desktop-name 'monitoring)
	      (message "starting interview")
	      ))
	   ((string-match "nodeserver" dir-name)
	    (progn
	      (setq current-desktop-name 'nodeserver)
	      (message "starting nodeserver")
	      )))
    (start-shell 1)))

(defun start-all-processes ()
  "Start all the initial processes."
  (progn
    (start-shell 'nil)
    (run-zookeeper 'nil)
    (run-at-time "10 sec" 'nil 'run-kafkabroker 'nil) ; we dont want to fail because of zk locks
    (run-kafkaconsumer 'nil)))

(defun lazy-load-after-init ()
  "Run after a delay."
  (run-at-time "10 sec" 'nil 'start-all-processes))

(add-hook 'after-init-hook 'lazy-load-after-init)
(defun str-cmd (path venv-path)
  "Get command as string, PATH is the command path and VENV-PATH is the virtual env path."
  (format "cd %s; source %s" path venv-path))

;;;###autoload
(defun shell-cd-desktop ()
  "Change directory to current desktop."
  (let* ((nodeadmin-path "~/code/node-admin/")
	 (nodeserver-path "~/code/node-server/")
	 (nodeadmin-venv-path "~/code/node-admin/django/env/bin/activate")
	 (myscypho-path "~/code/myscypho/")
	 (myscypho-venv-path "~/code/myscypho/myscypho/env/bin/activate")
	 (monitoring-path "~/code/web-monitoring/")
	 (monitoring-venv-path "~/code/web-monitoring/env/bin/activate"))
    (and (boundp 'current-desktop-name)
	 (cond ((eq current-desktop-name 'nodeadmin)
		(progn
		  (comint-simple-send
		   (get-buffer-process "*shell*") (str-cmd nodeadmin-path nodeadmin-venv-path))
		  (setq default-directory nodeadmin-path )))
	       ((eq current-desktop-name 'myscypho)
		(progn
		  (comint-simple-send
		   (get-buffer-process "*shell*") (str-cmd myscypho-path myscypho-venv-path))
		  (setq default-directory "~/code/myscypho/")))
	       ((eq current-desktop-name 'monitoring)
		(progn
		  (comint-simple-send
		   (get-buffer-process "*shell*") (str-cmd monitoring-path monitoring-venv-path))
		  (setq default-directory "~/code/web-monitoring/")))
	       ((eq current-desktop-name 'nodeserver)
		(progn
		  (comint-simple-send
		   (get-buffer-process "*shell*") "cd ~/code/node-server/")
		  (setq default-directory "~/code/node-server/")))))))


;; (defun test-shell-cd-desktop ()
;;   "Test function for cd-desktop, ; switch *shell* to nodeadmin and activates virtualenv."
;;   (let ((current-desktop-name 'myscypho))
;;     (progn
;;       (shell-cd-desktop))))

;;;###autoload
(defadvice elpy-nav-forward-block
    (before foo-bar ())
  "Enable code navigation forward from any point."
  (beginning-of-line))

;;;###autoload
(defadvice elpy-nav-backward-block
    (before foo-bar ())
  "Enable code navigation backward from any point."
  (beginning-of-line))

;;;###autoload
(ad-activate 'elpy-nav-forward-block)
;;;###autoload
(ad-activate 'elpy-nav-backward-block)
;;;###autoload
(ad-activate 'shell)

;; ;;;###autoload
;; (defvar zookeeper-cli-file-path "/home/ebby/apps/kafka/kafka-0.10/bin/zookeeper-server-start.sh"
;;   "Path to the program used by `run-zookeeper'.")

;; ;;;###autoload
;; (defvar zookeeper-cli-arguments "/home/ebby/apps/kafka/kafka-0.10/config/zookeeper.properties"
;;   "Command line arguments to `zookeeper-server-start.sh'.")

;;;###autoload
;; (defun run-zookeeper (switch)
;;   "Run Zookeeper switch to buffer if SWITCH is non 'nil."
;;   (interactive "i")
;;   (let* ((zookeeper-buffer-name "*zookeeper*")
;;	 (zookeeper-buffer (get-buffer-create zookeeper-buffer-name)))
;;     (if (comint-check-proc zookeeper-buffer)
;;	(and switch (switch-to-buffer zookeeper-buffer-name))
;;       (progn
;;	(apply 'make-comint-in-buffer "*zookeeper*"
;;	       zookeeper-buffer zookeeper-cli-file-path
;;	       'nil (list zookeeper-cli-arguments))
;;	(and switch (switch-to-buffer zookeeper-buffer)))
;;       )))

;;;###autoload
;; (defvar kafka-broker-cli-file-path "/home/ebby/apps/kafka/kafka-0.10/bin/kafka-server-start.sh"
;;   "Path to the program used by `run-kafka'.")

;;;###autoload
;; (defvar kafka-broker-cli-arguments "/home/ebby/apps/kafka/kafka-0.10/config/server.properties"
;;   "Command line arguments to `kafka-server-start.sh'.")

;;;###autoload
;; (defun run-kafkabroker(switch)
;;   "Run Kafka Broker"
;;   (interactive "i")
;;   (let* ((kafka-broker-buffer-name "*kafka*")
;;	 (kafka-broker-buffer (get-buffer-create kafka-broker-buffer-name)))
;;     (if (comint-check-proc kafka-broker-buffer)
;;	(and switch (switch-to-buffer kafka-broker-buffer))
;;       (progn
;;	(apply
;;	 'make-comint-in-buffer "*kafka*" kafka-broker-buffer
;;	 kafka-broker-cli-file-path 'nil (list kafka-broker-cli-arguments))
;;	(and switch (switch-to-buffer kafka-broker-buffer))))))

;;;###autoload
;; (defvar kafka-consumer-cli-file-path "/home/ebby/apps/kafka/kafka-0.10/bin/kafka-console-consumer.sh"
;;   "Path to the program used by `run-kafka'.")

;;;###autoload
;; (defvar kafka-consumer-cli-arguments '("--whitelist" "event.json.*" "--bootstrap-server" "localhost:9092")
;;   "Command line arguments to `kafka-console-consumer.sh'.")

;;;###autoload
(defun run-monitoring-ember (switch)
  "Run Monitoring Ember, SWITCH if non-nil."
  (interactive "i")
  (let* ((monitoring-ember-buffer-name "*monitoring-ember*")
	 (monitoring-ember-buffer (get-buffer-create monitoring-ember-buffer-name))
	 (monitoring-ember-cli-file-path "ember")
	 (monitoring-ember-cli-args '("serve")))
    (if (comint-check-proc monitoring-ember-buffer)
	(and switch (switch-to-buffer monitoring-ember-buffer))
      (progn
	(cd "~/code/web-monitoring/frontend/")
	(apply
	 'make-comint-in-buffer monitoring-ember-buffer-name monitoring-ember-buffer
	 monitoring-ember-cli-file-path 'nil monitoring-ember-cli-args)))))

;;;###autoload
(defun run-monitoring-server (switch)
  "Run Monitoring Ember only works in monitoring desktop environment, SWITCH if non-nil."
  (interactive "i")
  (let* ((monitoring-server-buffer-name "*monitoring-server*")
	 (monitoring-server-buffer (get-buffer-create monitoring-server-buffer-name))
	 (monitoring-server-cli-file-path "~/code/web-monitoring/manage.py")
	 (monitoring-server-cli-args '("runserver")))
    (if (comint-check-proc monitoring-server-buffer)
	(and switch (switch-to-buffer monitoring-server-buffer))
      (progn
	(if (equal current-desktop-name "monitoring")
	    (apply
	     'make-comint-in-buffer monitoring-server-buffer-name monitoring-server-buffer
	     monitoring-server-cli-file-path 'nil monitoring-server-cli-args)
	  (message "run-monitoring-server only works with monitoring desktop, running %s" current-desktop-name))))))


;;;###autoload
;; (defun run-kafkaconsumer(switch)
;;   "Run Kafka Consumer"
;;   (interactive "i")
;;   (let* ((kafka-consumer-buffer-name "*consumer*")
;;	 (kafka-consumer-buffer (get-buffer-create kafka-consumer-buffer-name)))
;;     (if (comint-check-proc kafka-consumer-buffer)
;;	(and switch (switch-to-buffer kafka-consumer-buffer))
;;       (progn
;;	(apply
;;	 'make-comint-in-buffer "*consumer*" kafka-consumer-buffer
;;	 kafka-consumer-cli-file-path 'nil kafka-consumer-cli-arguments)
;;	(and switch (switch-to-buffer kafka-consumer-buffer))
;;	))))

;; (defvar comint-mode-map)
;; (defvar kafka-mode-map
;;   (let ((map (nconc (make-sparse-keymap) comint-mode-map)))
;;     ;; example definition
;;     (define-key map "\t" 'completion-at-point)
;;     map)
;;   "Basic mode map for `run-cassandra'.")


;; (defvar kafka-prompt-regexp "^\\(?:\\[[^@]+@[^@]+\\]\\)"
;;   "Prompt for `run-kafka'.")


(defadvice save-buffers-kill-emacs
    (before save-logs (arg) activate)
  (save-some-buffers t (lambda () (when (eq major-mode 'erc-mode) t))))


(defun print-all-symbols ()
  "."
  (interactive)
  (defun print-syms (sym)
    (message "symbol: %s" sym))
  (mapatoms 'print-syms))


(provide 'tautles)

;;; tautles.el ends here
