#include<iostream>
#include <string>
using namespace std;

class tank {
protected:
	string nom; //string
	float capacitat;
	float contingut;

public:
	tank(char*name, float cap, float cont) {
		nom = name;
		capacitat = cap;
		contingut = cont;
	}
	
	~tank() {}

	void printDiposit() {
		cout << "Nom diposit: " << nom << endl;
		cout << "Capacitat: " << capacitat << endl;
		cout << "Contingut: " << contingut << endl;
	}

	float carregarDiposit(float litres2) {
		float litresomplir = litres2;
		if ((litresomplir + contingut) > capacitat) {
			cout << "No tenim suficient espai " << endl;
		}
		else {
			contingut = litresomplir + contingut;
		}
		//VERIFICAR
		cout << "Contingut: " << contingut << endl;	

		return litresomplir;
	}

};


class gasoil : public tank {
private:
	float preuvenda;
	float Lsubministrats;
	float import_vendes_acum;

public:
	gasoil(char*nom, float capacitat, float contingut, float pv) : tank(nom, capacitat, contingut) {
		preuvenda = pv;
		Lsubministrats = 0;
		import_vendes_acum = 0;
	}
	~gasoil() {}

	void showinfo() {
		cout << "Nom diposit: " << nom << endl;
		cout << "Capacitat: " << capacitat << endl;
		cout << "Contingut: " << contingut << endl;
		cout << "Preu venda: " << preuvenda << endl;
		cout << "Litres subministrats: " << Lsubministrats << endl;
		cout << "Import vendes: " << import_vendes_acum << endl;
		cout << endl;
	}	

	float subministrarCombustible(float litres){
		float litresvenuts = litres;
		if (litresvenuts > contingut) {
			cout << "No tenim suficient combustible "<< endl;
		}
		else {
			contingut = contingut - litresvenuts;
			Lsubministrats = Lsubministrats + litresvenuts;
			import_vendes_acum = import_vendes_acum + (preuvenda*litresvenuts);
		}

		//VERIFICAR

		cout << "Contingut: " << contingut << endl;
		cout << "Litres subministrats: " << Lsubministrats << endl;
		cout << "Import vendes: " << import_vendes_acum << endl;		

		return litresvenuts;
	}

	void transferirCombustible(float litres, gasoil* dip) {
	
		float litres1 = litres;
		float verifyhayL = 0;
		float verifyhayCap = 0;

		verifyhayL = contingut - litres1; //sacas
		Lsubministrats = Lsubministrats + litres1;
		verifyhayCap = dip->contingut + litres1; //metes

		if (verifyhayL >= 0 || verifyhayCap <= capacitat) {
			contingut = contingut - litres1; //sacas
			Lsubministrats = Lsubministrats + litres1;
			dip->contingut = dip->contingut + litres1; //metes
		}

		else cout << "Capacitats inadequades per fer la transferencia " << endl;
	
		//VERIFICAR

		cout << "Diposit: " << nom << endl;
		cout << "Contingut: " << contingut << endl;
		cout << "Litres subministrats: " << Lsubministrats << endl;		
		cout << endl;
		cout << "Diposit: " << dip->nom << endl;
		cout << "Contingut: " << dip->contingut << endl;
		cout << "Litres subministrats: " << dip->Lsubministrats << endl;
	}

};

class benzina : public tank {
private:
	float preuvenda;
	float Lsubministrats;
	float import_vendes_acum;

public:
	benzina(char*nom, float capacitat, float contingut, float pv) : tank(nom, capacitat, contingut) {
		preuvenda = pv;
		Lsubministrats = 0;
		import_vendes_acum = 0;
	}
	~benzina() {}

	void showinfo() {
		cout << "Nom diposit: " << nom << endl;
		cout << "Capacitat: " << capacitat << endl;
		cout << "Contingut: " << contingut << endl;
		cout << "Preu venda: " << preuvenda << endl;
		cout << "Litres subministrats: " << Lsubministrats << endl;
		cout << "Import vendes: " << import_vendes_acum << endl;
		cout << endl;
	}

