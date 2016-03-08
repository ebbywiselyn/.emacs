;;;###autoload
(defun greet-user ()
  "Salutes and greets user"
  (message "Welcome %s, I salute you" user-login-name))

(defun greet-host ()
  "Salutes and greets user"
  (message "A toast to you %s" user-login-name))
