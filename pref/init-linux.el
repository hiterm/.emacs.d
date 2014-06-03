;; cask
(require 'cask "$HOME/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; フォント
(add-to-list 'default-frame-alist '(font . "ricty-10.5"))

;; 最初の画面を消す
(setq inhibit-startup-message t)

(provide 'init-linux)
