//+------------------------------------------------------------------+
//|                                                           OBV.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Volumes.mqh>
#include "../CallableIndicator.mqh"

input group                "On Balance Volume"
input ENUM_APPLIED_VOLUME   OBVVolume  =  VOLUME_TICK;  // Applied Volume

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class OBV : public CallableIndicator
  {
private:
   CiOBV              obv;

public:

   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator() { return GetPointer(obv);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool OBV::InitIndicator()
  {
// initialize object
   if(!obv.Create(Symbol(), Period(),OBVVolume))
     {
      printf(__FUNCTION__ + ": error initializing OBV");
      return(false);
     }

   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double OBV::GetData(int index)
  {
   return obv.Main(index);
  };
//+------------------------------------------------------------------+
