_____________________________________________________________________________
classes.h
_________________________________________________________________________________

#ifndef CLASSES_H
#define CLASSES_H

#include <iostream>
#include <string>
using namespace std;

class Diposit {
protected:
	string nom;
	float capacitat;
	float contingut;

public:
	Diposit(char* n, float cap, float con) {
		nom = n;
		capacitat = cap;
		contingut = con;
		}

	void printDiposit() {
		cout << "--- Diposit: " << nom <<  endl;
		cout << "Capacitat: " << capacitat <<  endl;
		cout << "Contingut: " << contingut <<  endl;
		cout <<  endl;
		}

	float carregarDiposit(float litres) {
		float litres1; // litres que es podran carregar segons capacitat del diposit
		litres1 = capacitat - contingut;
		if (litres1 > litres) litres1 = litres;
		contingut += litres1;
		return litres1;
		}
	};

class DipositGasoil : public Diposit {
private:
	float preu_venda;
	float litres_subministrats; // Acumulat dels litres subministrats
	float import_vendes; // Acumulat de l'import total de vendes

public:
	DipositGasoil(char* nom, float capacitat, float contingut, float pvp): Diposit(nom, capacitat, contingut) {
		preu_venda = pvp;
		litres_subministrats = 0; 
		import_vendes = 0;
	}

	float subministrarCombustible(float litres) {
		float litres_a_subministrar = litres;
		if (litres > contingut)
			litres_a_subministrar = contingut;
		
		contingut -= litres_a_subministrar;
		litres_subministrats += litres_a_subministrar;
		import_vendes += litres_a_subministrar * preu_venda;
		return litres_a_subministrar;
		}

	void transferirCombustible(float litres, DipositGasoil* dip) {
		float litres1; // litres que es podran transferir segons disponibilitat
		float litres2; // litres que es podran transferir a dip segons la seva capacitat
		litres1=subministrarCombustible(litres);
		litres2=dip->carregarDiposit(litres1);
		if (litres2 < litres1) this->carregarDiposit(litres1 - litres2);
		}

	void printInfo() {
		cout << "Nom: " << nom << endl;
		cout << "Capacitat: " << capacitat << endl;
		cout << "Contingut: " << contingut << endl;
		cout << "PVP: " << contingut << endl;
		cout << "Total litres subministrats: " << litres_subministrats << endl;
		cout << "Total import vendes: " << import_vendes << endl;
		cout << endl;
		}
};

class DipositBenzina : public Diposit {
private:
	float preu_venda;
	float litres_subministrats;
	float import_vendes;

public:
	DipositBenzina(char* nom, float capacitat, float contingut, float pvp): Diposit(nom, capacitat, contingut) {
		preu_venda = pvp;
		litres_subministrats = 0;
		import_vendes = 0;
		}

	float subministrarCombustible(float litres) {
		float litres_a_subministrar = litres;
		if (litres > contingut)
			litres_a_subministrar = contingut;

		contingut -= litres_a_subministrar;
		litres_subministrats += litres_a_subministrar;
		import_vendes += litres_a_subministrar * preu_venda;
		return litres_a_subministrar;
	}

	void transferirCombustible(float litres, DipositBenzina* dip) {
		float litres1; // litres que es podran transferir segons disponibilitat
		float litres2; // // litres que es podran transferir a dip segons la seva capacitat
		litres1 = subministrarCombustible(litres);
		litres2 = dip->carregarDiposit(litres1);
		if (litres2 < litres1) this->carregarDiposit(litres1 - litres2);
	}

	void printInfo() {
		cout << "Nom: " << nom << endl;
		cout << "Capacitat: " << capacitat << endl;
		cout << "Contingut: " << contingut << endl;
		cout << "PVP: " << preu_venda << endl;
		cout << "Total litres subministrats: " << litres_subministrats << endl;
		cout << "Total import vendes: " << import_vendes << endl;
		cout << endl;
	}

};


#endif


_______________________________________________________________________________________________
benzinera.cpp
________________________________________________________________________________________________
#include "Classes.h"
using namespace std;

void main() {
	float litres;		// Quantiat de litres de combustible a repostar o carregar
	char opcio;			// Acció de l'usuari a triar segons el menú
	int dip,dip1, dip2;	// Dipòsits d'origen i destí
	
	DipositBenzina d1("Benzina 1", 50.0, 25.0, 1.7);
	DipositBenzina d2("Benzina 2", 100.0, 50.0, 1.7);
	DipositGasoil d3("Gasoil 1", 150.0, 10.0, 1.1);
	
	do {
		system("cls");
		d1.printDiposit();
		d2.printDiposit();
		d3.printDiposit();

		cout << endl;
		cout << "----- ACCIONS DISPONIBLES: " << endl;
		cout << "r: Repostar" << endl;
		cout << "c: Re-carregar diposit" << endl;
		cout << "v: Visualitzar informacio diposit" << endl;
		cout << "t: Transferir combustible entre diposits" << endl;
		cout << "s: Sortir" << endl;
		cin >> opcio;
		cout << endl;

		switch(opcio) {
			case 'r': // REPOSTAR
			cout << "Introdueix els litres a repostar: ";
			cin >> litres;
			cout << "De quin diposit? (1, 2, o 3): ";
			cin >> dip;

			if (dip == 1)		d1.subministrarCombustible(litres);
			else if (dip == 2)	d2.subministrarCombustible(litres);
			else if (dip == 3)	d3.subministrarCombustible(litres);
			else cout << "No existeix el diposit seleccionat!" << endl;
			system("pause");
			break;

			case 'c': //CARREGAR DIPÒSIT
			cout << "Introdueix els litres a carregar: ";
			cin >> litres;
			cout << "De quin diposit? (1, 2, o 3): ";
			cin >> dip;

			if (dip == 1)		d1.carregarDiposit(litres);
			else if (dip == 2)	d2.carregarDiposit(litres);
			else if (dip == 3)	d3.carregarDiposit(litres);
			else cout << "No existeix el diposit seleccionat!" << endl;
			break;

			case 't':
			cout << "Introdueix els litres a transferir: ";
			cin >> litres;
			cout << "Diposit d'origen? (1, 2, o 3): ";
			cin >> dip1;
			cout << "Diposit a carregar (1, 2, o 3): ";
			cin >> dip2;

			if (dip1 < 1 || dip1 > 3 || dip2 < 1 || dip2 > 3) cout << "Algun dels diposit seleccionats no existeix!" << endl;
			else if (dip1 == dip2) cout << "Has seleccionat el mateix diposit en ambdos casos!" << endl;
			else if (dip1 == 3 || dip2 == 3) cout << "Tipus de combustible diferent. No es pot transferir!" << endl;
			else if (dip1 == 1) d1.transferirCombustible(litres, &d2);
			else d2.transferirCombustible(litres, &d1);
			system("pause");
			break;

			case 'v':
				cout << "Indicar diposit (1, 2, o 3): ";
				cin >> dip;
				if (dip == 1)		d1.printInfo();
				else if (dip == 2)	d2.printInfo();
				else if (dip == 3)	d3.printInfo();
				else cout << "No existeix el diposit seleccionat!" << endl;
				system("pause");
				break;

			case 's':
				break;

			default:
				break;
		}
	} while (opcio != 's');
	}

