;; このファイルはload-path設定と
;; どの設定ファイルを読み込むかの指定をするだけ

;; load-pathの設定
;; elisp/以下のディレクトリを再帰的に追加

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
;; (when run-linux
;;   (require 'package))

;; Macでは、/usr/local/share/emacs/site-lisp をload-pathに加える
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")

;; それぞれ設定ファイルを呼び出す
(require 'init-el-get)
(when run-linux
  (require 'init-linux))
(when run-darwin
  (require 'init-mac))
(when window-system
  (require 'gui))
(require 'main)
(require 'modes)
(require 'terminal)
(when run-darwin
  (require 'latex_mac))
