(define (problem breast-surgery1) 

    (:domain breast-surgery)

    (:objects 
        t - tumor
        c - cautery
        n - needle
        g - gripper
    )

    (:init
        (holding c)
        (holding n)
        (holding g)
        (tool-active g)
        (gripper-free)
        (cautery-off)
        (needle-removed)
        (tumor-attached)
        (tumor-in)
    )

    (:goal 
        (and (needle-removed)
             (tumor-excised)
             (tumor-removed)
             (cautery-off)
             (gripper-free))
    )

)
