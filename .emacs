(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa.org/packages/") t)
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

(setq uniquify-buffer-name-style 'forward)

(which-function-mode)
(menu-bar-mode -1)

(require 'centered-cursor-mode)
(global-centered-cursor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; behavior
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defalias 'yes-or-no-p 'y-or-n-p)
(setq split-width-threshold 100)
(setq-default fill-column 80)

(defun my-kill-emacs ()
  "save some buffers, then exit unconditionally"
  (interactive)
  (save-some-buffers nil t)
  (kill-emacs))
(global-set-key (kbd "C-x C-c") 'my-kill-emacs)

(setq-default indent-tabs-mode nil)

(winner-mode)
(ido-mode 1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'python-mode-hook 'my-python-mode-hook)
(defun my-python-mode-hook ()
  (local-set-key (kbd "C-c d")
                 (lambda () (interactive) (insert "import ipdb; ipdb.set_trace(context=9)\n")))
  (setq python-fill-docstring-style 'pep-257-nn)
  (flycheck-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ledger mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; git-gutter.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-git-gutter-mode t)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-diff)
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)
(global-set-key (kbd "C-x r") 'git-gutter:revert-hunk)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; file navigation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key global-map (kbd "C-x g") (make-sparse-keymap))

(dumb-jump-mode)
(global-set-key (kbd "C-x g j") 'dumb-jump-go)
(global-set-key (kbd "C-x t") 'dumb-jump-go)
(global-set-key (kbd "C-x g p") 'dumb-jump-go-prompt)

(global-set-key (kbd "C-x g f") 'fiplr-find-file)
(global-set-key (kbd "C-x g g") 'vc-git-grep)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; linting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-c p") 'flycheck-previous-error)
(global-set-key (kbd "C-c n") 'flycheck-next-error)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pbcopy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; golang
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setenv "GOPATH" "/Users/jian/gocode")

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(defun my-go-mode-hook ()
  (lsp)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq create-lockfiles nil)
  ;; (local-set-key (kbd "C-x t") 'lsp-find-definition)
  (local-set-key (kbd "C-x g g") 'lsp-find-references)
  (go-guru-hl-identifier-mode)
  (ac-config-default)
  )

(add-hook 'go-mode-hook 'my-go-mode-hook)
(with-eval-after-load 'go-mode
  (require 'go-autocomplete))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;automatic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (json-mode projectile go-autocomplete go-rename centered-cursor-mode el-get pycoverage dumb-jump fiplr neotree flymake-go go-guru auto-complete exec-path-from-shell go-mode git-gutter flycheck))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
