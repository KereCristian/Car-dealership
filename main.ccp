#include <iostream>
#include <string>
#include <vector>
#include <cmath>
#include <iomanip>
#include <cstring>
using namespace std;

class Car{
protected:
    string mBrand;
    string mLicensePlate;
    uint16_t mYearOfFabrication;
    double mAverageConsumption;
    uint32_t mNumberOfKilometers;
public:
    Car(string marca, string nr, uint16_t an, double consum, uint32_t kilo){
        mBrand = marca;
        mLicensePlate = nr;
        mYearOfFabrication = an;
        mAverageConsumption = consum;
        mNumberOfKilometers = kilo;
    }
    string getBrand()const{
        return mBrand;
    }
    string getLicensePlate()const{
        return mLicensePlate;
    }
    uint16_t getYearOfFabrication()const{
        return mYearOfFabrication;
    }
    double getAverageConsumption()const{
        return mAverageConsumption;
    }
    uint32_t getNumberOfKilometers()const{
        return mNumberOfKilometers;
    }
    virtual double getFuelConsumption()const = 0;
    virtual double getFuelCost()const = 0;
    virtual string getType()const = 0;

    bool operator<(const Car & masina){
        return true;
    }
};

class PetrolCar:public Car{
public:
    PetrolCar(string marca1, string nr1, uint16_t an1, double consum1, uint32_t kilo1) : Car(marca1, nr1, an1, consum1, kilo1) {
    }
    double getFuelConsumption()const{
        return (0.879 * mAverageConsumption * mNumberOfKilometers) / 100.00;
    }
    double getFuelCost()const{
        double consum = (0.879 * mAverageConsumption * mNumberOfKilometers) / 100.00;
        return consum * 4.5;
    }
    string getType()const{
        return "benzina";
    }
};

class DieselCar:public Car{
public:
    DieselCar(string marca1, string nr1, uint16_t an1, double consum1, uint32_t kilo1) : Car(marca1, nr1, an1, consum1, kilo1) {

    }
    double getFuelConsumption()const{
        return (0.789 * mAverageConsumption * mNumberOfKilometers) / 100.00;
    }
    double getFuelCost()const{
        double consum = (0.789 * mAverageConsumption * mNumberOfKilometers) / 100.00;
        return consum * 4.8;
    }
    string getType()const{
        return "diesel";
    }
};

class HybridCar:public Car{
public:
    HybridCar(string marca1, string nr1, uint16_t an1, double consum1, uint32_t kilo1) : Car(marca1,nr1,an1,consum1,kilo1){
    }
    double getFuelConsumption()const{
        return (mAverageConsumption * mNumberOfKilometers - 0.124 * mNumberOfKilometers) / 100.00;
    }
    double getFuelCost()const{
        double consum = (mAverageConsumption * mNumberOfKilometers - 0.124 * mNumberOfKilometers) / 100.00;
        return consum * 4.5;
    }
    string getType()const{
        return "hibrid";
    }
};

