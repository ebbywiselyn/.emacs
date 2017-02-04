;;; tautles-skeletons.el --- Summary
;;; Commentary:
;;; Code:
(define-skeleton elisp-comment-package-start-skeleton
  "Generate comments for a package name"
  'nil
  ";;; " (buffer-name (current-buffer)) " --- Summary\n;;; Commentary:\n;;; Code:")

(define-skeleton elisp-comment-package-end-skeleton
  "Generate comments that mark the end of a package"
  'nil
  ";;; " (buffer-name (current-buffer)) " ends here")


;; needs more work, global skeleton defined
(defun elisp-skeleton-defun ()
  (interactive)
  (progn
    (setq comments "")
    (defun my-append (element)
       (progn
	 (setq comments (concat comments element " "))
	 element))
    (define-skeleton elisp-skeleton-defun1
      "Generate defun skeleon"
      "Name of function: "
      > "(defun " str " ("
      ((my-append (skeleton-read "Params:")) str " ")
      -1
      ")" \n
      > "\"Generated Doc: " (upcase comments) -1 "\"" \n
      >  "(" _ ")" \n > ")"))
  (elisp-skeleton-defun1))

;;; tautles-skeletons.el ends here
