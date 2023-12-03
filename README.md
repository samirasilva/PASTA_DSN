# PASTA (PAtient Simulation for Testing of bsn Applications)

**Paper Title**: Testing Body Sensor Networks Applications through Patient Simulation

**Submitted to**: 54th Annual IEEE/IFIP International Conference on Dependable Systems and Networks (DSN 2024)

**Abstract**: Body Sensor Networks (BSNs) have emerged from a recent thrust on wearable biosensor technology development. They provide an inexpensive means to continuously monitor the health status of patients and timely detect potential risks. Notwithstanding the growing interest attracted by BSNs and their critical nature, in the literature, there is a lack of testing approaches for BSNs. In this work, we fill this gap and propose PASTA (PAtient Simulation for Testing of bsn Applications), a novel model-based testing approach that mixes Combinatorial Testing and Markov Chains simulation to test a BSN. We simulate a patient by considering a set of sensors and by mimicking the trend of each sensor via a Discrete Time Markov Chain (DTMC). We evaluate PASTA by applying it to test a self-adaptive BSN system from the literature, the SA-BSN (Self-Adaptive Body Sensor Network). PASTA was able to detect some unknown failures and showed better effectiveness when compared to a random baseline. 
  
## **Configuring the SA-BSN**:
1. Download and install the [ROS Melodic for Ubuntu 18.04](http://wiki.ros.org/melodic/Installation/Ubuntu)
2. Download and install the [SA-BSN](https://github.com/lesunb/bsn/tree/1c45cd8f4c43e36fcf5665940d5ce7c66b907b31)

## **Clone this repository**:
```
$ git clone https://github.com/fedebotu/clone-anonymous-github.git && cd clone-anonymous-github
$ python3 src/download.py --url https://anonymous.4open.science/r/PASTA_DSN-6E66/
$ cd PASTA_DSN-6E66/
```

## PASTA
### **Preparing the SA-BSN to PASTA**:
1. Replace the *G4T1.cpp* file:
```
$ \cp PASTA/BSN_Files_to_Replace/G4T1.cpp bsn_path/src/sa-bsn/target_system/components/component/src/g4t1/G4T1.cpp
```
2. Replace the *DataGenerator.cpp* file:
```
$ \cp PASTA/BSN_Files_to_Replace/DataGenerator.cpp bsn_path/src/sa-bsn/src/libbsn/src/generator/DataGenerator.cpp
```
3. Replace the *PatientModule.cpp* file:
```
$ \cp PASTA/BSN_Files_to_Replace/PatientModule.cpp bsn_path/src/sa-bsn/environment/patient/src/PatientModule.cpp
```
4. Open a terminal of Ubuntu and type:
```
$ cd bsn_path
$ catkin_make       
```
<sub>(Replace "bsn_path" with the path to the BSN folder.)</sub>

### **Running PASTA**:

#### **Generation of T-way Combinations**:
*(Skip this step if you want to use the [provided t-way combinations](https://anonymous.4open.science/r/PASTA_DSN-6E66/PASTA/Output_Files/1_ACTS_BSN_Test_Set_t2/1_ACTS_BSN_Test_Set_t_2.txt))*

1. Download the [ACTS 3.2 tool](https://github.com/usnistgov/combinatorial-testing-tools).
2. Execute the ACTS tool (double-click on the *jar* file).
3. Click on *System->Open...* and choose the file `PASTA_DSN-6E66/PASTA/Output_Files/1_ACTS_BSN_Test_Set_t2/1_ACTS_BSN_Test_Set_t_2.txt` previously downloaded on your computer.
4. Click on *Edit->Modify...* to modify "parameters" or "constraints" for the combinations.
5. Click on *Build->Build* to regenerate the t-way combinations.
6. Finally, save your modifications with *System->Save*.

#### **Converting T-way Combinations into Patients**:

*(Step needed if the previous one has been performed)*
1. Execute the script `conver_tm_into_patient.py` to transform each t-way combination into a patient:
```
$ python PASTA_DSN-6E66/PASTA/PASTA_Scripts/conver_tm_into_patient.py ./save_the_patients_here/ PASTA_DSN-6E66/PASTA/Output_Files/1_ACTS_BSN_Test_Set_t2/1_ACTS_BSN_Test_Set_t_2.txt

```
`./save_the_patients_here/` is the folder where you want to save the patients.

#### **Executing PASTA**:
1. Open the terminal and type:
```
bash PASTA_DSN-6E66/PASTA/PASTA_Scripts/script_pasta_dns.sh 'Path_to_Patients_folder' 'number_of_patients' 'execution_time' 'number_of_executions'
```
3. To parse the log files, collect Sensor Readings and BSN Outcomes, and compute the Expected Outcome, type:
```
python read_output_prob_t2.py './save_the_patients_here' 'output_sensor_readings.txt' number_of_patients

```
Each "output_sensor_readings.txt" file contains the result of a single execution.

#### **Outcome Files**:
- [1 - SA-BSN](https://github.com/lesunb/bsn) 
- [2 - ACTS Tool](https://github.com/usnistgov/combinatorial-testing-tools)
- [3 - PASTA Scripts](https://github.com/samirasilva/PASTA_ICST/tree/main/PASTA%20Scripts)

- [1 - ACTS Test Set](https://github.com/samirasilva/PASTA_ICST/blob/main/1_ACTS_BSN_Test_Set_t_2.txt) (Configuration of the ACTS tool and the output (transition matrices))
- [2 - Test Patients](https://github.com/samirasilva/PASTA_ICST/tree/main/2_Test_Patients) (Configuration File for the BSN)
- [3 - Sensor Time Series and BSN Outcome](https://github.com/samirasilva/PASTA_ICST/tree/main/3_Sensor_Time_Series_And_BSN_Outcomes)
- [4 - Sensor Time Series, BSN Outcome and Expected Outcome](https://github.com/samirasilva/PASTA_ICST/tree/main/4_Sensor_Time_Series_BSN_Outcome_and_Expected_Outcome)
- 
## Random
### **Preparing the SA-BSN to Random**:
1. Enter this folder:
```
BSN_Folder_Path/src/sa-bsn/target_system/components/component/src/g4t1
```
Note: Replace "BSN_Folder_Path" with the path to the BSN folder.
2. Replace the G4T1.cpp file with the one we provide [here]().
3. Enter this folder:
```
BSN_Folder_Path/src/libbsn/src/generator
```
4. Replace the DataGenerator.cpp file with the one we provide [here]().
5. Enter this folder:
```
BSN_Folder_Path/src/sa-bsn/environment/patient/src
```
6. Replace the PatientModule.cpp file with the one we provide [here]().
7. Open a terminal of Ubuntu and type:
```
$ cd /BSN_Folder_Path/
$ catkin_make       
```
### **Running Random**:
1. Paste the [patient]() to the folder:
```
BSN_Folder_Path/src/sa-bsn/configurations/environment
```
2. Open the terminal in the script folder and type:
```
script_baseline_dns.sh 'Path_to_Patients_folder' 1 'execution_time' 'number_of_executions'
```
3. To parse the log files, collect Sensor Readings and BSN Outcomes, and compute the Expected Outcome, type:
```
python read_output_prob_t2.py './output' 'output_sensor_readings.txt' 1

```
Each "output_sensor_readings.txt" file contains the result of a single execution.

### **Outcome Files**:
- [1 - ACTS Test Set](https://github.com/samirasilva/PASTA_ICST/blob/main/1_ACTS_BSN_Test_Set_t_2.txt)

## How to Download and Install PASTA:
To run this project, download, unzip and enter the main folder: 

```
$ wget --no-check-certificate --content-disposition https://github.com/samirasilva/PASTA_ICST/archive/refs/heads/main.zip
$ unzip PASTA_ICST-main.zip -d PASTA_ICST-main
$ cd PASTA_ICST-main
```

## **Required Files**:
- [1 - ACTS Tool](https://github.com/usnistgov/combinatorial-testing-tools)
- [2 - PASTA Scripts](https://anonymous.4open.science/r/PASTA_DSN-6E66/PASTA/PASTA_Scripts/)
- [3 - Random Scripts](https://anonymous.4open.science/r/PASTA_DSN-6E66/Random_Approach/Random_Scripts/)
- [4 - PASTA Replacement Files](https://anonymous.4open.science/r/PASTA_DSN-6E66/PASTA/BSN_Files_to_Replace/)
- [5 - Random Replacement Files](https://anonymous.4open.science/r/PASTA_DSN-6E66/Random_Approach/BSN_Files_to_Replace/)
