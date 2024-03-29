;; packages.el
(require 'cl)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(defvar required-packages
  '(
    ag
    avy
    base16-theme
    buffer-move
    clojure-mode
    dockerfile-mode
    dtrt-indent
    dumb-jump
    elfeed
    expand-region
    forge
    git-messenger
    go-mode
    groovy-mode
    haml-mode
    handlebars-mode
    helm-projectile
    helm-swoop
    helm
    hlinum
    ido-completing-read+
    indent-guide
    indium
    jade-mode
    js2-mode
    json-mode
    key-chord
    less-css-mode
    magit
    multi-term
    multi-web-mode
    multiple-cursors
    nyan-mode
    neotree
    projectile
    recentf
    rjsx-mode
    tabbar
    web-mode
    xref-js2
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
