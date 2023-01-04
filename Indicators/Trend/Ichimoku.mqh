//+------------------------------------------------------------------+
//|                                                     Ichimoku.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Trend.mqh>
#include "../CallableIndicator.mqh"

input group "Ichimoku Kinko Hyo"
input int TenkanSen                           = 9; // Tenkan-Sen
input int KijunSen                            = 26;  // Kijun-Sen
input int SenkouSpan                          = 52;  // Senkou Span B
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Ichimoku : public CallableIndicator
  {
protected:
   CiIchimoku          cloud;

public:
                     Ichimoku() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index) { return  0;};
   virtual void*     GetIndicator() { return GetPointer(cloud);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Ichimoku::InitIndicator()
  {
   if(!cloud.Create(Symbol(), Period(),TenkanSen,KijunSen,SenkouSpan))
     {
      printf(__FUNCTION__ + ": error initializing Ichimoku");
      return (false);
     }

   return (true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class IchimokuTenkanSen : public Ichimoku
  {
public:
   virtual double    GetData(int index) override
     {
      return cloud.TenkanSen(index);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class IchimokuKijunSen : public Ichimoku
  {
   virtual double    GetData(int index) override
     {
      return cloud.KijunSen(index);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class IchimokuSenkouSpanA : public Ichimoku
  {
   virtual double    GetData(int index) override
     {
      return cloud.SenkouSpanA(index);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class IchimokuSenkouSpanB : public Ichimoku
  {
   virtual double    GetData(int index) override
     {
      return cloud.SenkouSpanB(index);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class IchimokuChikouSpan : public Ichimoku
  {
   virtual double    GetData(int index) override
     {
      return cloud.ChinkouSpan(index);
     };
  };
//+------------------------------------------------------------------+
