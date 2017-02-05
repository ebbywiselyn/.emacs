;;; simple-popup.el --- Summary
;;; Commentary:
;;; Code:

(require 'magit-popup)

(defun magit-eat ()
  (interactive)
  (message "eating!"))

(defun magit-throw ()
  (interactive)
  (message "throwing!!"))

(defun magit-bury ()
  (interactive)
  (message "burying!!"))

(magit-define-popup magit-fruits-popup
  "some doc."
  :man-page "git-tag-foo"
  :switches '((?a "Apple" "--apple")
	      (?b "Ball" "--ball")
	      (?c "Cat" "--cat"))
  :actions '((?t "Eat" magit-eat)
	     (?w "Throw" magit-throw)
	     (?y "Bury" magit-bury))
  :default-action 'magit-eat)

(magit-fruits-popup)

