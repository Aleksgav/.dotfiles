;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Aleks Gavr"
      user-mail-address "alex.phyp@gmail.com")

;; LOOK AND FEEL
;;
;; Set maximized window on initial frame and every subsequent frame
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . fullheight))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 16 :weight 'semi-light)
    doom-variable-pitch-font (font-spec :family "Fira Sans" :size 15)
    doom-unicode-font (font-spec :family "FiraCode Nerd Font" :size 16 :weight 'semi-light))

;;(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 16 :weight 'semi-light)
;;    doom-variable-pitch-font (font-spec :family "Fira Sans" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-tokyo-night)
;; (setq doom-theme 'doom-tomorrow-night)

(after! doom-themes
 (setq doom-themes-enable-bold t
       doom-themes-enable-italic t))
(custom-set-faces!
 '(font-lock-comment-face :slant italic)
 '(font-lock-keyword-face :slant italic))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; LOOK AND FEEL PACKAGES
;;
(setq doom-themes-treemacs-theme "doom-colors")
(use-package all-the-icons)
(use-package treemacs-all-the-icons)

(require 'highlight-indent-guides)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(add-hook 'text-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-auto-enabled nil)
(setq highlight-indent-guides-method 'character)

(set-face-background 'highlight-indent-guides-odd-face "darkgray")
(set-face-background 'highlight-indent-guides-even-face "dimgray")
(set-face-foreground 'highlight-indent-guides-character-face "dimgray")

(use-package centaur-tabs
 :demand
 :config
 (setq centaur-tabs-style "bar"
       centaur-tabs-set-icons t
       centaur-tabs-set-modified-marker t
       centaur-tabs-set-bar 'over
       centaur-tabs-modified-marker "~"
       x-underline-at-descent-line t
       centaur-tabs-height 34)
 (centaur-tabs-headline-match)
 (centaur-tabs-mode t)
 (centaur-tabs-group-by-projectile-project))

(defun centaur-tabs-hide-tab (x)
 "Do no to show buffer X in tabs."
 (let ((name (format "%s" x)))
   (or
    ;; Current window is not dedicated window.
    (window-dedicated-p (selected-window))

    ;; Buffer name not match below blacklist.
    (string-prefix-p "*typeprof" name)
    (string-prefix-p "*Compile-Log*" name)
    (string-prefix-p "*lsp" name)
    (string-prefix-p "*vterm" name)
    (string-prefix-p "*scratch" name)
    (string-prefix-p "*Messages" name)

    ;; Is not magit buffer.
    (and (string-prefix-p "magit" name)
	  (not (file-name-extension name)))
    )))

(use-package treemacs
 :ensure t
 :defer t
 :init
 (with-eval-after-load 'winum
   (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
 :config
 (progn
   (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
         treemacs-deferred-git-apply-delay      0.5
         treemacs-directory-name-transformer    #'identity
         treemacs-display-in-side-window        t
         treemacs-eldoc-display                 t
         treemacs-file-event-delay              5000
         treemacs-file-extension-regex          treemacs-last-period-regex-value
         treemacs-file-follow-delay             0.2
         treemacs-file-name-transformer         #'identity
         treemacs-follow-after-init             t
         treemacs-git-command-pipe              ""
         treemacs-goto-tag-strategy             'refetch-index
         treemacs-indentation                   2
         treemacs-indentation-string            " "
         treemacs-is-never-other-window         nil
         treemacs-max-git-entries               5000
         treemacs-missing-project-action        'ask
         treemacs-move-forward-on-expand        nil
         treemacs-no-png-images                 nil
         treemacs-no-delete-other-windows       t
         treemacs-project-follow-cleanup        nil
         treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
         treemacs-position                      'left
         treemacs-recenter-distance             0.1
         treemacs-recenter-after-file-follow    nil
         treemacs-recenter-after-tag-follow     nil
         treemacs-recenter-after-project-jump   'always
         treemacs-recenter-after-project-expand 'on-distance
         treemacs-show-cursor                   nil
         treemacs-show-hidden-files             t
         treemacs-silent-filewatch              nil
         treemacs-silent-refresh                nil
         treemacs-sorting                       'alphabetic-asc
         treemacs-space-between-root-nodes      t
         treemacs-tag-follow-cleanup            t
         treemacs-tag-follow-delay              1.5
         treemacs-user-mode-line-format         nil
         treemacs-user-header-line-format       nil
         treemacs-width                         35
         treemacs-workspace-switch-cleanup      nil)
   (treemacs-resize-icons 44)
   (treemacs-follow-mode t)
   (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode t)))

(use-package treemacs-evil
 :after treemacs evil
 :ensure t)

(use-package treemacs-projectile
 :after treemacs projectile
 :ensure t)

(use-package treemacs-icons-dired
 :after treemacs dired
 :ensure t
 :config (treemacs-icons-dired-mode))

;; LANGUAGE SUPPORT
;;
(setq lsp-rust-server 'rust-analyzer)
(setq rustic-lsp-server 'rust-analyzer)

;; PLUGINS
;;
(setq projectile-project-search-path '("~/projects/"))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(map! :desc "Create sparce tree" :ne "SPC | s" #'org-sparse-tree)
(map! :desc "Create sparce tree for tags" :ne "SPC | t" #'org-tags-sparse-tree)

(use-package flycheck
 :defer 2
 :diminish
 :init (global-flycheck-mode)
 :custom
 (flycheck-display-errors-delay .3))

;; DEFT
;;
(setq deft-directory "~/notes/"
     deft-extensions '("org" "txt")
     deft-recursive t)

;; ROAM
;;
(setq org-roam-directory "~/roam")


;; ORG MODE
;;

;; DEFINE CUSTOM FACES
(defface at-face
'((t (:foreground "green")))
   "Face for @")

(setq org-ellipsis " [>>>]")
(custom-set-faces
 '(org-ellipsis ((t (:foreground "#58B5A5")))) ;; background ellipsis color
)

;; HIDE EMPHASIS MARKERS
(setq org-hide-emphasis-markers t)

;; CUSTOM EMPHASIS FACES
(setq org-emphasis-alist
     '(("*" (bold :foreground "deep sky blue"))
       ("/" (italic :foreground "dark salmon"))
       ("_" (underline :foreground "cyan"))
       ("=" org-verbatim verbatim)
       ("~" org-code verbatim)
       ("+" (:strike-through t :foreground "dark green"))
       ;; next lines are not working and I didn't know why
       ;; https://emacs-orgmode.gnu.narkive.com/scSa2kfp/o-add-entries-to-emphasis-alist
       ;; https://emacs.stackexchange.com/questions/13820/inline-verbatim-and-code-with-quotes-in-org-mode
       ("%" (underline :foreground "dark salmon"))
       (":" (underline :foreground "dark salmon"))
       ("@" (underline :foreground "cyan"))))

;; CUSTOM FONT FACE
(after! org
 (custom-set-faces!
   '(org-document-title :height 1.3)
   '(org-level-1 :inherit outline-1 :weight extra-bold :height 1.4)
   '(org-level-2 :inherit outline-2 :weight bold :height 1.15)
   '(org-level-3 :inherit outline-3 :weight bold :height 1.12)
   '(org-level-4 :inherit outline-4 :weight bold :height 1.09)
   '(org-level-5 :inherit outline-5 :weight semi-bold :height 1.06)
   '(org-level-6 :inherit outline-6 :weight semi-bold :height 1.03)
   '(org-level-7 :inherit outline-7 :weight semi-bold)
   '(org-level-8 :inherit outline-8 :weight semi-bold)
   ;; Ensure that anything that should be fixed-pitch in org buffers appears that way
   '(org-block nil :foreground nil :inherit 'fixed-pitch)
   '(org-code nil   :inherit '(shadow fixed-pitch))
   '(org-table nil   :inherit '(shadow fixed-pitch))
   '(org-verbatim nil :inherit '(shadow fixed-pitch))
   '(org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
   '(org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
   '(org-checkbox nil :inherit 'fixed-pitch)))

(use-package org-bullets
 :after org-agenda)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode t)))

(use-package org-super-agenda
 :after org-agenda
 :init
 (setq org-super-agenda-groups '((:name "Today"
                                  :time-grid t
                                  :scheduled today)
                                 (:name "Due today"
                                  :deadline today)
                                 (:name "Important"
                                  :priority "A")
                                 (:name "Overdue"
                                  :deadline past)
                                 (:name "Due soon"
                                  :deadline future)
                                 (:name "Big Outcomes"
                                  :tag "bo")))
 (org-super-agenda-mode))

(use-package org-fancy-priorities
 :ensure t
 :hook (org-mode . org-fancy-priorities-mode)
 :config
 (setq org-fancy-priorities-list '(" ⚡" "⬆" "⬇" "☕")))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(after! org
 (setq org-directory "~/org/"
       org-agenda-files (list (expand-file-name "agenda.org" org-directory)
                              (expand-file-name "work.org" org-directory)
                              (expand-file-name "my.org" org-directory)
                              (expand-file-name "learn.org" org-directory)
                              (expand-file-name "biz.org" org-directory)
                              (expand-file-name "projects.org" org-directory))
       org-default-notes-file (expand-file-name "notes.org" org-directory)
       org-log-done 'time)
 (map! :map org-mode-map
       :n "M-j" #'org-metadown
       :n "M-k" #'org-metaup)
 (setq org-bullets-bullet-list '("⎈" "✽" "✲" "✱" "✻" "✼")
       org-priority-faces '((65 :foreground "#e45649")
                            (66 :foreground "#da8548")
                            (67 :foreground "#0098dd"))
       org-todo-keywords '((sequence "TODO(t)" "PROJ(p)" "STRT(s)" "INPG(i)"
                                     "WAIT(w)" "HOLD(h)" "|" "DONE(d)" "KILL(k)"
                                     "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)"))
       org-todo-keyword-faces
       '(("[-]" . +org-todo-active)
        ("STRT" . +org-todo-active)
        ("[?]" . +org-todo-onhold)
        ("WAIT" . +org-todo-onhold)
        ("HOLD" . +org-todo-onhold)
        ("PROJ" . +org-todo-project))))

(use-package org-journal
  :ensure t
  :defer t
  :init
  :config
  (setq org-journal-enable-agenda-integration t
        org-journal-date-prefix "#+TITLE: "
        org-journal-time-prefix "* "
        org-journal-date-format "%A, %d %B %Y"
        org-journal-file-format "%Y-%m-%d.org"))

(remove-hook 'text-mode-hook #'spell-fu-mode)

(defun insert-now-timestamp()
  "Insert Org Mode timestamp ap point with current date and time."
  (interactive)
  (org-insert-time-stamp (current-time) t))

(setq yas-snippet-dirs (append yas-snippet-dirs
                               '("~/.doom.d/snippets")))

