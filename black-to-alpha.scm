
(
  define
  (
    black-to-alpha pattern
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
          plug-in-colortoalpha 1 image drawable '(0 0 0)
        )
        (
          gimp-file-save RUN-NONINTERACTIVE image drawable (string-append filename ".png") (string-append filename ".png")
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
