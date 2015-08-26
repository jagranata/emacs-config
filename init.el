;; this startup file is being used at present (2015-08-25). 

;; general text formatting settings 
(setq font-lock-support-mode '((gams-mode . nil) (t . jit-lock-mode)))
(setq org-startup-indented t)   ;; smart indentation in org-mode
(global-visual-line-mode t)     ;; wrap text to sceen width

;; enable 'interactively do things' mode
(require 'ido)
(ido-mode t)  

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

;; (add-to-list 'ac-modes 'sql-mode)
;; (setq ac-modes '(c++-mode sql-mode))

;; custom functions
;; (defun start-virtual-notebook ()
;;   "Start data analysis venv and ipython kernel server."
;;   (interactive) ;; this function will be callable with execute-extended-command
;;   (venv-workon data-analysis) ;; activate virtualenv
;;   ;; (shell-command "ipython notebook")
;; )
