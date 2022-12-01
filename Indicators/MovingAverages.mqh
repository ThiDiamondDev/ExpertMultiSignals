//+------------------------------------------------------------------+
//|                                               MovingAverages.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Expert\ExpertSignal.mqh>



input group                "Moving average 1"

input int                  MA1Period       =  8;             // Period
input int                  MA1Shift        =  0;             // Shift
input ENUM_MA_METHOD       MA1Method       =  MODE_SMA;      // Method
input ENUM_APPLIED_PRICE   MA1AppliedPrice =  PRICE_CLOSE;   // AppliedPrice


input group                "Moving average 2"

input int                   MA2Period       =  10;            // Period
input int                   MA2Shift        =  0;             // Shift
input ENUM_MA_METHOD        MA2Method       =  MODE_SMA;      // Method
input ENUM_APPLIED_PRICE    MA2AppliedPrice =  PRICE_CLOSE;   // AppliedPrice


input group                "Moving average 3"

input int                  MA3Period        =  12;            // Period
input int                  MA3Shift         =  0;             // Shift
input ENUM_MA_METHOD       MA3Method        =  MODE_SMA;      // Method
input ENUM_APPLIED_PRICE   MA3AppliedPrice  =  PRICE_CLOSE;   // AppliedPrice


input group               "Moving average 4"

input int                  MA4Period       =  18;            // Period
input int                  MA4Shift        =  0;             // Shift
input ENUM_MA_METHOD       MA4Method       =  MODE_SMA;      // Method
input ENUM_APPLIED_PRICE   MA4AppliedPrice =  PRICE_CLOSE;   // AppliedPrice


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MovingAverages
  {
private:
   CiMA              *ma1,*ma2,*ma3,*ma4;
   CIndicators       *indicators;


public:
                     MovingAverages() {
                     ma1 = new CiMA();
                     ma2 = new CiMA();
                     ma3 = new CiMA();
                     ma4 = new CiMA();
                     indicators = new CIndicators();
                     };

                    ~MovingAverages(void){delete ma1; delete ma2; delete ma3; delete ma4; delete indicators;};
   bool                 InitMA(CiMA *ma, int period,
                               int shift, ENUM_MA_METHOD method,
                               ENUM_APPLIED_PRICE appliedPrice);


public:
   // initialization of the indicators

   bool              InitMA1();
   bool              InitMA2();
   bool              InitMA3();
   bool              InitMA4();
   // helper functions to read indicators' data
   double            GetMA1(int ind) { return(ma1.Main(ind)); }
   double            GetMA2(int ind) { return(ma2.Main(ind)); }
   double            GetMA3(int ind) { return(ma3.Main(ind)); }
   double            GetMA4(int ind) { return(ma4.Main(ind)); }

  };




//+------------------------------------------------------------------+
//| Create indicators                                                |
//+------------------------------------------------------------------+
bool MovingAverages::InitMA1()
  {
   return(InitMA(ma1,MA1Period,MA1Shift,MA1Method,MA1AppliedPrice));
  }

//+------------------------------------------------------------------+
//| Create indicators                                                |
//+------------------------------------------------------------------+
bool MovingAverages::InitMA2()
  {
   return(InitMA(ma2,MA2Period,MA2Shift,MA2Method,MA2AppliedPrice));
  }

//+------------------------------------------------------------------+
//| Create indicators                                                |
//+------------------------------------------------------------------+
bool MovingAverages::InitMA3()
  {
   return(InitMA(ma3,MA3Period,MA3Shift,MA3Method,MA3AppliedPrice));
  }

//+------------------------------------------------------------------+
//| Create indicators                                                |
//+------------------------------------------------------------------+
bool MovingAverages::InitMA4()
  {
   return(InitMA(ma4,MA4Period,MA4Shift,MA4Method,MA4AppliedPrice));
  }

//+------------------------------------------------------------------+
//| Create MA indicators                                             |
//+------------------------------------------------------------------+
bool MovingAverages::InitMA(CiMA *ma, int period,
                            int shift, ENUM_MA_METHOD method, ENUM_APPLIED_PRICE appliedPrice)
  {
   if(indicators == NULL)
      return(false);

// initialize object
   if(!ma.Create(Symbol(), Period(), period, shift, method, appliedPrice))
     {
      printf(__FUNCTION__ + ": error initializing ma");
      return(false);
     }

// add object to collection
   if(!indicators.Add(GetPointer(ma)))
     {
      printf(__FUNCTION__ + ": error adding ma");
      return(false);
     }

   return(true);
  }
//+------------------------------------------------------------------+
