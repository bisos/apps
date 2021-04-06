; Define the image rotation function
;rotate the images in here and save them to the rotation directory
(define (myrotate rotatedegrees infile outfile)
   (let* ((image (car (file-png-load 1 infile infile)))
          (drawable (car (gimp-image-active-drawable image)))
          (rotateradians (* rotatedegrees (/ 3.14159 180)))
         )

         (gimp-drawable-transform-rotate-default drawable rotateradians 0 150 150 0 1)

         (file-png-save 1 image drawable outfile outfile 
              1 0 0 0 0 0 0 )
            ; 1 Adam7 interlacing?
            ;   0 deflate compression factor (0-9)
            ;     0 Write bKGD chunk?
            ;       0 Write gAMMA chunk?
            ;         0 Write oFFs chunk?
            ;           0 Write tIME chunk?    ?? backwards in DB Browser
            ;             0 Write pHYS chunk?  ?? backwards in DB Browser
   )
)
; Define the looping function
(define (rotate-img Infile) 
	; Define the initial value of the rotation
	(set! xx 0)
	; Loop through each value of xx from 0 to 360 and do the image rotation for it.
	(while (< xx 360)
	; set the name of the current outfile
                (set! sx (number->string xx))
		(set! outfile (string-append sx ".png"))
		(myrotate xx Infile outfile)
		; Increment xx
		(set! xx (+ xx 1))
	)
)
; Finally register our script with script-fu.
(script-fu-register "rotate-img"
                    "Rotate image"
                    "Rotates an image through each of 0 to 360 degrees and saves a copy in the subdirectory of rotations"
                    "David Wees<dweesdesign@gmail.com>"
                    "David Wees - released under the GNU"
                    "2007-06-11"
                    ""
		    SF-FILENAME "Infile" "infile.png"
)

(script-fu-menu-register "rotate-img" "<Toolbox>/Xtns/Script-Fu/Misc")
