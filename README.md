# PASTA (PAtient Simulation for Testing of bsn Applications)

**Paper Title**: An Experience Report on Testing a Body Sensor Network Application

**Submitted to**: 50th Euromicro Conference Series on Software Engineering and Advanced Applications (SEAA) 2024

**Abstract**: Body Sensor Networks (BSNs) are becoming increasingly popular because of the thrust on wearable biosensor technology development. 
They provide an inexpensive means to continuously monitor the health status of patients and timely detect potential risks. Notwithstanding this growing interest and their critical nature, we notice a scarcity of approaches in the literature for the testing of BSN applications. Aiming at filling this gap, in this paper we describe our experience in testing an open-source BSN, namely the SA-BSN (Self-Adaptive BSN). The testing approach we used is PASTA (PAtient Simulation for Testing bsn Applications), an original approach that combines concepts from Combinatorial Testing and Model-based Testing. Specifically, we model the six SA-BSN sensors by Discrete Time Markov Chains and mock various patients by considering different combinations of the transition matrices representing the sensors. In our study, PASTA was able to detect some unknown failures and showed better effectiveness when compared to a random baseline. 
Out of this experience, we summarize a set of lessons learned for both researchers and practitioners and hint at promising future enhancements of PASTA.
  
## **Configure the SA-BSN**:
1. Download and install the [ROS Melodic for Ubuntu 18.04](http://wiki.ros.org/melodic/Installation/Ubuntu)
2. Download and install the [SA-BSN](https://github.com/lesunb/bsn/tree/1c45cd8f4c43e36fcf5665940d5ce7c66b907b31)

## **Clone this repository**:
[comment]: <> ($ git clone https://github.com/fedebotu/clone-anonymous-github.git && cd clone-anonymous-github)
[comment]: <> ($ python3 src/download.py --url https://anonymous.4open.science/r/PASTA_SAFECOMP-5F11/)
[comment]: <> ($ cd PASTA_SAFECOMP-5F11/)

```
$ git clone https://github.com/samirasilva/PASTA_SEAA.git
$ cd PASTA_SEAA
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
4. Replace the *g4t1.launch* file:
```
$ \cp PASTA/BSN_Files_to_Replace/g4t1.launch bsn_path/src/sa-bsn/configurations/target_system/g4t1.launch
```
5. Replace the *run.sh* file:
```
$ \cp PASTA/BSN_Files_to_Replace/run.sh bsn_path/run.sh
```
6. Build the SA-BSN:
```
$ (cd bsn_path ; catkin_make)
```
<sub>(Replace "bsn_path" with the path to the BSN folder.)</sub>

### **Running PASTA**:

#### **1. Generation of T-way Combinations**:
*(Skip this step if you want to use the [provided t-way combinations](https://github.com/samirasilva/PASTA_SEAA/blob/main/PASTA/Output_Files/1_ACTS_BSN_Test_Set_t2/1_ACTS_BSN_Test_Set_t_2.txt))*

1. Download the [ACTS 3.2 tool](https://github.com/usnistgov/combinatorial-testing-tools).
2. Execute the ACTS tool (double-click on the *jar* file).
3. Click on *System->Open...* and choose the file `PASTA_SEAA/PASTA/Output_Files/1_ACTS_BSN_Test_Set_t2/1_ACTS_BSN_Test_Set_t_2.txt` previously downloaded on your computer.
4. Click on *Edit->Modify...* to modify "parameters" or "constraints" for the combinations.
5. Click on *Build->Build* to regenerate the t-way combinations.
6. Finally, save your modifications with *System->Save*.

#### **2. Converting T-way Combinations into Patients**:
*(Step needed only if the previous one has been performed)*

1. Execute the script `conver_tm_into_patient.py` to transform each t-way combination into a patient:
```
$ python PASTA/PASTA_Scripts/conver_tm_into_patient.py PASTA/Output_Files/2_Test_Patients PASTA/Output_Files/1_ACTS_BSN_Test_Set_t2/1_ACTS_BSN_Test_Set_t_2.txt

```
`PASTA/Output_Files/2_Test_Patients` is the folder where you want to save the patients.

#### **3. Executing PASTA**:
1. Open the terminal and type:
```
bash PASTA/PASTA_Scripts/script_pasta_seaa.sh PASTA/Output_Files/2_Test_Patients 'number_of_patients' 'execution_time' 'number_of_executions'
```
Note: 
Replace `number_of_patients` with the number of patient files in `PASTA/Output_Files/2_Test_Patients` (e.g., 278 patients).
`execution_time` determines how much time each patient should be run (e.g., 30 seconds).
`number_of_executions` is the amount of times that PASTA should be run (e.g, 10 times).

2. To parse the log files, collect Sensor Readings and BSN Outcomes, and compute the Expected Outcome, type:
```
bash  PASTA/PASTA_Scripts/read_all_output.sh 'number_of_patients' 'number_of_executions'

```

#### **Outcome Files**:
- [1 - ACTS Test Set](https://github.com/samirasilva/PASTA_SEAA/blob/main/PASTA/Output_Files/1_ACTS_BSN_Test_Set_t2/1_ACTS_BSN_Test_Set_t_2.txt) (Configuration of the ACTS tool and the output (t-way combinations))
- [2 - Test Patients](https://github.com/samirasilva/PASTA_SEAA/tree/main/PASTA/Output_Files/2_Test_Patients) (Patient Configuration Files for the BSN)
- [3 - BSN Logs ](https://github.com/samirasilva/PASTA_SEAA/tree/main/PASTA/Output_Files/3_BSN_Logs) (Log files generated by the SA-BSN)
- [4 - Sensor Readings, BSN Outcomes and Expected Outcomes](https://github.com/samirasilva/PASTA_SEAA/tree/main/PASTA/Output_Files/4_Sensor_Readings_BSN_Outcome_and_Expected_Outcome) (Parsing of BSN Logs)
- [5 - Summary of Results](https://github.com/samirasilva/PASTA_SEAA/blob/main/PASTA/Output_Files/5_Summary_Of_Results/Pasta_experiments.ods) (Testing Results)
  
## Random
### **Preparing the SA-BSN to Random**:
1. Replace the *G4T1.cpp* file:
```
$ \cp Random_Approach/BSN_Files_to_Replace/G4T1.cpp bsn_path/src/sa-bsn/target_system/components/component/src/g4t1/G4T1.cpp
```
2. Replace the *DataGenerator.cpp* file:
```
$ \cp Random_Approach/BSN_Files_to_Replace/DataGenerator.cpp bsn_path/src/sa-bsn/src/libbsn/src/generator/DataGenerator.cpp
```
3. Replace the *PatientModule.cpp* file:
```
$ \cp Random_Approach/BSN_Files_to_Replace/PatientModule.cpp bsn_path/src/sa-bsn/environment/patient/src/PatientModule.cpp
```
4. Replace the *g4t1.launch* file:
```
$ \cp Random_Approach/BSN_Files_to_Replace/g4t1.launch bsn_path/src/sa-bsn/configurations/target_system/g4t1.launch
```
5. Replace the *run.sh* file:
```
$ \cp Random_Approach/BSN_Files_to_Replace/run.sh bsn_path/run.sh
```
6. Build the SA-BSN:
```
$ (cd bsn_path ; catkin_make)
```
<sub>(Replace "bsn_path" with the path to the BSN folder.)</sub>

### **Running Random**:
1. Unzip the Random Files:
```
$ (cd Random_Approach/Output_Files/2_BSN_Logs ; for f in *.tar.xz; do tar -xvf "$f"; done)
$ (cd Random_Approach/Output_Files/3_Sensor_Readings_BSN_Outcome_and_Expected_Outcome ; for f in *.tar.xz; do tar -xvf "$f"; done)
```
2. Type:
```
bash Random_Approach/Random_Scripts/script_baseline_seaa.sh Random_Approach/Output_Files/1_Test_Patients 1 'execution_time' 'number_of_executions'
```
To compare PASTA to Random, the `execution_time` should be equal to the number of patients in PASTA x execution time in PASTA (e.g., 278x30=8340 seconds).
`number_of_executions` is the number of times that Random should be run (e.g., 10 times).

3. To parse the log files, collect Sensor Readings and BSN Outcomes, and compute the Expected Outcome, type:
```
bash  Random_Approach/Random_Scripts/read_all_output.sh 1 'number_of_executions'
```

### **Outcome Files**:
- [1 - Test Patient](https://github.com/samirasilva/PASTA_SEAA/blob/main/Random_Approach/Output_Files/1_Test_Patients/patient_0.launch) (Patient Configuration File for the BSN)
- [2 - BSN Logs ](https://github.com/samirasilva/PASTA_SEAA/blob/main/Random_Approach/Output_Files/2_BSN_Logs/) (Log files generated by the SA-BSN)
- [3 - Sensor Readings, BSN Outcomes and Expected Outcomes](https://github.com/samirasilva/PASTA_SEAA/blob/main/Random_Approach/Output_Files/3_Sensor_Readings_BSN_Outcome_and_Expected_Outcome/ParseLog.tar.xz) (Parsing of BSN Logs)
- [4 - Summary of Results](https://github.com/samirasilva/PASTA_SEAA/blob/main/Random_Approach/Output_Files/4_Summary_Of_Results/)(Testing Results)

## **Statistical Tests**
- [1 - Datasets](https://github.com/samirasilva/PASTA_SEAA/blob/main/Scripts_Statistical_Tests/dataset.tar.xz) (Dataset with Test Cases (Sensor Readings and Expected Outcomes) and BSN Outcomes)
- [2 - Script ](https://github.com/samirasilva/PASTA_SEAA/blob/main/Scripts_Statistical_Tests/statistical_analysis.R) (Script to compute statistical tests)
