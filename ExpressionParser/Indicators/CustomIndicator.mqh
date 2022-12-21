//+------------------------------------------------------------------+
//|                                               CustomIndicator.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Custom.mqh>
#include "CallableIndicator.mqh"


input group                "Custom Indicator 1"

input string                Custom1Path         = "";    // Path to indicator file
input double                Custom1Param1       =  0;    // Parameter 1
input double                Custom1Param2       =  0;    // Parameter 2
input double                Custom1Param3       =  0;    // Parameter 3
input double                Custom1param4       =  0;    // Parameter 4

input group                "Custom Indicator 2"

input string                Custom2Path         = "";    // Path to indicator file
input double                Custom2Param1       =  0;    // Parameter 1
input double                Custom2Param2       =  0;    // Parameter 2
input double                Custom2Param3       =  0;    // Parameter 3
input double                Custom2param4       =  0;    // Parameter 4

input group                "Custom Indicator 3"

input string                Custom3Path         = "";    // Path to indicator file
input double                Custom3Param1       =  0;    // Parameter 1
input double                Custom3Param2       =  0;    // Parameter 2
input double                Custom3Param3       =  0;    // Parameter 3
input double                Custom3param4       =  0;    // Parameter 4

input group                "Custom Indicator 4"

input string                Custom4Path         = "";    // Path to indicator file
input double                Custom4Param1       =  0;    // Parameter 1
input double                Custom4Param2       =  0;    // Parameter 2
input double                Custom4Param3       =  0;    // Parameter 3
input double                Custom4param4       =  0;    // Parameter 4

enum CustomBuffers
  {
   A,B,C,D
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CustomIndicator : public CallableIndicator
  {
private:
   CiCustom                 custom;
   int                      buffer;
   void                     SetBuffer(int value) {buffer = value;};
public:
   virtual double           GetData(int index);
   virtual void*            GetIndicator() { return GetPointer(custom);};
   bool                     InitCustom(int buffer,string path, double param1,double param2, double param3, double param4);
  };
//+------------------------------------------------------------------+
//| Create Custom indicators                                             |
//+------------------------------------------------------------------+
bool CustomIndicator::InitCustom(int _buffer,string path, double param1,double param2, double param3, double param4)
  {
   if(_buffer > 3)
      return false;

   SetBuffer(_buffer);
   MqlParam params[4];
   params[0].type          = TYPE_STRING;
   params[0].string_value  = path;
   params[1].type          = TYPE_DOUBLE;
   params[1].double_value  = param1;
   params[2].type          = TYPE_DOUBLE;
   params[2].double_value  = param2;
   params[3].type          = TYPE_DOUBLE;
   params[3].double_value  = param3;
   params[4].type          = TYPE_DOUBLE;
   params[4].double_value  = param4;
// initialize object
   if(!custom.Create(Symbol(),Period(),IND_CUSTOM,ArraySize(params),params))
     {
      printf(__FUNCTION__ + ": error initializing Custom");
      return(false);
     }

   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CustomIndicator::GetData(int index)
  {
   return custom.GetData(buffer, index);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom1A: public CustomIndicator
  {
public:
   virtual bool      InitIndicator()
     {
      return InitCustom(A,Custom1Path,Custom1Param1,Custom1Param2, Custom1Param3, Custom1param4);
     };
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom1B: public CustomIndicator
  {
public:
   virtual bool      InitIndicator()
     {
      return InitCustom(B,Custom1Path,Custom1Param1,Custom1Param2, Custom1Param3, Custom1param4);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom1C: public CustomIndicator
  {
public:
   virtual bool      InitIndicator()
     {
      return InitCustom(C,Custom1Path,Custom1Param1,Custom1Param2, Custom1Param3, Custom1param4);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom1D: public CustomIndicator
  {
   virtual bool      InitIndicator()
     {
      return InitCustom(D,Custom1Path,Custom1Param1,Custom1Param2, Custom1Param3, Custom1param4);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom2A: public CustomIndicator
  {
public:
   virtual bool      InitIndicator()
     {
      return InitCustom(A,Custom2Path,Custom2Param1,Custom2Param2, Custom2Param3, Custom2param4);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom2B: public CustomIndicator
  {
public:

   virtual bool      InitIndicator()
     {
      return InitCustom(B,Custom2Path,Custom2Param1,Custom2Param2, Custom2Param3, Custom2param4);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom2C: public CustomIndicator
  {
public:
   virtual bool      InitIndicator()
     {
      return InitCustom(C,Custom2Path,Custom2Param1,Custom2Param2, Custom2Param3, Custom2param4);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom2D: public CustomIndicator
  {
public:

   virtual bool      InitIndicator()
     {
      return InitCustom(D,Custom2Path,Custom2Param1,Custom2Param2, Custom2Param3, Custom2param4);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom3A: public CustomIndicator
  {
public:
   virtual bool      InitIndicator()
     {
      return InitCustom(A,Custom3Path,Custom3Param1,Custom3Param2, Custom3Param3, Custom3param4);
     };
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom3B: public CustomIndicator
  {
public:
   virtual bool      InitIndicator()
     {
      return InitCustom(B,Custom3Path,Custom3Param1,Custom3Param2, Custom3Param3, Custom3param4);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom3C: public CustomIndicator
  {
public:
   virtual bool      InitIndicator()
     {
      return InitCustom(C,Custom3Path,Custom3Param1,Custom3Param2, Custom3Param3, Custom3param4);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom3D: public CustomIndicator
  {
public:
   virtual bool      InitIndicator()
     {
      return InitCustom(D,Custom3Path,Custom3Param1,Custom3Param2, Custom3Param3, Custom3param4);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom4A: public CustomIndicator
  {
public:
   virtual bool      InitIndicator()
     {
      return InitCustom(A,Custom4Path,Custom4Param1,Custom4Param2, Custom4Param3, Custom4param4);
     };
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom4B: public CustomIndicator
  {
public:
   virtual bool      InitIndicator()
     {
      return InitCustom(B,Custom4Path,Custom4Param1,Custom4Param2, Custom4Param3, Custom4param4);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom4C: public CustomIndicator
  {
public:
   virtual bool      InitIndicator()
     {
      return InitCustom(C,Custom4Path,Custom4Param1,Custom4Param2, Custom4Param3, Custom4param4);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Custom4D: public CustomIndicator
  {
public:
   virtual bool      InitIndicator()
     {
      return InitCustom(D,Custom4Path,Custom4Param1,Custom4Param2, Custom4Param3, Custom4param4);
     };
  };
//+------------------------------------------------------------------+
