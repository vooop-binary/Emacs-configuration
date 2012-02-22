(defcustom ca-preferred-reopen-rw-mode "sudo"
  "preferred mode for reopen"
  :type 'string
  :group 'ca
  )

(defcustom ca-dired-git-after-desktop
  nil
  "asking to open a dired buffer every time"
  :group 'ca
  :type 'boolean)

(defcustom ca-default-closing-char ";"
  "default closing char, change in ca-newline-force-close-alist if needed"
  :group 'ca
  :type 'string)

(defcustom ca-newline-force-close-alist
  '((python-mode . ":")
    (jython-mode . ":")
    (prolog-mode . ".")
    (latex-mode . " \\newline")
    (org-mode . " \\newline")
    (tuareg-mode . ";;")
    (html-mode . " <br>"))
  "Closing char for different modes"
  :group 'ca
  :type 'list)

(defcustom ca-show-battery
  nil
  "show the battery level"
  :group 'ca
  :type 'boolean)

(defcustom ca-spell-langs
  '(emacs-lisp-mode-hook python-mode-hook c-mode-common-hook nesc-mode-hook java-mode-hook jde-mode-hook haskell-mode-hook)
  "Set of programming modes for which I want to enable spelling in comments and strings"
  :group 'ca
  :type 'list)

(defcustom ca-camelCase-modes
  '(python-mode-hook java-mode-hook c-mode-common-hook nesc-mode-hook)
  "Modes where camelizing is allowed"
  :group 'ca
  :type 'list)

(defcustom ca-python-enable-rope nil
  "True if rope is enabled"
  :type 'boolean
  :group 'ca)

;FIXME: not used at the moment
(defcustom ca-python-enable-cedet t
  "True if we should use cedet also for python"
  :type 'boolean
  :group 'ca)

(defcustom ca-backend-assoc
  '(('Git . 'magit-status)
    ('Hg . 'hg-status)
    ('Svn . 'svn-status))
  "Mapping between backend and function"
  :type 'list)

;TODO: how do we check if we can check for the existing snippets?
;TODO: make it smarter, it would be good to accept also a function, in this way it can be made more generic
(defcustom ca-auto-header-conses
      '(
        ("setup.py" . "setup")
        ("\.sh$" . "bash")
        ("\.h$"  . "once")
        ("\.hpp$" . "once"))
      "snippets to expand per file extension"
      :group 'ca
      :type 'list)

(defcustom ca-whitespace-cleanup-enabled
  nil
  "True if the whitespace cleanup should be enabled, good candidate to use as dir-local variable"
  :type 'boolean
  :group 'ca)

;TODO: might be a list of functions, which can be also analyzed in some other ways
(defcustom ca-whitespace-ask-modes
  ()
  "Modes where the whitespace cleanup should query the user"
  :type 'list
  :group 'ca)

(defcustom ca-non-whitespaces-modes
      '(makefile-gmake-mode
        makefile-mode
        makefile-bsdmake-mode
        message-mode
        mail-mode)
      "Modes that should not run the whitespace cleanup automatically"
      :type 'list
      :group 'ca)

(defcustom ca-command-frequency-enabled
  nil
  "Enable recording the command frequency"
  :type 'boolean
  :group 'ca)

(defcustom ca-extra-conf-files
  '("\\.pkla\\'" "shorewall" "pylintrc" "\\.spec\\'" "etc")
  "Extra list of regexp to enable conf-mode"
  :type 'list
  :group 'ca)


(defcustom ca-conf-section-regexp
  "\\[.*\\]"
  "Regexp to distinguish the different configuration sections"
  :type 'string
  :group 'ca)

(defcustom ca-cedet-modes
  '(python-mode-hook c-mode-common-hook emacs-lisp-mode-hook makefile-mode-hook)
  "Modes for which cedet should be enabled"
  :type 'list
  :group 'ca)

(defcustom ca-cedet-enabled
  nil
  "Enable cedet"
  :type 'boolean
  :group 'ca)

(defcustom ca-fixme-mode-hooks
  '(python-mode-hook
    c-mode-common-hook
    ruby-mode-hook
    lisp-interaction-mode-hook
    org-mode-hook
    haskell-mode-hook
    emacs-lisp-mode-hook)
  "Modes for which fixme-mode should be enabled"
  :type 'list
  :group 'ca
  )

(defcustom ca-auto-complete-modes
  '(nesc-mode cmake-mode org-mode html-mode xml-mode haskell-mode ned-mode cpp-omnet-mode)
  "Modes for which auto-complete should be enabled"
  :type 'list
  :group 'ca)

(defcustom ca-autopair-mode-hooks
  '(python-mode-hook
    c-mode-common-hook
    ruby-mode-hook
    org-mode-hook
    conf-mode
    haskell-mode-hook
    rst-mode-hook
    latex-mode-hook
    html-mode-hook
    text-mode-hook
    message-mode-hook
    mail-mode-hook
    cmake-mode-hook
    shell-mode-hook
    sh-mode-hook
    org-mode-hook)
  "Modes for which fixme-mode should be enabled"
  :type 'list
  :group 'ca)

(provide 'ca-customs)
