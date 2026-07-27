;; ============================================================
;; 0. PACKAGE SYSTEM - must come first
;; ============================================================
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; ============================================================
;; 1. UI CLEANUP
;; ============================================================
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(message "init.el loaded")

;; ============================================================
;; 2. EVIL
;; ============================================================
(require 'evil)
(evil-mode 1)

;; ============================================================
;; 3. EDITOR SETTINGS
;; ============================================================
(setenv "PATH" (concat "C:/Program Files/LLVM/bin;" (getenv "PATH")))
(setq compilation-scroll-output t)
(setq auto-mode-alist
      (append '(("\\.c\\'" . c-mode))
              auto-mode-alist))
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(cd "D:/hackkerank_stuff/C/")
(setq default-directory "D:/hackkerank_stuff/C/")
(setq command-line-default-directory "D:/hackkerank_stuff/C/")
(setq backup-directory-alist `(("." . "~/.emacs.d/backups/")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs.d/backups/" t)))
(setq create-lockfiles nil)
(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(font-lock-add-keywords 'c-mode
  '(("\\<\\(strcpy\\|gets\\|sprintf\\|strcat\\)\\>" . font-lock-warning-face)))
(setq compilation-window-height 12)

(add-to-list 'display-buffer-alist
             '("\\*compilation\\*"
               (display-buffer-reuse-window display-buffer-at-bottom)
               (window-height . 8)))

;; ============================================================
;; 4. KEYBINDINGS
;; ============================================================
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "SPC") nil)
  ;; SPC c -> compile current file dynamically
  (define-key evil-normal-state-map (kbd "SPC c")
    (lambda ()
      (interactive)
      (save-some-buffers t)
      (let* ((file (buffer-file-name))
             (base (file-name-sans-extension (file-name-nondirectory file)))
             (cmd  (format "clang-cl %s /Zi /Od /Fe:%s.exe" file base)))
        (compile cmd))))
  (define-key evil-normal-state-map (kbd "SPC f") 'find-file)
  (define-key evil-normal-state-map (kbd "SPC b") 'switch-to-buffer)
  (define-key evil-normal-state-map (kbd "SPC s") 'save-buffer)
  (define-key evil-normal-state-map (kbd "SPC d") 'gdb)
  (define-key evil-normal-state-map (kbd "SPC i")
    (lambda () (interactive)
      (find-file "~/.emacs.d/init.el"))))

;; ============================================================
;; 5. RECENT FILES
;; ============================================================
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 20)

;; ============================================================
;; 6. DASHBOARD
;; ============================================================
(setq dashboard-banner-logo-title "SYSTEM READY - SECURITY RESEARCH LAB")
(setq dashboard-startup-banner 'official)
(setq dashboard-set-heading-icons nil)
(setq dashboard-set-file-icons    nil)
(setq dashboard-footer-messages '("SYSTEM READY"))
(setq dashboard-items '((recents . 10)))
(require 'dashboard)
(dashboard-setup-startup-hook)
(with-eval-after-load 'dashboard
  (define-key dashboard-mode-map (kbd "SPC") nil))

(add-to-list 'default-frame-alist '(font . "Cascadia Mono-8"))
