//+------------------------------------------------------------------+
//|                                            ExpressionSignals.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
enum OrderType
  {
   MARKET_PRICE,  //
   PENDING,       //
  };
enum TPSLType
  {
   FIXED,  //
   SIGNAL, //
  };

input group "Buy Signal"

input string BuySignal               = "ma1[2] < ma2[1] && ma1[1] > ma2[1]"; // Buy Signal
input string BuyReverseSignal        = "";                                  // Buy Reversal Signal
input OrderType BuyAt                = MARKET_PRICE;
input string BuyPendingSignal        = "";

input group "Buy Take Profit"

input TPSLType BuyTPType             = FIXED;                //Type of TP to use
input double    BuyFixedTakeProfit   = 300;                  //Fixed value
input string BuyTakeSignal           = "envelopes_upper[1]"; //Expression calculation

input group "Buy Stop Loss"

input TPSLType BuySLType           = FIXED;               //Type of SL to use
input double    BuyFixedStopLoss   = 300;                 //Fixed value
input string    BuyStopSignal      = "envelopes_lower[1]";//Expression calculation

input group "Sell Signal"

input string    SellSignal         = "";     // Sell Signal
input string    SellReverseSignal  = "";     // Sell Reversal Signal
input OrderType SellAt             = MARKET_PRICE;
input string    SellPendingSignal  = "";

input group "Sell Take Profit"

input TPSLType SellTPType          = FIXED; //Type of TP to use
input double   SellFixedTakeProfit = 0;     //Fixed value
input string   SellTakeSignal      = "";    //Expression calculation

input group "Sell Stop Loss"

input TPSLType SellSLType           = FIXED;//Type of SL to use
input double   SellFixedStopLoss    = 0;    //Fixed value
input string   SellStopSignal       = "";   //Expression calculation

#include <Expert\ExpertSignal.mqh>
#include "ExpressionParser.mqh"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ExpressionSignals : public CExpertSignal
  {

protected:
   Caller            caller;
   ExpressionParser  buyParser,buyReverseParser,buyPendingParser,buyTakeParser, buyStopParser;
   ExpressionParser  sellParser,sellReverseParser,sellPendingParser,sellTakeParser,sellStopParser;

   int               k;

   double            GetLongPrice();
   double            GetShortPrice();

public:
                     ExpressionSignals(void);
   // verification of settings
   virtual bool      ValidationSettings(void);

   // creating the indicator and timeseries
   virtual bool      InitIndicators(CIndicators *indicators);

   virtual bool      OpenLongParams(double& price,double& sl,double& tp,datetime& expiration);
   virtual bool      OpenShortParams(double& price,double& sl,double& tp,datetime& expiration);

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
   buyPendingParser(BuyPendingSignal,GetPointer(caller)),
   buyTakeParser(BuyTakeSignal,GetPointer(caller)),
   buyStopParser(BuyStopSignal,GetPointer(caller)),

   sellParser(SellSignal,GetPointer(caller)),
   sellReverseParser(SellReverseSignal,GetPointer(caller)),
   sellPendingParser(SellPendingSignal, GetPointer(caller)),
   sellTakeParser(SellTakeSignal,GetPointer(caller)),
   sellStopParser(SellStopSignal,GetPointer(caller))
  {
   if(Digits() % 2 == 1)
      k = 10;
   else
      k = 1;
  }
//+------------------------------------------------------------------+
//| Validation settings protected data                               |
//+------------------------------------------------------------------+
bool ExpressionSignals::ValidationSettings(void)
  {
   if(!CExpertSignal::ValidationSettings())
      return false;

   if(!buyParser.Init())
      return false;

   if(!sellParser.Init())
      return false;

   if(!buyReverseParser.Init())
      return false;

   if(!sellReverseParser.Init())
      return false;

   if(BuyTPType == SIGNAL)
      if(!buyTakeParser.Init())
         return false;

   if(BuySLType == SIGNAL)
      if(!buyStopParser.Init())
         return false;

   if(SellTPType == SIGNAL)
      if(!sellTakeParser.Init())
         return false;


   if(SellSLType == SIGNAL)
      if(!sellStopParser.Init())
         return false;

   if(BuyAt == PENDING)
      if(!buyPendingParser.Init())
         return false;

   if(SellAt == PENDING)
      if(!sellPendingParser.Init())
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
bool ExpressionSignals::OpenLongParams(double &price,double &sl,double &tp,datetime &expiration)
  {
   price = GetLongPrice();

   if(BuyTPType == FIXED)
      tp = m_symbol.NormalizePrice(price+(BuyFixedTakeProfit / k)*PriceLevelUnit());
   else
      tp = m_symbol.NormalizePrice(buyTakeParser.SolveExpression());

   if(BuySLType == FIXED)
      sl = m_symbol.NormalizePrice(price-(BuyFixedStopLoss / k)*PriceLevelUnit());
   else
      sl = m_symbol.NormalizePrice(buyStopParser.SolveExpression());

   expiration+=m_expiration*PeriodSeconds(m_period);
   return(true);

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionSignals::OpenShortParams(double &price,double &sl,double &tp,datetime &expiration)
  {
   price = GetShortPrice();

   if(SellTPType == FIXED)
      tp = m_symbol.NormalizePrice(price-(SellFixedTakeProfit / k)*PriceLevelUnit());
   else
      tp = m_symbol.NormalizePrice(sellTakeParser.SolveExpression());

   if(SellSLType == FIXED)
      sl = m_symbol.NormalizePrice(price+(SellFixedStopLoss / k)*PriceLevelUnit());
   else
      sl = m_symbol.NormalizePrice(sellStopParser.SolveExpression());

   expiration+=m_expiration*PeriodSeconds(m_period);
   return true;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionSignals::CheckOpenLong(double &price,double &sl,double &tp,datetime &expiration)
  {
   if(buyParser.SolveExpression() == 1)
      return OpenLongParams(price,sl,tp,expiration);

   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionSignals::CheckOpenShort(double &price,double &sl,double &tp,datetime &expiration)
  {
   if(sellParser.SolveExpression() == 1)
      return OpenShortParams(price,sl,tp,expiration);

   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionSignals::CheckReverseLong(double &price,double &sl,double &tp,datetime &expiration)
  {
   if(buyReverseParser.SolveExpression() == 1)
      return OpenLongParams(price,sl,tp,expiration);

   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionSignals::CheckReverseShort(double &price,double &sl,double &tp,datetime &expiration)
  {
   if(sellReverseParser.SolveExpression() == 1)
      return OpenShortParams(price,sl,tp,expiration);

   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ExpressionSignals::GetLongPrice()
  {
   double base_price=(m_base_price==0.0) ? m_symbol.Ask() : m_base_price;
   if(BuyAt == MARKET_PRICE)
      return m_symbol.NormalizePrice(base_price-m_price_level*PriceLevelUnit());
   return m_symbol.NormalizePrice(buyPendingParser.SolveExpression());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ExpressionSignals::GetShortPrice()
  {
   double base_price=(m_base_price==0.0) ? m_symbol.Bid() : m_base_price;
   if(SellAt == MARKET_PRICE)
      return m_symbol.NormalizePrice(base_price-m_price_level*PriceLevelUnit());
   return m_symbol.NormalizePrice(sellPendingParser.SolveExpression());
  }
//+------------------------------------------------------------------+
