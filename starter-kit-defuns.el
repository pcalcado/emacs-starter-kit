;;; starter-kit-defuns.el --- Saner defaults and goodies: function defs.
;;
;; Copyright (c) 2008-2010 Phil Hagelberg and contributors
;;
;; Author: Phil Hagelberg <technomancy@gmail.com>
;; URL: http://www.emacswiki.org/cgi-bin/wiki/StarterKit
;; Version: 2.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

;; This file contains all the function definitions for the starter kit.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(require 'thingatpt)
(require 'imenu)

;; Buffer-related

(defun esk-flatten-assoc-tree (tree pred)
  "Returns an alist of only (key . leaf) pairs in TREE. PRED
determines whether a value is a sub-alist or a leaf."
  (flet ((inner (lst)
                (mapcan (lambda (elt)
                          (cond ((atom elt) nil)
                                ((funcall pred elt) (inner elt))
                                (t (list elt))))
                        lst)))
    (inner tree)))

(defun esk-ido-imenu ()
  "Queries with `ido-completing-read' a symbol in the buffer's
imenu index, then jumps to that symbol's location."
  (interactive)
  (goto-char
   (let ((lst (nreverse (esk-flatten-assoc-tree
                         (imenu--make-index-alist) 'imenu--subalist-p))))
     (cdr (assoc (ido-completing-read "Symbol: " (mapcar 'car lst)) lst)))))

;;; These belong in coding-hook:

;; We have a number of turn-on-* functions since it's advised that lambda
;; functions not go in hooks. Repeatedly evaling an add-to-list with a
;; hook value will repeatedly add it since there's no way to ensure
;; that a lambda doesn't already exist in the list.

(defun esk-local-column-number-mode ()
  (make-local-variable 'column-number-mode)
  (column-number-mode t))

(defun esk-local-comment-auto-fill ()
  (set (make-local-variable 'comment-auto-fill-only-comments) t)
  (auto-fill-mode t))

<<<<<<< HEAD
(defun turn-on-hl-line-mode ()
  (when (> (display-color-cells) 8) (hl-line-mode t)))
=======
(defun esk-turn-on-hl-line-mode ()
  (when window-system (hl-line-mode t)))
>>>>>>> origin/v2

(defun esk-turn-on-save-place-mode ()
  (require 'saveplace)
  (setq save-place t))

(defun esk-turn-on-whitespace ()
  (whitespace-mode t))

(defun esk-turn-on-paredit ()
  (paredit-mode t))

(defun esk-pretty-lambdas ()
  (font-lock-add-keywords
   nil `(("(?\\(lambda\\>\\)"
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(make-char 'greek-iso8859-7 107))
                    nil))))))

<<<<<<< HEAD
(defun turn-on-idle-highlight ()
  (idle-highlight-mode t))

(defun add-watchwords ()
=======
(defun esk-add-watchwords ()
>>>>>>> origin/v2
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\):"
          1 font-lock-warning-face t))))

<<<<<<< HEAD
(add-hook 'coding-hook 'local-column-number-mode)
(add-hook 'coding-hook 'local-comment-auto-fill)
(add-hook 'coding-hook 'turn-on-hl-line-mode)
(add-hook 'coding-hook 'turn-on-save-place-mode)
(add-hook 'coding-hook 'pretty-lambdas)
(add-hook 'coding-hook 'add-watchwords)
(add-hook 'coding-hook 'turn-on-idle-highlight)
  
(defun run-coding-hook ()
=======
(add-hook 'esk-coding-hook 'esk-local-column-number-mode)
(add-hook 'esk-coding-hook 'esk-local-comment-auto-fill)
(add-hook 'esk-coding-hook 'esk-turn-on-hl-line-mode)
(add-hook 'esk-coding-hook 'esk-turn-on-save-place-mode)
(add-hook 'esk-coding-hook 'esk-pretty-lambdas)
(add-hook 'esk-coding-hook 'esk-add-watchwords)
(add-hook 'esk-coding-hook 'idle-highlight)

(defun esk-run-coding-hook ()
>>>>>>> origin/v2
  "Enable things that are convenient across all coding buffers."
  (run-hooks 'esk-coding-hook))

(defun esk-turn-off-tool-bar ()
  (tool-bar-mode -1))

(defun esk-untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun esk-indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun esk-cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (esk-indent-buffer)
  (esk-untabify-buffer)
  (delete-trailing-whitespace))

(defun esk-recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

;; Other

(defun esk-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(defun esk-sudo-edit (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun esk-lorem ()
  "Insert a lorem ipsum."
  (interactive)
  (insert "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do "
          "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim"
          "ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
          "aliquip ex ea commodo consequat. Duis aute irure dolor in "
          "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
          "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
          "culpa qui officia deserunt mollit anim id est laborum."))

(defun esk-insert-date ()
  "Insert a time-stamp according to locale's date and time format."
  (interactive)
  (insert (format-time-string "%c" (current-time))))

(defun esk-pairing-bot ()
  "If you can't pair program with a human, use this instead."
  (interactive)
  (message (if (y-or-n-p "Do you have a test for that? ") "Good." "Bad!")))

(defun esk-paredit-nonlisp ()
  "Turn on paredit mode for non-lisps."
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (paredit-mode 1))

<<<<<<< HEAD
(defun esk-space-for-delimiter? (endp delimiter)
  (not (member major-mode '(ruby-mode espresso-mode js-mode js2-mode))))

(eval-after-load 'paredit
  '(add-to-list 'paredit-space-for-delimiter-predicates
                'esk-space-for-delimiter?))

(defun message-point ()
  (interactive)
  (message "%s" (point)))

(defun esk-disapproval ()
  (interactive)
  (insert "ಠ_ಠ"))

(defun esk-agent-path ()
  (if (eq system-type 'darwin)
      "*launch*/Listeners"
    "*ssh*/agent\.*"))

(defun esk-find-agent ()
  (let* ((path-clause (format "-path \"%s\"" (esk-agent-path)))
         (find-command (format "$(find -L /tmp -uid $UID %s -type s 2> /dev/null)"
                               path-clause)))
    (first (split-string
            (shell-command-to-string
             (format "/bin/ls -t1 %s | head -1" find-command))))))

(defun fix-agent ()
  (interactive)
  (let ((agent (esk-find-agent)))
    (setenv "SSH_AUTH_SOCK" agent)
    (message agent)))

(defun toggle-fullscreen ()
  (interactive)
  ;; TODO: this only works for X. patches welcome for other OSes.
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))


=======
>>>>>>> origin/v2
;; A monkeypatch to cause annotate to ignore whitespace
(defun vc-git-annotate-command (file buf &optional rev)
  (let ((name (file-relative-name file)))
    (vc-git-command buf 0 name "blame" "-w" rev)))

(provide 'starter-kit-defuns)
;;; starter-kit-defuns.el ends here
