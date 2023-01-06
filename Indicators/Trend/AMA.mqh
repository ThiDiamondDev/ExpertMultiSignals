//+------------------------------------------------------------------+
//|                                                          AMA.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Trend.mqh>
#include "../CallableIndicator.mqh"


input group                "Adaptative Moving Average"

input int                  AMAPeriod       =  9;             // Period
input int                  AMAShift        =  0;             // Shift
input int                  FastEMA         =  8;             // Fast EMA
input int                  SlowEMA         =  13;            // Slow EMA
input ENUM_APPLIED_PRICE   AMAAppliedPrice =  PRICE_CLOSE;   // AppliedPrice


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class AMA : public CallableIndicator
  {
private:
   CiAMA              ama;

public:
   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator() { return GetPointer(ama);};
  };

//+------------------------------------------------------------------+
//|                                              |
//+------------------------------------------------------------------+
bool AMA::InitIndicator()
  {
// initialize object
   if(!ama.Create(Symbol(), Period(),AMAPeriod,FastEMA, SlowEMA,AMAShift,AMAAppliedPrice))
     {
      printf(__FUNCTION__ + ": error initializing AMA");
      return(false);
     }

   return(true);
  }
//+------------------------------------------------------------------+
double AMA::GetData(int index)
  {
   return ama.Main(index);
  };
//+------------------------------------------------------------------+
