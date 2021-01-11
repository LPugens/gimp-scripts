(
  define
  (
    resize-image-keep-ratio pattern ratio
  )
  (
    let* 
    (
      (
        filelist 
        (
          cadr 
          (
            file-glob pattern 1
          )
        )
      )
    ) 
    (
      while 
      (
        not 
        (
          null? filelist
        )
      ) 
      (
        let* 
        (
          (
            filename 
            (
              car filelist
            )
          )
          (
            image 
            (
              car 
              (
                gimp-file-load RUN-NONINTERACTIVE filename filename
              )
            )
          ) 
          (
            cur-width  
            (
              car 
              (
                gimp-image-width image
              )
            )
          )
          (
            cur-height 
            (
              car 
              (
                gimp-image-height image
              )
            )
          )
          (
            width      
            (
              * ratio cur-width
            )
          )
          (
            height     
            (
              * ratio cur-height
            )
          )
          (
            drawable 
            (
              car 
              (
                gimp-image-active-drawable image
              )
            )
          )
        ) 
        (
          gimp-image-scale image width height
        )
        (
          gimp-file-save RUN-NONINTERACTIVE image drawable filename filename
        ) 
        (
          gimp-image-delete image
        )
      )
      (
        set! filelist 
        (
          cdr filelist
        )
      )
    )
  )
)
