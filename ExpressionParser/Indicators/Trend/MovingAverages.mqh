//+------------------------------------------------------------------+
//|                                               MovingAverages.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Trend.mqh>
#include "../CallableIndicator.mqh"


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
class MovingAverage : public CallableIndicator
  {
private:
   CiMA              ma;


public:
                    ~MovingAverage(void) {};
   virtual bool              InitIndicator() {return(false);};
   virtual double            GetData(int index);

   bool              InitMA(int period,
                            int shift, ENUM_MA_METHOD method,
                            ENUM_APPLIED_PRICE appliedPrice);

  };

//+------------------------------------------------------------------+
//| Create MA indicators                                             |
//+------------------------------------------------------------------+
bool MovingAverage::InitMA(int period, int shift, ENUM_MA_METHOD method,
                           ENUM_APPLIED_PRICE appliedPrice)
  {
// initialize object
   if(!ma.Create(Symbol(), Period(), period, shift, method, appliedPrice))
     {
      printf(__FUNCTION__ + ": error initializing ma");
      return(false);
     }

   return(true);
  }
//+------------------------------------------------------------------+
double MovingAverage::GetData(int index)
  {
   return(ma.Main(index));
  };



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MA1: public MovingAverage
  {
public:
   virtual bool      InitIndicator() override
     {
      return(InitMA(MA1Period,MA1Shift,MA1Method,MA1AppliedPrice));
     };

  };
//+------------------------------------------------------------------+




//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MA2: public MovingAverage
  {
public:
   virtual bool      InitIndicator() override
     {
      return(InitMA(MA2Period,MA2Shift,MA2Method,MA2AppliedPrice));
     };

  };
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MA3: public MovingAverage
  {
public:
   virtual bool      InitIndicator() override
     {
      return(InitMA(MA3Period,MA3Shift,MA3Method,MA3AppliedPrice));
     };

  };
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MA4: public MovingAverage
  {
public:
   virtual bool      InitIndicator() override
     {
      return(InitMA(MA4Period,MA4Shift,MA4Method,MA4AppliedPrice));
     };

  };
//+------------------------------------------------------------------+
