#lang racket

(require racket/gui)

(define frame (new frame%
                   [label "Training Planner"]))

(define main-panel (new vertical-panel%
                        [parent frame]
                        [alignment '(center center)]))

(define top-h-panel (new horizontal-panel%
                         [parent main-panel]
                         [alignment '(center center)]))

(define bot-h-panel (new horizontal-panel%
                         [parent main-panel]
                         [alignment '(center center)]))

(define item-input (new text-field%
                        [label ""]
                        [parent top-h-panel]))

(define add-button (new button%
                        [label "+"]
                        [parent top-h-panel]
                        [callback (lambda (button event)
                                    (add-callback))]))

; Create a container list for keeping track of excercises
(define choices '())

(define savefile-path (build-path (current-directory) "savefile.txt"))

; Make sure a text file exists
(with-output-to-file savefile-path #:mode 'text #:exists 'append
  (lambda () (printf "")))

; §

(define get-savefile-contents
  (lambda ()
    (call-with-input-file savefile-path
      (lambda (in) (read-string in))))) ; TODO: Figure out how to read to the end of a file. Consider using read-line instead.

(define savefile-contents (get-savefile-contents))

(define read-savefile
  (lambda ()
    (string-split savefile-contents "§§§")))

; Populate choices
(set! choices (read-savefile))

(define list-display (new list-box%
                          [label ""]
                          [choices choices] ; TODO: Figure out how to load from sqlite
                          [parent bot-h-panel]))

; TODO: Figure out how to add an item at the of the list.
; TODO: Figure out how to add an item to sqlite.
(define add-callback
  (lambda ()
    (set! choices (cons (send item-input get-value) choices))
    (send list-display set choices)))

(define button-panel (new vertical-panel%
                         [parent bot-h-panel]
                         [alignment '(center center)]))

(define remove-button (new button%
                        [label "-"]
                        [parent button-panel]))

(define remove-index-from-list
  (lambda (x list)
    (list)))

(define remove-callback
  (lambda (x)
    (set! choices (remove-index-from-list x choices))
    (send list-display set choices)))

(define up-button (new button%
                        [label "^"]
                        [parent button-panel]))

(define down-button (new button%
                        [label "v"]
                        [parent button-panel]))

(send frame show #t)