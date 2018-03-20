#include <iostream>
#include <string>

using namespace std;

class tank {
protected:
	string name;
	int con;
	int cap;

public:
	tank(char*n, int co, int ca) {
		name = n;
		con = co;
		cap = ca;
	}

	void printDiposit() {
		cout << "tank\t" << name << "\n";
		cout << "content" << con << "\n";
		cout << "capacity" << cap << "\n";
	}

	int carregarDiposit(int fill) {
		int wasted = cap - con;
		if (wasted > fill) wasted = fill;
		con = con + wasted;
		return wasted;
	}

};

class gasolineTank : public tank{
protected:
	int price;
	int refueled;
	int amount;

public:
	gasolineTank(char*name, int con, int cap, int pr) :
		tank(name, con, cap) {
		price = pr;
		refueled = 0;
		amount = 0;
	}

	int subministrarCombustible(int fill) {
		int lit = fill;
		if (fill > con) {
			lit = con;
		}
		con = con - lit;
		refueled = refueled + lit;
		amount = price*lit;
		return lit;
	}

	void display() {
		cout << "name\t" << name << "\n";
		cout << "content\t" << con << "\n";
		cout << "capacity\t" << cap << "\n";
		cout << "price\t" << price << "\n";
		cout << "liters\t" << refueled << "\n";
		cout << "total amount\t" << amount << "\n";
	}

	void fuelTransfer(int fill, gasolineTank*gt) {
		int wasted, hollow;
		wasted = subministrarCombustible(fill);
		hollow = gt->carregarDiposit(wasted);
		if (wasted > hollow) this->carregarDiposit(wasted - hollow);
	}
};

class dieselTank : public tank {
protected:
	int price;
	int refueled;
	int amount;

public:
	dieselTank(char*name, int con, int cap, int pr) :
		tank(name, con, cap) {
		price = pr;
		refueled = 0;
		amount = 0;
	}

	int subministrarCombustible(int fill) {
		int lit = fill;
		if (fill > con) {
			lit = con;
		}
		con = con - lit;
		refueled = refueled + lit;
		amount = price*lit;
		return lit;
	}

	void display() {
		cout << "name\t" << name << "\n";
		cout << "content\t" << con << "\n";
		cout << "capacity\t" << cap << "\n";
		cout << "price\t" << price << "\n";
		cout << "liters\t" << refueled << "\n";
		cout << "total amount\t" << amount << "\n";
	}

	void fuelTransfer(int fill, dieselTank*dt) {
		int wasted, hollow;
		wasted = subministrarCombustible(fill);
		hollow = dt->carregarDiposit(wasted);
		if (wasted > hollow) this->carregarDiposit(wasted - hollow);
	}
};


int main() {

	int opt, opt1, opt2, op, l;

	dieselTank diestanka("diesel a", 67, 13, 2);
	dieselTank diestankb("diesel b", 800, 475, 2);
	gasolineTank gastank("gasoline", 75, 30, 3);

	do {
		diestanka.printDiposit();
		diestankb.printDiposit();
		gastank.printDiposit();

		cout << "<0>fill in\t<1>refuel\t<2>display\t<3>transfer\t<4>close";
		cin >> op;
		cout << "\n";

		switch (op) {
		case 0:
			cout << "how much?\n";
			cin >> l;
			cout << "which one?\n <0> <1> <2>";
			cin >> opt;

			switch (opt) {
			case 0:
				diestanka.subministrarCombustible(l);
				break;
			case 1:
				diestankb.subministrarCombustible(l);
				break;
			case 2:
				gastank.subministrarCombustible(l);
				break;
			}
			break;

		case 1:
			cout << "how much?\n";
			cin >> l;
			cout << "which one?\n <0> <1> <2>";
			cin >> opt;

			switch (opt) {
			case 0:
				diestanka.carregarDiposit(l);
				break;
			case 1:
				diestankb.carregarDiposit(l);
				break;
			case 2:
				gastank.carregarDiposit(l);
				break;
			}
			break;

		case 2:
			diestanka.display();
			diestankb.display();
			gastank.display();
			break;

		case 3:
			cout << "How much?\n";
			cin >> l;
			cout << "from <0> <1> <2>\n";
			cin >> opt1;
			cout << "to <0> <1> <2>\n";
			cin >> opt2;

			if (opt1 == opt2) {
				cout << "same tank\n";
			}
			else if (opt1 == 0 && opt2 == 1) {
				diestanka.fuelTransfer(l, &diestankb);
			}
			else if (opt1 == 1 && opt2 == 0) {
				diestankb.fuelTransfer(l, &diestanka);
			}
			else if (opt1 == 2 || opt2 == 2) {
				cout << "incompatible\n";
			}
			
			break;

		default:
			op = 4;
			break;
		}

	} while (op != 4);

	system("pause");
	return 0;
}
