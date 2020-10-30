(setq package-archives
      '(("org" . "https://orgmode.org/elpa/")
        ("melpa" . "http://melpa.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")))

(eval-when-compile (require 'cl))

(defun make-relative-path (filename)
  (concat base filename))

(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path (make-relative-path "use-package"))
  (require 'use-package))

(require 'package)
(package-initialize)
(package-refresh-contents)
(setq use-package-always-ensure t)

 (setq custom-safe-themes t)
(load-file (make-relative-path "functions.el"))
(load-file (make-relative-path "misc.el"))

(require 'use-package)
(setq use-package-verbose t)
(setq use-package-always-unsure t)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package ack)
(use-package adoc-mode)
(use-package ag)
(use-package auto-highlight-symbol)
(use-package autorevert
  :config
  (setq auto-revert-interval 1)
  (global-auto-revert-mode))

(use-package beacon
  :ensure t
  :custom
  (beacon-blink-duration 0.5))

(use-package browse-kill-ring)

(use-package cider
  :ensure t
  :defer t
  :init (add-hook 'cider-mode-hook #'clj-refactor-mode)
  :diminish subword-mode
  :bind (("C-<f5>" . cider-test-run-test))
  :config
  (setq cider-font-lock-dynamically '(macro core function var)
        nrepl-hide-special-buffers t

        cider-overlays-use-font-lock t)
  (cider-repl-toggle-pretty-printing))

(use-package clj-refactor)
(use-package cljr-helm)
(use-package clojure-mode
  :ensure t
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.edn\\'" . clojure-mode))
  :init
  (add-hook 'clojure-mode-hook #'subword-mode))

(use-package clojure-mode-extra-font-locking)

(use-package company
  :init (global-company-mode)
  :ensure t
  :custom
  (company-tooltip-align-annotations t)
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.3)
  (company-show-numbers t))

(use-package company-dict)
(use-package company-restclient)
(use-package company-shell)
(use-package csv-mode)
(use-package diff-hl
  :config (global-diff-hl-mode))

(use-package docker)
(use-package dockerfile-mode)
(use-package dracula-theme)
(use-package edit-server)
(use-package eldoc
  :diminish eldoc-mode
  :config (add-hook 'prog-mode-hook 'eldoc-mode))

(use-package elein)
(use-package emmet-mode)
(use-package expand-region)
(use-package eshell
  :bind (("<f8>" . eshell)))

(use-package fancy-narrow)
(use-package find-file-in-repository)
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package flycheck-clj-kondo)
(use-package flycheck-clojure)
(use-package flycheck-pos-tip)
(use-package flyspell
  :diminish flyspell-mode
  :config
  (add-hook 'text-mode-hook 'flyspell-mode)
  (add-hook 'prog-mode-hook 'flyspell-prog-mode))

(use-package gist)
(use-package git-commit)
(use-package gitconfig)
(use-package helm)
(use-package helm-ag)
(use-package helm-cider)
(use-package helm-clojuredocs)
(use-package helm-company)
(use-package helm-flycheck)
(use-package helm-flyspell)
(use-package helm-google)
(use-package helm-make)
(use-package helm-imenu
  :bind (("<f5>" . helm-imenu)))

(use-package helm-projectile
  :bind (( "<f7>" . helm-projectile-find-file)))

(use-package helm-swoop)
(use-package idle-highlight-mode
  :diminish idle-highlight-mode
  :config (add-hook 'prog-mode-hook 'idle-highlight-mode))

(use-package inf-clojure)
(use-package json-mode)
(use-package know-your-http-well)
(use-package kotlin-mode)
(use-package less-css-mode)
(use-package log4j-mode)
(use-package lsp-mode
  :commands lsp
  :init
  (add-hook 'rust-mode-hook #'lsp))

(use-package lsp-ui
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package rust-mode
  :config
  (setq rust-format-on-save t)
  (add-hook 'rust-mode-hook #'company-mode))

(use-package flycheck-rust
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package company-lsp
  :commands company-lsp)

(use-package cargo
  :hook
  (rust-mode . cargo-minor-mode))

(use-package magit
  :bind (("\C-xg" . magit-status)))

(use-package markdown-mode)
(use-package multiple-cursors
  :bind ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this))

(use-package nix-mode)
(use-package org-bullets)
(use-package paradox)
(use-package persistent-scratch)
(use-package powerline
  :custom
  (powerline-arrow-shape 'curve)
  (powerline-default-separator-dir '(right . left)))

(use-package projectile
  :diminish projectile
  :ensure t
  :config
  (projectile-global-mode)
  (bind-keys :map projectile-mode-map
             ("s-d" . projectile-find-dir)
             ("s-p" . projectile-switch-project)
             ("s-f" . projectile-find-file)
             ("s-a" . projectile-ag))
  :bind (("<f9>" . projectile-command-map)))

(use-package rainbow-delimiters
  :ensure t
  :delight
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package rainbow-mode
  :ensure t
  :delight
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode))

(use-package restclient)
(use-package smart-mode-line
  :custom
  (sml/theme 'powerline)
  :init (sml/setup))

(use-package smart-mode-line-powerline-theme)
(use-package smartparens
  :ensure t
  :delight
  :config
  (require 'smartparens-config)
  :init (smartparens-global-strict-mode)
  :bind
  (("C-M-f" . sp-forward-sexp)
   ("C-M-b" . sp-backward-sexp)
   ("C-M-d" . sp-down-sexp)
   ("C-M-a" . sp-backward-down-sexp)
   ("C-M-e" . sp-up-sexp)
   ("C-M-u" . sp-backward-up-sexp)
   ("C-M-t" . sp-transpose-sexp)
   ("C-M-n" . sp-next-sexp)
   ("C-M-p" . sp-previous-sexp)
   ("C-M-k" . sp-kill-sexp)
   ("C-M-w" . sp-copy-sexp)
   ("C-<right>" . sp-forward-slurp-sexp)
   ("C-<left>" . sp-forward-barf-sexp)
   ("C-]" . sp-select-next-thing-exchange)
   ("C-<left_bracket>" . sp-select-previous-thing)
   ("C-M-]" . sp-select-next-thing)
   ("M-F" . sp-forward-symbol)
   ("M-B" . sp-backward-symbol)))

(use-package time
  :custom
  (display-time-24hr-format t)
  (display-time-default-load-average nil)
  (display-time-mode))

(use-package toml-mode)
(use-package undo-tree
  :diminish "U"
  :init (global-undo-tree-mode))

(use-package web-mode)
(use-package which-key)
(use-package wordnut)
(use-package yaml-mode)

;; (use-package yasnippet-snippets
;;   :ensure t)

(use-package yasnippet
  :ensure t
  :custom
  (yas-verbosity 2)
  (yas-wrap-around-region t)

  :config
  (yas-reload-all)
  (yas-global-mode))

(setq dired-auto-revert-buffer 1)
(setq dired-isearch-filenames 'dwim)
(setq dired-listing-switches "-al")

(use-package time
  :init (display-time-mode))

(use-package linum
  :init (global-linum-mode))

(use-package paren
  :init (show-paren-mode))

(use-package which-func
  :init (which-function-mode))

(use-package which-key
  :init (which-key-mode))

(use-package windmove
  :init (windmove-default-keybindings 'shift))

;; TODO: reconfigure these two??
(global-prettify-symbols-mode t)
(transient-mark-mode t)

(use-package helm
  :bind (("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)
	 ("M-s o" . helm-occur)
	 ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-mini)
         ("C-x r b" . helm-filtered-bookmarks)
         ([f10] . helm-buffers-list)
         ([S-f10] . helm-recentf))
  :custom
  (helm-buffers-fuzzy-matching t)
  (helm-recentf-fuzzy-match t)
  (helm-locate-fuzzy-match t)
  (helm-use-frame-when-more-than-two-windows nil)
  (helm-M-x-fuzzy-match t)
  (helm-autoresize-mode t)
  (helm-mode t))

(use-package nrepl-client
  :custom
  (nrepl-log-messages t))

(use-package cider-repl
  :custom
  (cider-prompt-for-symbol nil)
  (cider-repl-display-help-banner nil)
  (cider-repl-pop-to-buffer-on-connect 'display-only)
  (cider-repl-display-in-current-window nil)
  (cider-repl-use-clojure-font-lock t)
  (cider-repl-use-pretty-printing t)
  (cider-repl-prompt-function 'cider-repl-prompt-abbreviated)
  (cider-repl-tab-command #'indent-for-tab-command)
  (cider-repl-buffer-size-limit 100000)
  (cider-repl-require-ns-on-set nil))

(use-package cider-test
  :custom
  (cider-auto-test-mode t))

(use-package dumb-jump
  :ensure t
  :bind (("M-?" . dumb-jump-go)))

(use-package ibuffer
  :bind (("C-x C-b" . ibuffer)))

(use-package ibuffer-vc
  :ensure t
  :defer t
  :init (add-hook 'ibuffer-hook
                  (lambda ()
                    (ibuffer-vc-set-filter-groups-by-vc-root)
                    (unless (eq ibuffer-sorting-mode 'alphabetic)
                      (ibuffer-do-sort-by-alphabetic)))))

(use-package winner
  :config (winner-mode t))

(global-set-key (kbd "M-p") 'ca-prev-defun)
(global-set-key (kbd "M-n") 'ca-next-defun)

(defalias 'bb 'bury-buffer)
(defalias 'dml 'delete-matching-lines)
(defalias 'eb 'eval-buffer)
(defalias 'elm 'emacs-lisp-mode)
(defalias 'er 'eval-region)
(defalias 'go 'google-search-it)
(defalias 'gs 'google-search-selection)
(defalias 'll 'load-library)
(defalias 'qrs 'query-replace-regexp)
(defalias 'qs 'query-replace)
(defalias 'rs 'replace-string)
(defalias 'yes-or-no-p 'y-or-n-p)

(defalias 'ys 'yas/reload-all)
(defalias 'yv 'yas/visit-snippet-file)

(defalias 'rb 'revert-buffer)

(defalias 'sh 'shell)

(defalias 'ws 'whitespace-mode)
(defalias 'bu 'browse-url)

(when (file-exists-p (make-relative-path "custom.el"))
  (message "loading custom file")
  (load-file (make-relative-path "custom.el")))

(load-file "~/Emacs-Configuration/custom.el")
