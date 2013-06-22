; anthy.el をロードする。
(load-library "anthy")
; japanese-anthy をデフォルトの input-method にする。
(setq default-input-method "japanese-anthy")
;; 遅いのを直す
(if (>= emacs-major-version 22)
    (setq anthy-accept-timeout 1))
;; 半角全角キーで切り替え
(global-set-key [zenkaku-hankaku] 'toggle-input-method)

(provide 'init-linux)
