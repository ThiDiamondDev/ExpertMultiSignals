//+------------------------------------------------------------------+
//|                                                          WPR.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "Williams' Percent Range"

input int WPRPeriod = 14;                          // Period
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class WPR : public CallableIndicator
  {
protected:
   CiWPR             wpr;

public:
                     WPR() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index);
   virtual void*     GetIndicator() { return GetPointer(wpr);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool WPR::InitIndicator()
  {
   if(!wpr.Create(Symbol(), Period(),WPRPeriod))
     {
      printf(__FUNCTION__ + ": error initializing WPR");
      return (false);
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double WPR::GetData(int index)
  {
   return wpr.Main(index);
  }
//+------------------------------------------------------------------+
