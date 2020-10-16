(defun make-conf-path (path)
  "Shortcut to create the path of the configuration"
  (expand-file-name (concat base path)))

(setq custom-file (make-conf-path "custom.el"))
(when (file-exists-p custom-file)
  (message "loading custom file")
  (load-file custom-file))

(setq package-archives
      '(("melpa-stable" . "http://stable.melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("melpa" . "http://melpa.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")))

(require 'use-package)

(use-package ack)
(use-package adoc-mode)
(use-package ag)
(use-package auto-highlight-symbol)
(use-package browse-kill-ring)
(use-package c-eldoc)
(use-package cider)
(use-package cider-decompile)
(use-package cider-eval-sexp-fu)
(use-package clj-refactor)
(use-package cljr-helm)
(use-package cljsbuild-mode)
(use-package clojure-mode)
(use-package clojure-mode-extra-font-locking)
(use-package color-moccur)
(use-package company)
(use-package company-dict)
(use-package company-go)
(use-package company-jedi)
(use-package company-restclient)
(use-package company-shell)
(use-package company-web)
(use-package csv-mode)
(use-package docker)
(use-package dockerfile-mode)
(use-package dracula-theme)
(use-package edit-server)
(use-package elein)
(use-package emamux)
(use-package emmet-mode)
(use-package expand-region)
(use-package fancy-narrow)
(use-package feature-mode)
(use-package find-file-in-repository)
(use-package flycheck)
(use-package flycheck-clj-kondo)
(use-package flycheck-clojure)
(use-package flycheck-pos-tip)
(use-package gist)
(use-package git-annex)
(use-package git-commit)
(use-package gitconfig)
(use-package go-mode)
(use-package golint)
(use-package graphviz-dot-mode)
(use-package groovy-mode)
(use-package haskell-mode)
(use-package helm)
(use-package helm-ag)
(use-package helm-aws)
(use-package helm-cider)
(use-package helm-clojuredocs)
(use-package helm-company)
(use-package helm-dired-history)
(use-package helm-dired-recent-dirs)
(use-package helm-flycheck)
(use-package helm-flyspell)
(use-package helm-git)
(use-package helm-git-files)
(use-package helm-google)
(use-package helm-make)
(use-package helm-projectile)
(use-package helm-swoop)
(use-package indent-guide)
(use-package inf-clojure)
(use-package jedi)
(use-package json-mode)
(use-package know-your-http-well)
(use-package ledger-mode)
(use-package less-css-mode)
(use-package log4j-mode)
(use-package magit)
(use-package markdown-mode)
(use-package minimap)
(use-package multiple-cursors)
(use-package nginx-mode)
(use-package nix-mode)
(use-package ob-diagrams)
(use-package ob-http)
(use-package ob-sql-mode)
(use-package org-bullets)
(use-package org-gcal)
(use-package outline-magic)
(use-package ox-reveal)
(use-package paradox)
(use-package persistent-scratch)
(use-package powerline)
(use-package rainbow-delimiters)
(use-package rainbow-mode)
(use-package restclient)
(use-package smart-mode-line)
(use-package smart-mode-line-powerline-theme)
(use-package smartparens)
(use-package sos)
(use-package sx)
(use-package toml-mode)
(use-package typo)
(use-package undo-tree)
(use-package web-mode)
(use-package which-key)
(use-package wordnut)
(use-package yafolding)
(use-package yaml-mode)
(use-package yasnippet)
(use-package yasnippet-snippets)

(use-package helm
  :bind (("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)
         ("M-<f5>" . helm-find-files)
         ([f10] . helm-buffers-list)
         ([S-f10] . helm-recentf))
  :config
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-recentf-fuzzy-match t)
  (setq helm-locate-fuzzy-match t)
  (setq helm-use-frame-when-more-than-two-windows nil)
  (setq helm-M-x-fuzzy-match t)
  (setq helm-autoresize-mode t))
