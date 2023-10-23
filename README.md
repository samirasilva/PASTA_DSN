# PASTA (PAtient Simulation for Testing of bsn Applications)
# Quality Metrics in Software Architecture

**Paper Title**: Testing Body Sensor Networks Applications through Patient Simulation

**Submitted to**: 17th IEEE International Conference on Software Testing, Verification and Validation (ICST 2024)

**Abstract**: Body Sensor Networks (BSNs) attract growing interest as an inexpensive means to continuously monitor the health status of patients and timely detect potential risks. 
They consist of a particular category of Wireless Sensor Networks (WSNs) made up of physiological parameter sensors that are attached to, or placed near, the human body or its surface. BSNs combine data fusion, sensors, and network communication. While actively researched, there is a lack of proper Software Engineering approaches focused on WSN applications, and when we take into account the testing of BSN applications, the situation becomes even worse, because relatively little of the state-of-art knowledge has been applied to BSN testing despite their criticality.  
In this work, we propose PASTA (PAtient Simulation for Testing of bsn Applications), a model-based testing approach that mixes Combinatorial Testing and Markov Chains to test a BSN in a novel way: in particular, we use a Discrete Time Markov Chain (DTMC) to simulate the trend of each sensor, which is determined by its transition probabilities. The latter are assigned by applying combinatorial testing.
We then simulate a patient by considering a whole set of sensors. A test run thus consists of monitoring for a pre-set time interval the behavior of the BSN applied to a simulated test patient. For evaluation, we apply PASTA to test a self-adaptive system from the literature, the SA-BSN (Self-Adaptive Body Sensor Network). PASTA was able to detect some not known failures and showed better effectiveness when compared to a random baseline. 


## **Requirements**:
- [1 - SA-BSN](https://github.com/lesunb/bsn) 
- [2 - ACTS Tool](https://github.com/usnistgov/combinatorial-testing-tools)
- [3 - PASTA Scripts](https://github.com/samirasilva/PASTA_ICST/tree/main/PASTA%20Scripts)

## **Supplementary Material** (Replication package):
- [1 - ACTS Test Set](https://github.com/samirasilva/PASTA_ICST/blob/main/1_ACTS_BSN_Test_Set_t_2.txt) (Configuration of the ACTS tool and the output (transition matrices))
- [2 - Test Patients](https://github.com/samirasilva/PASTA_ICST/tree/main/2_Test_Patients) (Configuration File for the BSN)
- [3 - Sensor Time Series and BSN Outcome](https://github.com/samirasilva/PASTA_ICST/tree/main/3_Sensor_Time_Series_And_BSN_Outcomes)
- [4 - Sensor Time Series, BSN Outcome and Expected Outcome](https://github.com/samirasilva/PASTA_ICST/tree/main/4_Sensor_Time_Series_BSN_Outcome_and_Expected_Outcome)

## **Baseline** (Replication package):
- [1 - ACTS Test Set](https://github.com/samirasilva/PASTA_ICST/blob/main/1_ACTS_BSN_Test_Set_t_2.txt)


## How to execute PASTA

To run this project, install it locally using npm:

```
$ cd ../lorem
$ npm install
$ npm start
```
## How to execute the Random Baseline

To run this project, install it locally using npm:

```
$ cd ../lorem
$ npm install
$ npm start
```
