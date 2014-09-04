;; latex-modeの設定


;; latex-math-previewのautoload
(autoload 'latex-math-preview-expression "latex-math-preview" nil t)
(autoload 'latex-math-preview-insert-symbol "latex-math-preview" nil t)
(autoload 'latex-math-preview-save-image-file "latex-math-preview" nil t)
(autoload 'latex-math-preview-beamer-frame "latex-math-preview" nil t)

;;
;; AUCTeX
;;

;; Automatic Parsing of TeX files.
(setq TeX-parse-self t)  ; ファイルを開いた時に自動パース
;; (setq TeX-auto-save  t)  ; パースしたデータを保存する

;; デフォルトをjapanese-latex-modeに
(setq TeX-default-mode 'japanese-latex-mode)

;; latexmk
(auctex-latexmk-setup)

;; auto-complete
(require 'auto-complete-auctex)

;; preview-latexで画像の場所がおかしい不具合を修正
(setq TeX-japanese-process-input-coding-system 'utf-8
      TeX-japanese-process-output-coding-system 'utf-8)

(eval-after-load "tex"
  '(progn
     (setq TeX-command-default "LatexMk")
     (setq TeX-view-program-list '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %s.pdf \"%b\"")))
     (setq TeX-view-program-selection '((output-dvi "Skim")
                                        (output-pdf "Skim")))
     (define-key LaTeX-mode-map (kbd "C-c j") 'latex-math-preview-insert-symbol)))

(eval-after-load "tex-jp"
  '(progn
     (setq Japanese-LaTeX-command-default "LatexMk")
     (setq TeX-command-default "LatexMk")
     (setq TeX-view-program-list '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %s.pdf \"%b\"")))
     (setq TeX-view-program-selection '((output-dvi "Skim")
                                        (output-pdf "Skim")))
     (setq japanese-LaTeX-default-style "jsarticle")
     (dolist (command '("pTeX" "pLaTeX" "pBibTeX" "jTeX" "jLaTeX" "jBibTeX" "Mendex"))
       (delq (assoc command TeX-command-list) TeX-command-list))
     ;; latex-math-previewのcheat sheet
     (define-key LaTeX-mode-map (kbd "C-c j") 'latex-math-preview-insert-symbol)))

;; (setq japanese-LaTeX-command-default "LatexMk")
;; (setq TeX-command-default "LatexMk")



(setq preview-image-type 'dvipng)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)


;;
;; RefTeX with AUCTeX
;;
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(setq reftex-label-alist
      '(("theorem" ?h "thm:" "\\ref{%s}" nil ())
        ("definition" ?d "def:" "\\ref{%s}" nil ())
        ("lemma" ?l "lem:" "\\ref{%s}" nil ())
        ("proposition" ?p "prop:" "\\ref{%s}" nil ())
        ("remark" ?r "rem:" "\\ref{%s}" nil ())
        ("corollary" ?c "cor:" "\\ref{%s}" nil ())
        ("example" ?x "ex:" "\\ref{%s}"nil ())
        (nil ?e nil "\\eqref{%s}" nil nil)))

(add-hook 'LaTeX-mode-hook
          '(lambda ()
             '("theorem" LaTeX-env-label)
             '("definition" LaTeX-env-label)
             '("lemma" LaTeX-env-label)
             '("proposition" LaTeX-env-label)
             '("remark" LaTeX-env-label)
             '("corollary" LaTeX-env-label)
             '("example" LaTeX-env-label)))

;;
;; kinsoku.el
;;
(setq kinsoku-limit 10)

;; punch.el
;; latex-modeで句読点をピリオド・カンマに変換
(require 'punch)
(add-hook 'LaTeX-mode-hook 'punch-mode)

;; smartparens
(sp-with-modes '(
                 tex-mode
                 plain-tex-mode
                 latex-mode
                 )
  (sp-local-pair "\\[" nil :actions :rem)
  (sp-local-pair "\\[" "\\]"
               :unless '(sp-latex-point-after-backslash)
               :post-handlers '(sp-latex-insert-spaces-inside-pair))
  (sp-local-pair "|" "|"))

(provide 'latex_mac)
