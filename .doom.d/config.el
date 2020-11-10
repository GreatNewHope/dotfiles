;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Marcos Galletero Romero"
      user-mail-address "marcos_garo95@hotmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-material)

(setq doom-font (font-spec :family "Source Code Pro" :size 14)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 14)
      doom-big-font (font-spec :family "Source Code Pro" :size 24))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(use-package! poke-line
  :config
  (poke-line-global-mode 1))
  :init
  (add-hook 'find-file-hook #'poke-line-set-random-pokemon)

(after! dired
  (ranger-override-dired-mode t))
;; ORG CONFIGURATION
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(use-package! org
  :defer t
  :custom
  ( org-directory "~/Dropbox/org")
  ( org-capture-diario-file (concat org-directory "/Diario.org") )
  ( org-agenda-skip-scheduled-if-done t )
  ( org-agenda-skip-deadline-if-done t ) ( org-agenda-include-deadlines t )
  ( org-agenda-block-separator nil )
  ( org-agenda-tags-column 100 )
  ( org-agenda-compact-blocks t )
  ( org-tag-persistent-alist  )
  ( org-agenda-custom-commands
    '(("o" "Overview" (
       (alltodo "" ((org-agenda-overriding-header "")
                    (org-super-agenda-groups
                     '((:name "Vencido"
                       :and
                       (:scheduled past :not (:habit t) )
                       :deadline past)
                       (:discard (:anything))
                       ))))
       (agenda "" ((org-agenda-span 2)
                   (org-agenda-start-day (format-time-string "%d"))
                   (org-extend-today-until 4)
                   (org-super-agenda-groups
                     '((:name ""
                        :and
                        ( :time-grid t :not (:scheduled past) :not (:deadline past) :not (:habit t))
                        :and
                        ( :date today :not (:habit t))
                        :and
                        ( :scheduled today :not (:habit t))
                        :and
                        ( :deadline today :not (:habit t)))
                       (:discard (:anything))
                       ))
                    ))
       (alltodo "" ((org-agenda-overriding-header "")
                    (org-super-agenda-groups
                     '((:name "mrH"
                        :and
                        (:file-path "projects.org" :tag ("mrh_dashboard" "i3_rest_server")))
                       (:discard (:anything))
                       ))))
       (alltodo "" ((org-agenda-overriding-header "")
                    (org-super-agenda-groups
                     '((:name "Máster"
                        :and
                        (:file-path "projects.org" :tag ()))
                       (:discard (:anything))
                       ))))
       (agenda "" ((org-super-agenda-groups
                     '((:name "Hábitos"
                        :and
                        ( :time-grid t :habit t )
                        :and
                        ( :date today :habit t )
                        :and
                        ( :scheduled today :habit t ))
                       (:discard (:not (:habit t)))
                       ))
                    ))
       ))
      ))
 )

