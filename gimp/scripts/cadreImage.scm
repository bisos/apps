
;;;
;;; Interactive ByStar Image Processing Extention
;;;

;;; (gimp-image-get-filename image)  -- Can be used to write the file afterwards

(define (bx-scale-cadre-to-1000x750 image drawable)
  (let*
      (
       (width (car (gimp-image-width image)))
       (height (car (gimp-image-height image)))
       )
    (if (< 750 height)
	(gimp-image-scale image (* width (/ 750 height)) 750)
      (if (< 1000 width)
	  (gimp-image-scale image 1000 (* height (/ 1000 width)))
	  )
      )
    )
  (gimp-image-resize image 1000 750
		     (/ (- 1000 (car (gimp-image-width image))) 2)
		     (/ (- 750 (car (gimp-image-height image))) 2)
		     )
  (gimp-context-set-background '( 0 0 0))
  (gimp-image-flatten image)
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
 "<Image>/ByStar/Image")

;;;
;;; Interactive+Batch ByStar Image Processing Extention
;;;

(define (bx-batch-scale-cadre-to-1000x750 filename)
  (let* ((image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
	 (drawable (car (gimp-image-get-active-layer image))))
    (bx-scale-cadre-to-1000x750 
     image 
     drawable)
    (set! drawable (car (gimp-image-get-active-layer image)))
    (gimp-file-save RUN-NONINTERACTIVE image drawable filename filename)
    (gimp-image-delete image)
    ))

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
 "<Image>/ByStar/Batch")


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
