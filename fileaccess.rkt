#lang racket

; read-savefile

(define savefile-contents
  (lambda (path)
    (let ([ip (open-input-file path)])
      (read-line ip 'any))))

(provide read-savefile)
(define (read-savefile path)
  (define (ifeof val)
    (if (eof-object? val)
        ""
        val))
  (string-split (ifeof (savefile-contents path)) "§§§"))

; save-to-file

(define list-to-string
  (lambda (str list)
    (if
     (null? list) str
     (list-to-string (string-append (string-append str "§§§") (car list)) (cdr list)))))

(provide save-to-file)
(define save-to-file
  (lambda (l path)
    (with-output-to-file path #:mode 'text #:exists 'replace
      (lambda () (printf (list-to-string "" l))))))
