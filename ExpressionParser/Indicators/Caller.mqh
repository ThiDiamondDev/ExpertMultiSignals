//+------------------------------------------------------------------+
//|                                                     Variable.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"

#include "MovingAverages.mqh"
// Include additional header
#include <Generic/HashMap.mqh>

#include <Arrays\ArrayString.mqh>


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Caller
  {
private:
   CHashMap          <string, CallableIndicator *>   indicatorsMap;
   CArrayString       calledIndicators;   
   bool              InitIndicator(string indicatorName);
   
public:
                     Caller();
                    ~Caller(void) {};
   double            CallIndicator(string indicatorName,int callIndex);
   bool              IsValidIndicator(string indicatorName);
   void              AddCalledIndicator(string indicatorName);
   bool              InitIndicators();
   
  };


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Caller::Caller()
  {
   indicatorsMap.Add("ma1", new MA1());
   indicatorsMap.Add("ma2", new MA2());
   indicatorsMap.Add("ma3", new MA3());
   indicatorsMap.Add("ma4", new MA4());
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool    Caller::InitIndicator(string indicatorName)
  {
   CallableIndicator *indicator = NULL;
   if(indicatorsMap.TryGetValue(indicatorName,indicator))
      return(indicator.InitIndicator());

   return(false);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool    Caller::InitIndicators()
  {
   for(int index=0; index<calledIndicators.Total(); index++)
      if(!InitIndicator(calledIndicators.At(index)))
         return(false);

   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void    Caller::AddCalledIndicator(string indicatorName)
  {
   if(calledIndicators.Search(indicatorName) == -1 && IsValidIndicator(indicatorName))
      calledIndicators.Add(indicatorName);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Caller::IsValidIndicator(string indicatorName)
  {
   return(indicatorsMap.ContainsKey(indicatorName));
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Caller::CallIndicator(string indicatorName,int callIndex)
  {
   CallableIndicator *indicator = NULL;
   if(indicatorsMap.TryGetValue(indicatorName,indicator))
      return(indicator.GetData(callIndex));

   return(0);
  }
//+------------------------------------------------------------------+
