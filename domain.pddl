; Domain specification of breast cancer surgery.

(define (domain breast-surgery)

    (:requirements 
        :equality
        :typing 
        :adl
        :negative-preconditions
        :non-deterministic
    )

    (:types
        holdable reims tumor x y z - object
        cautery needle ultrasound gripper - holdable
    )

    (:predicates
        (holding ?h - holdable)
        (tool-active ?h - holdable)
        (gripping ?o - object)
        (gripper-free)
        (cautery-on)
        (cautery-off)
        (cautery-calibrated)
        (needle-inserted)
        (tumor-excised)
        (tumor-removed)
        (adjacent ?x1 ?y1 ?z1 ?x2 ?y2 ?z2 - axis)
        (tumor-at ?x ?y ?z - axis)
    )

    (:action drop
        :parameters (?o - object)
        :precondition (and (gripping ?o))
        :effect (and (not (gripping ?o))
                     (gripper-free))
    )
    

    (:action switch-tool
        :parameters (?o1 ?o2 - holdable)
        :precondition (and (tool-active ?o1)
                           (holding ?o2))
        :effect (and (not (tool-active ?o1))
                     (tool-active ?o2))
    )

    ; TODO: robot can miss the center of the tumor
    (:action insert-needle
        :parameters (?n - needle ?g - gripper)
        :precondition (and (tool-active ?n)
                           (not (needle-inserted))
                           (not (tumor-excised))
                           (not (tumor-removed)))
        :effect (and (not (tool-active ?n))
                     (not (holding ?n))
                     (tool-active ?g)
                     (needle-inserted))
    )
    
    (:action remove-needle
        :parameters (?n - needle ?g - gripper)
        :precondition (and (tool-active ?g)
                           (gripper-free)
                           (needle-inserted)
                           (tumor-excised)
                           (not (tumor-removed)))
        :effect (and (not (needle-inserted))          
                     (not (gripper-free)) 
                     (gripping ?n))
    )

    (:action calibrate-cautery
        :parameters (?c - cautery)
        :precondition (and (tool-active ?c))
        :effect (and (cautery-calibrated))
    )
    
    
    (:action power-cautery
        :parameters (?c - cautery)
        :precondition (and (tool-active ?c))
        :effect (and (when (cautery-on)
                        (and (cautery-off)
                             (not (cautery-on))))
                     (when (cautery-off)
                        (and (cautery-on)
                             (not (cautery-off)))))
    )
    
    ; TODO: geometric bit-blasting?
    (:action cut
        :parameters (?c - cautery)
        :precondition (and (tool-active ?c)
                           (cautery-calibrated)
                           (cautery-on)
                           (needle-inserted)
                           (not (tumor-excised)))
        :effect (and (tumor-excised))
    )
    
    (:action remove-tumor
        :parameters (?g - gripper ?t - tumor)
        :precondition (and (tool-active ?g)
                           (gripper-free)
                           (tumor-excised)
                           (not (needle-inserted))
                           (not (tumor-removed)))
        :effect (and (not (gripper-free))
                     (tumor-removed)
                     (gripping ?t))
    )
    
)