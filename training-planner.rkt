#lang racket

(require racket/gui)
(require "fileaccess.rkt")

(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? cdr l))
      (else #f))))

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

; Make sure a text file exists
(with-output-to-file savefile-path #:mode 'text #:exists 'append
  (lambda () (printf "")))

; Populate choices
(set! choices (read-savefile))

(define list-display (new list-box%
                          [label ""]
                          [choices choices]
                          [parent bot-h-panel]
                          [callback (lambda (list-box event)
                                      (send item-input set-value (send list-display get-string-selection)))]))

(define add-callback
  (lambda ()
    (set! choices (cons (send item-input get-value) choices))
    (save-to-file choices)
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