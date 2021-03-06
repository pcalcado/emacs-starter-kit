;;;;;;;;;;;;;; global stuff

;;soft wrap
(visual-line-mode)

;; small font size
(set-face-attribute 'default (selected-frame) :height 100)

;;color
(add-to-list 'load-path "/Users/pcalcado/.emacs.d/emacs-color-theme-solarized/")
(require 'color-theme-solarized)
(color-theme-solarized-dark)

(global-linum-mode 1)

(setq column-number-mode t)

;;soft wrap
(visual-line-mode)

;; whitespace
(global-set-key (kbd "C-|") 'whitespace-cleanup)
(add-hook 'after-save-hook 'whitespace-cleanup)

;;auto complete
(add-to-list 'load-path "/Users/pcalcado/.emacs.d/auto-complete-1.3.1/")
(require 'auto-complete-config)
(ac-config-default)
(auto-complete-mode)
(global-set-key (kbd "M-/") 'hippie-expand)


;;;;;;;;;;;;;; language-specific
;; scheme
(require 'quack)

;;clojure
(add-to-list 'load-path "/Users/pcalcado/.emacs.d/clojure-mode")
(require 'clojure-mode)

(add-to-list 'load-path "/Users/pcalcado/.emacs.d/ac-slime")
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(global-set-key (kbd "C-M-|") 'slime-eval-buffer)

(setq slime-net-coding-system 'utf-8-unix)

;;highlighting for swank
(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

(require 'midje-mode)
(add-hook 'clojure-mode-hook 'midje-mode)

(require 'ruby-block)
(ruby-block-mode t)

;;rvm mode
;(add-to-list 'load-path "/Users/pcalcado/.emacs.d/rvm")
;(require 'rvm)
;(add-hook 'ruby-mode-hook
;;         (lambda () (rvm-activate-corresponding-ruby))
;;)

;(setq auto-mode-alist (cons '("Gemfile" . ruby-mode) auto-mode-alist))
;(add-hook 'ruby-mode-hook  'esk-paredit-nonlisp)

;(add-hook 'ruby-mode-hook  'auto-complete)

;;htmlize
(setq htmlize-output-type 'inline-css)

;;region overwritten
(delete-selection-mode 1)

;;haskell
;;(add-to-list 'load-path "./haskell-mode")
;;(require 'haskell-mode)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;;magit
(add-to-list 'load-path "/Users/pcalcado/.emacs.d/magit/magit.el")
(require 'magit)

(add-to-list 'load-path "/Users/pcalcado/.emacs.d/mo-git-blame")
(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)

;;c#
;;(require 'csharp-mode)
;;(setq auto-mode-alist (cons '("\\.cs$" . csharp-mode) auto-mode-alist))

;;scala
(add-to-list 'load-path "/Users/pcalcado/.emacs.d/scala-mode")
(require 'scala-mode)
(setq auto-mode-alist (cons '("\\.scala$" . scala-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.sbt$" . scala-mode) auto-mode-alist))
(add-hook 'scala-mode-hook 'paredit-mode)

;;python
(setq auto-mode-alist (cons '("\\.py$" python-mode flymake-mode) auto-mode-alist))

;; as per http://jblevins.org/projects/markdown-mode/
(defun markdown-custom () "markdown-mode-hook"
  (setq markdown-command "markdown | smartypants")) (add-hook 'markdown-mode-hook '(lambda() (markdown-custom)))


(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)
