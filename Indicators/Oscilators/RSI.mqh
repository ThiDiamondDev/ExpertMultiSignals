//+------------------------------------------------------------------+
//|                                                         RSI.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "RSI"

input int RSIPeriod = 14;   // Period
input ENUM_APPLIED_PRICE RSIPrice = PRICE_CLOSE; // Applied price

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class RSI : public CallableIndicator
  {
protected:
   CiRSI             rsi;

public:
                     RSI() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index) {return rsi.Main(index);}
   virtual void*     GetIndicator() { return GetPointer(rsi);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RSI::InitIndicator()
  {
   if(!rsi.Create(Symbol(), Period(),RSIPeriod,RSIPrice))
     {
      printf(__FUNCTION__ + ": error initializing RSI");
      return (false);
     }
   return true;
  }
//+------------------------------------------------------------------+
