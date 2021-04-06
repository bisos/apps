
;;;
;;; Interactive ByStar Image Processing Extention
;;;

;;; (gimp-image-get-filename image)  -- Can be used to write the file afterwards

(define (bx-scale-width-to image drawable inWidth)
  (let*
      (
       (width (car (gimp-image-width image)))
       (height (car (gimp-image-height image)))
       (scaledHeight (* height (/ inWidth width)))
       )
    (if (< inWidth width)
	(gimp-image-scale image inWidth scaledHeight)
	(gimp-image-resize image 
			   inWidth 
			   scaledHeight
			   0
			   0
			   )

	(gimp-context-set-background '( 0 0 0))
	(gimp-image-flatten image)
	)
    )
  )

(script-fu-register 
 "bx-scale-width-to"
 "/Image/Scale Width To"
 "Given a inWidth canvas, scales an image to fit right centered"
 "ByStar"
 "by-star.net"
 "June 2013"
 "RGB* GRAY*"
 SF-IMAGE "Image" 0
 SF-DRAWABLE "Drawable" 0
 SF-VALUE "Width Size" "1000"            ;; inWidth
 ) 

(script-fu-menu-register 
 "bx-scale-width-to" 
 "<Image>/ByStar/Image/ScaleWidth")

;;;
;;;  Interactive
;;;

(define (bx-scale-width-to-200 image drawable)
  (bx-scale-width-to image drawable 200)
  )

(script-fu-register 
 "bx-scale-width-to-200"
 "/Image/Scale Width To 200"
 "Given a 1000x750 canvas, scales an image to fit right centered"
 "ByStar"
 "by-star.net"
 "June 2013"
 "RGB* GRAY*"
 SF-IMAGE "Image" 0
 SF-DRAWABLE "Drawable" 0
 ) 

(script-fu-menu-register 
 "bx-scale-width-to-200" 
 "<Image>/ByStar/Image/ScaleWidth")

;;;
;;;  Interactive
;;;

(define (bx-scale-width-to-50 image drawable)
  (bx-scale-width-to image drawable 50)
  )

(script-fu-register 
 "bx-scale-width-to-50"
 "/Image/Scale Width To 50"
 "Given a 100x75 canvas, scales an image to fit right centered"
 "ByStar"
 "by-star.net"
 "June 2013"
 "RGB* GRAY*"
 SF-IMAGE "Image" 0
 SF-DRAWABLE "Drawable" 0
 ) 

(script-fu-menu-register 
 "bx-scale-width-to-50" 
 "<Image>/ByStar/Image/ScaleWidth")

;;;
;;; BATCH functions
;;;
;;; Interactive+Batch ByStar Image Processing Extention
;;;

(define (bx-batch-scale-width-to filename inWidth)
  (let* ((image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
	 (drawable (car (gimp-image-get-active-layer image))))
    (bx-scale-width-to
     image 
     drawable
     inWidth
     )
    (set! drawable (car (gimp-image-get-active-layer image)))
    (gimp-file-save RUN-NONINTERACTIVE image drawable filename filename)
    (gimp-image-delete image)
    ))

(script-fu-register 
 "bx-batch-scale-width-to"                    ; Func Name
 "/Batch/Scale Width-To"                 ; Menu Label
 "Given a inWidth X inWidth canvas, scales an image to fit right centered"
 "ByStar"                                          ; Author
 "by-star.net"                                     ; Copyleft
 "June 2013"                                       ; Date Created
 ""                                                ; Image Type
 SF-STRING "Path to source image" "filename.jpg"   ; A String Variable
 SF-VALUE "Width Size" "1000"                      ;; inWidth
 ) 

(script-fu-menu-register 
 "bx-batch-scale-width-to" 
 "<Image>/ByStar/Batch/ScaleWidth")

;;;
;;; Batch 1000x750
;;;

(define (bx-batch-scale-width-to-200 filename)
  (bx-batch-scale-width-to-200 filename 1000 750)
  )

(script-fu-register 
 "bx-batch-scale-width-to-200"                   ; Func Name
 "/Batch/Scale Width To 200"               ; Menu Label
 "Given a 1000x750 canvas, scales an image to fit right centered"
 "ByStar"                                          ; Author
 "by-star.net"                                     ; Copyleft
 "June 2013"                                       ; Date Created
 ""                                                ; Image Type
 SF-STRING "Path to source image" "filename.jpg"   ; A String Variable
 ) 

(script-fu-menu-register 
 "bx-batch-scale-width-to-200" 
 "<Image>/ByStar/Batch/ScaleWidth")
