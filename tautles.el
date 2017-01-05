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
	   )))



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
