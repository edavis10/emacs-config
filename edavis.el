; Colors
; http://www.cs.cmu.edu/~maverick/GNUEmacsColorThemeTest/
(require 'color-theme)
(load-file "~/.emacs.d/themes/color-theme-lss.el")
(color-theme-lss)

; Re-read a buffer from disk
(global-set-key (kbd "<f5>") 'revert-buffer)

; Search tags
(global-set-key [(control tab)] 'find-tag)

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

