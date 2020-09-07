#lang racket

(require racket/gui)
(require sqlite-table)

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

(define choices '())

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

(define up-button (new button%
                        [label "^"]
                        [parent button-panel]))

(define down-button (new button%
                        [label "v"]
                        [parent button-panel]))

(send frame show #t)