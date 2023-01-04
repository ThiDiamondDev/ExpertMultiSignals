//+------------------------------------------------------------------+
//|                                                         Dema.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Trend.mqh>
#include "../CallableIndicator.mqh"


input group                "Double Exponential Moving Average"

input int                  DemaPeriod       =  8;             // Period
input int                  DemaShift        =  0;             // Shift
input ENUM_APPLIED_PRICE   DemaAppliedPrice =  PRICE_CLOSE;   // AppliedPrice


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Dema : public CallableIndicator
  {
private:
   CiDEMA              dema;


public:
  
   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator() { return GetPointer(dema);};
  };

//+------------------------------------------------------------------+
//| Create MA indicators                                             |
//+------------------------------------------------------------------+
bool Dema::InitIndicator()
  {
// initialize object
   if(!dema.Create(Symbol(), Period(), DemaPeriod, DemaShift,DemaAppliedPrice))
     {
      printf(__FUNCTION__ + ": error initializing ma");
      return(false);
     }

   return(true);
  }
//+------------------------------------------------------------------+
double Dema::GetData(int index)
  {
   return dema.Main(index);
  };