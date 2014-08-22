;; 共通する設定


;; 言語を日本語にする
(set-language-environment 'Japanese)
;; 極力UTF-8とする
(prefer-coding-system 'utf-8)

;; C-hでバックスペース
(keyboard-translate ?\C-h ?\C-?)
;; 別のキーバインドにヘルプを割り当てる
(define-key global-map (kbd "C-c DEL") 'help-command)

;; 行番号
(require 'linum)
(global-linum-mode)

;; yasnippet
(yas-global-mode 1)
;; snippetの表示方法
(require 'dropdown-list)
(setq yas-prompt-functions '(yas-dropdown-prompt))
;; snippets directory
(setq yas-snippet-dirs (append yas-snippet-dirs
                               '("~/.emacs.d/snippets")))

;; helm
(require 'helm-config)
;; key bind
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; Tabで補完
(eval-after-load "helm-files"
  '(progn
     (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
     (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
     ;; Tabを2回押してもbufferを作成しない
     (defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
       "Execute command only if CANDIDATE exists"
       (when (file-exists-p candidate)
         ad-do-it))))
;; Emulate `kill-line' in helm minibuffer
(eval-after-load "helm"
  '(progn
(setq helm-delete-minibuffer-contents-from-point t)
(defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
  "Emulate `kill-line' in helm minibuffer"
  (kill-new (buffer-substring (point) (field-end))))))


;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'html-mode)
(add-to-list 'ac-modes 'asy-mode)
(add-to-list 'ac-modes 'latex-mode)
;; auto-complete の候補に日本語を含む単語が含まれないようにする
;; http://d.hatena.ne.jp/IMAKADO/20090813/1250130343
(defadvice ac-word-candidates (after remove-word-contain-japanese activate)
  (let ((contain-japanese (lambda (s) (string-match (rx (category japanese)) s))))
    (setq ad-return-value
          (remove-if contain-japanese ad-return-value))))

;; 括弧の補完 smartparens-mode
(smartparens-global-mode t)
(require 'smartparens-config)
(require 'smartparens-latex)
(require 'smartparens-ruby)
(require 'smartparens-html)
;;; 括弧の対応関係をハイライト表示
(show-smartparens-global-mode t)
;;; ハイライトの色
(set-face-attribute 'sp-show-pair-match-face nil
                    :foreground "cyan"
                    :background "darkslategray")

;; 最後に改行を入れる
(setq require-final-newline t)

;; バッファ終端の無駄な空行を削除する関数
(defun trim-eob ()
  "バッファの最後に溜った空行を消去"
  (interactive)
  (save-excursion
    (progn
      (goto-char (point-max))
      (delete-blank-lines)
      nil)))

;; セーブ時に行末の空白を削除 & 空行を削除
;; 無駄な行末の空白を削除する(Emacs Advent Calendar jp:2010) - tototoshiの日記
;; http://d.hatena.ne.jp/tototoshi/20101202/1291289625
(add-hook 'before-save-hook
          '(lambda ()
             (delete-trailing-whitespace)
             (trim-eob)))

;; バックアップファイルの保存先変更
;; create backup file in ~/.emacs.d/backup
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
            backup-directory-alist))
;; create auto-save file in ~/.emacs.d/backup
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backup/") t)))

;; バックアップファイルを複数世代残す
(setq version-control t)     ; 複数のバックアップを残します。世代。
(setq kept-new-versions 5)   ; 新しいものをいくつ残すか
(setq kept-old-versions 5)   ; 古いものをいくつ残すか
(setq delete-old-versions t) ; 確認せずに古いものを消す。
(setq vc-make-backup-files t) ; バージョン管理下のファイルもバックアップを作る。


;; recentf
(require 'recentf)
(recentf-mode 1)
(defvar my-recentf-list-prev nil)
;; 30秒毎に保存
(defadvice recentf-save-list
  (around no-message activate)
  "If `recentf-list' and previous recentf-list are equal,
do nothing. And suppress the output from `message' and
`write-file' to minibuffer."
  (unless (equal recentf-list my-recentf-list-prev)
    (cl-flet ((message (format-string &rest args)
                       (eval `(format ,format-string ,@args)))
              (write-file (file &optional confirm)
                          (let ((str (buffer-string)))
                            (with-temp-file file
                              (insert str)))))
      ad-do-it
      (setq my-recentf-list-prev recentf-list))))

(defadvice recentf-cleanup
  (around no-message activate)
  "suppress the output from `message' to minibuffer"
  (cl-flet ((message (format-string &rest args)
                     (eval `(format ,format-string ,@args))))
    ad-do-it))

(custom-set-variables '(recentf-save-file "~/.emacs.d/.recentf"))
(setq recentf-max-saved-items 2000)
(setq recentf-exclude '(".recentf"))
(setq recentf-auto-cleanup 10)
(run-with-idle-timer 30 t 'recentf-save-list)
(recentf-mode 1)

(global-set-key (kbd "C-x C-r") 'helm-recentf)


;; 矩形選択モード (C-Enter)
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; タブと全角スペースに色を付ける
(require 'whitespace)
;; see whitespace.el for more details
(setq whitespace-style '(face tabs tab-mark spaces space-mark))
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])))
(setq whitespace-space-regexp "\\(\u3000+\\)")
;;(set-face-foreground 'whitespace-tab "#adff2f")
(set-face-foreground 'whitespace-tab "gray25")
(set-face-background 'whitespace-tab 'nil)
(set-face-underline  'whitespace-tab t)
(set-face-foreground 'whitespace-space "#7cfc00")
(set-face-background 'whitespace-space 'nil)
(set-face-bold-p 'whitespace-space t)
(global-whitespace-mode 1)
(global-set-key (kbd "C-x w") 'global-whitespace-mode)

;; ;; 行末の空白を表示
;; (setq-default show-trailing-whitespace t)
;; ;;(set-face-background 'trailing-whitespace "purple4")

;; scrachバッファを消さない設定
;; "*scratch*" を作成して buffer-list に放り込む
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))
;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
(add-hook 'kill-buffer-query-functions
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (progn (my-make-scratch 0) nil)
              t)))
;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
(add-hook 'after-save-hook
          (lambda ()
            (unless (member (get-buffer "*scratch*") (buffer-list))
              (my-make-scratch 1))))

;; ispellの設定 (スペルチェッカ)
(setq-default ispell-program-name "aspell")

;; 折り返し時に、単語の切れ目を避けるようにする
;; (global-visual-line-mode)
(add-hook 'visual-line-mode-hook
          (lambda ()
            (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))))

;; Lispの設定
(setq inferior-lisp-program "sbcl")

;; smart-compile
(require 'smart-compile)
(setq smart-compile-alist
      (append
       '(("\\.rb$" . "ruby %f")
         ("\\.py$" . "python %f")
         ("\\.java$" . "javac %f && java %n"))
       smart-compile-alist))
(eval-after-load "ruby-mode"
  '(define-key ruby-mode-map (kbd "C-c C-c") 'smart-compile))
(eval-after-load "python"
  '(define-key python-mode-map (kbd "C-c C-c") 'smart-compile))
(eval-after-load "cc-mode"
  '(define-key java-mode-map (kbd "C-c C-c") 'smart-compile))

;; mini bufferのタブ補完で大文字小文字を区別しない
(setq completion-ignore-case t)

;; 補完をzshライクな挙動にする
(zlc-mode t)

;; avoid "Symbolic link to SVN-controlled source file; follow link? (yes or no)"
(setq vc-follow-symlinks t)

;; インデント
(setq-default indent-tabs-mode nil)

;; Highlighting indentation for Emacs
(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#192b36")
;; (set-face-background 'highlight-indentation-face "#002b80")
(set-face-background 'highlight-indentation-current-column-face "#002b80")
;; 各モードで有効に
(add-hook 'ruby-mode-hook 'highlight-indentation-mode)
(add-hook 'ruby-mode-hook 'highlight-indentation-current-column-mode)

;; mozc
(when run-linux (progn
                  (require 'mozc)
                  (setq default-input-method "japanese-mozc")
                  (setq mozc-candidate-style 'overlay)))

(provide 'main)
