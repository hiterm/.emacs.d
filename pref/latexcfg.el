;; latex-modeの設定

;; Homebrewに言われた
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(require 'tex-site)
;; AUCTeXのload
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;;
;; AUCTeX
;;
(setq japanese-LaTeX-default-style "jsarticle")
;; (setq TeX-engine-alist '((ptex "pTeX" "ptex2pdf -e -ot \"%S %(mode)\"" "ptex2pdf -l -ot \"%S %(mode)\"" "eptex")
;;                          (uptex "upTeX" "ptex2pdf -e -u -ot \"%S %(mode)\"" "ptex2pdf -l -u -ot \"%S %(mode)\"" "euptex")))
;; (setq TeX-engine 'ptex)
(setq TeX-view-program-list '(("Preview" "/usr/bin/open -a Preview.app %o")
                              ("Skim" "/usr/bin/open -a Skim.app %o")
                              ("displayline" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o \"%b\"")
                              ("TeXShop" "/usr/bin/open -a TeXShop.app %o")
                              ("TeXworks" "/usr/bin/open -a TeXworks.app %o")
                              ("Firefox" "/usr/bin/open -a Firefox.app %o")
                              ("AdobeReader" "/usr/bin/open -a \"Adobe Reader.app\" %o")))
(setq TeX-view-program-selection '((output-pdf "Preview")))
(setq preview-image-type 'dvipng)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook
          (function (lambda ()
                      (add-to-list 'TeX-command-list
                                   '("pdfpLaTeX" "/usr/texbin/platex %S %(mode) %t && /usr/texbin/dvipdfmx %d"
                                     TeX-run-TeX nil (latex-mode) :help "Run pLaTeX and dvipdfmx"))
                      (add-to-list 'TeX-command-list
                                   '("pdfpLaTeX2" "/usr/texbin/platex %S %(mode) %t && /usr/texbin/dvips -Ppdf -z -f %d | /usr/texbin/convbkmk -g > %f && /usr/local/bin/ps2pdf %f"
                                     TeX-run-TeX nil (latex-mode) :help "Run pLaTeX, dvips, and ps2pdf"))
                      (add-to-list 'TeX-command-list
                                   '("pdfupLaTeX" "/usr/texbin/uplatex %S %(mode) %t && /usr/texbin/dvipdfmx %d"
                                     TeX-run-TeX nil (latex-mode) :help "Run upLaTeX and dvipdfmx"))
                      (add-to-list 'TeX-command-list
                                   '("pdfupLaTeX2" "/usr/texbin/uplatex %S %(mode) %t && /usr/texbin/dvips -Ppdf -z -f %d | /usr/texbin/convbkmk -u > %f && /usr/local/bin/ps2pdf %f"
                                     TeX-run-TeX nil (latex-mode) :help "Run upLaTeX, dvips, and ps2pdf"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk" "/usr/texbin/latexmk %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-pdfpLaTeX" "/usr/texbin/latexmk -e '$latex=q/platex %S %(mode)/' -e '$bibtex=q/pbibtex/' -e '$makeindex=q/mendex/' -e '$dvipdf=q/dvipdfmx %%O -o %%D %%S/' -norc -gg -pdfdvi %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfpLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-pdfpLaTeX2" "/usr/texbin/latexmk -e '$latex=q/platex %S %(mode)/' -e '$bibtex=q/pbibtex/' -e '$makeindex=q/mendex/' -e '$dvips=q/dvips %%O -z -f %%S | convbkmk -g > %%D/' -e '$ps2pdf=q/ps2pdf %%O %%S %%D/' -norc -gg -pdfps %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfpLaTeX2"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-pdfupLaTeX" "/usr/texbin/latexmk -e '$latex=q/uplatex %S %(mode)/' -e '$bibtex=q/upbibtex/' -e '$makeindex=q/mendex/' -e '$dvipdf=q/dvipdfmx %%O -o %%D %%S/' -norc -gg -pdfdvi %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfupLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-pdfupLaTeX2" "/usr/texbin/latexmk -e '$latex=q/uplatex %S %(mode)/' -e '$bibtex=q/upbibtex/' -e '$makeindex=q/mendex/' -e '$dvips=q/dvips %%O -z -f %%S | convbkmk -u > %%D/' -e '$ps2pdf=q/ps2pdf %%O %%S %%D/' -norc -gg -pdfps %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfupLaTeX2"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-pdfLaTeX" "/usr/texbin/latexmk -e '$pdflatex=q/pdflatex %S %(mode)/' -e '$bibtex=q/bibtex/' -e '$makeindex=q/makeindex/' -norc -gg -pdf %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-LuaLaTeX" "/usr/texbin/latexmk -e '$pdflatex=q/lualatex %S %(mode)/' -e '$bibtex=q/bibtexu/' -e '$makeindex=q/texindy/' -norc -gg -pdf %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-LuaJITLaTeX" "/usr/texbin/latexmk -e '$pdflatex=q/luajitlatex %S %(mode)/' -e '$bibtex=q/bibtexu/' -e '$makeindex=q/texindy/' -norc -gg -pdf %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaJITLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-XeLaTeX" "/usr/texbin/latexmk -e '$pdflatex=q/xelatex %S %(mode)/' -e '$bibtex=q/bibtexu/' -e '$makeindex=q/texindy/' -norc -gg -xelatex %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-XeLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("pBibTeX" "/usr/texbin/pbibtex %s"
                                     TeX-run-BibTeX nil t :help "Run pBibTeX"))
                      (add-to-list 'TeX-command-list
                                   '("upBibTeX" "/usr/texbin/upbibtex %s"
                                     TeX-run-BibTeX nil t :help "Run upBibTeX"))
                      (add-to-list 'TeX-command-list
                                   '("BibTeXu" "/usr/texbin/bibtexu %s"
                                     TeX-run-BibTeX nil t :help "Run BibTeXu"))
                      (add-to-list 'TeX-command-list
                                   '("Mendex" "/usr/texbin/mendex %s"
                                     TeX-run-command nil t :help "Create index file with mendex"))
                      (add-to-list 'TeX-command-list
                                   '("Preview" "/usr/bin/open -a Preview.app %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run Preview"))
                      (add-to-list 'TeX-command-list
                                   '("Skim" "/usr/bin/open -a Skim.app %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run Skim"))
                      (add-to-list 'TeX-command-list
                                   '("displayline" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %s.pdf \"%b\""
                                     TeX-run-discard-or-function t t :help "Forward search with Skim"))
                      (add-to-list 'TeX-command-list
                                   '("TeXShop" "/usr/bin/open -a TeXShop.app %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run TeXShop"))
                      (add-to-list 'TeX-command-list
                                   '("TeXworks" "/usr/bin/open -a TeXworks.app %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run TeXworks"))
                      (add-to-list 'TeX-command-list
                                   '("Firefox" "/usr/bin/open -a Firefox.app %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run Mozilla Firefox"))
                      (add-to-list 'TeX-command-list
                                   '("AdobeReader" "/usr/bin/open -a \"Adobe Reader.app\" %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run Adobe Reader")))))

;;
;; RefTeX with AUCTeX
;;
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;;
;; kinsoku.el
;;
(setq kinsoku-limit 10)






;; ;; yatexの設定
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/yatex")
;; (autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;; (setq auto-mode-alist
;;       (append '(("\\.tex$" . yatex-mode)
;;                 ("\\.ltx$" . yatex-mode)
;;                 ("\\.cls$" . yatex-mode)
;;                 ("\\.sty$" . yatex-mode)
;;                 ("\\.clo$" . yatex-mode)
;;                 ("\\.bbl$" . yatex-mode)) auto-mode-alist))
;; (setq YaTeX-inhibit-prefix-letter t)
;; (setq YaTeX-kanji-code nil)
;; (setq YaTeX-use-LaTeX2e t)
;; (setq YaTeX-use-AMS-LaTeX t)
;; (setq YaTeX-dvi2-command-ext-alist
;;       '(("[agx]dvi\\|PictPrinter" . ".dvi")
;;         ("gv" . ".ps")
;;         ("Preview\\|TeXShop\\|TeXworks\\|Skim\\|mupdf\\|xpdf\\|Firefox\\|Adobe" . ".pdf")))
;; (setq tex-command "/usr/texbin/ptex2pdf -l -ot \"-synctex=1\"")
;; (setq bibtex-command (cond ((string-match "uplatex\\|-u" tex-command) "/usr/texbin/upbibtex")
;;                            ((string-match "platex" tex-command) "/usr/texbin/pbibtex")
;;                            ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "/usr/texbin/bibtexu")
;;                            ((string-match "pdflatex\\|latex" tex-command) "/usr/texbin/bibtex")
;;                            (t "/usr/texbin/pbibtex")))
;; (setq makeindex-command (cond ((string-match "uplatex\\|-u" tex-command) "/usr/texbin/mendex")
;;                               ((string-match "platex" tex-command) "/usr/texbin/mendex")
;;                               ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "/usr/texbin/texindy")
;;                               ((string-match "pdflatex\\|latex" tex-command) "/usr/texbin/makeindex")
;;                               (t "/usr/texbin/mendex")))
;; (setq dvi2-command "/usr/bin/open -a Preview")
;; ;(setq dvi2-command "/usr/bin/open -a Skim")
;; ;(setq dvi2-command "/usr/bin/open -a TeXShop")
;; ;(setq dvi2-command "/usr/bin/open -a TeXworks")
;; (setq dviprint-command-format "/usr/bin/open -a \"Adobe Reader\" `echo %s | sed -e \"s/\\.[^.]*$/\\.pdf/\"`")

;; (defun skim-forward-search ()
;;   (interactive)
;;   (let* ((ctf (buffer-name))
;;          (mtf)
;;          (pf)
;;          (ln (format "%d" (line-number-at-pos)))
;;          (cmd "/Applications/Skim.app/Contents/SharedSupport/displayline")
;;          (args))
;;     (if (YaTeX-main-file-p)
;;         (setq mtf (buffer-name))
;;       (progn
;;         (if (equal YaTeX-parent-file nil)
;;             (save-excursion
;;               (YaTeX-visit-main t)))
;;         (setq mtf YaTeX-parent-file)))
;;     (setq pf (concat (car (split-string mtf "\\.")) ".pdf"))
;;     (setq args (concat ln " " pf " " ctf))
;;     (message (concat cmd " " args))
;;     (process-kill-without-query
;;      (start-process-shell-command "displayline" nil cmd args))))

;; (add-hook 'yatex-mode-hook
;;           '(lambda ()
;;              (define-key YaTeX-mode-map (kbd "C-c s") 'skim-forward-search)))

;; (add-hook 'yatex-mode-hook
;;           '(lambda ()
;;              (auto-fill-mode -1)))

;; ;; latex-math-preview
;; (autoload 'latex-math-preview-expression "latex-math-preview" nil t)
;; (autoload 'latex-math-preview-insert-symbol "latex-math-preview" nil t)
;; (autoload 'latex-math-preview-save-image-file "latex-math-preview" nil t)
;; (autoload 'latex-math-preview-beamer-frame "latex-math-preview" nil t)

;; (add-hook 'yatex-mode-hook
;; '(lambda ()
;;    (local-set-key (kbd "C-c p") 'latex-math-preview-expression)
;;    (local-set-key (kbd "C-c C-p") 'latex-math-preview-save-image-file)
;;    (local-set-key (kbd "C-c j") 'latex-math-preview-insert-symbol)
;;    (local-set-key (kbd "C-c C-j") 'latex-math-preview-last-symbol-again)
;;    (local-set-key (kbd "C-c b") 'latex-math-preview-beamer-frame)))
;; (setq latex-math-preview-in-math-mode-p-func 'YaTeX-in-math-mode-p)

;; (setq latex-math-preview-command-path-alist
;;       '((latex . "/usr/texbin/latex")
;;         (dvipng . "/usr/texbin/dvipng")
;;         (dvips . "/usr/texbin/dvips")))

;; (setq latex-math-preview-tex-to-png-for-preview '(platex dvipng))
;; (setq latex-math-preview-tex-to-png-for-save '(platex dvipng))
;; (setq latex-math-preview-tex-to-eps-for-save '(platex dvips-to-eps))
;; (setq latex-math-preview-tex-to-ps-for-save '(platex dvips-to-ps))
;; (setq latex-math-preview-beamer-to-png '(platex dvipdfmx gs-to-png))

;; ;; インデントをタブでなくスペースに
;; (add-hook 'yatex-mode-hook
;;           '(lambda ()
;;              (setq indent-tabs-mode nil))
;;           )

;; ;;
;; ;; RefTeX with YaTeX
;; ;;
;; ;;(add-hook 'yatex-mode-hook 'turn-on-reftex)
;; (add-hook 'yatex-mode-hook
;;           '(lambda ()
;;              (reftex-mode 1)
;;              (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
;;              (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))

;; ;; デフォルトのDocumentclassをjsarticleに
;; (setq YaTeX-default-documentclass "jsarticle")

;; ;; ;; http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Emacs#h04d4173 より
;; ;; ;;
;; ;; ;; TeX Mode
;; ;; ;;
;; ;; (setq auto-mode-alist
;; ;;       (append '(("\\.tex$" . latex-mode)) auto-mode-alist))
;; ;; (setq tex-default-mode 'latex-mode)
;; ;; (setq tex-start-commands "\\nonstopmode\\input")
;; ;; (setq tex-run-command "/usr/texbin/eptex -synctex=1 -interaction=nonstopmode")
;; ;; (setq latex-run-command "/usr/texbin/platex -synctex=1 -interaction=nonstopmode")
;; ;; (setq tex-bibtex-command "/usr/texbin/pbibtex")
;; ;; (setq tex-dvi-view-command "/usr/bin/open -a PictPrinter.app")
;; ;; ;(setq tex-dvi-view-command "/usr/texbin/pxdvi -watchfile 1")
;; ;; ;(setq tex-dvi-view-command "/usr/bin/open -a Skim.app")
;; ;; (setq tex-dvi-print-command "/usr/texbin/dvipdfmx")
;; ;; (setq tex-compile-commands
;; ;;       '(("/usr/texbin/platex -synctex=1 -interaction=nonstopmode %f && /usr/texbin/dvipdfmx %r" "%f" "%r.pdf")
;; ;;         ("/usr/texbin/platex -synctex=1 -interaction=nonstopmode %f && /usr/texbin/dvips -Ppdf -z -f %r.dvi | /usr/texbin/convbkmk -g > %r.ps && /usr/local/bin/ps2pdf %r.ps" "%f" "%r.pdf")
;; ;;         ("/usr/texbin/uplatex -synctex=1 -interaction=nonstopmode %f && /usr/texbin/dvipdfmx %r" "%f" "%r.pdf")
;; ;;         ("/usr/texbin/uplatex -synctex=1 -interaction=nonstopmode %f && /usr/texbin/dvips -Ppdf -z -f %r.dvi | /usr/texbin/convbkmk -u > %r.ps && /usr/local/bin/ps2pdf %r.ps" "%f" "%r.pdf")
;; ;;         ("/usr/texbin/pdflatex -synctex=1 -interaction=nonstopmode %f" "%f" "%r.pdf")
;; ;;         ("/usr/texbin/lualatex -synctex=1 -interaction=nonstopmode %f" "%f" "%r.pdf")
;; ;;         ("/usr/texbin/luajitlatex -synctex=1 -interaction=nonstopmode %f" "%f" "%r.pdf")
;; ;;         ("/usr/texbin/xelatex -synctex=1 -interaction=nonstopmode %f" "%f" "%r.pdf")
;; ;;         ("/usr/texbin/pbibtex %r" "%r.bib" "%r.aux")
;; ;;         ("/usr/texbin/upbibtex %r" "%r.bib" "%r.aux")
;; ;;         ("/usr/texbin/bibtex %r" "%r.bib" "%r.aux")
;; ;;         ("/usr/texbin/bibtexu %r" "%r.bib" "%r.aux")
;; ;;         ("/usr/texbin/biber %r" "%r.bcf" "%r.bbl")
;; ;;         ("/usr/texbin/mendex %r" "%r.idx" "%r.ind")
;; ;;         ("/usr/texbin/makeindex %r" "%r.idx" "%r.ind")
;; ;;         ("/usr/texbin/texindy %r" "%r.idx" "%r.ind")
;; ;;         ((concat "\\doc-view" " " (car (split-string (format "%s" (tex-main-file)) "\\.")) ".pdf") "%r.pdf")
;; ;;         ("/usr/bin/open -a Preview.app %r.pdf" "%r.pdf")
;; ;;         ("/usr/bin/open -a TeXShop.app %r.pdf" "%r.pdf")
;; ;;         ("/usr/bin/open -a TeXworks.app %r.pdf" "%r.pdf")
;; ;;         ("/usr/bin/open -a Skim.app %r.pdf" "%r.pdf")
;; ;;         ("/usr/local/bin/gv --watch %r.pdf" "%r.pdf")
;; ;;         ("/usr/bin/open -a \"Adobe Reader.app\" %r.pdf" "%r.pdf")))

;; ;; (defun skim-forward-search ()
;; ;;   (interactive)
;; ;;   (let* ((ctf (buffer-name))
;; ;;          (mtf (tex-main-file))
;; ;;          (pf (concat (car (split-string mtf "\\.")) ".pdf"))
;; ;;          (ln (format "%d" (line-number-at-pos)))
;; ;;          (cmd "/Applications/Skim.app/Contents/SharedSupport/displayline")
;; ;;          (args (concat ln " " pf " " ctf)))
;; ;;     (message (concat cmd " " args))
;; ;;     (process-kill-without-query
;; ;;      (start-process-shell-command "displayline" nil cmd args))))

;; ;; (add-hook 'latex-mode-hook
;; ;;           '(lambda ()
;; ;;              (define-key latex-mode-map (kbd "C-c s") 'skim-forward-search)))

;; ;; ;;
;; ;; ;; RefTeX with TeX Mode
;; ;; ;;
;; ;; (add-hook 'latex-mode-hook 'turn-on-reftex)






(provide 'latexcfg)
