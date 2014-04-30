;; GUIのときだけの設定

;; solarizedテーマ
(load-theme 'solarized-dark t)
;; (load-theme 'solarized-light t)

;; ファイルを開くとき、現在のフレームで開く
(setq ns-pop-up-frames nil)

;; 括弧の対応関係をハイライト表示
(show-paren-mode nil)

;; 背景を透過させる
(set-frame-parameter nil 'alpha '(97 70))

;; 現在行のハイライト
(global-hl-line-mode)

;; 慣性スクロール
(require 'inertial-scroll)
(setq inertias-global-minor-mode-map
      (inertias-define-keymap
       '(
         ;; Mouse wheel scrolling
         ("<wheel-up>"   . inertias-down-wheel)
         ("<wheel-down>" . inertias-up-wheel)
         ("<mouse-4>"    . inertias-down-wheel)
         ("<mouse-5>"    . inertias-up-wheel)
         ) inertias-prefix-key))
(inertias-global-minor-mode 1)

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

(provide 'gui)
