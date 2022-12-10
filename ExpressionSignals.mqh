//+------------------------------------------------------------------+
//|                                            ExpressionSignals.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Expert\ExpertSignal.mqh>
#include "ExpressionParser/ExpressionParser.mqh"
// wizard description start
//+------------------------------------------------------------------+
//| Description of the class                                         |
//| Title=ExpressionSignals                                          |
//| Type=SignalAdvanced                                              |
//| Name=ExpressionSignals                                           |
//| ShortName=ExpressionSignals                                      |
//| Class=ExpressionSignals                                          |
//| Page=https://github.com/ThiDiamondDev/ExpertMultiSignals         |
//| Parameter=BuySignal,string,ma1[1] > ma2[1],Buy Signal            |
//| Parameter=SellSignal,string,ma1[1] < ma2[1],Sell Signal          |
//+------------------------------------------------------------------+

// wizard description end

//+------------------------------------------------------------------+
//| Class ExpressionSignals.                                         |
//| Purpose: MultiSIgnals                                            |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ExpressionSignals : public CExpertSignal
  {

protected:
   Caller            *caller;
   // "weights" of market models (0-100)
   int               m_pattern_0;
   ExpressionParser  buyParser,sellParser;
   string            buySignal, sellSignal;
public:
                     ExpressionSignals(void);
                    ~ExpressionSignals(void);

   // adjusting "weights" of market models
   void              Pattern_0(int value) { m_pattern_0 = value; }
   void              SellSignal(string value);
   void              BuySignal(string value);

   // verification of settings
   virtual bool      ValidationSettings(void);

   // creating the indicator and timeseries
   virtual bool      InitIndicators(CIndicators *indicators);

   // checking if the market models are formed
   virtual int       LongCondition(void);
   virtual int       ShortCondition(void);

  };

//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
ExpressionSignals::ExpressionSignals(void) :
   m_pattern_0(100)
  {
   caller     = new Caller();
  }

//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
ExpressionSignals::~ExpressionSignals(void)
  {
   delete caller;
  }
//+------------------------------------------------------------------+
//| Validation settings protected data                               |
//+------------------------------------------------------------------+
bool ExpressionSignals::ValidationSettings(void)
  {
   if(!CExpertSignal::ValidationSettings())
      return false;

   if(buyParser.HasError())
      return false;

   if(sellParser.HasError())
      return false;

   return true;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionSignals::BuySignal(string signal)
  {
   buySignal  = signal;
   buyParser = new ExpressionParser(buySignal,caller);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionSignals::SellSignal(string signal)
  {
   sellSignal  = signal;
   sellParser = new ExpressionParser(sellSignal,caller);
  }
//+------------------------------------------------------------------+
//| Create indicators                                                |
//+------------------------------------------------------------------+
bool ExpressionSignals::InitIndicators(CIndicators *indicators)
  {
   if(indicators == NULL)
      return false;
   if(!CExpertSignal::InitIndicators(indicators))
      return false;

   if(!caller.InitIndicators(indicators))
      return false;
   return true;
  }
//+------------------------------------------------------------------+
//| "Voting" that price will grow                                    |
//+------------------------------------------------------------------+
int ExpressionSignals::LongCondition(void)
  {
   if(buyParser.Resolve())
      return m_pattern_0;
   return 0;
  }

//+------------------------------------------------------------------+
//| "Voting" that price will fall                                    |
//+------------------------------------------------------------------+
int ExpressionSignals::ShortCondition(void)
  {
   if(sellParser.Resolve())
      return m_pattern_0;

   return 0;
  }
//+------------------------------------------------------------------+
