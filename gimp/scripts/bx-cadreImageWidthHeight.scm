
;;;
;;; Interactive ByStar Image Processing Extention
;;;

;;; (gimp-image-get-filename image)  -- Can be used to write the file afterwards

(define (bx-scale-cadre-to-width-height image drawable inWidth inHeight)
  (let*
      (
       (width (car (gimp-image-width image)))
       (height (car (gimp-image-height image)))
       )
    (if (< inHeight height)
	(gimp-image-scale image (* width (/ inHeight height)) inHeight)
      (if (< inWidth width)
	  (gimp-image-scale image inWidth (* height (/ inWidth width)))
	  )
      )
    )
  (gimp-image-resize image inWidth inHeight
		     (/ (- inWidth (car (gimp-image-width image))) 2)
		     (/ (- inHeight (car (gimp-image-height image))) 2)
		     )
  (gimp-context-set-background '( 0 0 0))
  (gimp-image-flatten image)
  )

(script-fu-register 
 "bx-scale-cadre-to-width-height"
 "/Image/Scale And Cadre (inWidth X inHeight)"
 "Given a inWidth X inHeight canvas, scales an image to fit right centered"
 "ByStar"
 "by-star.net"
 "June 2013"
 "RGB* GRAY*"
 SF-IMAGE "Image" 0
 SF-DRAWABLE "Drawable" 0
 SF-VALUE "Width Size" "1000"            ;; inWidth
 SF-VALUE "Height Size" "750"            ;; inHeight
 ) 

(script-fu-menu-register 
 "bx-scale-cadre-to-width-height" 
 "<Image>/ByStar/Image/ScaleCadre")

;;;
;;;  Interactive 1000x750
;;;

(define (bx-scale-cadre-to-1000x750 image drawable)
  (bx-scale-cadre-to-width-height image drawable 1000 750)
  )

(script-fu-register 
 "bx-scale-cadre-to-1000x750"
 "/Image/Scale And Cadre (1000x750)"
 "Given a 1000x750 canvas, scales an image to fit right centered"
 "ByStar"
 "by-star.net"
 "June 2013"
 "RGB* GRAY*"
 SF-IMAGE "Image" 0
 SF-DRAWABLE "Drawable" 0
 ) 

(script-fu-menu-register 
 "bx-scale-cadre-to-1000x750" 
 "<Image>/ByStar/Image/ScaleCadre")

;;;
;;;  Interactive 100x75
;;;

(define (bx-scale-cadre-to-100x75 image drawable)
  (bx-scale-cadre-to-width-height image drawable 100 75)
  )

(script-fu-register 
 "bx-scale-cadre-to-100x75"
 "/Image/Scale And Cadre (100x75)"
 "Given a 100x75 canvas, scales an image to fit right centered"
 "ByStar"
 "by-star.net"
 "June 2013"
 "RGB* GRAY*"
 SF-IMAGE "Image" 0
 SF-DRAWABLE "Drawable" 0
 ) 

(script-fu-menu-register 
 "bx-scale-cadre-to-100x75" 
 "<Image>/ByStar/Image/ScaleCadre")

;;;
;;; BATCH functions
;;;
;;; Interactive+Batch ByStar Image Processing Extention
;;;

(define (bx-batch-scale-cadre-to-width-height filename inWidth inHeight)
  (let* ((image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
	 (drawable (car (gimp-image-get-active-layer image))))
    (bx-scale-cadre-to-width-height
     image 
     drawable
     inWidth
     inHeight
     )
    (set! drawable (car (gimp-image-get-active-layer image)))
    (gimp-file-save RUN-NONINTERACTIVE image drawable filename filename)
    (gimp-image-delete image)
    ))

(script-fu-register 
 "bx-batch-scale-cadre-to-width-height"                    ; Func Name
 "/Batch/Scale And Cadre (Width X Height)"                 ; Menu Label
 "Given a inWidth X inHeight canvas, scales an image to fit right centered"
 "ByStar"                                          ; Author
 "by-star.net"                                     ; Copyleft
 "June 2013"                                       ; Date Created
 ""                                                ; Image Type
 SF-STRING "Path to source image" "filename.jpg"   ; A String Variable
 SF-VALUE "Width Size" "1000"                      ;; inWidth
 SF-VALUE "Height Size" "750"                      ;; inHeight
 ) 

(script-fu-menu-register 
 "bx-batch-scale-cadre-to-width-height" 
 "<Image>/ByStar/Batch/ScaleCadre")

;;;
;;; Batch 1000x750
;;;

(define (bx-batch-scale-cadre-to-1000x750 filename)
  (bx-batch-scale-cadre-to-width-height filename 1000 750)
  )

(script-fu-register 
 "bx-batch-scale-cadre-to-1000x750"                   ; Func Name
 "/Batch/Scale And Cadre (1000x750)"               ; Menu Label
 "Given a 1000x750 canvas, scales an image to fit right centered"
 "ByStar"                                          ; Author
 "by-star.net"                                     ; Copyleft
 "June 2013"                                       ; Date Created
 ""                                                ; Image Type
 SF-STRING "Path to source image" "filename.jpg"   ; A String Variable
 ) 

(script-fu-menu-register 
 "bx-batch-scale-cadre-to-1000x750" 
 "<Image>/ByStar/Batch/ScaleCadre")

;;;
;;; Batch 100x75
;;;

(define (bx-batch-scale-cadre-to-100x75 filename)
  (bx-batch-scale-cadre-to-width-height filename 100 75)
  )

(script-fu-register 
 "bx-batch-scale-cadre-to-100x75"                   ; Func Name
 "/Batch/Scale And Cadre (100x75)"               ; Menu Label
 "Given a 100x75 canvas, scales an image to fit right centered"
 "ByStar"                                          ; Author
 "by-star.net"                                     ; Copyleft
 "June 2013"                                       ; Date Created
 ""                                                ; Image Type
 SF-STRING "Path to source image" "filename.jpg"   ; A String Variable
 ) 

(script-fu-menu-register 
 "bx-batch-scale-cadre-to-100x75" 
 "<Image>/ByStar/Batch/ScaleCadre")


;;;
;;; JunkYARD
;;;


(define (scale-to-block-byStar image drawable size)
  (let*
      (
       (width (car (gimp-image-width image)))
       (height (car (gimp-image-height image)))
       )
    (if (> width height)
	(gimp-image-scale image size (* height (/ size width)))
	(gimp-image-scale image (* width (/ size height)) size)
	)
    )
  (gimp-image-resize image size size
		     (/ (- size (car (gimp-image-width image))) 2)
		     (/ (- size (car (gimp-image-height image))) 2)
		     )
  (gimp-context-set-background '( 0 0 0))
  (gimp-image-flatten image)
  )

(script-fu-register "scale-to-block-byStar"
		    "/Image/Scale To Block"
		    "Scales an image to a given size then makes the canvas a square with the image centered"
		    "ByStar"
		    "by-star.net"
		    "June 2013"
		    "RGB* GRAY*"
		    SF-IMAGE "Image" 0
		    SF-DRAWABLE "Drawable" 0
		    SF-VALUE "Block Size" "32"
		    ) 

 (script-fu-menu-register "scale-to-block-byStar" "<Image>/File/Create/Text")
