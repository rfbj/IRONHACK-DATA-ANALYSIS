import multiprocessing
import pandas as pd

dflist = []
i=0


def readcsv(file):
    print(file.split('2021')[-1].split('_')[0])
    ext = (file.split('2021')[-1].split('_')[0])
    df = pd.read_csv(file, sep=";", encoding="ANSI")
    dflist.append(f"{df}+_+{ext}")



def mp_concat(dflist):
    return pd.concat(dflist)



if __name__ == "__main__":


    p = multiprocessing.Pool(processes=18)
    files = [
        "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\RAW CSV\\202101_AuxilioEmergencial.csv",
        "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\RAW CSV\\202102_AuxilioEmergencial.csv",
        "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\RAW CSV\\202103_AuxilioEmergencial.csv",
        "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\RAW CSV\\202104_AuxilioEmergencial.csv",
        "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\RAW CSV\\202105_AuxilioEmergencial.csv",
        "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\RAW CSV\\202106_AuxilioEmergencial.csv",
        "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\RAW CSV\\202107_AuxilioEmergencial.csv",
        "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\RAW CSV\\202108_AuxilioEmergencial.csv",
        "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\RAW CSV\\202109_AuxilioEmergencial.csv",
        "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\RAW CSV\\202110_AuxilioEmergencial.csv"]

    p.map(readcsv, files)
    p.close()
    p.join()

    concat_csv = p.map(mp_concat, dflist)
    p.close()
    p.join()
