//+------------------------------------------------------------------+
//|                                                           AC.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\BillWilliams.mqh>
#include "../CallableIndicator.mqh"

//input group                "Accelerator Oscillator"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class AC : public CallableIndicator
  {
private:
   CiAC              ac;

public:

   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator() { return GetPointer(ac);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool AC::InitIndicator()
  {
// initialize object
   if(!ac.Create(Symbol(), Period()))
     {
      printf(__FUNCTION__ + ": error initializing AC");
      return(false);
     }

   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double AC::GetData(int index)
  {
   return ac.Main(index);
  };
//+------------------------------------------------------------------+
