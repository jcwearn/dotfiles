;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(xterm-mouse-mode 1)
(dumb-jump-mode)

(load "~/.emacs.d/packages.el")

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)


;; require find file at point.  require prefix of C-u
(require 'ffap)
(ffap-bindings)
(setq ffap-require-prefix t)

;; adds line numbers and extra space in between text and line numbers
(global-linum-mode 1)
(setq linum-format "%d ")

;; enable electric pair mode; this mode autocompletes (), [], '', "", etc.
(electric-pair-mode 1)

;; enable column-number-mode
(column-number-mode 1)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq sh-use-smie nil)
(setq sh-basic-offset 4)
(setq sh-indentation 4)
(setq require-final-newline nil)

(require 'dtrt-indent)
(dtrt-indent-mode t)

;; https://stackoverflow.com/questions/4177929/how-to-change-the-indentation-width-in-emacs-javascript-mode
;; set indent width for js files
(setq js-indent-level 4)
(setq js-switch-indent-offset 4)

;; load wombat as color theme
(load-theme 'wombat t)

;; enable js2-mode on all files of type js
;; http://ergoemacs.org/emacs/emacs_auto-activate_a_major-mode.html
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-to-list 'auto-mode-alist '("www" . js2-mode))

(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'indent-tabs-mode)
            (setq indent-tabs-mode nil)))

(add-to-list 'auto-mode-alist '("\\.hbs\\'" . handlebars-mode))
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))

;; enable groovy-mode on Jenkinsfile
(add-to-list 'auto-mode-alist '("Jenkinsfile" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))
(setq groovy-indent-offset 4)

;; enable dockerfile-mode on Dockerfile
(add-to-list 'auto-mode-alist '("Dockerfile" . dockerfile-mode))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

(setq js2-highlight-level 3)

(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags
      '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
        (js2-mode  "<script[^>]*>" "</script>")
        (css-mode "<style[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)

(add-to-list 'auto-mode-alist '("\\.haml\\'" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; enable clojure-mode on all files of type .clj
(add-to-list 'auto-mode-alist '("\\.clj\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs\\'" . clojure-mode))

;; enable elixir-mode on all files of type .ex, .exs, .elixir
(add-to-list 'auto-mode-alist '("\\.ex\\'" . elixir-mode))
(add-to-list 'auto-mode-alist '("\\.exs\\'" . elixir-mode))
(add-to-list 'auto-mode-alist '("\\.elixir\\'" . elixir-mode))

;; open recent files with C-x C-r
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;
(setq js2-basic-offset 4)

;; highlight current linenumber
(add-to-list 'load-path "~/.emacs.d/src/hlinum-mode")
(require 'hlinum)
(hlinum-activate)

;; set ctl ha as backspace and back kill ring
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-h") 'delete-backward-char)

;; enable meta key + movement keys to move windows
(global-set-key (kbd "C-c b") 'windmove-left)
(global-set-key (kbd "C-c f") 'windmove-right)
(global-set-key (kbd "C-c p") 'windmove-up)
(global-set-key (kbd "C-c n") 'windmove-down)

(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)

;; Enable 5 line movement with Meta keys
(global-set-key (kbd "M-n")
                (lambda () (interactive) (next-line 5)))
(global-set-key (kbd "M-p")
                (lambda () (interactive) (previous-line 5)))

;; add indent-region binding to C-c i
(global-set-key (kbd "C-c i") 'indent-region)

;;; Smex
(autoload 'smex "smex"
  "Smex is a M-x enhancement for Emacs, it provides a convenient interface to
your recently and most frequently used commands.")

(global-set-key (kbd "M-x") 'smex)

;; bind comment-region to C-x /
(global-set-key (kbd "C-x /") 'comment-region)

;; bind uncomment-region to C-c /
(global-set-key (kbd "C-c /") 'uncomment-region)

;; removes trailing white space when saving a file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; require multi-term and set zsh as program to run
(require 'multi-term)
(setq multi-term-program "/usr/local/bin/zsh")
;; bind multi-term to C-x t
(global-set-key (kbd "C-x t") 'multi-term)

(ido-mode 1)
(ido-everywhere 1)

(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (groovy-mode smex neotree multi-web-mode multi-term json-mode js2-mode ido-ubiquitous hlinum elixir-mode clojure-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'gofmt-before-save)
            (setq tab-width 4)
            (setq indent-tabs-mode nil)))
