;Domain specification of breast cancer surgery. Needle must be 
;inserted prior to tumor removal to localize tumor.

(define (domain breast-surgery)

    (:requirements 
        :strips 
        :typing 
        :negative-preconditions
    )

    (:types
        robot location locatable - object
        cautery needle tumor - locatable
        patient - location
    )

    (:predicates
        (on ?o - locatable ?loc - location)
        (holding ?rob - robot ?o - locatable)
        (hands-free ?rob - robot)
        (in ?o - locatable ?p - patient)
        (attached ?t - tumor ?p - patient)
        (cautery-off ?c - cautery)
    )

    (:action pickup
        :parameters (?rob - robot ?o - locatable ?loc - location)
        :precondition (and (on ?o ?loc)
                           (hands-free ?rob))
        :effect (and (not (hands-free ?rob))
                     (not (on ?o ?loc))
                     (holding ?rob ?o))
    )

    (:action drop
        :parameters (?rob - robot ?o - locatable ?loc - location)
        :precondition (and (holding ?rob ?o))
        :effect (and (not (holding ?rob ?o))
                     (hands-free ?rob)
                     (on ?o ?loc))
    )

    (:action insert-needle
        :parameters (?rob - robot ?n - needle ?t - tumor ?p - patient)
        :precondition (and (holding ?rob ?n)
                           (in ?t ?p)
                           (attached ?t ?p))
        :effect (and (not (holding ?rob ?n))
                     (hands-free ?rob)
                     (in ?n ?p))
    )
    
    (:action remove-needle
        :parameters (?rob - robot ?n - needle ?t - tumor ?p - patient)
        :precondition (and (hands-free ?rob)
                           (in ?n ?p)
                           (in ?t ?p)
                           (not (attached ?t ?p)))
        :effect (and (not (in ?n ?p))
                     (not (hands-free ?rob))
                     (holding ?rob ?n))
    )
    
    (:action power-on-cautery
        :parameters (?rob - robot ?c - cautery)
        :precondition (and (holding ?rob ?c)
                           (cautery-off ?c))
        :effect (and (not (cautery-off ?c)))
    )
    
    (:action power-off-cautery
        :parameters (?rob - robot ?c - cautery)
        :precondition (and (holding ?rob ?c)
                           (not (cautery-off ?c)))
        :effect (and (cautery-off ?c))
    )
    
    (:action cut
        :parameters (?rob - robot ?c - cautery ?n - needle ?t - tumor ?p - patient)
        :precondition (and (holding ?rob ?c)
                           (in ?n ?p)
                           (in ?t ?p)
                           (attached ?t ?p)
                           (not (cautery-off ?c)))
        :effect (and (not (attached ?t ?p)))
    )
    
    (:action remove-tumor
        :parameters (?rob - robot ?n - needle ?t - tumor ?p - patient)
        :precondition (and (hands-free ?rob)
                           (in ?t ?p)
                           (not (in ?n ?p))
                           (not (attached ?t ?p)))
        :effect (and (not (in ?t ?p))
                     (not (hands-free ?rob))
                     (holding ?rob ?t))
    )
    
)