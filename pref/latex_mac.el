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
     (setq TeX-command-default "LatexMk")))

(eval-after-load "tex-jp"
  '(progn
     (setq Japanese-LaTeX-command-default "LatexMk")
     (setq TeX-command-default "LatexMk")
     (setq TeX-view-program-list '(("Preview" "/usr/bin/open -a Preview.app %o")))
     (setq TeX-view-program-selection '((output-pdf "Preview")))
     (setq japanese-LaTeX-default-style "jsarticle")
     (dolist (command '("pTeX" "pLaTeX" "pBibTeX" "jTeX" "jLaTeX" "jBibTeX" "Mendex"))
       (delq (assoc command TeX-command-list) TeX-command-list))
     ;; latex-math-previewのcheat sheet
     (define-key LaTeX-mode-map (kbd "C-c p") 'latex-math-preview-insert-symbol)))

(setq japanese-LaTeX-command-default "LatexMk")
(setq TeX-command-default "LatexMk")




(setq preview-image-type 'dvipng)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)





;; (setq japanese-LaTeX-default-style "jsarticle")
;; (setq TeX-engine-alist '((ptex "pTeX" "ptex2pdf -e -ot \"%S %(mode)\"" "ptex2pdf -l -ot \"%S %(mode)\"" "eptex")
;;                          (uptex "upTeX" "ptex2pdf -e -u -ot \"%S %(mode)\"" "ptex2pdf -l -u -ot \"%S %(mode)\"" "euptex")))
;; (setq TeX-engine 'ptex)

;; (setq TeX-view-program-list '(("Preview" "/usr/bin/open -a Preview.app %o")
;;                               ("Skim" "/usr/bin/open -a Skim.app %o")
;;                               ("displayline" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o \"%b\"")
;;                               ("TeXShop" "/usr/bin/open -a TeXShop.app %o")
;;                               ("TeXworks" "/usr/bin/open -a TeXworks.app %o")
;;                               ("Firefox" "/usr/bin/open -a Firefox.app %o")
;;                               ("AdobeReader" "/usr/bin/open -a \"Adobe Reader.app\" %o")))
;; (setq TeX-view-program-selection '((output-pdf "Preview")))
;; (setq preview-image-type 'dvipng)
;; (setq TeX-source-correlate-method 'synctex)
;; (setq TeX-source-correlate-start-server t)
;; (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
;; (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; (add-hook 'LaTeX-mode-hook
;;           (function (lambda ()
;;                       (add-to-list 'TeX-command-list
;;                                    '("pdfpLaTeX" "/usr/texbin/platex %S %(mode) %t && /usr/texbin/dvipdfmx %d"
;;                                      TeX-run-TeX nil (latex-mode) :help "Run pLaTeX and dvipdfmx"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("pdfpLaTeX2" "/usr/texbin/platex %S %(mode) %t && /usr/texbin/dvips -Ppdf -z -f %d | /usr/texbin/convbkmk -g > %f && /usr/local/bin/ps2pdf %f"
;;                                      TeX-run-TeX nil (latex-mode) :help "Run pLaTeX, dvips, and ps2pdf"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("pdfupLaTeX" "/usr/texbin/uplatex %S %(mode) %t && /usr/texbin/dvipdfmx %d"
;;                                      TeX-run-TeX nil (latex-mode) :help "Run upLaTeX and dvipdfmx"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("pdfupLaTeX2" "/usr/texbin/uplatex %S %(mode) %t && /usr/texbin/dvips -Ppdf -z -f %d | /usr/texbin/convbkmk -u > %f && /usr/local/bin/ps2pdf %f"
;;                                      TeX-run-TeX nil (latex-mode) :help "Run upLaTeX, dvips, and ps2pdf"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("Latexmk" "/usr/texbin/latexmk %t"
;;                                      TeX-run-TeX nil (latex-mode) :help "Run Latexmk"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("Latexmk-pdfpLaTeX" "/usr/texbin/latexmk -e '$latex=q/platex %S %(mode)/' -e '$bibtex=q/pbibtex/' -e '$makeindex=q/mendex/' -e '$dvipdf=q/dvipdfmx %%O -o %%D %%S/' -norc -gg -pdfdvi %t"
;;                                      TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfpLaTeX"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("Latexmk-pdfpLaTeX2" "/usr/texbin/latexmk -e '$latex=q/platex %S %(mode)/' -e '$bibtex=q/pbibtex/' -e '$makeindex=q/mendex/' -e '$dvips=q/dvips %%O -z -f %%S | convbkmk -g > %%D/' -e '$ps2pdf=q/ps2pdf %%O %%S %%D/' -norc -gg -pdfps %t"
;;                                      TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfpLaTeX2"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("Latexmk-pdfupLaTeX" "/usr/texbin/latexmk -e '$latex=q/uplatex %S %(mode)/' -e '$bibtex=q/upbibtex/' -e '$makeindex=q/mendex/' -e '$dvipdf=q/dvipdfmx %%O -o %%D %%S/' -norc -gg -pdfdvi %t"
;;                                      TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfupLaTeX"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("Latexmk-pdfupLaTeX2" "/usr/texbin/latexmk -e '$latex=q/uplatex %S %(mode)/' -e '$bibtex=q/upbibtex/' -e '$makeindex=q/mendex/' -e '$dvips=q/dvips %%O -z -f %%S | convbkmk -u > %%D/' -e '$ps2pdf=q/ps2pdf %%O %%S %%D/' -norc -gg -pdfps %t"
;;                                      TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfupLaTeX2"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("Latexmk-pdfLaTeX" "/usr/texbin/latexmk -e '$pdflatex=q/pdflatex %S %(mode)/' -e '$bibtex=q/bibtex/' -e '$makeindex=q/makeindex/' -norc -gg -pdf %t"
;;                                      TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfLaTeX"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("Latexmk-LuaLaTeX" "/usr/texbin/latexmk -e '$pdflatex=q/lualatex %S %(mode)/' -e '$bibtex=q/bibtexu/' -e '$makeindex=q/texindy/' -norc -gg -pdf %t"
;;                                      TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaLaTeX"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("Latexmk-LuaJITLaTeX" "/usr/texbin/latexmk -e '$pdflatex=q/luajitlatex %S %(mode)/' -e '$bibtex=q/bibtexu/' -e '$makeindex=q/texindy/' -norc -gg -pdf %t"
;;                                      TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaJITLaTeX"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("Latexmk-XeLaTeX" "/usr/texbin/latexmk -e '$pdflatex=q/xelatex %S %(mode)/' -e '$bibtex=q/bibtexu/' -e '$makeindex=q/texindy/' -norc -gg -xelatex %t"
;;                                      TeX-run-TeX nil (latex-mode) :help "Run Latexmk-XeLaTeX"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("pBibTeX" "/usr/texbin/pbibtex %s"
;;                                      TeX-run-BibTeX nil t :help "Run pBibTeX"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("upBibTeX" "/usr/texbin/upbibtex %s"
;;                                      TeX-run-BibTeX nil t :help "Run upBibTeX"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("BibTeXu" "/usr/texbin/bibtexu %s"
;;                                      TeX-run-BibTeX nil t :help "Run BibTeXu"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("Mendex" "/usr/texbin/mendex %s"
;;                                      TeX-run-command nil t :help "Create index file with mendex"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("Preview" "/usr/bin/open -a Preview.app %s.pdf"
;;                                      TeX-run-discard-or-function t t :help "Run Preview"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("Skim" "/usr/bin/open -a Skim.app %s.pdf"
;;                                      TeX-run-discard-or-function t t :help "Run Skim"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("displayline" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %s.pdf \"%b\""
;;                                      TeX-run-discard-or-function t t :help "Forward search with Skim"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("TeXShop" "/usr/bin/open -a TeXShop.app %s.pdf"
;;                                      TeX-run-discard-or-function t t :help "Run TeXShop"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("TeXworks" "/usr/bin/open -a TeXworks.app %s.pdf"
;;                                      TeX-run-discard-or-function t t :help "Run TeXworks"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("Firefox" "/usr/bin/open -a Firefox.app %s.pdf"
;;                                      TeX-run-discard-or-function t t :help "Run Mozilla Firefox"))
;;                       (add-to-list 'TeX-command-list
;;                                    '("AdobeReader" "/usr/bin/open -a \"Adobe Reader.app\" %s.pdf"
;;                                      TeX-run-discard-or-function t t :help "Run Adobe Reader")))))

;;
;; RefTeX with AUCTeX
;;
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;;
;; kinsoku.el
;;
(setq kinsoku-limit 10)


(provide 'latex_mac)
