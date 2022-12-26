//+------------------------------------------------------------------+
//|                                                          ATR.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Trend.mqh>
#include "../CallableIndicator.mqh"

input group "ATR"
input int ATRPeriod = 14; // Period
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ATR : public CallableIndicator
  {
protected:
   CiATR             atr;

public:
                     ATR() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index);
   virtual void*     GetIndicator() { return GetPointer(atr);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ATR::InitIndicator()
  {
   if(!atr.Create(Symbol(), Period(), ATRPeriod))
     {
      printf(__FUNCTION__ + ": error initializing ATR");
      return (false);
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ATR::GetData(int index)
  {
   return atr.Main(index);
  }
