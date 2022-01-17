"""
User enters his name to start the game
- User thows a dart
    - Throw as a function?a
    - Throw - Loop - Random - Range (0-100)

- Target is fix object
- User gets points according to how close dart hits the center of the target

    Points:

    |_10_|_25_|_50_|_75_|_100_|_75_|_50_|_25_|_10_|

    Target:

    (    (    (    (    (BsEye)    )    )    )    )

    Range:
    |_____________________100_____________________|

- consecutive hits multiply user points
  - if hit --> hit += 1 -- consecutive bonus --> points * consecutive where consecutive = hit (if hit !=0)

- When user gets to 250 points he wins

- When user wins he gets prompted whether or not he wants to play again
"""
import time
from random import *

# number_of_players = input("Digite o número de jogadores: ")
#
# class Players():
#     def __init__(self, name=""):
#         self.name = name
#         if name == "":
#             name = input("Digite seu nome: ")


# while number_of_players.isdigit() == False:
#     number_of_players = input("Digite o número de jogadores: ")
#
# for player in range(1, int(number_of_players)+1):
#     dict_players = {f"player{player}":Players().name}
#     for key, value in dict_players.items():
#        dict_players[key] = input("Digite seu nome: ")
#        print(dict_players)

def py_dart():
    score = 0
    dart_count = 0

    while score < 250:
        start = time.time()
        target = randint(1, 5)
        input(f"Aperte ENTER aos {target} para arremessar o dardo e atingir o alvo")
        end = time.time()
        result = int(end - start)
        if result == target:
            score += 100
            print("Na mosca! Você marcou 100 pontos")
        elif result == target - 1 or result == target + 1:
            score += 75
            print("Quase lá! Você marcou 75 pontos")
        elif result == target - 2 or result == target + 2:
            score += 50
            print("Foco, você consegue! Você marcou 50 pontos")
        elif result == target - 3 or result == target + 3:
            score += 25
            print("Você pode melhorar! Você marcou 25 pontos")
        elif result == target - 4 or result == target + 4:
            score += 10
            print("Por pouco você não erra! Você marcou 10 pontos")
        else:
            print("Você errou!")
        dart_count += 1

    return dart_count


def set_winner(resj1, resj2):
    if resj1 > resj2:
        return f"{j2} venceu!"
    elif resj1 < resj2:
        return f"{j1} venceu!"
    else:
        return "Empatou"


j1 = input("Digite seu nome: ")
j2 = input("Digite seu nome: ")
print(f"Jogador {j1} começa!")
print()
print()

resj1 = py_dart()
print(f"Jogador {j1} atingiu a pontuação com {resj1} dardos")
print()
print()

print(f"Agora é a vez do Jogador {j2}")
resj2 = py_dart()
print(f"Jogador {j2} atingiu a pontuação com {resj2} dardos")
print()
print()

print(set_winner(resj1,resj2))
