(ql:quickload :cl-bunny.examples)

(in-package :cl-bunny.examples)

(let ((args (cdr sb-ext:*posix-argv*)))
  (if args
      (with-connection ("amqp://")
        (with-channel ()
          (let ((args (cdr sb-ext:*posix-argv*))
                (q (queue.declare :auto-delete t)))
            (loop for severity in args do
                     (queue.bind q "topic_logs" :routing-key severity))
            (format t " [*] Waiting for logs. To exit type (exit)~%")
            (subscribe q (lambda (message)
                           (let ((body (message-body-string message)))
                             (format t " [x] #~a~%" body)))
                       :type :sync)
            (consume))))
      (error "Usage: #{$0} [binding key]")))
