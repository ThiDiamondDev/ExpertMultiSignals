//+------------------------------------------------------------------+
//|                                                           AD.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Volumes.mqh>
#include "../CallableIndicator.mqh"


input group                "Accumulation/Distribuition"

input ENUM_APPLIED_VOLUME   ADVolume  =  VOLUME_TICK;  // Applied Volume


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class AD : public CallableIndicator
  {
private:
   CiAD              ad;

public:

   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator() { return GetPointer(ad);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool AD::InitIndicator()
  {
// initialize object
   if(!ad.Create(Symbol(), Period(),ADVolume))
     {
      printf(__FUNCTION__ + ": error initializing ad");
      return(false);
     }

   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double AD::GetData(int index)
  {
   return ad.Main(index);
  };
//+------------------------------------------------------------------+
