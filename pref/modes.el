;; 様々なモードの毎の設定


;; ; html-mode
;; (add-hook 'html-mode-hook
;; (lambda ()
;; (setq indent-tabs-mode t)
;; (setq tab-width 4)))

                                        ; Tclモード
;; (add-hook 'html-mode-hook '(lambda () (setq tab-width 4)))
;; (setq c-basic-offset 4)

;; htmlモードでインデント幅を4に
(add-hook
 'sgml-mode-hook
 (lambda ()
   (setq
    sgml-basic-offset 4
    )))
(setq indent-tabs-mode t)

;; ;; htmlモードのオートインデントをやめる
;; (add-hook 'html-mode-hook
;;           '(lambda ()
;;              (global-set-key "\C-m" 'newline)
;;              ))

;; asymptoteモード
(autoload 'asy-mode "asy-mode.el" "Asymptote major mode." t)
(autoload 'lasy-mode "asy-mode.el" "hybrid Asymptote/Latex major mode." t)
(autoload 'asy-insinuate-latex "asy-mode.el" "Asymptote insinuate LaTeX." t)
(add-to-list 'auto-mode-alist '("\\.asy$" . asy-mode))
(add-hook 'asy-mode-hook
          '(lambda ()
             (local-set-key [f5] 'asy-compile)
             (setq c-basic-offset 4)))

;; c-mode, c++-mode
(add-hook 'c-mode-common-hook
          '(lambda ()
             ;;; K&R のスタイルを使う
             (c-set-style "k&r")
             ;;; インデントには tab を使う
             (setq indent-tabs-mode t)
             ;;; インデント幅
             (setq c-basic-offset 4)
             ))

;; 2012-03-18
;; emacs-lisp-modeでバッファーを開いたときに行う設定
(add-hook
 'emacs-lisp-mode-hook
 '(lambda ()
   ;; スペースでインデントをする
   (setq indent-tabs-mode nil)
   (setq indent-level 4)
   ))

;; ;; fortranモード
;; (add-hook 'fortran-mode-hook
;;           '(lambda ()
;;             (setq fortran-do-indent 4)
;;             (setq fortran-if-indent 4)
;;             (setq fortran-structure-indent 4)
;;             (setq fortran-continuation-indent 4)))

;; ;; f90モード
;; (add-hook 'f90-mode-hook
;;           '(lambda () (setq f90-do-indent 4
;;                             f90-if-indent 4
;;                             f90-type-indent 4
;;                             f90-program-indent 4
;;                             f90-continuation-indent 4
;;                             f90-comment-region "!!$"
;;                             f90-directive-comment-re "!hpf\\$"
;;                             f90-indented-comment-re "!"
;;                             f90-break-delimiters "[-+\\*/,><=% \t]"
;;                             f90-break-before-delimiters t
;;                             f90-beginning-ampersand t
;;                             f90-smart-end 'blink
;;                             f90-auto-keyword-case nil
;;                             f90-leave-line-no  nil
;;                             f90-startup-message t
;;                             indent-tabs-mode t
;;                             f90-font-lock-keywords f90-font-lock-keywords-2)))
;;              ;; ;;The rest is not default.
;;              ;; (abbrev-mode 1)             ; turn on abbreviation mode
;;              ;; (f90-add-imenu-menu)        ; extra menu with functions etc.
;;              ;; (if f90-auto-keyword-case   ; change case of all keywords on startup
;;              ;;     (f90-change-keywords f90-auto-keyword-case))

;; Textモード
;; 空白を削除しない
(remove-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'modes)
