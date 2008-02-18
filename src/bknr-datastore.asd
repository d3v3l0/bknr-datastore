;; -*-Lisp-*-

(in-package :cl-user)

(defpackage :bknr-datastore.system
  (:use :cl :asdf))

(in-package :bknr-datastore.system)

(defsystem :bknr-datastore
  :name "baikonour datastore"
  :author "Hans Huebner <hans@huebner.org>"
  :author "Manuel Odendahl <manuel@bl0rg.net>"
  :version "0"
  :maintainer "Manuel Odendahl <manuel@bl0rg.net>"
  :licence "BSD"
  :description "baikonour - launchpad for lisp satellites"

  :depends-on (:cl-interpol
               :closer-mop
               :unit-test
               :bknr-utils
               :bknr-indices)

  :components ((:module "data" :components ((:file "package")
                                            (:file "encoding" :depends-on ("package"))
                                            (:file "txn" :depends-on ("encoding" "package"))
                                            (:file "object" :depends-on ("txn" "package"))
                                            (:file "blob" :depends-on ("txn" "object" "package"))))))

(defsystem :bknr-datastore-test  
  :depends-on (:bknr-datastore :FiveAM)
  :components ((:module "data" :components ((:file "encoding-test")
                                            ))))

(defmethod asdf:perform ((op asdf:test-op) (system (eql (find-system :bknr-datastore))))
  (asdf:oos 'asdf:load-op :bknr-datastore-test)
  (funcall (intern (string :run!) (string :it.bese.FiveAM)) :bknr.datastore))
