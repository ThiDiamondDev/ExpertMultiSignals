//+------------------------------------------------------------------+
//|                                                          BearsPower.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "BearsPower"
input int BearsPowerPeriod = 14; // Period
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class BearsPower : public CallableIndicator
  {
protected:
   CiBearsPower             bears;

public:
                     BearsPower() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index);
   virtual void*     GetIndicator() { return GetPointer(bears);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool BearsPower::InitIndicator()
  {
   if(!bears.Create(Symbol(), Period(), BearsPowerPeriod))
     {
      printf(__FUNCTION__ + ": error initializing BearsPower");
      return (false);
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double BearsPower::GetData(int index)
  {
   return bears.Main(index);
  }
