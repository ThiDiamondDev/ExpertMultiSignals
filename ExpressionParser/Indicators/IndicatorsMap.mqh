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


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class IndicatorsMap: public CHashMap<string, CallableIndicator *>
  {
public:
                     IndicatorsMap();
   void              AddTrendIndicators();
   void              AddVolumeIndicators();
   void              AddBillWilliamsIndicators();

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
