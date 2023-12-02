# PASTA (PAtient Simulation for Testing of bsn Applications)
# Quality Metrics in Software Architecture

**Paper Title**: Testing Body Sensor Networks Applications through Patient Simulation

**Submitted to**: 54th Annual IEEE/IFIP International Conference on Dependable Systems and Networks (DNS 2024)

**Abstract**: Body Sensor Networks (BSNs) have emerged from a recent thrust on wearable biosensor technology development. They provide an inexpensive means to continuously monitor the health status of patients and timely detect potential risks. Notwithstanding the growing interest attracted by BSNs and their critical nature, in the literature, there is a lack of testing approaches for BSNs. In this work, we fill this gap and propose PASTA (PAtient Simulation for Testing of bsn Applications), a novel model-based testing approach that mixes Combinatorial Testing and Markov Chains simulation to test a BSN. We simulate a patient by considering a set of sensors and by mimicking the trend of each sensor via a Discrete Time Markov Chain (DTMC). We evaluate PASTA by applying it to test a self-adaptive BSN system from the literature, the SA-BSN (Self-Adaptive Body Sensor Network). PASTA was able to detect some unknown failures and showed better effectiveness when compared to a random baseline. 

## **PASTA**:
- 1 - Download and install the [ROS Melodic for Ubuntu 18.04](http://wiki.ros.org/melodic/Installation/Ubuntu)
- 2 - Download and install the [SA-BSN](https://github.com/lesunb/bsn/tree/1c45cd8f4c43e36fcf5665940d5ce7c66b907b31)
- 3 - Paste all the patient files to the folder:
```
/BSN_Folder_Path/src/sa-bsn/configurations/environment
```
Note: Replace "BSN_Folder_Path" with the path to the BSN folder.
- 4 - Enter this folder:
```
/BSN_Folder_Path/src/sa-bsn/target_system/components/component/src/g4t1
```
- 5 - Replace the G4T1.cpp file with the one we provide [here]().
- 6 - Enter this folder:
```
/BSN_Folder_Path/src/libbsn/src/generator
```
- 7 - Replace the DataGenerator.cpp file with the one we provide [here]().
- 8 - In a terminal of Ubuntu, type:
```
       $ cd /BSN_Folder_Path/
       $ catkin_make
       
```

### **Outcome Files**:
- [1 - SA-BSN](https://github.com/lesunb/bsn) 
- [2 - ACTS Tool](https://github.com/usnistgov/combinatorial-testing-tools)
- [3 - PASTA Scripts](https://github.com/samirasilva/PASTA_ICST/tree/main/PASTA%20Scripts)

## **Random Approach**:

### **Outcome Files**:




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

To run this project, download, unzip and enter the main folder: 

```
$ wget --no-check-certificate --content-disposition https://github.com/samirasilva/PASTA_ICST/archive/refs/heads/main.zip
$ unzip PASTA_ICST-main.zip -d PASTA_ICST-main
$ cd PASTA_ICST-main
```