	float subministrarCombustible(float litres) {
		float litresvenuts = litres;
		if (litresvenuts > contingut) {
			cout << "No tenim suficient combustible " << endl;
		}
		else {
			contingut = contingut - litresvenuts;
			Lsubministrats = Lsubministrats + litresvenuts;
			import_vendes_acum = import_vendes_acum + (preuvenda*litresvenuts);
		}
		//VERIFICAR

		cout << "Contingut: " << contingut << endl;
		cout << "Litres subministrats: " << Lsubministrats << endl;
		cout << "Import vendes: " << import_vendes_acum << endl;		

		return litresvenuts;
	}

	void transferirCombustible(float litres, benzina* dip) {
	
		float litres1 = litres;
		float verifyhayL = 0;
		float verifyhayCap = 0;
	
			verifyhayL = contingut - litres1; //sacas
			Lsubministrats = Lsubministrats + litres1;
			verifyhayCap = dip->contingut + litres1; //metes

			if (verifyhayL >= 0 || verifyhayCap <= capacitat) {
				contingut = contingut - litres1; //sacas
				Lsubministrats = Lsubministrats + litres1;
				dip->contingut = dip->contingut + litres1; //metes
			}

			else cout << "Capacitats inadequades per fer la transferencia " << endl;
			
			//VERIFICAR
		
			cout << "Diposit: " << nom << endl;
			cout << "Contingut: " << contingut << endl;
			cout << "Litres subministrats: " << Lsubministrats << endl;		
			cout << endl;
			cout << "Diposit: " << dip->nom << endl;
			cout << "Contingut: " << dip->contingut << endl;
			cout << "Litres subministrats: " << dip->Lsubministrats << endl;
	}
};

int main() {
	float litres;
	float litres2;
	int dipo;
	int dipo2;
	int dip1, dip2;
	char opcio;

	benzina d1("Benzina 1", 100.0f, 50.0f, 1.2f);
	benzina d2("Benzina 2", 200.0f, 100.0f, 1.3f);
	gasoil d3("Gasoil 1", 250.0f, 125.0f, 1.1f);

	d1.showinfo();
	d2.showinfo();
	d3.showinfo();

	cout << endl;
	cout << "MENU: " << endl;
	cout << "c: Comprar combustible" << endl;
	cout << "o: Omplir diposit" << endl;
	cout << "t: Transferir combustible entre diposits" << endl;
	cout << "s: Sortir" << endl;
	cin >> opcio;
	cout << endl;

	switch (opcio) {
	case 'c':
		cout << "Litres que vols? " << endl;
		cin >> litres;
		cout << "De quin diposit? " << endl;
		cin >> dipo;

		if (dipo == 1)		d1.subministrarCombustible(litres);
		else if (dipo == 2)	d2.subministrarCombustible(litres);
		else if (dipo == 3)	d3.subministrarCombustible(litres);
		else cout << "Error de seleccio" << endl;
		break;

	case 'o':
		cout << "Litres a omplir: ";
		cin >> litres2;
		cout << "De quin diposit? (1, 2, o 3): ";
		cin >> dipo2;

		if (dipo2 == 1)		    d1.carregarDiposit(litres2);
		else if (dipo2 == 2)	d2.carregarDiposit(litres2);
		else if (dipo2 == 3)	d3.carregarDiposit(litres2);
		else cout << "Error de seleccio" << endl;
		break;

	case 't':
		cout << "Introdueix els litres a transferir: ";
		cin >> litres;
		cout << "Diposit d'origen? (1, 2, o 3): ";
		cin >> dip1;
		cout << "Diposit a omplir (1, 2, o 3): ";
		cin >> dip2;
		cout << endl;

		if (dip1 < 1 || dip1 > 3 || dip2 < 1 || dip2 > 3) cout << "Eleccio erronia" << endl;
		else if (dip1 == dip2) cout << "Els diposits son els mateixos" << endl;
		else if (dip1 == 3 || dip2 == 3) cout << "Els diposits son de combustibles diferents" << endl;
		else if (dip1 == 1) d1.transferirCombustible(litres, &d2); //del 1 al 2
		else d2.transferirCombustible(litres, &d1); //del 2 al 1
		
	case 's':
		break;

	default:
		break;
	}

	system("pause");
	return 0;
}
