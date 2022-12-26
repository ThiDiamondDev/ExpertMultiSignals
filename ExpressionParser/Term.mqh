//+------------------------------------------------------------------+
//|                                                         Term.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"

#include "Utils.mqh";
#include "Indicators/Caller.mqh";

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class NumericTerm : public CallableIndicator
  {
protected:
   double            value;
public:
                     NumericTerm(double number): value(number) {};
   virtual double    GetData(int index) { return value;};
   virtual bool      InitIndicator() { return true;};
   virtual void*     GetIndicator() { return NULL;};

  };


//+------------------------------------------------------------------+
//|  Term Class                                                      |
//+------------------------------------------------------------------+
class Term
  {
private:
   Caller            *caller;
   CallableIndicator *indicator;
   string            name;
   string            error;
   int               index;

   void              SetName(string value)  {name  = value;}
   void              SetError(string value) {error = value;}
   void              SetIndex(int value)    {index = value;}

   bool              SearchName(string arrayName);

   bool              HasError();

public:
                     Term(): name(""),index(-1), error("") {};
                     Term(string _name,Caller *_caller);
                    ~Term();
   double            GetValue();
   int               GetIndex()  {return(index);};
   string            GetName() {return(name);};
   string            GetError() {return(error);};

  };


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Term::Term(string _name,Caller *_caller): name(_name), error(""), caller(_caller)
  {
   if(!SearchName(GetName()))
      SetError("Error searching term name: " + name);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Term::~Term()
  {
   delete indicator;
   delete caller;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Term::SearchName(string termName)
  {
   if(IsNumeric(termName))
     {
      indicator = new NumericTerm(StringToInteger(termName));
      return true;
     }
   if(caller.TryGetIndicator(termName,indicator))
      return true;
   string splitted[], indexValue;
   int bracketsCloseIndex;
   StringSplit(termName,'[',splitted);

   if(ArraySize(splitted) == 2)
     {
      indexValue = splitted[1];
      bracketsCloseIndex = StringLen(indexValue) - 1;
      if(StringGetCharacter(indexValue,bracketsCloseIndex) == ']')
        {
         string callName = splitted[0];
         indexValue = StringSubstr(indexValue,0,bracketsCloseIndex);
         bool isValidTerm = caller.IsValidIndicator(callName);
         if(IsNumeric(indexValue) && isValidTerm)
           {
            SetName(callName);
            SetIndex((int)StringToInteger(indexValue));
            caller.AddCalledIndicator(callName);
            return caller.TryGetIndicator(callName,indicator);
           }
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Term::HasError(void)
  {
   return(GetError() != "");
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Term::GetValue(void)
  {
   return indicator.GetData(GetIndex());
  }
//+------------------------------------------------------------------+
