(in-package :cl-user)

(defpackage :cl-bunny.system
  (:use :cl :asdf))

(in-package :cl-bunny.system)

(defsystem :cl-bunny
  :version "0.1"
  :description "High-level interface for cl-rabbit"  
  :maintainer "Ilya Khaprov <ilya.khaprov@publitechs.com>"
  :author "Ilya Khaprov <ilya.khaprov@publitechs.com>"
  :licence "MIT"
  :depends-on ("alexandria"
               "string-case"
               "cl-amqp"
               "iolib"
               "cl-rabbit"
               "quri"
               "lparallel"
               "blackbird"
               "safe-queue"
               "eventfd"
               "log4cl")
  :components ((:module "src"
                :serial t
                :components
                ((:file "package")
                 (:module "support"
                  :serial t
                  :components
                  ((:file "int-allocator")
                   (:file "channel-id-allocator")
                   (:file "threaded-promise")))
                 (:file "conditions")
                 (:file "properties-and-headers")
                 (:module "connection"
                  :serial t
                  :components
                  ((:file "spec")
                   (:file "connection-base")
                   (:file "pool")
                   (:file "threaded-connection")
                   (:file "librabbitmq")
                   (:file "channel")))
                 (:file "message")
                 (:file "queue")
                 (:file "exchange")
                 (:file "consumer")
                 (:file "basic")
                 (:file "confirm")
                 (:file "tx")))))
