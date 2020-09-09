#lang racket

; Add an item to the end of a list

(provide add-end)
(define add-end
  (lambda (list item)
    (cond
      ((null? list) (cons item (quote())))
      (else (cons (car list) (add-end (cdr list) item))))))

; Add an item after a specified index/item in a list

(provide add-index)
(define add-index
  (lambda (list item iitem)
    (cond
      ((null? list) (quote()))
      ((eq? iitem (car list)) (cons (car list) (cons item (cdr list))))
      (else (cons (car list) (add-index (cdr list) item iitem))))))

;(add-index '("a" "b" "c") "b" "g")

; TODO: Delete a specific item/index from a list

; TODO: Move an item one place left in a list

; TODO: Move an item one place right in a list
