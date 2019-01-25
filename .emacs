;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(xterm-mouse-mode 1)
(dumb-jump-mode)

(load "~/.emacs.d/packages.el")
(load "~/.emacs.d/tabbar-tweak.el")

(setq interprogram-cut-function
      (lambda (text &optional push)
    (let* ((process-connection-type nil)
           (pbproxy (start-process "pbcopy" "pbcopy" "/usr/bin/pbcopy")))
      (process-send-string pbproxy text)
      (process-send-eof pbproxy))))

;; https://emacsredux.com/blog/2013/04/28/execute-commands-ninja-style-with-key-chord-mode/
;; key chords
(require 'key-chord)
(key-chord-mode +1)

(require 'expand-region)
(key-chord-define-global "EE" 'er/expand-region)
(key-chord-define-global "CC" 'er/contract-region)

(require 'indium)
;; need to remap C-c b keys https://github.com/NicolasPetton/Indium/blob/128b160d6568ceecba493bf6ca7f928c2024355f/indium-interaction.el#L356-L364
(define-key indium-interaction-mode-map (kbd "C-c b") 'windmove-left)
(define-key indium-interaction-mode-map (kbd "C-c f") 'windmove-right)
(define-key indium-interaction-mode-map (kbd "C-c p") 'windmove-up)
(define-key indium-interaction-mode-map (kbd "C-c n") 'windmove-down)

(require 'neotree)
(global-set-key (kbd "<f8>") 'neotree-toggle)

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

(require 'indent-guide)
(indent-guide-global-mode)

(require 'buffer-move)
(global-set-key (kbd "<C-S-up>") 'buf-move-up)
(global-set-key (kbd "<C-S-down>") 'buf-move-down)
(global-set-key (kbd "<C-S-left>") 'buf-move-left)
(global-set-key (kbd "<C-S-right>") 'buf-move-right)

(require 'multiple-cursors)
(global-set-key (kbd "C-c C-c") 'mc/edit-lines)
(global-set-key (kbd "C-c C-n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-x <mouse-1>") 'mc/add-cursor-on-click)

;; require find file at point.  require prefix of C-u
(require 'ffap)
(ffap-bindings)
(setq ffap-require-prefix t)

(require 'helm-swoop)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
(define-key helm-swoop-map (kbd "M-n")
  (lambda () (interactive) (helm-next-line 5)))
(define-key helm-swoop-map (kbd "M-p")
  (lambda () (interactive) (helm-previous-line 5)))

;; C-s in a buffer: open helm-swoop with empty search field
(global-set-key (kbd "C-s") 'helm-swoop)
(with-eval-after-load 'helm-swoop
    (setq helm-swoop-pre-input-function
        (lambda () nil)))

(require 'helm-config)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(key-chord-define-global "BM" 'helm-bookmarks)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(key-chord-define-global "FF" 'helm-find-files)
(key-chord-define-global "AG" 'helm-do-ag)

(with-eval-after-load 'helm
  (define-key helm-map (kbd "C-c p") 'ignore)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ;; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ;; make TAB works in terminal
  (define-key helm-map (kbd "C-z") 'helm-select-action)
  (define-key helm-map (kbd "C-k") 'helm-buffer-run-kill-buffers) ;; helm-kill-marked-buffers
  (define-key helm-map (kbd "M-n")
    (lambda () (interactive) (helm-next-line 5)))
  (define-key helm-map (kbd "M-p")
    (lambda () (interactive) (helm-previous-line 5))))

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
(add-to-list 'auto-mode-alist '("www" . rjsx-mode))

(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'indent-tabs-mode)
            (setq indent-tabs-mode nil)))

;; https://emacs.cafe/emacs/javascript/setup/2017/05/09/emacs-setup-javascript-2.html
(require 'company)
(require 'company-tern)

(add-hook 'after-init-hook 'global-company-mode)

(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook
          (lambda ()
            (tern-mode)
            (company-mode)))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;; Disable completion keybindings, as we use xref-js2 instead
(define-key tern-mode-keymap (kbd "M-.") nil)
(define-key tern-mode-keymap (kbd "M-,") nil)

;; https://emacs.cafe/emacs/javascript/setup/2017/04/23/emacs-setup-javascript.html
(require 'js2-refactor)
(require 'xref-js2)

(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-r")
(define-key js2-mode-map (kbd "C-k") #'js2r-kill)
(define-key js2-mode-map (kbd "C-c C-a") 'mc/mark-all-like-this)

;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
;; unbind it.
(define-key js-mode-map (kbd "M-.") nil)

(add-hook 'js2-mode-hook
          (lambda ()
            (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

;; https://emacs.stackexchange.com/questions/46568/update-point-using-mouse/46569#46569
(global-set-key (kbd "<S-mouse-1>")
                (lambda (event)
                  (interactive (list last-command-event))
                  (posn-set-point (event-end event))
                  (xref-find-definitions (thing-at-point 'word))))

(key-chord-define-global "FR" 'xref-find-references)
(key-chord-define-global "FD" 'xref-find-definitions)
(key-chord-define-global "FB" 'xref-pop-marker-stack)

(setq js2-basic-offset 4)

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
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; highlight current linenumber
(require 'hlinum)
(hlinum-activate)

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

;; https://emacsredux.com/blog/2013/04/28/switch-to-previous-buffer/
(defun er-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; https://emacsredux.com/blog/2013/04/28/execute-commands-ninja-style-with-key-chord-mode/
;; key chords
(key-chord-define-global "JJ" #'er-switch-to-previous-buffer)

;; add indent-region binding to C-c i
(global-set-key (kbd "C-c i") 'indent-region)

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
    (groovy-mode neotree multi-web-mode multi-term json-mode js2-mode ido-ubiquitous hlinum elixir-mode clojure-mode)))
 '(tabbar-separator (quote (0.5)))
 '(xref-js2-ignored-dirs (quote ("bower_components" "node_modules" "build"))))
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
