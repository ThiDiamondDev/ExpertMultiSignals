//+------------------------------------------------------------------+
//|                                                         Term.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"

#include "Variable.mqh";
#include "Indicators/Caller.mqh";

enum TermType
  {
   TERM_UNDEFINED,
   TERM_NUMERIC,
   TERM_VARIABLE,
   TERM_ARRAY,
   TERM_EXPRESSION
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
   string            name;
   string            error;
   int               index;
   TermType          type;
   int               arrayIndex;

   void              SetError(string _error) {error = _error;}
   void              SetType(TermType _type) {type = _type;}
   void              SetIndex(int _index) {index = _index;}
   void              SetArrayIndex(int _index) {arrayIndex = _index;}

   double            GetVariableValue();
   double            GetArrayValue();
   bool              SearchVariable(string variableName);
   bool              SearchArrayName(string arrayName);

   bool              SearchTermName(string termName, string &array[],TermType _type);
   bool              IsVariable();
   bool              IsArray();
   bool              HasError();
   double            CalculateExpressions();

   int               GetArrayIndex() {return(arrayIndex);};
   string            GetName() {return(name);};
   string            GetError() {return(error);};
   bool              IsNumericValue(string value);
   int               GetNumericValue(string value);
   void              SearchValue(string valueName,double &value);


public:
                     Term(): name(""), type(TERM_UNDEFINED),index(-1), error("") {};
                     Term(string _name,Caller *_caller);
   double            GetValue();
   string            GetValueString();
   TermType          GetType() {return(type);};
   int               GetIndex() {return(index);};
   

  };


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Term::Term(string _name,Caller *_caller): name(_name), type(TERM_UNDEFINED), index(-1),error("")
  {
  caller = _caller;
   if(IsNumericValue(GetName()))
      SetType(TERM_NUMERIC);
   else
      if(!SearchVariable(GetName()))
         SearchArrayName(GetName());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Term::IsVariable(void)
  {
   return(GetType() == TERM_VARIABLE && GetIndex() >= 0);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Term::SearchVariable(string variableName)
  {
   return(SearchTermName(variableName,VALID_VARIABLES, TERM_VARIABLE));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Term::SearchArrayName(string arrayName)
  {
   bool isValidTerm = false;
   string splitted[], indexValue;
   int bracketsCloseIndex;
   StringSplit(arrayName,'[',splitted);
   if(ArraySize(splitted) == 2)
     {
      indexValue = splitted[1];
      bracketsCloseIndex = StringLen(indexValue) - 1;
      if(StringGetCharacter(indexValue,bracketsCloseIndex) == ']')
        {
         indexValue = StringSubstr(indexValue,0,bracketsCloseIndex);
         isValidTerm = SearchTermName(splitted[0],VALID_ARRAYS, TERM_ARRAY);
         if(IsNumericValue(indexValue) && isValidTerm)
           {
            SetArrayIndex(GetNumericValue(indexValue));
            return(true);
           }
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Term::CalculateExpressions(void)
  {
   string splitted[];
   double result = 0;
   int resultSize = StringSplit(GetName(),'+',splitted);

   if(resultSize > 0)
      for(int i=0; i<resultSize - 1; i+=2)
        {
         double valueA, valueB;
         SearchValue(splitted[i], valueA);
         SearchValue(splitted[i + 1], valueB);
         if(valueA && valueB)
            result += valueA + valueB;
        }
   return(result);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Term::SearchValue(string valueName,double &value)
  {
   if(IsNumericValue(valueName))
      value = GetNumericValue(valueName);
   else
     {
      int varIndex = ArrayContains(valueName,VALID_VARIABLES);
      if(varIndex >= 0)
         value = VARIABLE_VALUES[varIndex];
      else
        {
         int _arrayIndex = ArrayContains(valueName,VALID_ARRAYS);
         if(_arrayIndex >= 0)
            value = GetArrayValue();

        }
     }
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
bool Term::SearchTermName(string termName, string &array[],TermType _type)
  {
   int _index = ArrayContains(termName,array);
   if(_index >= 0)
     {
      SetType(_type);
      SetIndex(_index);
      return(true);
     }
   return(false);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Term::IsArray(void)
  {
   return(GetType() == TERM_ARRAY && GetIndex() >= 0 && GetArrayIndex() >= 0);
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
      case TERM_VARIABLE:
         return(GetVariableValue());
      case TERM_ARRAY:
         return(GetArrayValue()) ;
      case TERM_EXPRESSION:
         return(CalculateExpressions()) ;

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
      return(DoubleToString(GetValue(), 0));
   return(DoubleToString(GetValue()));
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Term::GetVariableValue(void)
  {
   return(VARIABLE_VALUES[GetIndex()]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Term::GetArrayValue(void)
  {
   return(caller.CallIndicator(GetIndex(), GetArrayIndex()));
  }


//+------------------------------------------------------------------+
