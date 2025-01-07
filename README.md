# tp_fpga

# TP FPGA
### GUIFFAULT Gabriel JACQUOT Nolan
# 1 Tutoriel Quartus
### 1.1 Création d’un projet
Pour creer le projet sur Quartus :
- File > New Project Wizard
- choisir le FPGA suivant : 5CSEBA6U23I7
- La dernière page est un récapitulatif, cliquez sur Finish

### 1.2 Création d’un fichier VHDL

- Pour créer un nouveau fichier
File > New
- Une fenêtre s’ouvre, il faut sélectionner
VHDL File

Ci dessous un exemple de composant:
```vhd
library ieee;
use ieee.std_logic_1164.all;
entity tuto_fpga is
port (
sw : in std_logic;
led : out std_logic
);
end entity tuto_fpga;
architecture rtl of tuto_fpga is
begin
led <= sw;
end architecture rtl;
```
### 1.3 Fichier de contrainte

Nous utilisons la DE10-Nano, il y a plusiers LED et plusieurs Switches.
LED0 est sur la broche PIN_W15
SW0 est sur la broche PIN_Y24
Quartus ne peut pas connaître ces informations, il faut donc lui préciser.

- Avant toute chose, il faut synthétiser le projet. Pour cela, on lance Analysis & Synthesis
- Ensuite, cliquez sur : Assignments > Pin Planner
- Nous pouvons dans cette fenetre assigner les pin identifié plus haut au composants correspondants
  
### 1.4 Programmation de la carte

- Nous compilons l’intégralité du projet avec Compile Design
- Lancer l’outil de programmation du FPGA Tools > Programmer
- Une fenêtre s’ouvre : Cliquez sur Auto Detect
- Deux fenêtres pop-up apparaissent successivements, acceptez les paramètres par défaut
- Le schéma de deux puces apparait.
- Celle que l'on sélectionne est celle notée 5CSEBA6
- Chargez le bitstream : Clic-droit sur la puce > Edit > Change File
- Sélectionnez le fichier .sof dans output_files
- Cochez la case Program / Configure
- Programmez la carte
- Cliquez sur Start


### 1.5 Modification du VHDL

Nous allons remplacer nos std_logic par des
std_logic_vector.
```vhd
library ieee;
use ieee.std_logic_1164.all;
entity tuto_fpga is
port (
sw : in std_logic_vector(3 downto 0);
led : out std_logic_vector(3 downto 0)
);
end entity tuto_fpga;
architecture rtl of tuto_fpga is
begin
led <= sw;
end architecture rtl;
```
### 1.6 Faire clignoter une LED
### 1.7 Chenillard !
# 2 Petit projet : Bouncing ENSEA Logo

### Objectif :
Sur la sortie HDMI, faire rebondir le logo ENSEA, comme dans les
lecteurs DVD (https://www.bouncingdvdlogo.com/).

### 2.1 Contrôleur HDMI
