;; このファイルはload-path設定と
;; どの設定ファイルを読み込むかの指定をするだけ

;; load-pathの設定
;; elisp/以下のディレクトリを再帰的に追加
(defconst my-elisp-directory "~/.emacs.d/elisp" "The directory for my elisp file.")
(dolist (dir (let ((dir (expand-file-name my-elisp-directory)))
               (list dir (format "%s%d" dir emacs-major-version))))
  (when (and (stringp dir) (file-directory-p dir))
    (let ((default-directory dir))
      (add-to-list 'load-path default-directory)
      (normal-top-level-add-subdirs-to-load-path))))
;; pref以下のディレクトリを再帰的に追加
(defconst my-elisp-directory "~/.emacs.d/pref" "The directory for my elisp file.")
(dolist (dir (let ((dir (expand-file-name my-elisp-directory)))
               (list dir (format "%s%d" dir emacs-major-version))))
  (when (and (stringp dir) (file-directory-p dir))
    (let ((default-directory dir))
      (add-to-list 'load-path default-directory)
      (normal-top-level-add-subdirs-to-load-path))))

;; OSを判別 http://coderepos.org/share/browser/dotfiles/emacs/kentaro/.emacs
(defvar run-unix
  (or (equal system-type 'gnu/linux)
      (or (equal system-type 'usg-unix-v)
          (or  (equal system-type 'berkeley-unix)
               (equal system-type 'cygwin)))))
(defvar run-linux
  (equal system-type 'gnu/linux))
(defvar run-system-v
  (equal system-type 'usg-unix-v))
(defvar run-bsd
  (equal system-type 'berkeley-unix))
(defvar run-cygwin ;; cygwinもunixグループにしておく
  (equal system-type 'cygwin))
(defvar run-w32
  (and (null run-unix)
       (or (equal system-type 'windows-nt)
           (equal system-type 'ms-dos))))
(defvar run-darwin (equal system-type 'darwin))

;; linuxのとき、package.el
(when run-linux
  (require 'package))


;; それぞれ設定ファイルを呼び出す
(require 'main)
(if window-system (progn
                    (require 'gui)))
(require 'modes)
(require 'termcfg)
(require 'latexcfg)
(when run-linux
  (require 'init-linux))
(when run-darwin
  (require 'init-mac))

;; ; auto-complete
;; ;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/auto-complete-1.3.1/dict")
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (add-to-list 'ac-modes 'html-mode)

;; ;; ; 括弧の補完
;; ;; (global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
;; ;; (global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
;; ;; (global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
;; ;; (global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
;; ;; (global-set-key (kbd "<") 'skeleton-pair-insert-maybe)
;; ;; (setq skeleton-pair 1)

;; ; 括弧の補完
;; ;(require 'cl)
;; (require 'flex-autopair)
;; (flex-autopair-mode 1)

;; ;; ; html-mode
;; ;; (add-hook 'html-mode-hook
;; ;; (lambda ()
;; ;; (setq indent-tabs-mode t)
;; ;; (setq tab-width 4)))

;; ; Tclモード
;; ;; (add-hook 'html-mode-hook '(lambda () (setq tab-width 4)))
;; ;; (setq c-basic-offset 4)

;; (add-hook
;;  'sgml-mode-hook
;;  (lambda ()
;;    (setq
;;     sgml-basic-offset 4
;;     )))
;; (setq indent-tabs-mode t)

;; ; 改行時にインデント
;; (global-set-key "\C-m" 'newline-and-indent)



;; ; GUIのときだけの設定
;; (if window-system (progn

;; ; ファイルを開くとき、現在のフレームで開く
;; (setq ns-pop-up-frames nil)

;; ; 言語を日本語にする
;; (set-language-environment 'Japanese)
;; ; 極力UTF-8とする
;; (prefer-coding-system 'utf-8)

;; ;; ; フォント
;; ;; (set-face-attribute 'default nil
;; ;;             :family "Osaka" ;; font
;; ;;             :height 120)    ;; font size
;; ;; (set-fontset-font
;; ;;  nil 'japanese-jisx0208
;; ;;  (font-spec :family "Hiragino Kaku Gothic Pro")) ;; font
;; ;; (setq face-font-rescale-alist
;; ;;       '((".*Hiragino_Mincho_pro.*" . 1.2)))

;; ;フォントの設定
;; (create-fontset-from-ascii-font "Menlo-14:weight=normal:slant=normal" nil "menlokakugo")
;; (set-fontset-font "fontset-menlokakugo"
;;                   'unicode
;;                   (font-spec :family "Hiragino Kaku Gothic ProN" :size 12)
;;                   nil
;;                   'append)
;; (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))

;; ; 括弧の対応関係をハイライト表示
;; (show-paren-mode nil)
;; ; 背景を透過させる
;; (set-frame-parameter nil 'alpha '(97 70))
;; ; 現在行のハイライト
;; (defface hlline-face
;;   '((((class color)
;;       (background dark))
;;      (:background "gray17"))
;;     (((class color)
;;       (background light))
;;      (:background "SeaGreen" :))
;;     (t
;;      ()))
;;   "Used face hl-line.")
;; (setq hl-line-face 'hlline-face)
;; (global-hl-line-mode)
;; ;行番号
;; (require 'linum)
;; (global-linum-mode)

;; ; マウスホイールで2行ずつスクロール
;; (defun scroll-down-with-lines ()
;;   ""
;;   (interactive)
;;   (scroll-down 2)
;;   )
;; (defun scroll-up-with-lines ()
;;    ""
;;    (interactive)
;;    (scroll-up 2)
;; )
;; (global-set-key [wheel-up] 'scroll-down-with-lines)
;; (global-set-key [wheel-down] 'scroll-up-with-lines)
;; ; スクロールを加速
;; (setq mouse-wheel-progressive-speed nil)

;; ; elpaのパッケージを増やす
;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (package-initialize)

;; ; color-theme
;; (require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-molokai)

;; ; スクロール時のビープ音を消す
;; (defun my-bell-function ()
;;   (unless (memq this-command
;;     	'(isearch-abort abort-recursive-edit exit-minibuffer
;;           keyboard-quit scroll-up-with-lines scroll-down-with-lines
;; 	      down up next-line previous-line
;;           backward-char forward-char
;; 	      scroll-up-command scroll-down-command))
;;     (ding)))
;; (setq ring-bell-function 'my-bell-function)

;; ; C-hでバックスペース
;; (keyboard-translate ?\C-h ?\C-?)


;; ; インデントをスペースではなくタブに
;; (setq-default indent-tabs-mode nil)
;; ;; tab 幅を 4 に設定
;; (setq-default tab-width 4)

;; ;; 2012-03-18
;; ;; emacs-lisp-modeでバッファーを開いたときに行う設定
;; (add-hook
;;  'emacs-lisp-mode-hook
;;  (lambda ()
;;    ;; スペースでインデントをする
;;    (setq indent-tabs-mode nil)
;;    (setq indent-level 4)
;; ))


;; ; タブ化
;; (require 'tabbar)
;; ;; (tabbar-mode 1)

;; (defun my-tabbar-buffer-list ()
;;   (delq nil
;;         (mapcar #'(lambda (b)
;;                     (cond
;;                      ;; Always include the current buffer.
;;                      ((eq (current-buffer) b) b)
;;                      ((buffer-file-name b) b)
;;                      ((char-equal ?\  (aref (buffer-name b) 0)) nil)
;; 		     ((equal "*scratch*" (buffer-name b)) b) ; *scratch*バッファは表示する
;;              ((equal "*terminal*" (buffer-name b)) b)
;; 		     ((char-equal ?* (aref (buffer-name b) 0)) nil) ; それ以外の * で始まるバッファは表示しない
;;                      ((buffer-live-p b) b)))
;;                 (buffer-list))))
;; (setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

;; ;; (require 'tabbar)
;; (tabbar-mode)
;; (global-set-key "\M-]" 'tabbar-forward)  ; 次のタブ
;; (global-set-key "\M-[" 'tabbar-backward) ; 前のタブ
;; ;; タブ上でマウスホイールを使わない
;; (tabbar-mwheel-mode nil)
;; ;; グループを使わない
;; (setq tabbar-buffer-groups-function nil)
;; ;; 左側のボタンを消す
;; (dolist (btn '(tabbar-buffer-home-button
;;                tabbar-scroll-left-button
;;                tabbar-scroll-right-button))
;;   (set btn (cons (cons "" nil)
;;                  (cons "" nil))))
;; ;; 色設定
;; ;; (set-face-attribute ; バー自体の色
;; ;;   'tabbar-default nil
;; ;;    :background "white"
;; ;;    :family "Inconsolata"
;; ;;    :height 1.0)
;; ;; (set-face-attribute ; アクティブなタブ
;; ;;   'tabbar-selected nil
;; ;;    :background "black"
;; ;;    :foreground "white"
;; ;;    :weight 'bold
;; ;;    :box nil)
;; ;; (set-face-attribute ; 非アクティブなタブ
;; ;;   'tabbar-unselected nil
;; ;;    :background "white"
;; ;;    :foreground "black"
;; ;;    :box nil)

;; ;; asymptoteモード
;; (autoload 'asy-mode "asy-mode.el" "Asymptote major mode." t)
;; (autoload 'lasy-mode "asy-mode.el" "hybrid Asymptote/Latex major mode." t)
;; (autoload 'asy-insinuate-latex "asy-mode.el" "Asymptote insinuate LaTeX." t)
;; (add-to-list 'auto-mode-alist '("\\.asy$" . asy-mode))
;; (add-hook 'asy-mode-hook (lambda () (local-set-key [f5] 'asy-compile)))

;; ;; c-mode, c++-mode
;; (add-hook 'c-mode-common-hook
;;           '(lambda ()
;;              ;;; K&R のスタイルを使う
;;              (c-set-style "k&r")
;;              ;;; インデントには tab を使う
;;              (setq indent-tabs-mode t)
;;              ;;; インデント幅
;;              (setq c-basic-offset 4)
;;              ))

;; ))

;; ;; タブ, 全角スペース、改行直前の半角スペースを表示する
;; (when (require 'jaspace nil t)
;;   (when (boundp 'jaspace-modes)
;;     (setq jaspace-modes (append jaspace-modes
;;                                 (list 'php-mode
;;                                       'yaml-mode
;;                                       'javascript-mode
;;                                       'ruby-mode
;;                                       'text-mode
;;                                       'fundamental-mode))))
;;   (when (boundp 'jaspace-alternate-jaspace-string)
;;     (setq jaspace-alternate-jaspace-string "□"))
;;   (when (boundp 'jaspace-highlight-tabs)
;;     (setq jaspace-highlight-tabs ?^))
;;   (add-hook 'jaspace-mode-off-hook
;;             (lambda()
;;               (when (boundp 'show-trailing-whitespace)
;;                 (setq show-trailing-whitespace nil))))
;;   (add-hook 'jaspace-mode-hook
;;             (lambda()
;;               (progn
;;                 (when (boundp 'show-trailing-whitespace)
;;                   (setq show-trailing-whitespace t))
;;                 (face-spec-set 'jaspace-highlight-jaspace-face
;;                                '((((class color) (background light))
;;                                   (:foreground "blue"))
;;                                  (t (:foreground "green"))))
;;                 (face-spec-set 'jaspace-highlight-tab-face
;;                                '((((class color) (background light))
;;                                   (:foreground "red"
;;                                    :background "unspecified"
;;                                    :strike-through nil
;;                                    :underline t))
;;                                  (t (:foreground "purple"
;;                                      :background "unspecified"
;;                                      :strike-through nil
;;                                      :underline t))))
;;                 (face-spec-set 'trailing-whitespace
;;                                '((((class color) (background light))
;;                                   (:foreground "red"
;;                                    :background "unspecified"
;;                                    :strike-through nil
;;                                    :underline t))
;;                                  (t (:foreground "purple"
;;                                      :background "unspecified"
;;                                      :strike-through nil
;;                                      :underline t))))))))
