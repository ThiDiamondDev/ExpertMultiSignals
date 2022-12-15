//+------------------------------------------------------------------+
//|                                                           MFI.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Volumes.mqh>
#include "../CallableIndicator.mqh"

input group                "Money Flow Index"
input int                   MFIPeriod = 14;
input ENUM_APPLIED_VOLUME   MFIVolume  =  VOLUME_TICK;  // Applied Volume

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MFI : public CallableIndicator
  {
private:
   CiMFI              mfi;

public:

   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator() { return GetPointer(mfi);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MFI::InitIndicator()
  {
// initialize object
   if(!mfi.Create(Symbol(), Period(),MFIPeriod,MFIVolume))
     {
      printf(__FUNCTION__ + ": error initializing MFI");
      return(false);
     }

   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double MFI::GetData(int index)
  {
   return mfi.Main(index);
  };
