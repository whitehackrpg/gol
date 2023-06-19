# Conway's Game of Life

This is a Lisp implementation of Conway's Game of Life. It's using cl-blt for the display atm, so you will want to install that first. Then clone this repository and soft-link it in your quicklisp/local-projects directory. Then`(ql:quickload :gol)`, `(in-package :gol)` and `(game-of-life *gosper*)`. The keys are ESC to quit, Space to pause, j to wind back and k to wind forward. The windback buffer holds 100 frames.

https://github.com/whitehackrpg/gol/assets/130791778/abfd9a0f-c663-458e-88ec-331abbf0660b



