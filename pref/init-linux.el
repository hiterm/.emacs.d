;; cask
(require 'cask "$HOME/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; フォント
(add-to-list 'default-frame-alist '(font . "ricty-10.5"))

;; 最初の画面を消す
(setq inhibit-startup-message t)

;; 変換キーでon、無変換キーでoffで切り替え
(define-key global-map [Hangul]
  (lambda ()
    (interactive)
    (if current-input-method (inactivate-input-method))
    (toggle-input-method)))
(defadvice mozc-handle-event (around intercept-keys (event))
  "Intercept keys muhenkan and zenkaku-hankaku, before passing keys to mozc-server (which the function mozc-handle-event does), to properly disable mozc-mode."
  (if (member event (list 'zenkaku-hankaku 'Hangul_Hanja))
      (progn
        (mozc-clean-up-session)
        (toggle-input-method))
    (progn ;(message "%s" event) ;debug
      ad-do-it)))
(ad-activate 'mozc-handle-event)

(provide 'init-linux)
