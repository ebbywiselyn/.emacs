;;;###autoload
(defun ffap-delete ()
  "Delete file at point"
  (interactive)
  (progn
    (ffap-copy-string-as-kill)
    (let ((f (current-kill 0)))
      (if (yes-or-no-p (format "Really delete? %s" f))
	  (delete-file (current-kill 0))
	(message "just copied to kill ring")))))

;;;###autoload
(defun show-buffer-header ()
  (interactive)
  ;; Rewrite this with pos-tip-show()
  (beginning-of-buffer-other-window (split-window-right)))

;;;###autoload
(defun show-buffer-head-postip (line-num)
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
  (interactive)
  (let ((sym (symbol-at-point)))
    (if sym
	(progn
	  (setq isearch-string (concat "" (symbol-name sym) "")
		isearch-message (mapconcat 'isearch-text-char-description isearch-string "")))
	  (ding)))
  (isearch-search-and-update)
  (isearch-edit-string))

;;;###autoload
(defun get-desktop-name ()
  (interactive)
  (message (format "Desktop: %s" current-desktop-name)))

;;;###autoload
(defun desktop-dir (dir-name)
  ;; TODO see if you can use def-advice (advising functions instead)
  (interactive
   (list
    (read-directory-name "Change To Directory: " "/home/ebby/.emacs.d/desktop/")))
  (message "dir:%s" dir-name)
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
	   )
    (start-shell)))



(defun start-all-processes ()
  (progn
    (start-shell)
    (run-zookeeper)
    (run-at-time "5 sec" 'nil 'run-kafkabroker) ; we dont want to fail because of zk locks
    (run-kafkaconsumer)))

(defun lazy-load-after-init ()
  (run-at-time "10 sec" 'nil 'start-all-processes))

(add-hook 'after-init-hook 'lazy-load-after-init)
;; fix me this messes up the autocomplete(default is always home till a cd)
(defun shell-cd-desktop ()
  (if (boundp 'current-desktop-name)
      (cond ((eq current-desktop-name 'nodeadmin)
	     (progn
	       (comint-simple-send (get-buffer-process "*shell*") "cd ~/code/node-admin/")
	       (setq default-directory "~/code/node-admin/")))
	    ((eq current-desktop-name 'myscypho)
	     (comint-simple-send (get-buffer-process "*shell*") "cd ~/code/myscypho/"))
	    ((eq current-desktop-name 'monitoring)
	     (comint-simple-send (get-buffer-process "*shell*") "cd ~/code/web-monitoring/"))
	    ((eq current-desktop-name 'nodeserver)
	     (comint-simple-send (get-buffer-process "*shell*") "cd ~/code/node-server/"))
	    )
    '()
    ))

;;;###autoload
(defadvice shell
    (after shell-after ())
  "This switches to the current directory of the desktop"
  (shell-cd-desktop))


;;;###autoload
(defadvice elpy-nav-forward-block
    (before foo-bar ())
  "This enables code navigation forward from any point"
  (beginning-of-line))

;;;###autoload
(defadvice elpy-nav-backward-block
    (before foo-bar ())
  "This enables code navigation backward from any point"
  (beginning-of-line))

;;;###autoload
(ad-activate 'elpy-nav-forward-block)
;;;###autoload
(ad-activate 'elpy-nav-backward-block)
;;;###autoload
(ad-activate 'shell)


;;;###autoload
(defvar zookeeper-cli-file-path "/home/ebby/apps/kafka/kafka-0.10/bin/zookeeper-server-start.sh"
  "Path to the program used by `run-zookeeper'")

;;;###autoload
(defvar zookeeper-cli-arguments "/home/ebby/apps/kafka/kafka-0.10/config/zookeeper.properties"
  "command line arguments to `zookeeper-server-start.sh'")

;;;###autoload
(defun run-zookeeper ()
  "Run Zookeeper"
  (interactive)
  (let* ((zookeeper-buffer-name "*zookeeper*")
	 (zookeeper-buffer (get-buffer-create zookeeper-buffer-name)))
    (if (comint-check-proc zookeeper-buffer)
	(switch-to-buffer zookeeper-buffer-name)
      (progn
	(apply 'make-comint-in-buffer "*zookeeper*"
	       zookeeper-buffer zookeeper-cli-file-path
	       'nil (list zookeeper-cli-arguments))
	(switch-to-buffer zookeeper-buffer))
      )))

;;;###autoload
(defvar kafka-broker-cli-file-path "/home/ebby/apps/kafka/kafka-0.10/bin/kafka-server-start.sh"
  "path to the program used by `run-kafka'")

;;;###autoload
(defvar kafka-broker-cli-arguments "/home/ebby/apps/kafka/kafka-0.10/config/server.properties"
  "command line arguments to `kafka-server-start.sh'")

;;;###autoload
(defun run-kafkabroker()
  "Run Kafka Broker"
  (interactive)
  (let* ((kafka-broker-buffer-name "*kafka*")
	 (kafka-broker-buffer (get-buffer-create kafka-broker-buffer-name)))
    (if (comint-check-proc kafka-broker-buffer)
	(switch-to-buffer kafka-broker-buffer)
      (progn
	(apply
	 'make-comint-in-buffer "*kafka*" kafka-broker-buffer
	 kafka-broker-cli-file-path 'nil (list kafka-broker-cli-arguments))
	(switch-to-buffer kafka-broker-buffer)))))

;;;###autoload
(defvar kafka-consumer-cli-file-path "/home/ebby/apps/kafka/kafka-0.10/bin/kafka-console-consumer.sh"
  "path to the program used by `run-kafka'")

;;;###autoload
(defvar kafka-consumer-cli-arguments '("--whitelist" "event.json.*" "--bootstrap-server" "localhost:9092")
  "command line arguments to `kafka-console-consumer.sh'")

;;;###autoload
(defun run-kafkaconsumer()
  "Run Kafka Consumer"
  (interactive)
  (let* ((kafka-consumer-buffer-name "*consumer*")
	 (kafka-consumer-buffer (get-buffer-create kafka-consumer-buffer-name)))
    (if (comint-check-proc kafka-consumer-buffer)
	(switch-to-buffer kafka-consumer-buffer)
      (progn
	(apply
	 'make-comint-in-buffer "*consumer*" kafka-consumer-buffer
	 kafka-consumer-cli-file-path 'nil kafka-consumer-cli-arguments)
	(switch-to-buffer kafka-consumer-buffer)
	))))

;;;###autoload
(defvar kafka-mode-map
  (let ((map (nconc (make-sparse-keymap) comint-mode-map)))
    ;; example definition
    (define-key map "\t" 'completion-at-point)
    map)
  "Basic mode map for `run-cassandra'")

;;;###autoload
(defvar kafka-prompt-regexp "^\\(?:\\[[^@]+@[^@]+\\]\\)"
  "Prompt for `run-kafka'.")
