//+------------------------------------------------------------------+
//|                                                   BullsPower.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "BullsPower"
input int BullsPowerPeriod = 14; // Period
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class BullsPower : public CallableIndicator
  {
protected:
   CiBullsPower             bulls;

public:
                     BullsPower() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index);
   virtual void*     GetIndicator() { return GetPointer(bulls);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool BullsPower::InitIndicator()
  {
   if(!bulls.Create(Symbol(), Period(), BullsPowerPeriod))
     {
      printf(__FUNCTION__ + ": error initializing BullsPower");
      return (false);
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double BullsPower::GetData(int index)
  {
   return bulls.Main(index);
  }
