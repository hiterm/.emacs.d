;; 様々なモードの毎の設定


;; htmlモードでインデント幅を4に
(add-hook
 'sgml-mode-hook
 (lambda ()
   (setq
    sgml-basic-offset 4
    )))

;; c-mode, c++-mode
(add-hook 'c-mode-common-hook
          '(lambda ()
             ;;; K&R のスタイルを使う
             (c-set-style "k&r")
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

;; シェルスクリプトモード
(add-hook 'sh-mode-hook
          '(lambda ()
             (setq sh-basic-offset 2
                   sh-indentation 2
                   indent-tabs-mode nil)))

;; ;; f90モード
(add-hook 'before-save-hook
          'delete-trailing-whitespace
          'trim-eob)
(add-hook 'f90-mode-hook
          '(lambda () (add-hook 'before-save-hook
                                'delete-trailing-whitespace
                                'trim-eob)))

;; Textモード
;; 空白を削除しない
(add-hook 'text-mode-hook
          '(lambda ()
             (remove-hook 'before-save-hook
                          'delete-trailing-whitespace)))
;; (remove-hook 'before-save-hook 'delete-trailing-whitespace)

;; haskell-mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(add-hook 'haskell-mode-hook 'imenu-add-menubar-index)

;; mikutterモード
(require 'mikutter)

;; lilypondモード
(when (file-exists-p "/usr/local/share/emacs/site-lisp/lilypond-init.el")
  (load "lilypond-init.el"))
;; pdfのプレビュー
(defun LilyPond-pdf-view ()
  (interactive)
  (shell-command
   (concat "filename=" (buffer-file-name) "; open ${filename%.*}.pdf")))
(eval-after-load "lilypond-mode"
  '(define-key LilyPond-mode-map (kbd "C-c C-v") 'LilyPond-pdf-view))
;; <>をsmartparensで補完
(sp-local-pair 'LilyPond-mode "<" ">")

;; tuareg-mode ocamlのモード
(eval-after-load "tuareg-mode"
  '(progn
     ;; Indent `=' like a standard keyword.
     (setq tuareg-lazy-= t)
     ;; Indent [({ like standard keywords.
     (setq tuareg-lazy-paren t)
     ;; No indentation after `in' keywords.
     (setq tuareg-in-indent 0)))


(provide 'init-mode)
