//+------------------------------------------------------------------+
//|                                                         Momentum.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "Momentum"

input int MomentumPeriod = 14; // Period
input ENUM_APPLIED_PRICE   MomentumPrice  = PRICE_CLOSE; // Applied price

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Momentum : public CallableIndicator
  {
protected:
   CiMomentum             momentum;

public:
                     Momentum() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index) {return momentum.Main(index);}
   virtual void*     GetIndicator() { return GetPointer(momentum);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Momentum::InitIndicator()
  {
   if(!momentum.Create(Symbol(), Period(),MomentumPeriod, MomentumPrice))
     {
      printf(__FUNCTION__ + ": error initializing Momentum");
      return (false);
     }
   return true;
  }
//+------------------------------------------------------------------+
