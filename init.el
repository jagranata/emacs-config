;; emacs config file

;; general text formatting settings 
(setq org-startup-indented t)   ;; smart indentation in org-mode
(global-visual-line-mode t)     ;; wrap text to sceen width

;; disable splash screen and scratch message.
;; initial major mode for scratch buffer: org mode 
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; highlight selected line 
(global-hl-line-mode 1)

;; display line and col nums in mode line
(setq line-number-mode t)
(setq column-number-mode t)

;; customize the current line highlight background color
(set-face-background 'hl-line "#000000")  ;; Emacs 22 Onl

;; blinking cursor
(setq visible-cursor t)

;; set the emacs region highlight color
(set-face-attribute 'region nil :background "#FFB347")

;; copy to / past from system clipboard
(setq x-select-enable-clipboard t)

;; enable 'interactively do things' mode
(require 'ido)
(ido-mode t)  

;; Emacs 24 package repository manager
(require 'package)

;; load the Markdown exporter automatically with org-mode
(eval-after-load "org"
  '(require 'ox-md nil t))

;; el-get for managing elisp packages 
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(add-to-list 'el-get-user-package-directory "~/.emacs.d/el-get-init-files") ;; user packages
(el-get 'sync)

;; setup emacs jedi (auto-complete)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; flycheck mode with flake8 for python
(add-hook 'python-mode-hook 'flycheck-mode)

;; set flake8 max line length
(setq flycheck-flake8-maximum-line-length 80)

;; faster navigation (move 5 lines at a time)
(global-set-key (kbd "C-n")
		(lambda () (interactive) (next-line 5)))
(global-set-key (kbd "C-p")
		(lambda () (interactive) (previous-line 5)))

;; after setting load path above
;; show column marker (so not to exceed 80 lines in code)
(require 'fill-column-indicator)
(setq fci-rule-width 8)
(setq fci-rule-column 80) ;; pep8 
(setq fci-rule-color "#333333")
(setq fci-rule-use-dashes nil)
(global-set-key (kbd "C-c m") 'fci-mode)
(add-hook 'python-mode-hook 'fci-mode)

(add-hook 'python-mode-hook 'highlight-indentation-mode)

;; sphinx-doc: emacs minor mode for inserting python docstring skeletons
(add-hook 'python-mode-hook (lambda ()
			      (require 'sphinx-doc)
			      (sphinx-doc-mode t)))

;; configure highlight-indentation
(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#00000F")
(set-face-background 'highlight-indentation-current-column-face "#c3b3b3")

;; automatically follow symlinks to version controlled files
(setq vc-follow-symlinks t)

;; virtual env wrapper for using python virtualenv in emacs shell
(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location '("~/.virtualenvs/data-analysis")) ;; list of virtual envs

;; globally turn on autocomplete 
(require 'auto-complete)
(global-auto-complete-mode t)

;; require ein to use autocomplete
(setq ein:use-auto-complete t)

;; indicate empty lines in file
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
    (toggle-indicate-empty-lines))

;; type y or n instead of yes or no 
(defalias 'yes-or-no-p 'y-or-n-p)

;; miscellaneous key bindings
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x /") 'comment-or-uncomment-region)

;; git-commit-mode for formatting commit messages
;; (require 'git-commit)
;; (add-hook 'git-commit-mode-hook 'turn-on-flyspell)

;; auto indentation
(electric-indent-mode 1)

;; turn down time to echo keystrokes, don't use dialog boxes.
;; turn off the audible beep (visual indicator instead)
;; always highlight parentheses
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)

;; adding swiper for searching overview
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key "\C-r" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key [f6] 'ivy-resume)

(put 'upcase-region 'disabled nil)

;; set MELPA package archives
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; exec-path is not initialized from the shell, so the command-line tools
;; flycheck needs for some modes are not available
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; to find flake8
;; (add-to-list 'exec-path "/usr/local/bin")

;; solarized theme settings

;; make the fringe stand out from the background
(setq solarized-distinct-fringe-background t)

;; Use more colors for indicators such as git:gutter, flycheck and similar
(setq solarized-emphasize-indicators t)

;; solarized
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/color-theme-solarized-20120301/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/color-theme-solarized-20150619.1734/")
(load-theme 'solarized-dark t)

;; set emacs modeline to green
;; (set-face-background 'mode-line "#77DD77")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ein:cell-input-area ((t (:background "color-233" :box (:line-width 2 :color "brightwhite" :style released-button))))))

;; markdown mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; shortcuts for connecting buffer to ipython notebook server (repl)
;; manage server sessions (ipython, postgres, etc.) w/ tmux
;; C-c C-c will send to ipython notebook (w/ current venv)
(global-set-key (kbd "C-x p o") 'ein:notebooklist-open)
(global-set-key (kbd "C-x p c") 'ein:connect-to-notebook-buffer)

;; python autocompletion for emacs using jedi
(add-hook 'ein:connect-mode-hook 'ein:jedi-setup)

;; coloring for the mode-line
(set-face-background 'mode-line "green")
(set-face-foreground 'mode-line "black")
(set-face-foreground 'mode-line-buffer-id "black")
(set-face-background 'mode-line-inactive "blue")
(set-face-foreground 'mode-line-inactive "black")

(set-face-background 'scroll-bar "#000000")
(set-face-foreground 'scroll-bar "#000000")

;; region (select)
(set-face-background 'region "blue")
(set-face-foreground 'region "#FFFFFF")

;; highlight (swiper search)
(set-face-background 'highlight "#FE2EC8")
(set-face-foreground 'highlight "#FFFFFF")

;; secondary highlight (same)
(set-face-background 'lazy-highlight "#FE2EC8")
(set-face-foreground 'lazy-highlight "#FFFFFF")

;; coloring for the menu
(set-face-background 'menu "#424242")
(set-face-background 'menu "#FFFFFF")

;; coloring for the menu
(set-face-background 'query-replace "#FE2EC8")
(set-face-background 'query-replace "#000000")

;; let the terminal decide the coloring for text in files (solarized) to get around emacs bugs
(custom-set-faces (if (not window-system)
		      '(default ((t (:background "nil"))))
		    ))

;; helm imenu for searching python functions
(global-set-key (kbd "C-x t") 'helm-imenu)

;; utility for copy/paste interaction w/ system clipboard
;; (require 'simpleclip)
;; (simpleclip-mode 1)

;; Press super-c to copy without affecting the kill ring.
;; Press super-x or super-v to cut or paste.
;; On OS X, use ⌘-c, ⌘-v, ⌘-x.

(require 'simpleclip)
(defun copy-to-x-clipboard ()
  (interactive)
  (let ((thing (if (region-active-p)
		   (buffer-substring-no-properties (region-beginning) (region-end))
		 (thing-at-point 'symbol))))
    (simpleclip-set-contents thing)
    (message "thing => clipboard!")))

(defun paste-from-x-clipboard()
  "Paste string clipboard"
  (interactive)
  (insert (simpleclip-get-contents)))

;; Press `Alt-Y' to paste from clibpoard when in minibuffer
(defun my/paste-in-minibuffer ()
  (local-set-key (kbd "M-y") 'paste-from-x-clipboard))
(add-hook 'minibuffer-setup-hook 'my/paste-in-minibuffer)
