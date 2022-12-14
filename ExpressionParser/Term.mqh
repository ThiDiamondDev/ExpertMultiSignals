//+------------------------------------------------------------------+
//|                                                         Term.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"

#include "Indicators/Caller.mqh";

enum TermType
  {
   TERM_UNDEFINED,
   TERM_NUMERIC,
   TERM_CALLABLE
  };


template<typename T> int ArrayContains(T value, const T& array[])
  {
   int index=ArraySize(array);
   while(--index >= 0)
      if(array[index] == value)
         break;
   return index;
  }
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
   TermType          type;

   void              SetName(string value) {name = value;}
   void              SetError(string value) {error = value;}
   void              SetType(TermType _type) {type = _type;}
   void              SetIndex(int _index) {index = _index;}

   double            CallValue();
   bool              SearchName(string arrayName);

   bool              HasError();

   string            GetName() {return(name);};
   string            GetError() {return(error);};
   bool              IsNumericValue(string value);
   int               GetNumericValue(string value);

public:
                     Term(): name(""), type(TERM_UNDEFINED),index(-1), error("") {};
                     Term(string _name,Caller *_caller);
                     ~Term();
   double            GetValue();
   string            GetValueString();
   TermType          GetType()   {return(type);};
   int               GetIndex()  {return(index);};
   bool              IsNumeric() { return(IsNumericValue(GetName()));};


  };


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Term::Term(string _name,Caller *_caller): name(_name), error(""), caller(_caller)
  {
   if(IsNumericValue(GetName()))
      SetType(TERM_NUMERIC);
   else
      if(!SearchName(GetName()))
         SetError("Error searching term name");

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
   bool isValidTerm = false;
   if(caller.TryGetIndicator(termName,indicator))
     {
      caller.AddCalledIndicator(termName);
      SetType(TERM_CALLABLE);
      return true;
     }
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
         isValidTerm = caller.IsValidIndicator(callName);
         if(IsNumericValue(indexValue) && isValidTerm)
           {
            SetName(callName);
            SetIndex(GetNumericValue(indexValue));
            SetType(TERM_CALLABLE);
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
bool Term::IsNumericValue(string value)
  {
   for(int i=0; i<StringLen(value); i++)
     {
      int currentChar = StringGetCharacter(value, i);
      if(currentChar < '0' || currentChar > '9')
         return(false);
     }
   return(true);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Term::GetNumericValue(string value)
  {
   return((int)StringToInteger(value));
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
   switch(GetType())
     {
      case TERM_NUMERIC:
         return(GetNumericValue(GetName()));
      case TERM_CALLABLE:
         return(CallValue()) ;

     }

   SetError("Term not found");
   return(0);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Term::GetValueString(void)
  {
   if(HasError())
      return(error);
   if(GetType() == TERM_NUMERIC)
      return DoubleToString(GetValue(), 0);
   return DoubleToString(GetValue());
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Term::CallValue(void)
  {
   return indicator.GetData(GetIndex());
  }


//+------------------------------------------------------------------+
