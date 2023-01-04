//+------------------------------------------------------------------+
//|                                                         OsMA.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "Moving Average of Oscilator"

input int OsMAFastEMA = 12; // Fast EMA period
input int OsMASlowEMA = 26; // Slow EMA period
input int OsMASMA     =  9; // OsMA SMA period
input ENUM_APPLIED_PRICE   OsMAPrice  = PRICE_CLOSE; // Applied price

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class OsMA : public CallableIndicator
  {
protected:
   CiOsMA             osMA;

public:
                     OsMA() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index) {return osMA.Main(index);}
   virtual void*     GetIndicator() { return GetPointer(osMA);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool OsMA::InitIndicator()
  {
   if(!osMA.Create(Symbol(), Period(),OsMAFastEMA,OsMASlowEMA,OsMASMA,OsMAPrice))
     {
      printf(__FUNCTION__ + ": error initializing OsMA");
      return (false);
     }
   return true;
  }
//+------------------------------------------------------------------+
