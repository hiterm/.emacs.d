;; GUIのときだけの設定

;; solarizedテーマ
(load-theme 'solarized-dark t)

;; ファイルを開くとき、現在のフレームで開く
(setq ns-pop-up-frames nil)

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

(provide 'gui)
