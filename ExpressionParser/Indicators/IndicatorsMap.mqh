//+------------------------------------------------------------------+
//|                                                IndicatorsMap.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link "https://github.com/ThiDiamondDev"
#property version "1.00"

#include <Generic/HashMap.mqh>
#include "Trend/AMA.mqh"
#include "Trend/ADX.mqh"
#include "Trend/ADXWilder.mqh"
#include "Trend/BollingerBands.mqh"
#include "Trend/Dema.mqh"
#include "Trend/Envelopes.mqh"
#include "Trend/FrAMA.mqh"
#include "Trend/Ichimoku.mqh"
#include "Trend/MovingAverages.mqh"
#include "Trend/ParabolicSAR.mqh"
#include "Trend/StdDev.mqh"
#include "Trend/Tema.mqh"
#include "Trend/Vidya.mqh"

#include "Volumes/AD.mqh"
#include "Volumes/MFI.mqh"
#include "Volumes/OBV.mqh"
#include "Volumes/Volumes.mqh"

#include "BillWilliams/AC.mqh"
#include "BillWilliams/Alligator.mqh"
#include "BillWilliams/AlligatorOscilator.mqh"
#include "BillWilliams/AO.mqh"
#include "BillWilliams/BWMFI.mqh"
#include "BillWilliams/Fractals.mqh"

#include "CustomIndicator.mqh"
#include "Timeseries.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class IndicatorsMap: public CHashMap<string, CallableIndicator *>
  {
private:
   CustomIndicator   customIndicator;
public:
                     IndicatorsMap();
   void              AddTrendIndicators();
   void              AddVolumeIndicators();
   void              AddBillWilliamsIndicators();
   void              AddCustomIndicators();
   void              AddTimeseriesIndicators();
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
IndicatorsMap::IndicatorsMap(void)
  {
   ::CHashMap<string, CallableIndicator *>();
   AddTrendIndicators();
   AddVolumeIndicators();
   AddBillWilliamsIndicators();
   AddCustomIndicators();
   AddTimeseriesIndicators();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void IndicatorsMap::AddTrendIndicators()
  {
   Add("ama", new AMA());

   Add("ma1", new MA1());
   Add("ma2", new MA2());
   Add("ma3", new MA3());
   Add("ma4", new MA4());

   Add("adx_main", new ADXMain());
   Add("adx_plus", new ADXPlus());
   Add("adx_minus",new ADXMinus());

   Add("adx_wilder_main", new ADXWilderMain());
   Add("adx_wilder_plus", new ADXWilderPlus());
   Add("adx_wilder_minus",new ADXWilderMinus());

   Add("bb_upper", new BBUpper());
   Add("bb_base",  new BBBase());
   Add("bb_lower", new BBLower());

   Add("dema", new Dema());

   Add("envelopes_upper", new EnvelopesUpper());
   Add("envelopes_lower", new EnvelopesLower());

   Add("frama", new FrAMA());

   Add("tenkan_sen",    new IchimokuTenkanSen());
   Add("kijun_sen",     new IchimokuKijunSen());
   Add("senkou_span_a", new IchimokuSenkouSpanA());
   Add("senkou_span_b", new IchimokuSenkouSpanB());
   Add("chikou_span",   new IchimokuChikouSpan());

   Add("parabolic_sar",   new ParabolicSAR());

   Add("std_dev",   new StdDev());

   Add("tema",   new Tema());

   Add("vidya",   new Vidya());

  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void IndicatorsMap::AddVolumeIndicators()
  {
   Add("ad", new AD());
   Add("mfi", new MFI());
   Add("obv", new OBV());
   Add("volumes", new Volumes());
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void IndicatorsMap::AddBillWilliamsIndicators()
  {
   Add("ac", new AD());

   Add("alligator_lips", new AlligatorLips());
   Add("alligator_teeth",new AlligatorTeeth());
   Add("alligator_jaws", new AlligatorJaws());

   Add("gator_upper", new GatorUpper());
   Add("gator_lower",new GatorLower());

   Add("ao", new AO());
   Add("bwmfi", new BWMFI());

   Add("fractals_up", new FractalsUpper());
   Add("fractals_down",new FractalsLower());

  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void IndicatorsMap::AddCustomIndicators()
  {
   Add("custom1a", customIndicator.CreateCustomIndicator(CUSTOM1,A));
   Add("custom1b", customIndicator.CreateCustomIndicator(CUSTOM1,B));
   Add("custom1c", customIndicator.CreateCustomIndicator(CUSTOM1,C));
   Add("custom1d", customIndicator.CreateCustomIndicator(CUSTOM1,D));

   Add("custom2a", customIndicator.CreateCustomIndicator(CUSTOM2,A));
   Add("custom2b", customIndicator.CreateCustomIndicator(CUSTOM2,B));
   Add("custom2c", customIndicator.CreateCustomIndicator(CUSTOM2,C));
   Add("custom2d", customIndicator.CreateCustomIndicator(CUSTOM2,D));

   Add("custom3a", customIndicator.CreateCustomIndicator(CUSTOM3,A));
   Add("custom3b", customIndicator.CreateCustomIndicator(CUSTOM3,B));
   Add("custom3c", customIndicator.CreateCustomIndicator(CUSTOM3,C));
   Add("custom3d", customIndicator.CreateCustomIndicator(CUSTOM3,D));

   Add("custom4a", customIndicator.CreateCustomIndicator(CUSTOM4,A));
   Add("custom4b", customIndicator.CreateCustomIndicator(CUSTOM4,B));
   Add("custom4c", customIndicator.CreateCustomIndicator(CUSTOM4,C));
   Add("custom4d", customIndicator.CreateCustomIndicator(CUSTOM4,D));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void IndicatorsMap::AddTimeseriesIndicators()
  {
   Add("open",new Open());
   Add("high",new High());
   Add("low",new Low());
   Add("close",new Close());

   Add("ask", new Ask());
   Add("bid", new Bid());
   Add("last",new Last());
  };
//+------------------------------------------------------------------+
