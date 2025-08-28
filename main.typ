#import "@preview/ilm:1.4.1": *
#import "@preview/diagraph:0.3.5": raw-render

#set text(lang: "en")

#show: ilm.with(
  title: [How to Become A\ Distributed Systems Engineer],
  author: "Sienna Meridian Satterwhite",
  date: datetime(year: 2025, month: 08, day: 29),
  abstract: [
    Becoming a distributed systems engineer is a lifelong pursuit to answer one question: how can order be created from instability? This book dives into the core concepts required to be a highly competent, highly capable distributed systems engineer capable of working on the most complex systems in the world.
  ],
  preface: [
    #align(center + horizon)[
      For Tanya.
    ]
  ],
  bibliography: bibliography("refs.bib"),
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

= Distributed Systems Mastery
_A comprehensive learning path from fundamentals to advanced research topics_

== Learning Philosophy

This roadmap is designed around the principle that *distributed systems are fundamentally about coordination in the presence of uncertainty*. Each concept builds upon previous ones, creating a coherent understanding of how systems achieve correctness, performance, and fault tolerance when components are physically separated and communication is unreliable.

The progression moves from:
- *Local reasoning* → *Global properties*
- *Perfect systems* → *Fault-tolerant systems*
- *Deterministic protocols* → *Probabilistic algorithms*
- *Theory* → *Practice*

#include "phase-1.typ"

= Phase 2: Communication Primitives
_Building reliable communication from unreliable channels_

=== 2.1 Reliable Broadcast
_Making sure everyone gets the message_

*Core Papers:*
- *Hadzilacos, V. & Toueg, S.* (1994). "A Modular Approach to Fault-Tolerant Broadcasts and Related Problems." Technical Report TR94-1425, Cornell University.
- *Chandra, T. & Toueg, S.* (1996). "Unreliable Failure Detectors for Reliable Distributed Systems." _Journal of the ACM_, 43(2), 225-267.

*Connection:* Builds on ordering concepts to ensure not just delivery, but _consistent_ delivery across all processes.

=== 2.2 Causal and Total Order Broadcast
_When message order matters_

*Core Papers:*
- *Birman, K. & Joseph, T.* (1987). "Reliable Communication in the Presence of Failures." _ACM Transactions on Computer Systems_, 5(1), 47-76.
- *Défago, X., Schiper, A. & Urbán, P.* (2004). "Total Order Broadcast and Multicast Algorithms: Taxonomy and Survey." _ACM Computing Surveys_, 36(4), 372-421.

*Connection:* Vector clocks enable causal broadcast; total order requires consensus (foreshadowing Phase 4).

== Phase 3: Global State and Snapshots
_Understanding the system as a whole_

=== 3.1 Distributed Snapshots
_Capturing consistent global states_

*Core Paper:*
- *Chandy, K.M. & Lamport, L.* (1985). "Distributed Snapshots: Determining Global States of Distributed Systems." _ACM Transactions on Computer Systems_, 3(1), 63-75.
  - *Why it matters:* First algorithm to capture global state without stopping the system
  - *Key insight:* Using marker messages to create consistent cuts

*Supporting Material:*
- Lamport's version: https://lamport.azurewebsites.net/pubs/chandy.pdf
- *Learning objectives:* Implement the algorithm, understand consistent cuts vs. inconsistent cuts

*Connection:* Direct application of Lamport's happened-before relation. The "straightforward application" Lamport mentioned.

== Phase 4: The Impossibility Results
_Understanding the fundamental limits_

=== 4.1 FLP Impossibility
_The most important negative result in distributed systems_

*Core Paper:*
- *Fischer, M.J., Lynch, N.A. & Paterson, M.S.* (1985). "Impossibility of Distributed Consensus with One Faulty Process." _Journal of the ACM_, 32(2), 374-382.
  - *Why it matters:* Proves that perfect consensus is impossible in asynchronous systems
  - *Key insight:* There always exists a "critical" execution that prevents termination

*Supporting Material:*
- MIT's copy: https://groups.csail.mit.edu/tds/papers/Lynch/jacm85.pdf
- Excellent explanation: https://www.the-paper-trail.org/post/2008-08-13-a-brief-tour-of-flp-impossibility/

*Connection:* This is why all the previous work on broadcast and snapshots was possible - they don't require consensus!

=== 4.2 Byzantine Generals Problem
_The fundamental impossibility with malicious failures_

*Core Papers:*
- *Pease, M., Shostak, R. & Lamport, L.* (1980). "Reaching Agreement in the Presence of Faults." _Journal of the ACM_, 27(2), 228-234.
- *Lamport, L., Shostak, R. & Pease, M.* (1982). "The Byzantine Generals Problem." _ACM Transactions on Programming Languages and Systems_, 4(3), 382-401.

*Supporting Material:*
- Lamport's website: https://lamport.azurewebsites.net/pubs/byz.pdf

*Connection:* Shows that Byzantine consensus requires n ≥ 3f + 1 processes to tolerate f failures. Complements FLP by showing limits under stronger failure assumptions.

