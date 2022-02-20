import os


def ask_dl():
    question = input("Deseja baixar os arquivos?(S/N)")
    if question == "S" or question == "s" or question == "Y" or question == "y":

        return True

    elif question == "N" or question == "n":

        return False
    else:
        ask_dl()

#ask_dl()

need_dl = ask_dl()

if need_dl:
    print(need_dl)
else:
    print(f"imprimindo o else {need_dl}")

need_dl



files_path = "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data"


print(f"{files_path}\\")