; Colors
; http://www.cs.cmu.edu/~maverick/GNUEmacsColorThemeTest/
(require 'color-theme)
(load-file "~/.emacs.d/themes/color-theme-lss.el")
(color-theme-lss)

; Re-read a buffer from disk
(global-set-key (kbd "<f5>") 'revert-buffer)

; Search tags
(global-set-key [(control tab)] 'find-tag)

; Map C-Enter to do the standard Enter (with reindents). Used for lazy holding Ctrl Eric Davis
(global-set-key [(control return)] 'reindent-then-newline-and-indent)

; Indent with spaces
(setq-default indent-tabs-mode nil)

; Set current tabs to 2
(setq default-tab-width 2)

; Syntax highlight please
(global-font-lock-mode t)

; Spel check comments
(setq-default flyspell-prog-mode t)

; Magic Function to chmod +x anyfile that starts with a hashbang
; http://rubygarden.org/ruby?InstallingEmacsExtensions
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

; No scroll please
(scroll-bar-mode -1)

;; Always wordwrap
(setq truncate-partial-width-windows nil)
(setq word-wrap t)

; no autofills please
(setq auto-fill-mode 0)

; Always highlight the current line
(global-hl-line-mode 1)

; format the title-bar to always include the buffer name
(setq frame-title-format (list "" "emacs" ": %f" ))

(setq auto-mode-alist (cons '("\\.mdwn$" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.page$" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.eml$" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md$" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown$" . markdown-mode) auto-mode-alist))

(setq auto-mode-alist (cons '("\\.thor$" . ruby-mode) auto-mode-alist))

;; Tab completion
;; http://www.emacsblog.org/2007/03/12/tab-completion-everywhere/
(require 'smart-tab)
(setq smart-tab-using-hippie-expand 1)
(global-set-key [(tab)] 'smart-tab)

;; rhtml-mode (because MuMaMo-mode locks up every other day on large
;; buffers)
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit/rhtml"))
     (require 'rhtml-mode)
     (add-hook 'rhtml-mode-hook
     	  (lambda () (rinari-launch)))

(add-to-list 'auto-mode-alist '("\\.liquid$" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.rhtml" . rhtml-mode))

(autoload 'todo-list-mode "todo-list-mode") ;load when needed
 
(setq auto-mode-alist (cons '("\\.todo$" . todo-list-mode) auto-mode-alist))

;; Emacs macro to sort the todo list
(fset 'sort-todo
      [?\M-< ?\C-  ?\M-> ?\M-x ?s ?o ?r ?t ?- ?l ?i ?n ?e ?s return ?\M-<])

;; Emacs macro to add a pomodoro item
(fset 'pomodoro
   "[ ]")

;; Emacs macro to add a pomodoro table
;;
;; | G | Organization | [ ] |
;; |   |              |     |
(fset 'pomodoro-table
   [?| ?  ?G ?  ?| ?  ?O ?r ?g ?a ?n ?i ?z ?a ?t ?i ?o ?n ?  ?| ?  ?\[ ?  ?\] ?  ?| tab])

;; Build tags automatically
(setq rinari-tags-file-name "TAGS")

;; Unbind arrow keys to learn the emacs movement keys better
(global-set-key [up] nil)
(global-set-key [down] nil)
(global-set-key [left] nil)
(global-set-key [right] nil)

(global-set-key [(control z)] nil)

;; Hippie expand rules
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

(load-file "~/.emacs.d/elpa-to-submit/yasnippets-rails/setup.el")
(setq yas/root-directory "~/.emacs.d/snippets")

;; Load the snippets
(yas/load-directory yas/root-directory)

;; asciidoc

(autoload 'doc-mode "doc-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.adoc$" . doc-mode))
(add-hook 'doc-mode-hook
          '(lambda ()
             (require 'asciidoc)))

;; Macro to clear the buffer and enter a merge commit like:
;;
;;  "Merged r[] from trunk."  where the point is at []
(fset 'merge-commit
   [escape ?< ?\C-  ?\M-> ?\C-w ?M ?e ?r ?g ?e ?d ?  ?r ?  ?f ?r ?o ?m ?  ?t ?r ?u ?n ?k ?. ?\M-b ?\M-b ?\M-b ?\C-f])

;; Some writing helpers

;;; http://www.emacswiki.org/emacs/WordCount
(defun wc (&optional start end)
  "Prints number of lines, words and characters in region or whole buffer."
  (interactive)
  (let ((n 0)
        (start (if mark-active (region-beginning) (point-min)))
        (end (if mark-active (region-end) (point-max))))
    (save-excursion
      (goto-char start)
      (while (< (point) end) (if (forward-word 1) (setq n (1+ n)))))
    (message "%3d Lines - %3d Words - %3d Characters" (count-lines start end) n (- end start))))

(defalias 'word-count 'wc)
(defalias 'count-words 'wc)


(defun word-count-analysis (start end)
  "Count how many times each word is used in the region. Punctuation is ignored."
  (interactive "r")
  (let (words)
    (save-excursion
      (goto-char start)
      (while (re-search-forward "\\w+" end t)
        (let* ((word (intern (match-string 0)))
               (cell (assq word words)))
          (if cell
              (setcdr cell (1+ (cdr cell)))
            (setq words (cons (cons word 1) words))))))
    (when (interactive-p)
      (message "%S" words))
    words))


;; orgmode is turning on word wrap by default

(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

;; Open a buffer in multiple frames
(setq ido-default-buffer-method 'selected-window)

;; MobileOrg
;; Set to the location of your Org files on your local system
(setq org-directory "~/doc/N/Notes")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/doc/N/Notes/incoming.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-mobile-files (quote ("~/doc/N/Notes/web-business-system.org"
                               "~/doc/N/Notes/Kindle/accidental_genius.org")))
