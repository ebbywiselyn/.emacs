(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-install 'js-comint)
(require 'js-comint)
