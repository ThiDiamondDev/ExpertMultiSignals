//+------------------------------------------------------------------+
//|                                              CustomIndicator.mqh |
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

enum CustomType
  {
   CUSTOM1,CUSTOM2,CUSTOM3,CUSTOM4
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CustomIndicator : public CallableIndicator
  {
private:
   CiCustom                 *custom;
   CustomBuffers             buffer;
   string            path;
   double            param1,param2,param3,param4;
                     CustomIndicator(CiCustom *indicator, CustomBuffers _buffer,string _path,double p1,double p2,double p3,double p4);
public:
                     CustomIndicator(): custom(new CiCustom) {};
                     ~CustomIndicator(){
                      delete custom;
                     };
   CustomIndicator          *CreateCustomIndicator(CustomType _type,CustomBuffers _buffer);
   virtual double           GetData(int index);
   virtual void*            GetIndicator() { return GetPointer(custom);};
   virtual bool             InitIndicator();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CustomIndicator *CustomIndicator::CreateCustomIndicator(CustomType _type,CustomBuffers _buffer)
  {
   switch(_type)
     {
      case  CUSTOM1:
         return new CustomIndicator(custom,_buffer,Custom1Path,Custom1Param1,Custom1Param2, Custom1Param3, Custom1param4);
      case  CUSTOM2:
         return new CustomIndicator(custom,_buffer,Custom2Path,Custom2Param1,Custom2Param2, Custom2Param3, Custom2param4);
      case  CUSTOM3:
         return new CustomIndicator(custom,_buffer,Custom3Path,Custom3Param1,Custom3Param2, Custom3Param3, Custom3param4);
      case  CUSTOM4:
         return new CustomIndicator(custom,_buffer,Custom4Path,Custom4Param1,Custom4Param2, Custom4Param3, Custom4param4);
     }
   return NULL;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CustomIndicator::
CustomIndicator(CiCustom *indicator, CustomBuffers _buffer,string _path,double p1,double p2,double p3,double p4):
   custom(indicator),buffer(_buffer), path(_path), param1(p1),param2(p2),param3(p3),param4(p4)
  {
  }

//+------------------------------------------------------------------+
//| Create Custom indicators                                             |
//+------------------------------------------------------------------+
bool CustomIndicator::InitIndicator()
  {
   if(custom.Handle() != INVALID_HANDLE)
      return true;
   if(buffer > 3)
      return false;

   MqlParam params[5];
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
