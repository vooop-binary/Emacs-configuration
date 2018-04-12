(require 'calendar)
(require 'ca-customs)

(defun ca-gen-path-dirs (base-dir)
  "Add to load path all the subdirectories of first level"
  (interactive)
  (message "adding all directories in the first level to the load-path")
  (dolist (dir (directory-files base-dir t))
    (if (and
         (file-directory-p dir)
         (not (file-symlink-p dir)))
        (add-to-list 'load-path dir))))

(defun ca-insdate-insert-any-date (date)
  "Insert DATE using the current locale."
  (interactive (list (calendar-read-date)))
  (insert (calendar-date-string date)))

(defun ca-insdate-insert-date-from (&optional days)
  "Insert date that is DAYS from current."
  (interactive "p*")
  (insert
   (calendar-date-string
    (calendar-gregorian-from-absolute
     (+ (calendar-absolute-from-gregorian (calendar-current-date))
        days)))))

; next step is to remove conf completely
(defun ca-reload-dirs ()
  "Add all the first-level directories to the path"
  (interactive)
  (ca-gen-path-dirs base))

(defun ca-reload-conf ()
  "Reload the current configuration"
  (interactive)
  (require 'ca-init))

; TODO: maybe better as a macro

(defun ca-manipulate-matched-text (fn)
  "Apply a function on the matched text"
  (let
      ((matched-text (buffer-substring (match-beginning 0) (match-end 0))))
    (funcall fn matched-text)))

(defun ca-newline-force()
  "Goes to newline leaving untouched the rest of the line"
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun ca-newline-force-close()
  "Same as ca-newline-force but putting a closing char at end unless it's already present"
  (interactive)
  (let ((closing-way (assoc major-mode ca-newline-force-close-alist))
        closing-char)
    ;; Setting the user defined or the constant if not found
    (if (not closing-way)
        (progn
          (message "closing char not defined for this mode, using default")
          (setq closing-char ca-default-closing-char))
      (setq closing-char (cdr closing-way)))
    (when (not (bobp))
      ;; if we're at beginning of buffer, the backward-char will beep
      ;; :( This works even in the case of narrowing (e.g. we don't
      ;; look outside of the narrowed area.
      (if (not (looking-at (format ".*%s.*" closing-char)))
          (progn
            (end-of-line)
            (insert closing-char))
        (message "%s already present" closing-char))
      (ca-newline-force))))

(defun ca-err-switch()
  "switch on/off error debugging"
  (interactive)
  (if debug-on-error
      (setq debug-on-error nil)
    (setq debug-on-error t))
  (message "debug-on-error now %s" debug-on-error))

(defun ca-rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun ca-move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR."
  (interactive "DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn
        (copy-file filename newname 1)
        (delete-file filename)
        (set-visited-file-name newname)
        (set-buffer-modified-p nil) t))))

(defun ca-delete-current-file ()
  "Delete the file associated with the current buffer."
  (interactive)
  (let (currentFile)
    (setq currentFile (buffer-file-name))
    (when (yes-or-no-p (format "Delete file % s and kill buffer? " currentFile))
      (kill-buffer (current-buffer))
      (delete-file currentFile)
      (message "Deleted file: %s " currentFile))))

(defun ca-before-last (list)
  (nth (- (length list) 2) list))

(defun ca-git-grep-string (string-to-find)
  "Look for a string using git-grep"
  (interactive "sString: ")
  (let ((grep-result-buffer (get-buffer-create "*git grep result*")))
    (shell-command (format "git --no-pager grep -nH -e %s" string-to-find) grep-result-buffer)
    (pop-to-buffer grep-result-buffer)
    (grep-mode)))

(defun ca-git-branches-list ()
  "list the current branches"
  (remove "*" (split-string (shell-command-to-string "git branch"))))

(defun ca-select-line ()
  "If the mark is not active, select the current line.
Otherwise, expand the current region to select the lines the region touches."
  (interactive)
  (if mark-active ;; expand the selection to select lines
      (let ((top (= (point) (region-beginning)))
            (p1 (region-beginning))
            (p2 (region-end)))
        (goto-char p1)
        (beginning-of-line)
        (push-mark (point))
        (goto-char p2)
        (unless (looking-back "\n")
          (progn
            (end-of-line)
            (if (< (point) (point-max)) (forward-char))))
        (setq mark-active t
              transient-mark-mode t)
        (if top (exchange-point-and-mark)))
    (progn
      (beginning-of-line)
      (push-mark (point))
      (end-of-line)
      (if (< (point) (point-max)) (forward-char))
      (setq mark-active t
            transient-mark-mode t))))

(defun ca-all-asscs (asslist query)
  "returns a list of all corresponding values (like rassoc)"
  (cond
   ((null asslist) nil)
   (t
    (if (equal (cdr (car asslist)) query)
        (cons (car (car asslist)) (ca-all-asscs (cdr asslist) query))
      (ca-all-asscs (cdr asslist) query)))))

(defun ca-reopen-read-write ()
  "Reopen the file in rw mode, sui"
  (interactive)
  (let
      ((read-only-old-file (buffer-file-name)))
    (if (not (file-writable-p read-only-old-file))
        (when (yes-or-no-p "kill the read only and reopen in rw?")
          (progn
            (kill-buffer)
            (find-file (concat "/" ca-preferred-reopen-rw-mode "::" read-only-old-file))))
      (message "you can already write on this file"))))

;FIXME: Not really doing what is expected
(defun ca-wc-buffer ()
  "Print number of words in Buffer"
  (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))

;; Taken from http://www.emacswiki.org/emacs/TrampMode
(defvar find-file-root-prefix (if (featurep 'xemacs) "/[sudo/root@localhost]" "/sudo:root@localhost:" )
  "*The filename prefix used to open a file with `ca-find-file-root'.")

(defvar ca-find-file-root-history nil
  "History list for files found using `ca-find-file-root'.")

(defvar ca-find-file-root-hook nil
  "Normal hook for functions to run after finding a \"root\" file.")

(defun ca-find-file-root ()
  "*Open a file as the root user.
   Prepends `ca-find-file-root-prefix' to the selected file name so that it
   maybe accessed via the corresponding tramp method."

  (interactive)
  (require 'tramp)
  (let* ( ;; We bind the variable `file-name-history' locally so we can
         ;; use a separate history list for "root" files.
         (file-name-history ca-find-file-root-history)
         (name (or buffer-file-name default-directory))
         (tramp (and (tramp-tramp-file-p name)
                     (tramp-dissect-file-name name)))
         path dir file)

    ;; If called from a "root" file, we need to fix up the path.
    (when tramp
      (setq path (tramp-file-name-localname tramp)
            dir (file-name-directory path)))

    (when (setq file (read-file-name "Find file (UID = 0): " dir path))
      (find-file (concat find-file-root-prefix file))
      ;; If this all succeeded save our new history list.
      (setq ca-find-file-root-history file-name-history)
      ;; allow some user customization
      (run-hooks 'ca-find-file-root-hook))))

(defface ca-find-file-root-header-face
  '((t (:foreground "white" :background "red3")))
  "*Face use to display header-lines for files opened as root.")

(defun ca-find-file-root-header-warning ()
  "*Display a warning in header line of the current buffer.
   This function is suitable to add to `ca-find-file-root-hook'."
  (let* ((warning "WARNING: EDITING FILE AS ROOT!")
         (space (+ 6 (- (window-width) (length warning))))
         (bracket (make-string (/ space 2) ?-))
         (warning (concat bracket warning bracket)))
    (setq header-line-format
          (propertize  warning 'face 'ca-find-file-root-header-face))))

(add-hook 'ca-find-file-root-hook 'ca-find-file-root-header-warning)

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun ca-unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

;; You can convert an entire buffer from paragraphs to lines by
;; recording a macro that calls ‘unfill-paragraph’ and moves past the
;; blank-line to the next unfilled paragraph and then executing that
;; macro on the whole buffer, ‘C-u 0 C-x e’ (see
;; InfiniteArgument). Or, use ca-unfill-region, below.

(defun ca-unfill-region ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-region (region-beginning) (region-end) nil)))

;; Handy key definitions
(global-set-key "\M-Q" 'ca-unfill-paragraph)
(global-set-key "\M-\C-q" 'ca-unfill-region)

(defun ca-camelize (s)
  "Convert under_score string S to CamelCase string."
  (mapconcat 'identity (mapcar
                        '(lambda (word) (capitalize (downcase word)))
                        (split-string s "_")) ""))

(defun ca-camelize-method (s)
  "Convert under_score string S to camelCase string."
  (mapconcat 'identity (mapcar-head
                        '(lambda (word) (downcase word))
                        '(lambda (word) (capitalize (downcase word)))
                        (split-string s "_")) ""))

(defun ca-un-camelcase-string (s &optional sep start)
  "Convert CamelCase string S to lower case with word separator SEP.
    Default for SEP is a hyphen \"-\".
    If third argument START is non-nil, convert words after that
    index in STRING."
  (let ((case-fold-search nil))
    (while (string-match "[A-Z]" s (or start 1))
      (setq s (replace-match (concat (or sep "-")
                                     (downcase (match-string 0 s)))
                             t nil s)))
    (downcase s)))

(defun ca-uncamel ()
  (ca-manipulate-matched-text 'un-camelcase-string))

(defun ca-untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun ca-indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun ca-cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  ;; (ca-indent-buffer)
  (ca-untabify-buffer)
  ;TODO: use whitespace cleanup instead?
  (delete-trailing-whitespace))

; FIXME: previous-line should be only used as interactive function
(defun ca-ditto ()
  "*Copy contents of previous line, starting at the position above point."
  (interactive)
  (let ((last-command nil))
    (save-excursion
      (previous-line 1)
      (copy-region-as-kill (point) (progn (end-of-line) (point))))
    (yank 1)))

;; TODO: add support for different modes
(defun ca-look-for-function ()
  (interactive)
  (let ((baseurl "http://www.google.com/codesearch?q=%s"))
    (browse-url (format baseurl (thing-at-point 'symbol) ))))

(defun ca-is-new-file ()
  "Check if it's a new file"
  (not (file-exists-p buffer-file-name)))

(defun ca-insert-header ()
  "try to insert the header smartly"
  (when
      (ca-is-new-file)
    (let
        ((snip
          (ca-find-matching-snippet (file-name-nondirectory (buffer-file-name)))))
      (when
          snip
        (ca-insert-at-startup (cdr snip))))))

(defun ca-new-shell ()
  (interactive)
  (shell (concat "*shell-" default-directory)))

(defun ca-next-defun ()
  (interactive)
  (end-of-defun 2)
  (beginning-of-defun 1))

(defun ca-prev-defun ()
  (interactive)
  (beginning-of-defun))

(provide 'ca-utils)
