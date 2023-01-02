//+------------------------------------------------------------------+
//|                                            ExpressionSignals.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
input group "Buy Signal"
input string BuySignal         = "ma1[1] > ma2[1]";    // Buy Signal
input string BuyReverseSignal  = "";    // Buy Reversal Signal

input group "Sell Signal"
input string SellSignal         = "";  // Buy Signal
input string SellReverseSignal  = "";  // Buy Signal

#include <Expert\ExpertSignal.mqh>
#include "ExpressionParser/ExpressionParser.mqh"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ExpressionSignals : public CExpertSignal
  {

protected:
   Caller            caller;
   ExpressionParser  buyParser,buyReverseParser,sellParser,sellReverseParser;
   double            m_limit;
public:
                     ExpressionSignals(void);
   // verification of settings
   virtual bool      ValidationSettings(void);

   // creating the indicator and timeseries
   virtual bool      InitIndicators(CIndicators *indicators);

   virtual bool      CheckOpenShort(double& price,double& sl,double& tp,datetime& expiration);
   virtual bool      CheckOpenLong(double& price,double& sl,double& tp,datetime& expiration);
   virtual bool      CheckReverseShort(double& price,double& sl,double& tp,datetime& expiration);
   virtual bool      CheckReverseLong(double& price,double& sl,double& tp,datetime& expiration);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ExpressionSignals::ExpressionSignals():
   buyParser(BuySignal,GetPointer(caller)),
   buyReverseParser(BuyReverseSignal,GetPointer(caller)),
   sellParser(SellSignal,GetPointer(caller)),
   sellReverseParser(SellReverseSignal,GetPointer(caller))
  {

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
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionSignals::CheckOpenLong(double &price,double &sl,double &tp,datetime &expiration)
  {
   if(buyParser.Resolve())
      return OpenLongParams(price,sl,tp,expiration);

   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionSignals::CheckOpenShort(double &price,double &sl,double &tp,datetime &expiration)
  {
   if(sellParser.Resolve())
      return OpenShortParams(price,sl,tp,expiration);

   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionSignals::CheckReverseLong(double &price,double &sl,double &tp,datetime &expiration)
  {
   if(buyReverseParser.Resolve())
      return OpenLongParams(price,sl,tp,expiration);

   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionSignals::CheckReverseShort(double &price,double &sl,double &tp,datetime &expiration)
  {
   if(sellReverseParser.Resolve())
      return OpenShortParams(price,sl,tp,expiration);

   return false;
  }
//+------------------------------------------------------------------+
