
;;;
;;; Interactive ByStar Image Processing Extention
;;;

;;; (gimp-image-get-filename image)  -- Can be used to write the file afterwards

(define (bx-scale-height-to image drawable inHeight)
  (let*
      (
       (width (car (gimp-image-width image)))
       (height (car (gimp-image-height image)))
       (scaledWidth (* width (/ inHeight height)))
       )
    (if (< inHeight height)
	(gimp-image-scale image scaledWidth inHeight)
    	(gimp-image-resize image 
			   scaledWidth
			   inHeight 
			   0
			   0
			   )
	(gimp-context-set-background '( 0 0 0))
	(gimp-image-flatten image)
	)
    )
  )

(script-fu-register 
 "bx-scale-height-to"
 "/Image/Scale Height To"
 "Given a inHeight canvas, scales an image to fit right centered"
 "ByStar"
 "by-star.net"
 "June 2013"
 "RGB* GRAY*"
 SF-IMAGE "Image" 0
 SF-DRAWABLE "Drawable" 0
 SF-VALUE "Width Size" "1000"            ;; inHeight
 ) 

(script-fu-menu-register 
 "bx-scale-height-to" 
 "<Image>/ByStar/Image/ScaleHeight")

;;;
;;;  Interactive
;;;

(define (bx-scale-height-to-200 image drawable)
  (bx-scale-height-to image drawable 200)
  )

(script-fu-register 
 "bx-scale-height-to-200"
 "/Image/Scale Height To 200"
 "Given a 1000x750 canvas, scales an image to fit right centered"
 "ByStar"
 "by-star.net"
 "June 2013"
 "RGB* GRAY*"
 SF-IMAGE "Image" 0
 SF-DRAWABLE "Drawable" 0
 ) 

(script-fu-menu-register 
 "bx-scale-height-to-200" 
 "<Image>/ByStar/Image/ScaleHeight")

;;;
;;;  Interactive
;;;

(define (bx-scale-height-to-50 image drawable)
  (bx-scale-height-to image drawable 50)
  )

(script-fu-register 
 "bx-scale-height-to-50"
 "/Image/Scale Height To 50"
 "Given a 100x75 canvas, scales an image to fit right centered"
 "ByStar"
 "by-star.net"
 "June 2013"
 "RGB* GRAY*"
 SF-IMAGE "Image" 0
 SF-DRAWABLE "Drawable" 0
 ) 

(script-fu-menu-register 
 "bx-scale-height-to-50" 
 "<Image>/ByStar/Image/ScaleHeight")

;;;
;;; BATCH functions
;;;
;;; Interactive+Batch ByStar Image Processing Extention
;;;

(define (bx-batch-scale-height-to filename inHeight)
  (let* ((image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
	 (drawable (car (gimp-image-get-active-layer image))))
    (bx-scale-height-to
     image 
     drawable
     inHeight
     )
    (set! drawable (car (gimp-image-get-active-layer image)))
    (gimp-file-save RUN-NONINTERACTIVE image drawable filename filename)
    (gimp-image-delete image)
    ))

(script-fu-register 
 "bx-batch-scale-height-to"                    ; Func Name
 "/Batch/Scale Height-To"                 ; Menu Label
 "Given a inHeight X inHeight canvas, scales an image to fit right centered"
 "ByStar"                                          ; Author
 "by-star.net"                                     ; Copyleft
 "June 2013"                                       ; Date Created
 ""                                                ; Image Type
 SF-STRING "Path to source image" "filename.jpg"   ; A String Variable
 SF-VALUE "Width Size" "1000"                      ;; inHeight
 ) 

(script-fu-menu-register 
 "bx-batch-scale-height-to" 
 "<Image>/ByStar/Batch/ScaleHeight")

;;;
;;; Batch 1000x750
;;;

(define (bx-batch-scale-height-to-200 filename)
  (bx-batch-scale-height-to-200 filename 1000 750)
  )

(script-fu-register 
 "bx-batch-scale-height-to-200"                   ; Func Name
 "/Batch/Scale Height To 200"               ; Menu Label
 "Given a 1000x750 canvas, scales an image to fit right centered"
 "ByStar"                                          ; Author
 "by-star.net"                                     ; Copyleft
 "June 2013"                                       ; Date Created
 ""                                                ; Image Type
 SF-STRING "Path to source image" "filename.jpg"   ; A String Variable
 ) 

(script-fu-menu-register 
 "bx-batch-scale-height-to-200" 
 "<Image>/ByStar/Batch/ScaleHeight")
