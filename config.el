;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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


(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell (executable-find "fish"))
(setq-default explicit-shell-file-name (executable-find "fish"))



;;golang
(setq lsp-gopls-staticcheck t)
(setq lsp-eldoc-render-all t)
(setq lsp-gopls-complete-unimported t)
(setq lsp-gopls-codelens nil)
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Optional - provides fancier overlays.
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; Company mode is a standard completion package that works well with lsp-mode.
(use-package company
  :ensure t
  :config
  ;; Optionally enable completion-as-you-type behavior.
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

;; Optional - provides snippet support.
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))


;; sort-tab配置
(use-package! sort-tab
  :config
  (sort-tab-mode))

;; window-numbering
(use-package! window-numbering
  :config
  (window-numbering-mode))


(map! :leader
      (:prefix "w"
       :desc "选择窗口2" "2" #'select-window-2
       :desc "选择窗口3" "3" #'select-window-3
       :desc "选择窗口4" "4" #'select-window-4
       :desc "选择窗口5" "5" #'select-window-5
       :desc "选择窗口6" "6" #'select-window-6
       )
      (:prefix "f"
       :desc "Open emacs config.el" "o" #'doom/goto-private-config-file
       )
      )

(map! :leader
      (:prefix ("r" . "Rustic")
       :desc "rustic cargo run" "r" #'rustic-cargo-run
       :desc "rustic recompile" "TAB" #'rustic-recompile
       :desc "rustic cargo add" "a" #'rustic-cargo-add
       :desc "rustic cargo bench" "B" #'rustic-cargo-bench
       :desc "rustic cargo clean" "C" #'rustic-cargo-clean
       :desc "rustic cargo doc" "d" #'rustic-cargo-doc
       :desc "rustic cargo clippy fix" "F" #'rustic-cargo-clippy-fix
       :desc "rustic cargo init" "i" #'rustic-cargo-init
       :desc "rustic cargo clippy" "k" #'rustic-cargo-clippy
       :desc "rustic cargo new" "n" #'rustic-cargo-new
       :desc "rustic cargo rm" "R" #'rustic-cargo-rm
       :desc "rustic cargo upgrade" "u" #'rustic-cargo-upgrade
       :desc "rustic docstring dwim" "," #'rustic-docstring-dwim
       :desc "rustic cargo build" "b" #'rustic-cargo-build
       :desc "rustic cargo current test" "c" #'rustic-cargo-current-test
       :desc "rustic racer describe" "D" #'rustic-racer-describe
       :desc "rustic cargo format" "f" #'rustic-cargo-fmt
       :desc "rustic cargo check" "K" #'rustic-cargo-check
       :desc "rustic cargo clippy" "l" #'rustic-cargo-clippy

       )
      )
