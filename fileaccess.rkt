#lang racket

; savefile-path

(provide savefile-path)
(define savefile-path (build-path (current-directory) "savefile.txt"))

; read-savefile

(define savefile-contents (let ([ip (open-input-file savefile-path)])
      (read-line ip 'any)))

(provide read-savefile)
(define read-savefile
  (lambda ()
    (string-split savefile-contents "§§§")))

; save-to-file

(define list-to-string
  (lambda (str list)
    (if
     (null? list) str
     (list-to-string (string-append (string-append str "§§§") (car list)) (cdr list)))))

(provide save-to-file)
(define save-to-file
  (lambda (l)
    (with-output-to-file savefile-path #:mode 'text #:exists 'replace
      (lambda () (printf (list-to-string "" l))))))
