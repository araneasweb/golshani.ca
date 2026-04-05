---
title: projects
---

Racket-ish Compiler
--------------------------

An end-to-end compiler for a Racket-like language in Typed Racket.

Designed type-preserving compiler passes with a guarantee that every
intermediate representation remained well typed; used RackCheck
property-based testing to validate pass invariants and compiler
correctness. Implemented graph-colouring register allocation with
liveness/conflict analysis and a closure-conversion pipeline for
first-class procedures, including free-variable analysis, lambda
hoisting, and closure lowering.

Benchmarked generated binaries against gcc -O2, Racket, and GHC -O2;
in tested workloads, the compiler produced faster executables with a
smaller runtime binary than equivalent C -O3 builds.

Capability-Based Multikernel OS
--------------------------------------

A Barrelfish-inspired research OS on ARMv8-A, centered on
capability-based resource management, self-paging virtual memory, and
user-space process creation.

Built a shadow-page-table-backed paging system with page-fault
handling, foreign-address-space mapping for process spawning, and
serialized paging-state transfer between parent and child processes.
Implemented cross-core process management and RPC over shared-memory
UMP, including fragmentation, reply routing across LMP/UMP, and
multicore communication primitives.

Extended Hake to support Nix-based reproducible builds and optimized
large-frame mapping with a greedy spill strategy delivering nearly
70× better mapping performance.

SQL-like Data Querying DSL
---------------------------------

An extensible SQL-style query language for filtering and aggregating
structured datasets.

Built a service layer that returns 50k+ results in under a second,
supporting pagination and complex predicates. Shipped a
functional-reactive UI for importing and querying arbitrary datasets
with a clean end-to-end workflow.

Turing Machine Visualiser
--------------------------------

A Haskell + GTK3 visualiser for Turing machines.

Created an IDE for Brainfuck featuring step-through execution, reverse
stepping, and live tape visualization. Encoded Turing machines with
compile-time guarantees for well-formed machines and valid
transitions. Represented the tape as a lazily-evaluated infinite
structure to support unbounded execution.

SAT-Based Circuit Designer and Simulator
-----------------------------------------------

An extensible circuit simulator and visual editor built with Prolog,
C, and GTK3.

Designed circuit simulation where components are defined as n-arity
Prolog clauses. Built a visual circuit editor with a real-time
simulation engine in C + GTK3 interfacing with the clause database.
Implemented SAT solving for combinational logic circuits using
unification and backtracking.

Agentic Research Loop for Nonprofit Newsletters
------------------------------------------------------

An agentic research system on GCP that searches the web, evaluates
source trustworthiness, and generates update newsletters and emails
for nonprofit campaigns.

Implemented evidence-backed generation workflows in Python,
TypeScript, and PostgreSQL, restricting outputs to explicitly
verifiable, source-backed factual claims. Used Vertex AI, Google ADK,
RAG, Nix, and external APIs to support reliable deployment and
reusable content-generation pipelines.
