//+------------------------------------------------------------------+
//|                                                       expert.mq5 |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link "https://github.com/ThiDiamondDev"
#property version "1.00"

//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
//--- inputs for expert
input string Expert_Title = "expert";        // Document name
input string BuySignal = "ma1[1] >= ma2[1]"; // Buy Signal
input string SellSignal = "ma1[1] < ma2[1]"; // Sell Signal

ulong Expert_MagicNumber = 25401; //
bool Expert_EveryTick = false;    //
//--- inputs for main signal
input int Signal_ThresholdOpen = 10;                // Signal threshold value to open [0...100]
input int Signal_ThresholdClose = 10;               // Signal threshold value to close [0...100]
input double Signal_PriceLevel = 0.0;               // Price level to execute a deal
input double Signal_StopLevel = 50.0;               // Stop Loss level (in points)
input double Signal_TakeLevel = 50.0;               // Take Profit level (in points)
input int Signal_Expiration = 4;                    // Expiration of pending orders (in bars)
input double Signal_ExpressionSignals_Weight = 1.0; // ExpressionSignals Weight [0...1.0]
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include <Expert\Expert.mqh>
//--- available signals
#include "ExpressionSignals.mqh"
//--- available trailing
#include <Expert\Trailing\TrailingNone.mqh>
//--- available money management
#include <Expert\Money\MoneyNone.mqh>
//+------------------------------------------------------------------+
//| Global expert object                                             |
//+------------------------------------------------------------------+
CExpert ExtExpert;
//+------------------------------------------------------------------+
//| Initialization function of the expert                            |
//+------------------------------------------------------------------+
int OnInit()
{
  ENUM_ACCOUNT_TRADE_MODE account_type = (ENUM_ACCOUNT_TRADE_MODE)AccountInfoInteger(ACCOUNT_TRADE_MODE);
  if (account_type != ACCOUNT_TRADE_MODE_DEMO)
    return (INIT_FAILED);
  //--- Initializing expert
  if (!ExtExpert.Init(Symbol(), Period(), Expert_EveryTick, Expert_MagicNumber))
  {
    //--- failed
    printf(__FUNCTION__ + ": error initializing expert");
    ExtExpert.Deinit();
    return (INIT_FAILED);
  }

  //--- Creating signal
  ExpressionSignals *signal = new ExpressionSignals;
  if (signal == NULL)
  {
    //--- failed
    printf(__FUNCTION__ + ": error creating signal");
    ExtExpert.Deinit();
    return (INIT_FAILED);
  }
  //---
  ExtExpert.InitSignal(signal);
  signal.ThresholdOpen(Signal_ThresholdOpen);
  signal.ThresholdClose(Signal_ThresholdClose);
  signal.PriceLevel(Signal_PriceLevel);
  signal.StopLevel(Signal_StopLevel);
  signal.TakeLevel(Signal_TakeLevel);
  signal.Expiration(Signal_Expiration);
  signal.BuySignal(BuySignal);
  signal.SellSignal(SellSignal);

  //--- Creating filter ExpressionSignals
  ExpressionSignals *filter0 = new ExpressionSignals;
  if (filter0 == NULL)
  {
    //--- failed
    printf(__FUNCTION__ + ": error creating filter0");
    ExtExpert.Deinit();
    return (INIT_FAILED);
  }
  signal.AddFilter(filter0);
  //--- Set filter parameters
  filter0.Weight(Signal_ExpressionSignals_Weight);
  //--- Creation of trailing object
  CTrailingNone *trailing = new CTrailingNone;
  if (trailing == NULL)
  {
    //--- failed
    printf(__FUNCTION__ + ": error creating trailing");
    ExtExpert.Deinit();
    return (INIT_FAILED);
  }
  //--- Add trailing to expert (will be deleted automatically))
  if (!ExtExpert.InitTrailing(trailing))
  {
    //--- failed
    printf(__FUNCTION__ + ": error initializing trailing");
    ExtExpert.Deinit();
    return (INIT_FAILED);
  }
  //--- Set trailing parameters
  //--- Creation of money object
  CMoneyNone *money = new CMoneyNone;
  if (money == NULL)
  {
    //--- failed
    printf(__FUNCTION__ + ": error creating money");
    ExtExpert.Deinit();
    return (INIT_FAILED);
  }
  //--- Add money to expert (will be deleted automatically))
  if (!ExtExpert.InitMoney(money))
  {
    //--- failed
    printf(__FUNCTION__ + ": error initializing money");
    ExtExpert.Deinit();
    return (INIT_FAILED);
  }
  //--- Set money parameters
  //--- Check all trading objects parameters
  if (!ExtExpert.ValidationSettings())
  {
    //--- failed
    ExtExpert.Deinit();
    return (INIT_FAILED);
  }
  //--- Tuning of all necessary indicators
  if (!ExtExpert.InitIndicators())
  {
    //--- failed
    printf(__FUNCTION__ + ": error initializing indicators");
    ExtExpert.Deinit();
    return (INIT_FAILED);
  }
  //--- ok
  return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Deinitialization function of the expert                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
  ExtExpert.Deinit();
}
//+------------------------------------------------------------------+
//| "Tick" event handler function                                    |
//+------------------------------------------------------------------+
void OnTick()
{
  ExtExpert.OnTick();
}
//+------------------------------------------------------------------+
//| "Trade" event handler function                                   |
//+------------------------------------------------------------------+
void OnTrade()
{
  ExtExpert.OnTrade();
}
//+------------------------------------------------------------------+
//| "Timer" event handler function                                   |
//+------------------------------------------------------------------+
void OnTimer()
{
  ExtExpert.OnTimer();
}
//+------------------------------------------------------------------+