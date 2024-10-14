(package-initialize)
(setq custom-file "~/.config/emacs/custom.el")
;; Set the directory for auto-save files
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-save/" t)))
;; Set the directory for backup files
(setq backup-directory-alist
      `((".*" . "~/.emacs.d/backups/")))


(load-file "~/.config/emacs/rc.el")

;;; apparence
;; font
;; (add-to-list 'default-frame-alist `(font . "JetBrains Mono:style=Regular"))
(add-to-list 'default-frame-alist `(font . "Iosevka:20"))
;; theme
;;(rc/require-theme 'chyla-dark)
;;(load-theme 'tsdh-dark t)
(rc/require-theme 'aircon)
;; editor
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode 1)
(ido-mode 1)
(ido-everywhere 1)

;;; smex
(rc/require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; move text
(load-file "~/.config/emacs/move-text.el")
(move-text-default-bindings)

;; ;;; keybinds
;; (global-set-key (kbd "M-S-C-<kp-down>") 'duplicate-dwim)
;; (global-set-key (kbd "M-S-C-<kp-up>")   'duplicate-line)
(global-set-key [M-S-down] 'duplicate-line)
(global-set-key [M-S-up]   'duplicate-line)
(global-set-key (kbd "C-x C-;") 'comment-line)
		     
;;; simple C mode
;; (require 'simpc-mode)
(load-file "~/.config/emacs/simpc-mode.el")
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;;; multiple cursors
(rc/require 'multiple-cursors)
;;(global-set-key (kbd "M-S-c M-S-c") 'mc/edit-lines)
(global-set-key (kbd "M->")           'mc/mark-next-like-this)
(global-set-key (kbd "M-<")           'mc/mark-previous-like-this)
;;(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
;;(global-set-key (kbd "M-[")         'mc/skip-to-next-like-this)
;;(global-set-key (kbd "M-]")         'mc/skip-to-previous-like-this)

(rc/require 'magit)

(with-eval-after-load 'magit
  (rc/require 'forge))
;;(with-eval-after-load 'magit
;;  (require 'forge))

(rc/require '0x0) ; http://0x0.st Share files

(require 'treesit)
;;(treesit-available-p)

;; (rc/require '0xc) ; binary conversion


(load-file custom-file)
