//+------------------------------------------------------------------+
//|                                                     Demarker.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "Demarker"
input int DemarkerPeriod = 14; // Period
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Demarker : public CallableIndicator
  {
protected:
   CiDeMarker             demarker;

public:
                     Demarker() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index);
   virtual void*     GetIndicator() { return GetPointer(demarker);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Demarker::InitIndicator()
  {
   if(!demarker.Create(Symbol(), Period(), DemarkerPeriod))
     {
      printf(__FUNCTION__ + ": error initializing Demarker");
      return (false);
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Demarker::GetData(int index)
  {
   return demarker.Main(index);
  }
