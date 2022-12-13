//+------------------------------------------------------------------+
//|                                                        FrAMA.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators/Trend.mqh>
#include "../CallableIndicator.mqh"

input group "Fractal Adaptative Moving Average"
input int FrAMAPeriod                       = 14;           // Period
input int FrAMAShift                        = 0;            // Shift
input ENUM_APPLIED_PRICE FrAMAAppliedPrice  = PRICE_CLOSE;  // Applied Price

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class FrAMA : public CallableIndicator
  {
protected:
   CiFrAMA           frAMA;

public:
                     FrAMA() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index) { return  frAMA.Main(index);};
   virtual void*     GetIndicator() { return GetPointer(frAMA);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool FrAMA::InitIndicator()
  {
   if(!frAMA.Create(
         Symbol(), Period(), FrAMAPeriod,FrAMAShift,FrAMAAppliedPrice))
     {
      printf(__FUNCTION__ + ": error initializing FrAMA");
      return (false);
     }

   return (true);
  }

//+------------------------------------------------------------------+
