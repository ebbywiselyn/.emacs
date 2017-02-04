;;; tautles-mode --- Summary
;;; Commentary:
;;; Code:

(setq tautles-highlights '(("Sin\\|Cos\\|Sum\\|Tan" . font-lock-function-name-face)
			   ("Pi\\|Infinity" . font-lock-constant-face)))

(define-derived-mode tautles-mode fundamental-mode "tautles"
  "major mode for editing tautles language code"
  (setq font-lock-defaults '(tautles-highlights)))

(tautles-mode)
;;Sin(x) = Cos(y) = Tan(z)
;;Sum(z) = Pi * Infinity

(tautles-mode)

;;; tautles-mode ends here
