;;color
(require 'color-theme)
(color-theme-blackboard)


(global-linum-mode 1)
(setq column-number-mode t)

;;auto-complete
(add-to-list 'load-path "/Users/pcalcado/.emacs.d/auto-complete-1.3.1")
(require 'auto-complete)

;(add-to-list 'load-path "/Users/pcalcado/.emacs.d/slime/contrib")
;(require 'slime-fuzzy)

;clojure
(add-to-list 'load-path "/Users/pcalcado/.emacs.d/clojure-mode")
(require 'clojure-mode)

(add-to-list 'load-path "/Users/pcalcado/.emacs.d/ac-slime")
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)

;;highlighting for swank
(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

;;File associations
(setq auto-mode-alist (cons '("\\.ftl$" . html-mode) auto-mode-alist))

(require 'midje-mode)
(add-hook 'clojure-mode-hook 'midje-mode)


;;htmlize
(setq htmlize-output-type 'inline-css)

;;region overwritten
(delete-selection-mode 1) 

;;haskell
;(add-to-list 'load-path "./haskell-mode")
;(require 'haskell-mode)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;;magit
(add-to-list 'load-path "/Users/pcalcado/.emacs.d/magit/magit.el")
(require 'magit)

;;c#
(require 'csharp-mode)
(setq auto-mode-alist (cons '("\\.cs$" . csharp-mode) auto-mode-alist))

;;scala
(add-to-list 'load-path "/Users/pcalcado/.emacs.d/scala-mode")
(require 'scala-mode)
(setq auto-mode-alist (cons '("\\.scala$" . scala-mode) auto-mode-alist))
(add-hook 'scala-mode-hook 'paredit-mode)

;; Load the ensime lisp code...
(add-to-list 'load-path "/Users/pcalcado/.emacs.d/ensime")
(require 'ensime)

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;;python
(setq auto-mode-alist (cons '("\\.py$" python-mode flymake-mode) auto-mode-alist))


;;sof wrap
(visual-line-mode)


