# PASTA_ICST
# Quality Metrics in Software Architecture

**Paper Title**: Testing Body Sensor Networks Applications through Patient Simulation

**Submitted to**: 17th IEEE International Conference on Software Testing, Verification and Validation (ICST 2024)

**Abstract**: Body Sensor Networks (BSNs) attract growing interest as an inexpensive means to continuously monitor the health status of patients and timely detect potential risks. 
They consist of a particular category of Wireless Sensor Networks (WSNs) made up of physiological parameter sensors that are attached to, or placed near, the human body or its surface. BSNs combine data fusion, sensors, and network communication. While actively researched, there is a lack of proper Software Engineering approaches focused on WSN applications, and when we take into account the testing of BSN applications, the situation becomes even worse, because relatively little of the state-of-art knowledge has been applied to BSN testing despite their criticality.  
In this work, we propose PASTA (PAtient Simulation for Testing of bsn Applications), a model-based testing approach that mixes Combinatorial Testing and Markov Chains to test a BSN in a novel way: in particular, we use a Discrete Time Markov Chain (DTMC) to simulate the trend of each sensor, which is determined by its transition probabilities. The latter are assigned by applying combinatorial testing.
We then simulate a patient by considering a whole set of sensors. A test run thus consists of monitoring for a pre-set time interval the behavior of the BSN applied to a simulated test patient. For evaluation, we apply PASTA to test a self-adaptive system from the literature, the SA-BSN (Self-Adaptive Body Sensor Network). PASTA was able to detect some not known failures and showed better effectiveness when compared to a random baseline. 


**Supplementary Material** (Replication package):
- [1 - ACTS Test Set](link) (Configuration of the ACTS tool and the output (transition matrices))
- [2 - Test Patients](link) (Configuration File for the BSN)
- 
