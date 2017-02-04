;;; skeleton-helpers --- Summary
;;; Commentary:
;;; Code:

(defvar *skeleton-markers* nil
  "Markers for locations saved in skeleton-positions.")

(add-hook 'skeleton-end-hook 'skeleton-make-markers)

(defun skeleton-make-markers ()
  (while *skeleton-markers*
    (set-marker (pop *skeleton-markers*) nil))
  (setq *skeleton-markers*
	(mapcar 'copy-marker (reverse skeleton-positions))))

(defun skeleton-next-position (&optional reverse)
    "Jump to next position in skeleton, REVERSE - Jump to previous position in skeleton."
    (interactive "P")
    (let* ((positions (mapcar 'marker-position *skeleton-markers*))
           (positions (if reverse (reverse positions) positions))
           (comp (if reverse '> '<))
           pos)
      (when positions
        (if (catch 'break
              (while (setq pos (pop positions))
                (when (funcall comp (point) pos)
                  (throw 'break t))))
            (goto-char pos)
          (goto-char (marker-position
                      (car *skeleton-markers*)))))))

;;; skeleton-helpers ends here