== Phase 5: Graph Theory Foundations
_Understanding network structure and routing_

=== 5.1 Distributed Spanning Trees
_Building structure in networks_

*Core Paper:*
- *Gallager, R.G., Humblet, P.A. & Spira, P.M.* (1983). "A Distributed Algorithm for Minimum-Weight Spanning Trees." _ACM Transactions on Programming Languages and Systems_, 5(1), 66-77.

*Connection:* Many distributed algorithms require underlying tree structures for efficient communication.

=== 5.2 Distributed Hash Tables
_Structured peer-to-peer systems_

*Core Papers:*
- *Stoica, I., Morris, R., Karger, D., et al.* (2001). "Chord: A Scalable Peer-to-peer Lookup Service for Internet Applications." _ACM SIGCOMM_.
- *Maymounkov, P. & Mazières, D.* (2002). "Kademlia: A Peer-to-peer Information System Based on the XOR Metric." _IPTPS_.

*Connection:* DHTs solve routing and load balancing using consistent hashing and graph-theoretic properties.

== Phase 6: Gossip Protocols
_Probabilistic information dissemination_

=== 6.1 Epidemic Algorithms
_Information spreading like diseases_

*Core Papers:*
- *Demers, A., Greene, D., Hauser, C., et al.* (1987). "Epidemic Algorithms for Replicated Database Maintenance." _ACM PODC_.
- *Pittel, B.* (1987). "On Spreading a Rumor." _SIAM Journal on Applied Mathematics_, 47(1), 213-223.

*Connection:* Uses probabilistic analysis and random graph theory to achieve eventual consistency.

=== 6.2 Membership and Failure Detection
_Who's in the system?_

*Core Papers:*
- *Das, A., Gupta, I. & Motivala, A.* (2002). "SWIM: Scalable Weakly-consistent Infection-style Process Group Membership Protocol." _IEEE DSNET_.
- *Leitão, J., Pereira, J. & Rodrigues, L.* (2007). "HyParView: a Membership Protocol for Reliable Gossip-based Broadcast." _IEEE DSN_.

*Connection:* Builds on epidemic algorithms to maintain dynamic group membership.

== Phase 7: Consistency Models
_Defining what "correct" means_

=== 7.1 Sequential and Causal Consistency
_Relaxed consistency models_

*Core Papers:*
- *Lamport, L.* (1979). "How to Make a Multiprocessor Computer That Correctly Executes Multiprocess Programs." _IEEE Transactions on Computers_, C-28(9), 690-691.
- *Ahamad, M., Neiger, G., Burns, J.E., et al.* (1995). "Causal Memory: Definitions, Implementation, and Programming." _Distributed Computing_, 9(1), 37-49.

*Connection:* Causal consistency directly uses vector clocks; sequential consistency relates to total order broadcast.

=== 7.2 Eventual Consistency and CRDTs
_Convergence without coordination_

*Core Papers:*
- *Shapiro, M., Preguiça, N., Baquero, C. & Zawirski, M.* (2011). "Conflict-Free Replicated Data Types." _SSS_.
- *Bailis, P. & Ghodsi, A.* (2013). "Eventual Consistency Today: Limitations, Extensions, and Beyond." _ACM Queue_, 11(3).

*Connection:* Resolves the FLP impossibility by giving up strong consistency - shows how to achieve convergence without consensus.

== Phase 8: Advanced Consensus
_Practical solutions despite impossibility_

=== 8.1 Paxos Family
_The classic consensus algorithm_

*Core Papers:*
- *Lamport, L.* (1998). "The Part-Time Parliament." _ACM Transactions on Computer Systems_, 16(2), 133-169.
- *Lamport, L.* (2001). "Paxos Made Simple." _ACM SIGACT News_, 32(4), 18-25.

*Supporting Material:*
- Lamport's website: https://lamport.azurewebsites.net/pubs/paxos-simple.pdf

*Connection:* Shows how to achieve consensus despite FLP by assuming eventual synchrony and majority availability.

=== 8.2 Modern Consensus
_Practical alternatives_

*Core Papers:*
- *Ongaro, D. & Ousterhout, J.* (2014). "In Search of an Understandable Consensus Algorithm." _USENIX ATC_. (Raft)
- *Castro, M. & Liskov, B.* (1999). "Practical Byzantine Fault Tolerance." _OSDI_.

*Connection:* Raft simplifies Paxos; PBFT makes Byzantine consensus practical.

== Phase 9: Advanced Topics
_Cutting-edge research areas_

=== 9.1 Self-Stabilization
_Systems that heal themselves_

*Core Papers:*
- *Dijkstra, E.W.* (1974). "Self-Stabilizing Systems in Spite of Distributed Control." _Communications of the ACM_, 17(11), 643-644.
- *Dolev, S.* (2000). "Self-Stabilization." _MIT Press_ (Book).

=== 9.2 Dynamic Networks
_Handling churn and mobility_

