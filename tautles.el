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
