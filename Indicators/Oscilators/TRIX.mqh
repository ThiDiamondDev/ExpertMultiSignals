//+------------------------------------------------------------------+
//|                                                         TRIX.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "Triple Exponential Average"

input int TRIXPeriod = 14;                          // Period
input ENUM_APPLIED_PRICE TRIXPrice = PRICE_CLOSE;   // Applied price

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class TRIX : public CallableIndicator
  {
protected:
   CiTriX             trix;

public:
                     TRIX() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index);
   virtual void*     GetIndicator() { return GetPointer(trix);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool TRIX::InitIndicator()
  {
   if(!trix.Create(Symbol(), Period(),TRIXPeriod, TRIXPrice))
     {
      printf(__FUNCTION__ + ": error initializing TRIX");
      return (false);
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double TRIX::GetData(int index)
  {
   return trix.Main(index);
  }
//+------------------------------------------------------------------+
