;Domain specification of breast cancer surgery.

(define (domain breast-surgery)

    (:requirements 
        :equality
        :typing 
        :adl
        :negative-preconditions
    )

    (:types
        holdable tumor reims - object
        cautery needle ultrasound gripper - holdable
    )

    (:predicates
        (holding ?h - holdable)
        (tool-active ?h - holdable)
        (gripping ?o - object)
        (gripper-free)
        (cautery-on)
        (cautery-off)
        (needle-inserted)
        (needle-removed)
        (tumor-attached)
        (tumor-excised)
        (tumor-in)
        (tumor-removed)
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
                           (needle-removed)
                           (tumor-attached)
                           (tumor-in))
        :effect (and (not (tool-active ?n))
                     (not (needle-removed))
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
                           (tumor-in))
        :effect (and (not (needle-inserted))          
                     (not (gripper-free))
                     (needle-removed)  
                     (gripping ?n))
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
                           (cautery-on)
                           (needle-inserted)
                           (tumor-attached))
        :effect (and (not (tumor-attached))
                     (tumor-excised))
    )
    
    (:action remove-tumor
        :parameters (?g - gripper ?t - tumor)
        :precondition (and (tool-active ?g)
                           (gripper-free)
                           (needle-removed)
                           (tumor-excised)
                           (tumor-in))
        :effect (and (not (gripper-free))
                     (not (tumor-in))
                     (tumor-removed)
                     (gripping ?t))
    )
    
)