;; ref: https://github.com/lclem/markdown-agda-mode/

(defgroup markdown-agda-mode nil
  "org-agda-mode customisations"
  :group 'languages)

;;; (defcustom use-agda-input t
;;;   "Whether to use Agda input mode in non-Agda parts of the file."
;;;   :group 'markdown-agda-mode
;;;   :type 'boolean)

(define-hostmode poly-markdown-agda-hostmode
  :mode 'markdown-mode
  :keep-in-mode 'host)

(define-innermode poly-markdown-agda-innermode
  :mode 'agda2-mode
  :head-matcher "```"
  :tail-matcher "```"
  ;; Keep the code block wrappers in Org mode, so they can be folded, etc.
  :head-mode 'markdown-mode
  :tail-mode 'markdown-mode
  ;; Disable font-lock-mode, which interferes with Agda annotations,
  ;; and undo the change to indent-line-function Polymode makes.
  :init-functions '((lambda (_) (font-lock-mode 0))
                    (lambda (_) (setq indent-line-function #'indent-relative))))

(define-polymode poly-markdown-agda-mode
  :hostmode 'poly-markdown-agda-hostmode
  :innermodes '(poly-markdown-agda-innermode)
  (set-input-method "Agda"))

;; (assq-delete-all 'background 'agda2-highlight-faces)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.lagda.md" . poly-markdown-agda-mode))
