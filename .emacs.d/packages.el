;; packages.el
(require 'cl)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(defvar required-packages
  '(
    base16-theme
    clojure-mode
    dtrt-indent
    go-mode
    groovy-mode
    haml-mode
    hlinum
    ido-completing-read+
    jade-mode
    js2-mode
    json-mode
    multi-term
    multi-web-mode
    neotree
    recentf
    rjsx-mode
    smex
    yaml-mode
    ) "a list of packages to ensure are installed at launch")

;; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
;; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
            (package-install p))))
