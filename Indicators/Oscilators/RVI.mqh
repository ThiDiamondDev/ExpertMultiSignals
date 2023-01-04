//+------------------------------------------------------------------+
//|                                                          RVI.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "RVI"

input int RVIPeriod = 12; // Period
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class RVI : public CallableIndicator
  {
protected:
   CiRVI             rvi;

public:
                     RVI() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index) {return rvi.Main(index);}
   virtual void*     GetIndicator() { return GetPointer(rvi);};
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RVI::InitIndicator()
  {
   if(!rvi.Create(Symbol(), Period(),RVIPeriod))
     {
      printf(__FUNCTION__ + ": error initializing RVI");
      return (false);
     }
   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class RVISignal : public RVI
  {
public:
   virtual double    GetData(int index) {return rvi.Signal(index);}
  };
//+------------------------------------------------------------------+
