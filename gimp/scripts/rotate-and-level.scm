;;;

(define (batch-rotate pattern rotate-type)
  (let* ((filelist (cadr (file-glob pattern 1))))
    (while (not (null? filelist))
           (let* ((filename (car filelist))
                  (image (car (gimp-file-load RUN-NONINTERACTIVE
                                              filename filename)))
                  (drawable (car (gimp-image-get-active-layer image))))
             (set! filename (strbreakup filename "."))
             (set! filename (butlast filename))
             (set! filename (string-append (unbreakupstr filename ".") ".png"))
             (gimp-image-rotate image rotate-type)
             (gimp-levels-stretch drawable)
             (gimp-file-save RUN-NONINTERACTIVE
                             image drawable filename filename)
             (gimp-image-delete image))
           (set! filelist (cdr filelist)))))
