//+------------------------------------------------------------------+
//|                                                    Envelopes.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Trend.mqh>
#include "../CallableIndicator.mqh"

input group "Envelopes"
input int EnvelopesPeriod                       = 14;           // Period
input double EnvelopesDeviation                 = 0.1;          // Deviation
input int EnvelopesShift                        = 0;            // Shift
input ENUM_APPLIED_PRICE EnvelopesAppliedPrice  = PRICE_CLOSE;  // Applied Price
input ENUM_MA_METHOD     EnvelopesMethod        = MODE_SMA;     // Price Method

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Envelopes : public CallableIndicator
  {
protected:
   CiEnvelopes       envelopes;

public:
                     Envelopes() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index) { return  0;};
   virtual void*     GetIndicator() { return GetPointer(envelopes);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Envelopes::InitIndicator()
  {
   if(!envelopes.Create(
         Symbol(), Period(), EnvelopesPeriod,EnvelopesShift,
         EnvelopesMethod,EnvelopesAppliedPrice, EnvelopesDeviation))
     {
      printf(__FUNCTION__ + ": error initializing Envelopes");
      return (false);
     }

   return (true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class EnvelopesUpper : public Envelopes
  {
public:
   virtual double    GetData(int index) override
     {
      return envelopes.Upper(index);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class EnvelopesLower : public Envelopes
  {
public:
   virtual double    GetData(int index) override
     {
      return envelopes.Lower(index);
     };
  };
//+------------------------------------------------------------------+