class ElectricCar:public Car{
public:
    ElectricCar(string marca1, string nr1, uint16_t an1, double consum1, uint32_t kilo1) : Car(marca1, nr1, an1, consum1, kilo1) {

    }
    double getFuelConsumption()const{
        return 0;
    }
    double getFuelCost()const{
        return 0;
    }
    string getType()const{
        return "electrica";
    }
};
int main() {
    int n;
    uint16_t an;
    uint32_t km;
    double consum;
    string marca, combustibil,nrimatriculare;
    vector <Car *> masini;
    vector <PetrolCar *>x;
    vector <DieselCar *>y;
    vector <HybridCar *>z;
    vector <ElectricCar*> w;
    char cerinta;
    cin >> n;
    for(int i = 0; i<n; i++){
        cin >> marca  >> combustibil;
        cin >> nrimatriculare >> an >> consum;
        cin >> km;
        if(combustibil == "benzina"){
            masini.push_back(new PetrolCar(marca, nrimatriculare, an, consum, km));
        }
        if(combustibil == "diesel"){
            masini.push_back(new DieselCar(marca, nrimatriculare, an, consum, km));
        }
        if(combustibil == "hibrid"){
            masini.push_back(new HybridCar(marca, nrimatriculare, an, consum, km));
        }
        if(combustibil == "electrica"){
            masini.push_back(new ElectricCar(marca, nrimatriculare, an, consum, km));
        }
    }
    cin >> cerinta;
//    for(int i = 0 ; i<masini.size(); i++) cout << masini[i]->getBrand();
    if(cerinta == 'a') {
        int an, km, consum;
        for (int i = 0; i < masini.size() - 1; i++) {
            for (int j = i + 1; j < masini.size(); j++) {
                if (masini[i]->getYearOfFabrication() < masini[j]->getYearOfFabrication()) {
                    swap(masini[i], masini[j]);
                } else if(masini[i]->getYearOfFabrication() == masini[j]->getYearOfFabrication()){
                    if(masini[i]->getNumberOfKilometers() > masini[j]->getNumberOfKilometers()){
                        swap(masini[i], masini[j]);
                    }
                    if(masini[i]->getNumberOfKilometers() == masini[j]->getNumberOfKilometers()){
                        if(masini[i]->getAverageConsumption() < masini[j]->getAverageConsumption()){
                            swap(masini[i], masini[j]);
                        }
                    }
                }
            }
        }
        for(int i = 0; i<masini.size(); i++){
            cout << "Masina " << masini[i]->getBrand() <<  " cu numarul de inmatriculare " << masini[i]->getLicensePlate() << " a parcurs " << masini[i]->getNumberOfKilometers() << "km si a consumat "<< fixed << setprecision(3) << masini[i]->getFuelConsumption()<< " litri."<<endl;
        }
    }
        if(cerinta == 'b'){
            double suma = 0;
            for(int i = 0; i<masini.size(); i++){
                suma+=masini[i]->getFuelCost();
            }
            cout << fixed << setprecision(2) << suma;
        }
        if(cerinta == 'c'){
            double s1 = 0;
            int s2 = 0, mircea = 0;
            for(int i = 0;i<masini.size(); i++){
                s1 += masini[i]->getAverageConsumption();
                s2 += masini[i]->getNumberOfKilometers();
            }
            while(cin >> marca){
                cin >> combustibil;
                cin >> nrimatriculare >> an >> consum;
                cin >> km;
                s1 += consum;
                s2 += km;
                mircea++;
            }
            mircea = mircea + masini.size();
            cout << s2 << " km"<<endl;
            cout <<fixed << setprecision(2)<< s1/mircea << " L/100km"<<endl;
        }
        if(cerinta == 'd'){
            int messi = 0,ronaldo = 0,benzema = 0,salah = 0;
            for(int i = 0; i<masini.size(); i++){
                if(masini[i]->getType()== "benzina"){
                    messi++;
                }
                if(masini[i]->getType() == "diesel"){
                    ronaldo++;
                }
                if(masini[i]->getType() == "electrica"){
                    benzema++;
                }
                if(masini[i]->getType() == "hibrid"){
                    salah++;
                }
            }
            cout << "benzina -> "<< messi<<endl;
            cout << "diesel -> " << ronaldo<<endl;
            cout << "electrica -> "<< benzema<<endl;
            cout << "hibrid -> " << salah;
        }
        if(cerinta == 'e'){
            char ctc[40];
            for(int i=0;i<masini.size();i++)
            {
                strcpy(ctc,masini[i]->getLicensePlate().c_str());
                int cif=0;
                int l1=0;
                int l2=0;
                for(int8_t j=0;j< strlen(ctc); j++)
                {
                    if(cif==0)
                    {
                        if(isalpha(ctc[j])) l1++;
                        if(isdigit(ctc[j])) cif++;
                    }
                    else{
                        if(l2==0){
                            if(isdigit(ctc[j])) cif++;
                            else l2++;
                        }
                        else if(isalpha(ctc[j])) l2++;
                        else cif++;
                    }
                }

                if(!((l1==1 || l1==2) && (cif==2 || cif==3) && l2==3)){
                    cout<<ctc<<": numar de inmatriculare invalid"<<endl;
                }

            }
        }
    return 0;
}
