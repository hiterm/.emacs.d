;; termの設定


;; multi-term
(require 'multi-term)
(setq multi-term-program shell-file-name)
(setq locale-coding-system 'utf-8)


;; PATHの設定
;; より下に記述した物が PATH の先頭に追加されます
(dolist (dir (list
              "/Users/ht/Documents/bin"
              "/Applications/Ghostscript.app"
              "/usr/local/sbin"
              "/usr/texbin"
              "/opt/X11/bin"
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))
 ;; PATH と exec-path に同じ物を追加します
 (when (and (file-exists-p dir) (not (member dir exec-path)))
   (setenv "PATH" (concat dir ":" (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path))))

;; MANPATHの設定
(setenv "MANPATH" (concat "/usr/local/man:/usr/share/man:/Developer/usr/share/man:/sw/share/man" (getenv "MANPATH")))

;; shell の存在を確認
(defun skt:shell ()
  (or (executable-find "bash")
      (executable-find "zsh")
      ;; (executable-find "f_zsh") ;; Emacs + Cygwin を利用する人は Zsh の代りにこれにしてください
      ;; (executable-find "f_bash") ;; Emacs + Cygwin を利用する人は Bash の代りにこれにしてください
      (executable-find "cmdproxy")
      (error "can't find 'shell' command in PATH!!")))

;; Shell 名の設定
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

;; multi-termの設定
(add-hook 'term-mode-hook
          '(lambda ()
             (hl-line-mode -1)
             (setq show-trailing-whitespace nil)
             ))

;; ;; shell-popの設定
;; (require 'shell-pop)
;; (add-to-list 'shell-pop-internal-mode-list '("multi-term" "*terminal<1>*" '(lambda () (multi-term))))
;; (shell-pop-set-internal-mode "multi-term")
;; (shell-pop-set-internal-mode-shell "/bin/bash")
;; (shell-pop-set-window-height 60) ;the number for the percentage of the selected window. if 100, shell-pop use the whole of selected window, not spliting.
;; (shell-pop-set-window-position "bottom") ;shell-pop-up position. You can choose "top" or "bottom".
;; (global-set-key [f8] 'shell-pop)


(provide 'terminal)
