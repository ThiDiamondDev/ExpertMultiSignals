//+------------------------------------------------------------------+
//|                                                          BollingerBands.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Trend.mqh>
#include "../CallableIndicator.mqh"

input group "Bollinger Bands"
input int BBPeriod                         = 20; // Period
input double BBDeviation                   = 2;  // Deviation
input int BBShift                          = 0;  // Shift
input ENUM_APPLIED_PRICE BBAppliedPrice    = PRICE_CLOSE;  // AppliedPrice

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class BollingerBands : public CallableIndicator
  {
protected:
   CiBands             bands;

public:
                     BollingerBands() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index) { return  0;};
   virtual void*     GetIndicator() { return GetPointer(bands);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool BollingerBands::InitIndicator()
  {
   if(!bands.Create(Symbol(), Period(), BBPeriod,BBShift,BBDeviation,BBAppliedPrice))
     {
      printf(__FUNCTION__ + ": error initializing BollingerBands");
      return (false);
     }

   return (true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class BBUpper : public BollingerBands
  {
public:
   virtual double    GetData(int index) override
     {
      return bands.Upper(index);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class BBBase : public BollingerBands
  {
public:
   virtual double    GetData(int index) override
     {
      return bands.Base(index);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class BBLower : public BollingerBands
  {
public:
   virtual double    GetData(int index) override
     {
      return bands.Lower(index);
     };
  };
//+------------------------------------------------------------------+
