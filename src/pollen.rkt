#lang racket
(require pollen/tag)

(define link (default-tag-function 'a))

(provide post-card)
(provide personal-link)
(provide post-heading)

(define (post-card #:to to #:title title #:description [description "???"])
  `(a ((class "border border-rose-500 p-2 flex flex-col gap-3") (href ,to))
      (h3 ((class "text-xl")) ,title)
      (span ((class "flex-1")) ,description)
      (div ((class "flex flex-row gap-2"))
           (span ((class "border border-pink-500 rounded-lg p-1")) "???"))))

(define (personal-link #:label label #:subtext [subtext ""] #:url url #:class classes)
  (define class-list (string-join (list "rounded-full border border-pink-500 flex items-center justify-center block flex flex-col" classes)))
  `(a ((class ,class-list) (href ,url)) ,label (span ,subtext)))

(define (post-heading #:heading heading #:id id)
  (define ref (string-append "#" id))
  `(h2 ((id ,id)) (a ((class "text-blue-500 underline") (href ,ref)) "# " ,heading)))
