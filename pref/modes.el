;; 様々なモードの毎の設定


;; htmlモードでインデント幅を4に
(add-hook
 'sgml-mode-hook
 (lambda ()
   (setq
    sgml-basic-offset 4
    )))
(setq indent-tabs-mode t)

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

;; rubyモード
(add-hook 'ruby-mode-hook
          'ruby-end-mode)
;; ruby-block (rubyで対応するendをハイライト)
(require 'ruby-block)
(ruby-block-mode t)
;; ミニバッファに表示し, かつ, オーバレイする.
(setq ruby-block-highlight-toggle t)

;; haskell-mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(add-hook 'haskell-mode-hook 'imenu-add-menubar-index)

;; mikutterモード
(require 'mikutter)

;; lilypondモード
(load "lilypond-init.el")
;; pdfのプレビュー
(defun LilyPond-pdf-view ()
  (interactive)
  (shell-command
   (concat "filename=" (buffer-file-name) "; open ${filename%.*}.pdf")))
(eval-after-load "lilypond-mode"
  '(define-key LilyPond-mode-map (kbd "C-c C-v") 'LilyPond-pdf-view))
;; <>をsmartparensで補完
(eval-after-load "LilyPond-mode"
  '(sp-pair "<" ">"))

(provide 'modes)
