;; GUIのときだけの設定


;; ファイルを開くとき、現在のフレームで開く
(setq ns-pop-up-frames nil)

;; 括弧の対応関係をハイライト表示
(show-paren-mode nil)

;; 背景を透過させる
(set-frame-parameter nil 'alpha '(97 70))

;; 現在行のハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "gray17"))
    (((class color)
      (background light))
     (:background "SeaGreen" :))
    (t
     ()))
  "Used face hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;; マウスホイールで2行ずつスクロール
(defun scroll-down-with-lines ()
  ""
  (interactive)
  (scroll-down 2)
  )
(defun scroll-up-with-lines ()
  ""
  (interactive)
  (scroll-up 2)
  )
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)
;; スクロールを加速
(setq mouse-wheel-progressive-speed nil)

;; color-theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-molokai)

;; スクロール時のビープ音を消す
(defun my-bell-function ()
  (unless (memq this-command
                '(isearch-abort abort-recursive-edit exit-minibuffer
                                keyboard-quit scroll-up-with-lines scroll-down-with-lines
                                down up next-line previous-line
                                backward-char forward-char
                                scroll-up-command scroll-down-command))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;; タブ化
(require 'tabbar)
;; (tabbar-mode 1)

(defun my-tabbar-buffer-list ()
  (delq nil
        (mapcar #'(lambda (b)
                    (cond
                     ;; Always include the current buffer.
                     ((eq (current-buffer) b) b)
                     ((buffer-file-name b) b)
                     ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                     ((equal "*scratch*" (buffer-name b)) b) ; *scratch*バッファは表示する
                     ((equal "*terminal*" (buffer-name b)) b)
                     ((equal "*terminal<1>*" (buffer-name b)) b)
                     ((equal "*terminal<2>*" (buffer-name b)) b)
                     ((equal "*terminal<3>*" (buffer-name b)) b)
                     ((equal "*terminal<4>*" (buffer-name b)) b)
                     ((char-equal ?* (aref (buffer-name b) 0)) nil) ; それ以外の * で始まるバッファは表示しない
                     ((buffer-live-p b) b)))
                (buffer-list))))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

;; (require 'tabbar)
(tabbar-mode)
(global-set-key "\M-]" 'tabbar-forward)  ; 次のタブ
(global-set-key "\M-[" 'tabbar-backward) ; 前のタブ
;; タブ上でマウスホイールを使わない
(tabbar-mwheel-mode nil)
;; グループを使わない
(setq tabbar-buffer-groups-function nil)
;; 左側のボタンを消す
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))
;; 色設定
;; (set-face-attribute ; バー自体の色
;;   'tabbar-default nil
;;    :background "white"
;;    :family "Inconsolata"
;;    :height 1.0)
;; (set-face-attribute ; アクティブなタブ
;;   'tabbar-selected nil
;;    :background "black"
;;    :foreground "white"
;;    :weight 'bold
;;    :box nil)
;; (set-face-attribute ; 非アクティブなタブ
;;   'tabbar-unselected nil
;;    :background "white"
;;    :foreground "black"
;;    :box nil)

(provide 'gui)
