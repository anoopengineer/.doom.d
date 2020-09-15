;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "/home/anoop/Dropbox/notes")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Anoop's customizations ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;;Start maximized
(setq-default cursor-type 'bar)     ;; Bar cursor rather than block
(setq-default indent-tabs-mode nil) ;; never indent with tabs


(defun aks-yank-line-below ()
  "copy current line and yank it to the next line.
Cursor doesn't move."
  (interactive)
  (setq init-point (point))
  (save-excursion
    (beginning-of-line)
    (setq beg-point (point))
    (end-of-line)
    (setq end-point (point))
    (setq line-text (delete-and-extract-region end-point beg-point))
    (insert line-text)
    (newline)
    (insert line-text))
  (goto-char init-point))

(global-set-key (kbd "M-p") 'aks-yank-line-below)
(global-set-key "\C-x2" (lambda ()(interactive)(split-window-below)(other-window 1)))
(global-set-key "\C-x3" (lambda ()(interactive)(split-window-right)(other-window 1)))

;; (global-set-key (kbd "M-o") 'ace-window)
;; (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(use-package ace-jump-mode
  :bind ("C-." . ace-jump-mode))

(use-package ace-window
  :bind ("M-o" . ace-window))

;;; Rainbow delimiters
(use-package rainbow-delimiters
  :config (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;;; Zygospore, make C-x 1 toggleable
(use-package zygospore
  :commands (zygospore-toggle-delete-other-windows)
  :bind ("C-x 1" . zygospore-toggle-delete-other-windows))

;; Golden ratio on window splits
(use-package golden-ratio
  :diminish golden-ratio-mode
  :config
  (add-to-list 'golden-ratio-extra-commands 'ace-window)
  :init
  (golden-ratio-mode t))


(setq doom-theme 'doom-dracula)
;; https://www.ianjones.us/own-your-second-brain
(setq org-roam-directory "/home/anoop/Dropbox/notes")
(after! org-roam
        (map! :leader
            :prefix "n"
            :desc "org-roam" "l" #'org-roam
            :desc "org-roam-insert" "i" #'org-roam-insert
            :desc "org-roam-switch-to-buffer" "b" #'org-roam-switch-to-buffer
            :desc "org-roam-find-file" "f" #'org-roam-find-file
            :desc "org-roam-show-graph" "g" #'org-roam-show-graph
            :desc "org-roam-insert" "i" #'org-roam-insert
            :desc "org-roam-capture" "c" #'org-roam-capture))

(require 'company-org-roam)
    (use-package company-org-roam
      :when (featurep! :completion company)
      :after org-roam
      :config
      (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev)))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Anoop Kunjuraman"
      user-mail-address "anoopengineer@gmail.com")

(add-hook! 'js2-mode-hook
  (unless (locate-dominating-file default-directory ".prettierrc")
    (format-all-mode -1)))

(setq doom-modeline-bar-width 10)
(setq doom-modeline-height 35)
(setq global-hl-line-mode 1)
(setq hl-line-mode 1)
