//+------------------------------------------------------------------+
//|                                                   ForceIndex.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "ForceIndex"
input int ForceIndexPeriod = 14; // Period
input ENUM_MA_METHOD       ForceIndexMethod = MODE_SMA; // Averaging method
input ENUM_APPLIED_VOLUME  ForceIndexVolumes = VOLUME_TICK; // Volume type

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ForceIndex : public CallableIndicator
  {
protected:
   CiForce             forceIndex;

public:
                     ForceIndex() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index);
   virtual void*     GetIndicator() { return GetPointer(forceIndex);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ForceIndex::InitIndicator()
  {
   if(!forceIndex.Create(Symbol(), Period(),ForceIndexPeriod,ForceIndexMethod, ForceIndexVolumes))
     {
      printf(__FUNCTION__ + ": error initializing ForceIndex");
      return (false);
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ForceIndex::GetData(int index)
  {
   return forceIndex.Main(index);
  }
