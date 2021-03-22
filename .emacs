
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(set-frame-font "Consolas 16")
(add-to-list 'load-path "/usr/bin/julia")
(add-to-list 'load-path "~/.emacs.d/julia-repl")
(add-to-list 'load-path "~/.emacs.d/highlight-numbers")
(add-to-list 'load-path "~/.emacs.d/parent-mode")
(add-to-list 'load-path "~/.emacs.d/markdown-mode")
(add-to-list 'load-path "~/.emacs.d/projectile")
(add-to-list 'load-path "~/.emacs.d/dash.el")
(add-to-list 'load-path "~/.emacs.d/ov")
(add-to-list 'load-path "~/.emacs.d/frame-local")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;(add-to-list 'load-path "~/.emacs.d/sidebar.el")

(load-theme 'zenburn t)
(require 'julia-mode)
(require 'julia-repl)
(require 'highlight-numbers)

(global-display-line-numbers-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(add-hook 'julia-mode-hook 'julia-repl-mode) 

(add-to-list 'load-path "~/.local/share/icons-in-terminal/")
(require 'icons-in-terminal)
;(require 'sidebar)

(insert (icons-in-terminal 'oct_flame)) 
;(global-set-key (kbd "C-x C-f") 'sidebar-open)
;(global-set-key (kbd "C-x C-a") 'sidebar-buffers-open)
(global-auto-revert-mode t)
(setq doc-view-resolution 300)

;(setq  x-meta-keysym 'super
;       x-super-keysym 'meta)

(setq inhibit-splash-screen t)

(add-hook 'prog-mode-hook 'highlight-numbers-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(defun julia-repl-send-buffer-save (arg)
  (interactive "P")
  (let* ((file (and (not arg) buffer-file-name)))
    (when (and file (buffer-modified-p))
          (save-buffer))
    (julia-repl--send-string
     (if file
         (concat "@time include(\""
                 (julia-repl--path-rewrite file julia-repl-path-rewrite-rules)
                 "\");")
       (buffer-substring-no-properties (point-min) (point-max))))))

(global-set-key (kbd "<C-S-return>") 'julia-repl-send-buffer-save)
(global-set-key (kbd "<C-enter>") 'julia-repl-send-buffer-save)


(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(setq markdown-command "pandoc")
