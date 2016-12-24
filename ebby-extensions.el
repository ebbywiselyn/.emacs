(defun example (arg)
  (interactive "p")
  (message "hello world, %s, %s" arg "hello"))
(setq one 1)
(message "hello %s" one)

(defun print-value-at-point (arg buffer)
  (interactive "p\nbVisiting Buffer: ")
  (message "In dir: %d, %s" arg buffer))

(defun print-dir (dir)
  (interactive "D") ;; takes a directory as an argument, so prompts using a dir prompt
  (message "In dir: %s" dir))

(defun print-file (file)
  (interactive "f")
  (message "Visiting file: %s" file))

(defun print-num (num)
  (interactive "n")
  (message "You typed: %d" num))

(defun copy-to-buffer (buffer)
  (generate-new-buffer buffer) ;; get-buffer-create?
  (setq copy (defun copy (arg)
	       (set-buffer buffer)
	       (insert arg)
	       (insert "\n")))
nn  copy)

(defun dired-copy-marked-to-buffer (buffer)
  "Copy marked files to some buffer"
  (interactive "B")
  (require 'dired)
  (setq copy-fn (copy-to-buffer buffer))
  (mapc copy-fn (dired-get-marked-files)))

(defun wlog ()
  (interactive)
  (find-file "/home/ebby/wlogs/"))


(defun append-to-buffer (buffer start end)
  (interactive
   (list (read-buffer "Some Name: "
		      (other-buffer (current-buffer) t))
	 (region-beginning)
	 (region-end)))
  (let ((oldbuf (current-buffer)))
    (save-excursion
      (let* ((append-to (get-buffer-create buffer))
	     (windows (get-buffer-window-list append-to t t))
	     point)
	(set-buffer append-to)
	(setq point (point))
	(barf-if-buffer-read-only)
	(insert-buffer-substring oldbuf start end)
	(dolist (window windows)
	  (when (= (window-point window) point)
	    (set-window-point window (point))))))))


(defun simplified-end-of-buffer (buffer)
  (interactive "b")
    (set-buffer buffer)
    (goto-char (point-max)))

(defun exercise-fn (&optional arg)
  "5.5 optional argument exercise"
  (interactive "P")
  (let ((num (if
		 (not (consp arg))
		 (prefix-numeric-value arg)
	       56)))
    (if
	(>= num fill-column)
	(message "%d greater than or equalto " num)
      (message "%d not greater" num))))

	       (count-lines 1 (point))))))

(defun first-60-chars ()
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (message "60chars: %s" (buffer-substring (point-min) 60))
      )))

(message "What I read was %s" (read-string "what is your name"))
(message "This is wht you typed :%s" (this-command-keys))
(y-or-n-p "hello?")


(defun show-buffer-header ()
  (interactive "p")
  (beginning-of-buffer-other-window (split-window-right)))

(show-buffer-header)






		
 

