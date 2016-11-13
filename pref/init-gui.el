;; GUIのときだけの設定

;; solarizedテーマ
(add-to-list 'custom-theme-load-path "~/.emacs.d/el-get/solarized-emacs")
(load-theme 'solarized-dark t)

;; ファイルを開くとき、現在のフレームで開く
(setq ns-pop-up-frames nil)

;; 現在行のハイライト
(global-hl-line-mode)

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

(provide 'init-gui)
