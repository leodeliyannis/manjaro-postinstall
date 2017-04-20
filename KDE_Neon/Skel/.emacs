(add-to-list 'load-path "~/.elisp")
;; N�mero de linha e coluna
(line-number-mode 1)
(column-number-mode 1)

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(default-input-method "utf-8")
 '(eshell-prefer-to-shell nil nil (eshell))
 '(fill-column 72)
 '(global-font-lock-mode t nil (font-lock))
 '(make-backup-files nil)
 '(mouse-wheel-mode t nil (mwheel))
 '(scroll-bar-mode nil)
 '(show-paren-mode t nil (paren))
 '(show-trailing-whitespace t)
 '(standard-indent 4)
 '(menu-bar-mode nil)
 '(tab-width 4)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(transient-mark-mode t)
 '(undo-limit 99999)
 '(undo-strong-limit 100999))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )
;; Ativa o syntax highlighting para javascript
(autoload 'javascript-mode "javascript" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
;; Usa espaços para tabulação
(setq-default indent-tabs-mode nil)
;; ;; Seleciona texto com o shift
;; (require `pc-select)
;; (pc-selection-mode)
;; Texto selecionado é substituído pelo que for digitado
(require 'delsel)
(delete-selection-mode 1)
;; Mostra o horário na barra de status
(display-time)
;; O mouse foge do cursor
(mouse-avoidance-mode)
;; Desabilita a barra de ferramentas
(tool-bar-mode 0)
;; Faz M-g ser goto-line
(global-set-key "\M-g" 'goto-line)
;; Remove o texto padrão na abertura do emacs
(setq inhibit-startup-message t)
;; Pergunta y-or-n ao invés de yes-or-no
(fset 'yes-or-no-p 'y-or-n-p)

(defun djcb-opacity-modify (&optional dec)
  "modify the transparency of the emacs frame; if DEC is t,
    decrease the transparency, otherwise increase it in 10%-steps"
  (let* ((alpha-or-nil (frame-parameter nil 'alpha)) ; nil before setting
          (oldalpha (if alpha-or-nil alpha-or-nil 100))
          (newalpha (if dec (- oldalpha 10) (+ oldalpha 10))))
    (when (and (>= newalpha frame-alpha-lower-limit) (<= newalpha 100))
      (modify-frame-parameters nil (list (cons 'alpha newalpha))))))

 ;; C-8 will increase opacity (== decrease transparency)
 ;; C-9 will decrease opacity (== increase transparency
 ;; C-0 will returns the state to normal
(global-set-key (kbd "C-8") '(lambda()(interactive)(djcb-opacity-modify)))
(global-set-key (kbd "C-9") '(lambda()(interactive)(djcb-opacity-modify t)))
(global-set-key (kbd "C-0") '(lambda()(interactive)
                               (modify-frame-parameters nil `((alpha . 100)))))

(modify-frame-parameters nil `((alpha . 75)))




