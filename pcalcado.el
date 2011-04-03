;;color

(require 'color-theme)
(color-theme-blackboard)

(global-linum-mode 1)
(setq column-number-mode t)

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
(add-to-list 'load-path "./magit/magit.el")
(require 'magit)

;;c#
(require 'csharp-mode)
(setq auto-mode-alist (cons '("\\.cs$" . csharp-mode) auto-mode-alist))
