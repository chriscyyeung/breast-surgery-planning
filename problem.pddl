(define (problem tumor-removal1) 

    (:domain breast-surgery)

    (:objects 
        docr - robot
        clean dirty container - location
        p1 - patient
        t - tumor
        c - cautery
        n - needle
    )

    (:init
        (on c clean)
        (on n clean)
        (hands-free docr)
        (in t p1)
        (attached t p1)
        (cautery-off c)
    )

    (:goal 
        (and (on t container)
             (on c dirty)
             (on n dirty)
             (cautery-off c))
    )

)
