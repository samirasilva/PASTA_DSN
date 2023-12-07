import sys

#COMPUTATION OF THE EXPECTED OUTCOME
def compute_oracle(spo2, hr, temp, sys_bp, dias_bp, glu):

    output=""

    all_sensors=[]
    all_sensors.append(spo2)
    all_sensors.append(hr)
    all_sensors.append(temp)
    all_sensors.append(sys_bp)
    all_sensors.append(dias_bp)
    all_sensors.append(glu)

    amount_high=0
    amount_med=0
    amount_low=0

    for item in all_sensors:
         if(item=="low risk"):
             amount_low=amount_low+1
         elif(item=="moderate risk"):
             amount_med=amount_med+1
         elif(item=="high risk"):
             amount_high=amount_high+1

    total= amount_high+amount_med+amount_low

    if (total!=6):
    	return "Error"

    elif (amount_low==6):
        return "VERY LOW RISK"

    elif (amount_med==1 and amount_high==0):
        return "LOW RISK"

    elif (amount_med>=2 and amount_high==0):
        return "MODERATE RISK"

    elif (amount_high==1):
        return "CRITICAL RISK"

    elif (amount_high>1):
        return "VERY CRITICAL RISK"

    else: 
        return "ERROR!"




#FORMAT OUTPUT OF THE BSN AND COMPUTE THE ORACLE
#Example of call: 
#python read_output_prob_t2.py './output' 'output_sensor_readings.txt' number_of_patients
#or
#python read_output_prob_t2.py

def main(argv):

    if(len(sys.argv)==4):
        BSN_output_folder= sys.argv[1]
        resulting_file_name = sys.argv[2] 
        number_of_patients= int(sys.argv[3])       
    elif(len(sys.argv)==1):
        BSN_output_folder= './output'
        resulting_file_name = 'output_sensor_readings.txt'
        number_of_patients=1
    else:
	print("Error!")
        exit(0)

    file1 = open(BSN_output_folder+"/"+resulting_file_name, "w") 
    file1.write("Id\t"+"Patient"+"\t"+"Oxi"+"\t"+"Ecg"+"\t"+"Term"+"\t"+"Abps"+"\t"+"Abpd"+"\t"+"Glc\t"+"BSN Outcome\t"+"Expected Outcome\t"+"Difference\t"+"Oxi-Risk"+"\t"+"Ecg-Risk"+"\t"+"Term-Risk"+"\t"+"Abps-Risk"+"\t"+"Abpd-Risk"+"\t"+"Glc-Risk\t"+"Oxi-Sens"+"\t"+"Ecg-Sens"+"\t"+"Term-Sens"+"\t"+"Abps-Sens"+"\t"+"Abpd-Sens"+"\t"+"Glc-Sens\t"+"Timestamp\n")

    term_sensor="0"
    ecg_sensor="0"
    oxi_sensor="0"
    abps_sensor="0"
    abpd_sensor="0"
    glc_sensor="0"
    sensor_values=False
    id=0

    id_outcome=0
    id_oracle=0
    id_difference=0
    for i in range(0,number_of_patients):
        with open(BSN_output_folder+'/g4t1_'+str(i)+'-1-stdout.log') as f:
            x = f.readline() 
            for line in f: 

                if(sensor_values==False):
            	    if(line.startswith("Term:")):
                	    term=line[6:len(line)-1]
            	    if(line.startswith("Ecg:")):
                	    ecg=line[5:len(line)-1]
            	    if(line.startswith("Oxi:")):
                	    oxi=line[5:len(line)-1]
            	    if(line.startswith("Abps:")):
                	    abps=line[6:len(line)-1]
            	    if(line.startswith("Abpd:")):
                	    abpd=line[6:len(line)-1]
            	    if(line.startswith("Glc:")):
                	    glc=line[5:len(line)-1]

           	    if(line.startswith("| THERM_RISK: ")):
                	    term_risk=line[14:len(line)-1]
            	    if(line.startswith("| ECG_RISK: ")):
                	    ecg_risk=line[12:len(line)-1]
            	    if(line.startswith("| OXIM_RISK: ")):
               	 	    oxi_risk=line[13:len(line)-1]
           	    if(line.startswith("| ABPS_RISK: ")):
                	    abps_risk=line[13:len(line)-1]
            	    if(line.startswith("| ABPD_RISK: ")):
                	    abpd_risk=line[13:len(line)-1]
            	    if(line.startswith("| GLC_RISK: ")):
                	    glc_risk=line[12:len(line)-1]
                    if(line.startswith("++++++++++++++++++++")):
                            sensor_values=True
                else:
	            if(line.startswith("Trm:")):
                	    term_sensor=line[5:len(line)-1]
            	    if(line.startswith("Ecg:")):
	                    ecg_sensor=line[5:len(line)-1]
            	    if(line.startswith("Oxi:")):
               		    oxi_sensor=line[5:len(line)-1]
            	    if(line.startswith("Abps:")):
               		    abps_sensor=line[6:len(line)-1]
            	    if(line.startswith("Abpd:")):
                	    abpd_sensor=line[6:len(line)-1]
            	    if(line.startswith("Glc:")):
               		    glc_sensor=line[5:len(line)-1]
                    if(line.startswith("++++++++++++++++++++")):
                            sensor_values=False           

                if(line.startswith("MilliSeconds Since Epoch:")):
                    time=line[20:(len(line)-1)]

                if(line.startswith("| PATIENT_STATE:")):
                    resultado=line[16:(len(line)-1)]
                    if(term!="unknown" and ecg!="unknown" and oxi!="unknown" and abps!="unknown" and abpd!="unknown" and glc!="unknown"):
                        oracle=compute_oracle(oxi,ecg,term,abps, abpd, glc)

                        if (resultado=="VERY LOW RISK"):
                           id_outcome=0
                        elif (resultado=="LOW RISK"):
                           id_outcome=1
                        elif (resultado=="MODERATE RISK"):
                           id_outcome=2
                        elif (resultado=="CRITICAL RISK"):
                           id_outcome=3
                        elif (resultado=="VERY CRITICAL RISK"):
                           id_outcome=4
                        else:
                           id_outcome=9999999999999

                        if (oracle=="VERY LOW RISK"):
                           id_oracle=0
                        elif (oracle=="LOW RISK"):
                           id_oracle=1
                        elif (oracle=="MODERATE RISK"):
                           id_oracle=2
                        elif (oracle=="CRITICAL RISK"):
                           id_oracle=3
                        elif (oracle=="VERY CRITICAL RISK"):
                           id_oracle=4
                        else:
                           id_oracle=9999999999999
                        id_difference=abs(id_outcome-id_oracle)

                        testcase = str(id)+"\t"+str(i)+"\t"+oxi+"\t"+ecg+"\t"+term+"\t"+abps+"\t"+abpd+"\t"+glc+"\t"+resultado+"\t"+oracle+"\t"+str(id_difference)+"\t"+oxi_risk+"\t"+ecg_risk+"\t"+term_risk+"\t"+abps_risk+"\t"+abpd_risk+"\t"+glc_risk+"\t"+oxi_sensor+"\t"+ecg_sensor+"\t"+term_sensor+"\t"+abps_sensor+"\t"+abpd_sensor+"\t"+glc_sensor+"\t"+time+"\n"
		        id=id+1
                        file1.write(testcase)
    file1.close()

if __name__ == "__main__":
    main(sys.argv)