*Core Papers:*
- *Kuhn, F., Lynch, N. & Oshman, R.* (2010). "Distributed Computation in Dynamic Networks." _STOC_.
- *Augustine, J., Pandurangan, G., Robinson, P. & Upfal, E.* (2013). "Towards Robust and Efficient Computation in Dynamic Peer-to-Peer Networks." _SODA_.

== Learning Progression Strategy

=== Phase Dependencies:

#raw-render(```
digraph PhaseGraph {
    // Graph properties
    rankdir=TB;
    node [shape=box, style=filled, fontname="Arial"];
    edge [fontname="Arial"];

    // Node definitions with colors
    P1 [label="Phase 1\nTime/Ordering", fillcolor="#e1f5fe"];
    P2 [label="Phase 2\nCommunication", fillcolor="#e1f5fe"];
    P3 [label="Phase 3\nSnapshots", fillcolor="#e1f5fe"];
    P4 [label="Phase 4\nImpossibility", fillcolor="#fff3e0"];
    P5 [label="Phase 5\nGraph Theory", fillcolor="#fff3e0"];
    P6 [label="Phase 6\nGossip", fillcolor="#f3e5f5"];
    P7 [label="Phase 7\nConsistency", fillcolor="#fff3e0"];
    P8 [label="Phase 8\nConsensus", fillcolor="#f3e5f5"];
    P9 [label="Phase 9\nAdvanced", fillcolor="#f3e5f5"];

    // Dependencies
    P1 -> P2;
    P2 -> P3;
    P1 -> P4;
    P4 -> P5;
    P4 -> P7;
    P5 -> P6;
    P6 -> P8;
    P7 -> P8;
    P8 -> P9;
}
```
)

=== For Each Paper:
1. *Read the abstract and introduction* - Understand the problem
2. *Implement the algorithm* (where possible) - This is crucial for Rust developers
3. *Work through examples* - Create test cases
4. *Connect to previous concepts* - How does it build on what you know?
5. *Identify the key insight* - What's the breakthrough idea?

=== Practical Exercises:
- *Phase 1-2:* Build a simple chat system with Lamport timestamps
- *Phase 3:* Implement Chandy-Lamport snapshots in your chat system
- *Phase 4:* Prove why your chat system can't solve consensus
- *Phase 5-6:* Add peer-to-peer discovery using DHT + gossip
- *Phase 7:* Implement different consistency models
- *Phase 8:* Add Raft consensus for coordination
- *Phase 9:* Make your system self-stabilizing

== Assessment Milestones

=== Beginner → Intermediate:
Can explain why distributed systems are fundamentally different from concurrent systems, implement basic algorithms, understand causality vs. concurrency.

=== Intermediate → Advanced:
Can prove impossibility results, design fault-tolerant protocols, understand trade-offs between consistency and availability.

=== Advanced → Research:
Can identify open problems, propose novel algorithms, prove correctness properties, handle Byzantine failures.

== Essential Textbooks
_For deeper understanding_

1. *Lynch, N.A.* (1996). "Distributed Algorithms." _Morgan Kaufmann_ - The definitive theoretical treatment
2. *Cachin, C., Guerraoui, R. & Rodrigues, L.* (2011). "Introduction to Reliable and Secure Distributed Programming." _Springer_ - Modern practical approach
3. *Kleppmann, M.* (2017). "Designing Data-Intensive Applications." _O'Reilly_ - Practical systems perspective

== Research Venues
_Where the cutting-edge work appears_

- *PODC* - ACM Symposium on Principles of Distributed Computing
- *DISC* - International Symposium on Distributed Computing
- *OSDI/SOSP* - Systems conferences
- *SIGCOMM/NSDI* - Networking conferences

== Current Research Frontiers (2020+)
_Where the field is heading_

=== Emerging Areas:
- *Causal Consistency at Scale:* Large-scale implementations in production systems (MongoDB, etc.)
- *Hardware-Software Co-design:* Custom network cards with built-in timestamping (sub-microsecond accuracy)
- *Time-Sensitive Networking (TSN):* IEEE standards for real-time Ethernet in industrial applications
- *Quantum Clock Synchronization:* Theoretical work on using quantum entanglement for global time
- *ML-Assisted Synchronization:* Using machine learning to predict and compensate for clock drift patterns

=== Open Research Problems:
- *Energy-Efficient Time Sync:* Battery-constrained IoT devices need microsecond accuracy with minimal power
- *Cross-Cloud Coordination:* How to achieve TrueTime-like guarantees across different cloud providers
- *Byzantine Time Synchronization:* Dealing with adversarial attacks on time infrastructure
- *Relativistic Distributed Systems:* Accounting for special relativity in global-scale systems

=== Tools for Staying Current:
- *PODC/DISC:* Primary venues for theoretical advances
- *OSDI/SOSP:* Systems implementations and evaluations
- *NSDI:* Networking approaches to synchronization
- *Industry Blogs:* CockroachDB, Google Research, Microsoft Research for practical advances

This roadmap represents approximately 2-3 years of dedicated study for a strong systems engineer. The key is to *implement everything* - distributed systems knowledge is experiential, not just theoretical.
