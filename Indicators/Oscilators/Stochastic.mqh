//+------------------------------------------------------------------+
//|                                                   Stochastic.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "Stochastic"

input int StochasticK = 5;                               // %K Period
input int StochasticD = 3;                               // %D Period
input int StochasticSlowing = 3;                         // Slowing
input ENUM_MA_METHOD StochasticMethod = MODE_SMA;        // Averaging method
input ENUM_STO_PRICE StochasticPrice = STO_CLOSECLOSE;   // Stochastic price

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Stochastic : public CallableIndicator
  {
protected:
   CiStochastic             stochastic;

public:
                     Stochastic() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index) {return stochastic.Main(index);}
   virtual void*     GetIndicator() { return GetPointer(stochastic);};
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Stochastic::InitIndicator()
  {
   if(!stochastic.Create(Symbol(), Period(),StochasticK,StochasticD,StochasticSlowing,StochasticMethod,StochasticPrice))
     {
      printf(__FUNCTION__ + ": error initializing Stochastic");
      return (false);
     }
   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class StochasticSignal : public Stochastic
  {
public:
   virtual double    GetData(int index) {return stochastic.Signal(index);}
  };
//+------------------------------------------------------------------+
