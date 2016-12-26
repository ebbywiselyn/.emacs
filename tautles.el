;;;###autoload
(defun show-buffer-header ()
  (interactive)
  (beginning-of-buffer-other-window (split-window-right)))

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


