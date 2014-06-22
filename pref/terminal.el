;; termの設定


;; multi-term
(require 'multi-term)
(setq multi-term-program shell-file-name)
(setq locale-coding-system 'utf-8)

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
