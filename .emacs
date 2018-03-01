(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; shortcuts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-x h") 'help-command)
(global-set-key (kbd "C-x i") 'previous-multiframe-window)
(global-set-key (kbd "C-c r") 'revert-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; display
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(column-number-mode)

;; keeps page centered
(add-hook 'post-command-hook
	  (lambda ()
	    (recenter '("don't redraw"))))

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(which-function-mode)

(setq-default
 mode-line-format
 '(
   "%e"
   mode-line-buffer-identification
   "   " mode-line-position
   mode-line-misc-info
   mode-line-modes
   mode-line-end-spaces
   )
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; behavior
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; prevent yes or no prompt
(defalias 'yes-or-no-p 'y-or-n-p)

(defadvice save-buffers-kill-emacs (around no-y-or-n activate)
  (flet ((yes-or-no-p (&rest args) t)
         (y-or-n-p (&rest args) t))
    ad-do-it))

(require 'pbcopy)

(setq-default indent-tabs-mode nil)
(setq require-final-newline 'visit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq python-fill-docstring-style 'django)

(add-hook 'python-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c d")
			   (lambda () (interactive) (insert "import ipdb; ipdb.set_trace()")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; javascript mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq js-indent-level 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ledger mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; git-gutter.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-git-gutter-mode t)
(global-set-key (kbd "C-x g") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-diff)
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)
(global-set-key (kbd "C-x r") 'git-gutter:revert-hunk)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; linting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'after-init-hook #'global-flycheck-mode)
(global-set-key (kbd "C-c p") 'flycheck-previous-error)
(global-set-key (kbd "C-c n") 'flycheck-next-error)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; jump
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(dumb-jump-mode)
(global-set-key (kbd "C-x t") 'dumb-jump-go)
