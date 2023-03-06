# Breast Surgery Planning

This repository contains a task planning model for robot-assisted breast cancer surgery. The code is written in PDDL following the FOND formalism. The tissue is represented as a cube where each position can be excised from the patient. Various steps need to be completed prior to excising the tissue, such as insertion of a localization needle, calibrating of the cautery, and scanning the tissue using a mass spectrometer. The non-determinism comes from the uncertainty of which tissue position is cancerous/healthy and the possibility of imcomplete tumor excision when cutting.
