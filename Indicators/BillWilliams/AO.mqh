//+------------------------------------------------------------------+
//|                                                           AO.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\BillWilliams.mqh>
#include "../CallableIndicator.mqh"

//input group                "Awesome Oscillator"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class AO : public CallableIndicator
  {
private:
   CiAO              ao;

public:

   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator() { return GetPointer(ao);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool AO::InitIndicator()
  {
// initialize object
   if(!ao.Create(Symbol(), Period()))
     {
      printf(__FUNCTION__ + ": error initializing AO");
      return(false);
     }

   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double AO::GetData(int index)
  {
   return ao.Main(index);
  };
//+------------------------------------------------------------------+
