(require 'ca-customs)
(require 'ca-utils)
(require 'yasnippet)

(setq yas/root-directory
      (list (make-conf-path "yasnippet-snippets/")))

;; Maybe needed to set to fixed for some modes
(setq
 yas/indent-line 'auto
 yas/ignore-filenames-as-triggers nil)

(yas/initialize)

(message "loading all the snippets")
(mapc 'yas/load-directory yas/root-directory)

;; simple function to create a .yas-parents
(defun ca-make-yas-parents-file (path)
  (interactive "DPath: ")
  (find-file (concat path ".yas-parents"))
  (insert "text-mode"))

(defun ca-find-matching-snippet (filename)
  (assoc-if
   (lambda (x) (string-match x filename))
   ca-auto-header-conses))

(defun ca-insert-at-startup (snippet)
  "try to expand a snippet at startup"
  (if
      (yes-or-no-p (format "expand snippet %s?" snippet))
      (progn
        (insert snippet)
        ;; add checking
        (yas/expand))))

(add-hook 'find-file-hook 'ca-insert-header)

(provide 'ca-yas)
