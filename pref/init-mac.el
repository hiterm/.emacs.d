;; C-M-\ を正しく実行 (￥になってしまうのを回避)
(define-key global-map (kbd "C-M-¥") (kbd "C-M-\\"))

(define-key global-map (kbd "C-¥") (kbd "C-\\"))

;; ことえり
(setq default-input-method "MacOSX")

;; フォント

(if window-system
    (when run-darwin
      (when (>= emacs-major-version 23)
        (set-face-attribute 'default nil
                            :family "monaco"
                            :height 120)
        (set-fontset-font
         (frame-parameter nil 'font)
         'japanese-jisx0208
         '("Hiragino Kaku Gothic Pro" . "iso10646-1"))
        (set-fontset-font
         (frame-parameter nil 'font)
         'japanese-jisx0212
         '("Hiragino Kaku Gothic Pro" . "iso10646-1"))
        (set-fontset-font
         (frame-parameter nil 'font)
         'mule-unicode-0100-24ff
         '("monaco" . "iso10646-1"))
        (setq face-font-rescale-alist
              '(("^-apple-hiragino.*" . 1.2)
                (".*osaka-bold.*" . 1.2)
                (".*osaka-medium.*" . 1.2)
                (".*courier-bold-.*-mac-roman" . 1.0)
                (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
                (".*monaco-bold-.*-mac-roman" . 0.9)
                ("-cdac$" . 1.3))))))

(provide 'init-mac)
