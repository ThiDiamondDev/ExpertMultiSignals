//+------------------------------------------------------------------+
//|                                                   Timeseries.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Custom.mqh>
#include "CallableIndicator.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Open : public CallableIndicator
  {
private:
   CiOpen            open;
public:
   virtual double    GetData(int index) { return open.GetData(index);};
   virtual void*     GetIndicator()     { return GetPointer(open);};
   virtual bool      InitIndicator();
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Open::InitIndicator()
  {
// initialize object
   if(!open.Create(Symbol(),Period()))
     {
      printf(__FUNCTION__ + ": error initializing Open");
      return false ;
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class High : public CallableIndicator
  {
private:
   CiHigh            high;
public:
   virtual double    GetData(int index) { return high.GetData(index);};
   virtual void*     GetIndicator()     { return GetPointer(high);};
   virtual bool      InitIndicator();
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool High::InitIndicator()
  {
// initialize object
   if(!high.Create(Symbol(),Period()))
     {
      printf(__FUNCTION__ + ": error initializing High");
      return false ;
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Low : public CallableIndicator
  {
private:
   CiLow             low;
public:
   virtual double    GetData(int index) { return low.GetData(index);};
   virtual void*     GetIndicator()     { return GetPointer(low);};
   virtual bool      InitIndicator();
  };

//+------------------------------------------------------------------+
//|                                                                             |
//+------------------------------------------------------------------+
bool Low::InitIndicator()
  {
// initialize object
   if(!low.Create(Symbol(),Period()))
     {
      printf(__FUNCTION__ + ": error initializing Low");
      return false ;
     }
   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Close : public CallableIndicator
  {
private:
   CiClose            close;
public:
   virtual double     GetData(int index) { return close.GetData(index);};
   virtual void*      GetIndicator()     { return GetPointer(close);};
   virtual bool       InitIndicator();
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Close::InitIndicator()
  {
// initialize object
   if(!close.Create(Symbol(),Period()))
     {
      printf(__FUNCTION__ + ": error initializing Close");
      return false ;
     }
   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Ask: public CallableIndicator
  {
public:
   virtual double    GetData(int index) { return SymbolInfoDouble(Symbol(), SYMBOL_ASK);};
   virtual void*     GetIndicator()     { return NULL;};
   virtual bool      InitIndicator()    { return true;};
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Bid: public CallableIndicator
  {
public:
   virtual double    GetData(int index) { return SymbolInfoDouble(Symbol(), SYMBOL_BID);};
   virtual void*     GetIndicator()     { return NULL;};
   virtual bool      InitIndicator()    { return true;};
  };
  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Last: public CallableIndicator
  {
public:
   virtual double    GetData(int index) { return SymbolInfoDouble(Symbol(), SYMBOL_LAST);};
   virtual void*     GetIndicator()     { return NULL;};
   virtual bool      InitIndicator()    { return true;};
   };