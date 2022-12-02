//+------------------------------------------------------------------+
//|                                             ExpressionParser.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+

#include "Expression.mqh"
#include "Indicators\Caller.mqh";
#include <Object.mqh>
#include <Arrays\ArrayObj.mqh>
#include <Arrays\ArrayString.mqh>

const string RELATIONAL_OPERATORS_STRING[] = {"==","!=",">","<",">=","<="};
const char RELATIONAL_OPERATORS_TOKENS[] = {'=','!','>','<','@','#'};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int    TOKENS_SIZE = ArraySize(RELATIONAL_OPERATORS_TOKENS);
char LOGICAL_OPERATORS[] = {'&'};


//+------------------------------------------------------------------+
//| ExpressionParser class                                           |
//+------------------------------------------------------------------+
class ExpressionParser
  {
private:
   string            expression_str;
   CArrayObj         expressions;
  Caller            *caller;

  string             GetExpressionStr(void) {return(expression_str);}
   void              SplitExpressions(void);
   void              ReplaceOperatorsWithTokens(string &_expression);
   int               SplitByOperators(string &expression,ushort &codeArray[], string &result[]);
   bool              ResolveLogicalExpression(bool expression1, bool expression2,bool isAndCondition);

public:
                     ExpressionParser(string _expression);
                    ~ExpressionParser();

   bool              ResolveAllExpressions(void);
   void              PrintAllSolvedExpressions();
   string            GetAllSolvedExpressions();
   bool              InitIndicators();

  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ExpressionParser::ExpressionParser(string _expression)
   : expression_str(_expression)
  {
   StringReplace(expression_str, " ", "");
   caller = new Caller();
   SplitExpressions();
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ExpressionParser::~ExpressionParser()
  {
   delete caller;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::SplitExpressions()
  {
   string _expressions[];
   string expression = GetExpressionStr();

   ReplaceOperatorsWithTokens(expression);

   StringSplit(expression, LOGICAL_OPERATORS[0],_expressions);
   for(int expIdx = 0; expIdx < ArraySize(_expressions); expIdx++)
      for(int opIdx=0; opIdx < ArraySize(RELATIONAL_OPERATORS_TOKENS) ; opIdx++)
        {
         string result[];
         if(StringSplit(_expressions[expIdx],RELATIONAL_OPERATORS_TOKENS[opIdx],result) == 2)
            expressions.Add(
               new  Expression(result[0], result[1], RELATIONAL_OPERATORS_STRING[opIdx],opIdx,caller));
        }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionParser::InitIndicators()
  {
   return(caller.InitIndicators());
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::ReplaceOperatorsWithTokens(string &_expression)
  {
   for(int i=0; i<TOKENS_SIZE; i++)
      StringReplace(_expression,RELATIONAL_OPERATORS_STRING[i],CharToString(RELATIONAL_OPERATORS_TOKENS[i]));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionParser::ResolveAllExpressions(void)
  {
   for(int i=0; i<expressions.Total(); i++)
     {
      Expression *expr= expressions.At(i);
      if(!expr.Resolve())
         return(false);
     }
   return true;
  }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::PrintAllSolvedExpressions(void)
  {
   for(int i=0; i<expressions.Total(); i++)
     {
      Expression *expression= expressions.At(i);
      Print("Expression[" + IntegerToString(i) + "]");
      Print(expression.GetSolvedString());
     }
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ExpressionParser::GetAllSolvedExpressions(void)
  {
   string solution = "";
   for(int i=0; i<expressions.Total(); i++)
     {
      Expression *expression= expressions.At(i);
      if(i > 0)
         solution += " & ";

      solution += expression.GetSolvedString();
     }
   return(solution);
  }
//+------------------------------------------------------------------+
