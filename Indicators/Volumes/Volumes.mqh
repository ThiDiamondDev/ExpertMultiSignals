//+------------------------------------------------------------------+
//|                                                      Volumes.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Volumes.mqh>
#include "../CallableIndicator.mqh"

input group                "Volumes"
input ENUM_APPLIED_VOLUME   AppliedVolume  =  VOLUME_TICK;  // Applied Volume

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Volumes : public CallableIndicator
  {
private:
   CiVolumes              volumes;

public:

   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator() { return GetPointer(volumes);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Volumes::InitIndicator()
  {
// initialize object
   if(!volumes.Create(Symbol(), Period(),AppliedVolume))
     {
      printf(__FUNCTION__ + ": error initializing Volumes");
      return(false);
     }

   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Volumes::GetData(int index)
  {
   return volumes.Main(index);
  };
//+------------------------------------------------------------------+
