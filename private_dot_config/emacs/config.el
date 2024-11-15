;;; package --- Summary
;;; Commentary:
;;; Code:

(package-initialize)
(eval-when-compile
  (require 'use-package))
  
(load-file "~/.config/emacs/rc.el")

;; Set the directory for auto-save files
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-save/" t)))
;; Set the directory for backup files
(setq backup-directory-alist
      `((".*" . "~/.emacs.d/backups/")))

;;; APPARENCE
;; font
;; (add-to-list 'default-frame-alist `(font . "JetBrains Mono:style=Regular"))
(add-to-list 'default-frame-alist `(font . "Iosevka:20"))

;;dark themes
;; (rc/require-theme 'chyla-dark)
(rc/require-theme 'gruvbox)
;; (load-theme 'tsdh-dark)
;;light themes
;; (rc/require-theme 'aircon)

;; editor
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode 1)
(ido-mode 1)
(ido-everywhere 1)

;;; KEYBINDS
(global-set-key [M-S-down] 'duplicate-dwim)
(global-set-key [M-S-up]   'duplicate-line)
(global-set-key (kbd "C-x C-;") 'comment-line)
;; (global-set-key (kbd "M-S-C-<kp-down>") 'duplicate-dwim)
;; (global-set-key (kbd "M-S-C-<kp-up>")   'duplicate-line)

;; TODO: easily way to access scratch buffers (more than 1, preferably)

;;; PACKAGES
;; smex
;; repplace for default command executor (M-x)
(use-package smex
  :ensure t
  :bind (
     ("M-x" . smex)
     ("C-c C-c M-x" . execute-extended-command))
  )
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; move text
(load-file "~/.config/emacs/move-text.el")
(move-text-default-bindings)
		     
;;; simple C mode
(load-file "~/.config/emacs/simpc-mode.el")
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;; ivy
;; generic completion
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1))
;; (use-package ivy
;;   ;; :after 'counsel
;;   :demand t
;;   :diminish ivy-mode
;;   :config
;;   (ivy-mode 1)
;;   ;; (counsel-mode 1)

;;   (setq ivy-use-virtual-buffers t)
;;   (setq ivy-use-selectable-prompt t)
;;   (setq ivy-ignore-buffers '("\\` " "\\`\\*magit"))
;;   (setq ivy-re-builders-alist '(
;;                                 (t . ivy--regex-ignore-order)
;;                                 ))
;;   (setq ivy-height 10)
;;   ;; (setq counsel-find-file-at-point t)
;;   (setq ivy-count-format "(%d/%d) "))

;; (use-package counsel
;;   :bind (
;;          ("C-x C-b" . ivy-switch-buffer)
;;          ("C-x b" . ivy-switch-buffer)
;;          ("M-r" . counsel-ag)
;;          ("C-x d" . counsel-dired)
;; 	 ("C-x C-d" . dired)
;; 	 )
;;   :diminish
;;   :config
;;   (global-set-key [remap org-set-tags-command] #'counsel-org-tag))

(use-package swiper
  :bind(("M-C-s" . swiper)))

;; (use-package ivy-hydra)

;; treesit
;; syntax formmat
(use-package treesit
      :mode (("\\.tsx\\'" . tsx-ts-mode)
             ("\\.js\\'"  . typescript-ts-mode)
             ("\\.mjs\\'" . typescript-ts-mode)
             ("\\.mts\\'" . typescript-ts-mode)
             ("\\.cjs\\'" . typescript-ts-mode)
             ("\\.ts\\'"  . typescript-ts-mode)
             ("\\.jsx\\'" . tsx-ts-mode)
             ("\\.json\\'" .  json-ts-mode)
             ("\\.Dockerfile\\'" . dockerfile-ts-mode)
             ("\\.prisma\\'" . prisma-ts-mode)
             ;; More modes defined here...
             )
      :preface
      (defun os/setup-install-grammars ()
        "Install Tree-sitter grammars if they are absent."
        (interactive)
        (dolist (grammar
                 '((css . ("https://github.com/tree-sitter/tree-sitter-css" "v0.20.0"))
                   (bash "https://github.com/tree-sitter/tree-sitter-bash")
                   (html . ("https://github.com/tree-sitter/tree-sitter-html" "v0.20.1"))
                   (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript" "v0.21.2" "src"))
                   (json . ("https://github.com/tree-sitter/tree-sitter-json" "v0.20.2"))
                   (python . ("https://github.com/tree-sitter/tree-sitter-python" "v0.20.4"))
                   (go "https://github.com/tree-sitter/tree-sitter-go" "v0.20.0")
                   (markdown "https://github.com/ikatyang/tree-sitter-markdown")
                   (make "https://github.com/alemuller/tree-sitter-make")
                   (elisp "https://github.com/Wilfred/tree-sitter-elisp")
                   (cmake "https://github.com/uyha/tree-sitter-cmake")
                   (c "https://github.com/tree-sitter/tree-sitter-c")
                   (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
                   (toml "https://github.com/tree-sitter/tree-sitter-toml")
                   (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src"))
                   (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src"))
                   (yaml . ("https://github.com/ikatyang/tree-sitter-yaml" "v0.5.0"))
                   (prisma "https://github.com/victorhqc/tree-sitter-prisma")))
          (add-to-list 'treesit-language-source-alist grammar)
          ;; Only install `grammar' if we don't already have it
          ;; installed. However, if you want to *update* a grammar then
          ;; this obviously prevents that from happening.
          (unless (treesit-language-available-p (car grammar))
            (treesit-install-language-grammar (car grammar)))))

      ;; Optional, but recommended. Tree-sitter enabled major modes are
      ;; distinct from their ordinary counterparts.
      ;;
      ;; You can remap major modes with `major-mode-remap-alist'. Note
      ;; that this does *not* extend to hooks! Make sure you migrate them
      ;; also
      (dolist (mapping
               '((python-mode . python-ts-mode)
                 (css-mode . css-ts-mode)
                 (typescript-mode . typescript-ts-mode)
                 (js-mode . typescript-ts-mode)
                 (js2-mode . typescript-ts-mode)
                 (c-mode . c-ts-mode)
                 (c++-mode . c++-ts-mode)
                 (c-or-c++-mode . c-or-c++-ts-mode)
                 (bash-mode . bash-ts-mode)
                 (css-mode . css-ts-mode)
                 (json-mode . json-ts-mode)
                 (js-json-mode . json-ts-mode)
                 (sh-mode . bash-ts-mode)
                 (sh-base-mode . bash-ts-mode)))
        (add-to-list 'major-mode-remap-alist mapping))
      :config
      (os/setup-install-grammars))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :bind (:map flycheck-mode-map
	      ("M-n" . flycheck-next-error)
	      ("M-p" . flycheck-previous-error)))


;;; multiple cursors
;; (rc/require 'multiple-cursors)
(use-package multiple-cursors
  :ensure t
  :bind (
	 ("M->" . mc/mark-next-like-this)
	 ("M-<" . mc/mark-previous-like-this)
	 ))
  ;;(global-set-key (kbd "M-S-c M-S-c") 'mc/edit-lines)
  ;;(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
  ;;(global-set-key (kbd "M-[")         'mc/skip-to-next-like-this)
  ;;(global-set-key (kbd "M-]")         'mc/skip-to-previous-like-this)

;; magit + forge
;; git porcelan tool + work with git forges (github/gitlab)
(use-package magit
  :ensure t)
(use-package forge
  :ensure t
  :after magit)

;; 0x0.st
;; Share files (http://0x0.st)
(use-package 0x0
  :ensure t)

;; 0xc
;; binary conversion
;; (use-package 0xc) ; 

;; dumb-jump
;; "Jump to definiton" any language
(use-package dumb-jump
  :ensure t
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(setq custom-file "~/.config/emacs/custom.el")
(load-file custom-file)

;; VARIABLES
(setq inhibit-splash-screen t)
(setq display-line-numbers-type 'relative)

;; ENABLED COMMANDS
(put 'upcase-region 'disabled nil)


(provide 'config)
;;; config.el ends here
