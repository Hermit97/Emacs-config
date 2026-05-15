;; UI cleanup
;; hides the main screen on start up. (setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(message "init.el loaded")

;; Better scrolling in compile buffer
(setq compilation-scroll-output t)

;; Treat .c files as C mode
(setq auto-mode-alist
      (append '(("\\.c\\'" . c-mode))
              auto-mode-alist))

;; Simple compile command for Windows (clang-cl)
(setq-default compile-command "clang-cl main.c /Zi /Od /Fe:main.exe")

;; Enable line numbers for programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(require 'evil)
(evil-mode 1)

;; 1. Force Emacs to move to your project folder on startup
(cd "D:/hackkerank_stuff/C/")

;; 2. Ensure all new buffers look there by default
(setq default-directory "D:/hackkerank_stuff/C/")

;; 3. Set the startup screen to also recognize this path
(setq command-line-default-directory "D:/hackkerank_stuff/C/")

;; Keep backup files in a dedicated directory
(setq backup-directory-alist `(("." . "~/.emacs.d/backups/")))

;; Also move "Auto-save" files (the ones like #main.c#)
(setq auto-save-file-name-transforms `((".*" "~/.emacs.d/backups/" t)))

;; Don't clutter the OS with lock files (the .#main.c files)
(setq create-lockfiles nil)

;;c formatting
(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil) ;; Use spaces, not tabs, for consistency

;;Tells me if im using scary functions
(font-lock-add-keywords 'c-mode
  '(("\\<\\(strcpy\\|gets\\|sprintf\\|strcat\\)\\>" . font-lock-warning-face)))

;;Changed leader from ctrl to space for compile, find file, debug, switch buffer
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "SPC") nil)

  ;; SPC c -> SAVE and COMPILE (Matches your F5 logic)
  (define-key evil-normal-state-map (kbd "SPC c") 
    (lambda () 
      (interactive) 
      (save-some-buffers t) 
      (compile compile-command)))

  ;; SPC f -> Find File
  (define-key evil-normal-state-map (kbd "SPC f") 'find-file)

  ;; SPC b -> Switch Buffer
  (define-key evil-normal-state-map (kbd "SPC b") 'switch-to-buffer)

  ;; SPC s -> Save current file only
  (define-key evil-normal-state-map (kbd "SPC s") 'save-buffer)

  ;; SPC d -> Debug (Pointed to Windows-friendly command)
  (define-key evil-normal-state-map (kbd "SPC d") 'gdb))

;; --- FINAL CLEAN DASHBOARD CONFIG ---

;; 1. Initialize Packages
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; 2. Enable Recent Files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 20)

;; 3. Dashboard Settings
(setq dashboard-banner-logo-title "SYSTEM READY - SECURITY RESEARCH LAB")
(setq dashboard-startup-banner 'official)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-navigator t)

;; 4. Define the Buttons (Using 'list' to prevent the 'void: nil' error)
(setq dashboard-navigator-buttons
      (list
       (list
        (list nil "Open init.el" "Edit config"
              (lambda (&rest _) (find-file "c:/Users/shawn/AppData/Roaming/.emacs.d/init.el")))
        (list nil "C: Projects" "Jump to Lab"
              (lambda (&rest _) (find-file "D:/hackkerank_stuff/C/"))))))

;; 5. Choose Sections (Navigator first, then Recents)
(setq dashboard-items '((navigator . 2)
                        (recents   . 10)))

;; 6. Start it up
(require 'dashboard)
(dashboard-setup-startup-hook)

;; 7. Spacebar Logic (Cleaned up to prevent crashes)
(with-eval-after-load 'dashboard
  (define-key dashboard-mode-map (kbd "SPC") nil))