(use-package! org-super-agenda
  :hook
  '(org-agenda-mode . org-super-agenda-mode))

(use-package! treemacs
  :defer t
  :config
  (treemacs-follow-mode))

(after! org
  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  ;; Esta es la configuración del que hizo el paquete de org-recur
  ;; Refresh org-agenda after rescheduling a task.
  (defun org-agenda-refresh ()
    "Refresh all `org-agenda' buffers."
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (when (derived-mode-p 'org-agenda-mode)
          (org-agenda-maybe-redo)))))

  (defadvice org-schedule (after refresh-agenda activate)
    "Refresh org-agenda."
    (org-agenda-refresh))
  ;; Log time a task was set to Done.
  (setq org-log-done (quote time))

  ;; Don't log the time a task was rescheduled or redeadlined.
  (setq org-log-redeadline nil)
  (setq org-log-reschedule nil)
  ;; Hide italics marker
  org-hide-emphasis-markers t

  (setq org-read-date-prefer-future 'time)
  ;;
  ;; (setq org-extend-today-until 4)
  (setq org-modules '(ol-bibtex org-habit))
  (setq org-log-into-drawer t)
  (setq org-babel-python-command "python3")
  (setq org-habit-graph-column 67)
  (setq org-capture-templates '(("d" "Diario personal" entry
                                                                                     (file+olp+datetree org-capture-diario-file "Diario")
                                                                                     "* 3 cosas que he disfrutado hoy
%i%?
\* Estado de ánimo con el que me acuesto ( :smile: | :neutral-face: | :slight_frown: ) y razón por la que ha cambiado con respecto a ayer
%i
\* 3 cosas que podría haber hecho de manera diferente hoy para que el día hubiera sido mejor
%i
\* 3 cosas por las que me siento agradecido en la vida
%i
\* 3 propósitos que quiero cumplir el día de mañana
" :prepend t)
                                                                                    ("t" "Personal todo" entry
                                                                                     (file+headline +org-capture-todo-file "Inbox")
                                                                                     "* [ ] %?
%i
%a" :prepend t)
                                                                                    ("n" "Personal notes" entry
                                                                                     (file+headline +org-capture-notes-file "Inbox")
                                                                                     "* %u %?
%i
%a" :prepend t)
                                                                                    ("j" "Journal" entry
                                                                                     (file+olp+datetree +org-capture-journal-file)
                                                                                     "* %U %?
%i
%a" :prepend t)
                                                                                    ("p" "Templates for projects")
                                                                                    ("pt" "Project-local todo" entry
                                                                                     (file+headline +org-capture-project-todo-file "Inbox")
                                                                                     "* TODO %?
%i
%a" :prepend t)
                                                                                    ("pn" "Project-local notes" entry
                                                                                     (file+headline +org-capture-project-notes-file "Inbox")
                                                                                     "* %U %?
%i
%a" :prepend t)
                                                                                    ("pc" "Project-local changelog" entry
                                                                                     (file+headline +org-capture-project-changelog-file "Unreleased")
                                                                                     "* %U %?
%i
%a" :prepend t)
                                                                                    ("o" "Centralized templates for projects")
                                                                                    ("ot" "Project todo" entry
                                                                                     (function +org-capture-central-project-todo-file)
                                                                                     "* TODO %? :%( projectile-project-name )
 %i
 %a" :heading "Tasks" :prepend nil)
                                                                                    ("on" "Project notes" entry
                                                                                     (function +org-capture-central-project-notes-file)
                                                                                     "* %U %? :%( projectile-project-name )
 %i
 %a" :prepend t :heading "Notes")
                                                                                    ("oc" "Project changelog" entry
                                                                                     (function +org-capture-central-project-changelog-file)
                                                                                     "* %U %? :%( projectile-project-name )
 %i
 %a" :prepend t :heading "Changelog"))))

;; Activa el emojify globalmente
(use-package! emojify
  :defer nil
  :custom
  (emojify-emoji-styles '(github))
  :config
  (global-emojify-mode))
;; Activamos el org-recur para mejorar la planificación de las tareas
(use-package! org-recur
  :hook ((org-mode . org-recur-mode)
         (org-agenda-mode . org-recur-agenda-mode))
  :config

  (setq org-recur-finish-done t
        org-recur-finish-archive t))
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(use-package! cus-edit
  :defer t
  :custom
  (custom-unlispify-menu-entries nil)
  (custom-unlispify-tag-names nil)
  (custom-unlispify-remove-prefixes nil))
;; Here are some additional functions/macros that could help you configure Doom:

;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(general-auto-unbind-keys)

(defun eide-smart-tab-jump-out-or-indent (&optional arg)
  "Smart tab behavior. Jump out quote or brackets, or indent."
  (interactive "P")
  (if (-contains? (list "\"" "'" ")" "}" ";" "|" ">" "]" ) (make-string 1 (char-after)))
      (forward-char 1)
    (indent-for-tab-command arg)))

(global-set-key [remap indent-for-tab-command]
                'eide-smart-tab-jump-out-or-indent)
;; ace más accesible desde keybindings
(map! :map global-map
      :n "C-w w" #'ace-window
      :desc "Select any window")
(map! :map org-recur-mode-map
      :n "C-c d" #'org-recur-finish
      :desc "Function to use instead of org-todo for org-recur tasks")
(map! :map org-recur-agenda-mode-map
      :m "C-c d" #'org-recur-finish
      :desc "Function to use instead of org-todo for org-recur tasks")

(setq fancy-splash-image (expand-file-name "misc/splash-images/logo-verde.svg" doom-private-dir))
