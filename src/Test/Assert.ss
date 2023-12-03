(library (Test.Assert foreign)
  (export assertImpl checkThrows)
  (import (chezscheme)
          (only (purs runtime bytestring) bytestring->string))

  (define assertImpl
    (lambda (message)
      (lambda (success)
        (lambda ()
          (if (not success) 
            (raise-continuable
              (condition
                (make-message-condition (bytestring->string message)))))))))

  (define checkThrows
    (lambda (fn)
      (lambda ()
        (call/cc (lambda (k)
          (with-exception-handler
            (lambda (e) (k #t))
            (lambda () (begin (fn 'unit) #f))))))))

  )
