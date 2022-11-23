//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+

/*
   Operations: /, %, *, +, -, >, <, >=, <=, ==, !=, &&, ||
*/
#include "Expression.mqh"
#include <Object.mqh>
#include <Arrays\ArrayObj.mqh>
#include <Arrays\ArrayInt.mqh>

const string RELATIONAL_OPERATORS_STRING[] = {"==","!=",">","<",">=","<="};
string RELATIONAL_OPERATORS_TOKENS[] = {"=","!",">","<","@","#",};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int    TOKENS_SIZE = ArraySize(RELATIONAL_OPERATORS_TOKENS);
string LOGICAL_OPERATORS_STRING[] = {"&"};


//+------------------------------------------------------------------+
//| ExpressionParser class                                           |
//+------------------------------------------------------------------+
class ExpressionParser
  {
private:
   string            expression_str;
   CArrayObj         expressions;
   CArrayInt         *termIndexArray;
   ushort            relationalCodeArray[], logicalCodeArray[];

   void              FillTermIndexArray(void);
   string            GetExpressionStr(void) {return(expression_str);}
   void              SplitExpressions(void);
   void              GetValidOperatorsCodeArray(ushort& array[],string &operators[]);
   void              ReplaceOperatorsWithTokens(string &_expression);
   void              ReplaceTokensWithOperators(string &_expression);
   int               SplitByOperators(string &expression,ushort &codeArray[], string &result[]);
   bool              ResolveLogicalExpression(bool expression1, bool expression2,bool isAndCondition);

public:
                     ExpressionParser(string _expression);
                     ~ExpressionParser(){
                     delete termIndexArray;
                     };
   
   void              ResolveAllExpressions(void);
   void              PrintAllSolvedExpressions();
   string            GetAllSolvedExpressions();
   void              GetTermIndexArray();
   void              TermIndexArray(CArrayInt *array);
   
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ExpressionParser::ExpressionParser(string _expression)
   : expression_str(_expression)
  {
   StringReplace(expression_str, " ", "");
   GetValidOperatorsCodeArray(relationalCodeArray,RELATIONAL_OPERATORS_TOKENS);
   GetValidOperatorsCodeArray(logicalCodeArray,LOGICAL_OPERATORS_STRING);

   SplitExpressions();
   FillTermIndexArray();
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::SplitExpressions()
  {
   string _expressions[];
   string expression = GetExpressionStr();

   ReplaceOperatorsWithTokens(expression);

   StringSplit(expression, logicalCodeArray[0],_expressions);
   for(int expIdx = 0; expIdx < ArraySize(_expressions); expIdx++)
      for(int opIdx=0; opIdx < ArraySize(relationalCodeArray) ; opIdx++)
        {
         string result[];
         if(StringSplit(_expressions[expIdx],relationalCodeArray[opIdx],result) == 2)
            expressions.Add(
               new  Expression(result[0], result[1], RELATIONAL_OPERATORS_STRING[opIdx],opIdx));
        }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  ExpressionParser::FillTermIndexArray()
  {
   for(int i=0; i<expressions.Total(); i++)
     {
      Expression *expression= expressions.At(i);
      if(!expression.HasError())
        {
         TermType typeA = expression.GetTermAType();
         TermType typeB = expression.GetTermBType();
         int      indexA = expression.GetTermAIndex();
         int      indexB = expression.GetTermBIndex();

         if(typeA == TERM_ARRAY && termIndexArray.Search(indexA) == -1)
            termIndexArray.Add(indexA);
         if(typeB == TERM_ARRAY && termIndexArray.Search(indexB) == -1)
            termIndexArray.Add(indexB);

        }
     }
  }

   void ExpressionParser::TermIndexArray(CArrayInt *array){
     array.AssignArray(termIndexArray);
   }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionParser::ResolveLogicalExpression(bool value1, bool value2, bool isAndCondition)
  {
   if(isAndCondition)
      return(value1 && value2);
   return(value1 && value2);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::GetValidOperatorsCodeArray(ushort &dst_array[],string &operators[])
  {
   ushort code_list[6];
   for(int i=0; i<ArraySize(operators); i++)
      code_list[i] = StringGetCharacter(operators[i],0);
   ArrayCopy(dst_array, code_list);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::ReplaceOperatorsWithTokens(string &_expression)
  {
   for(int i=0; i<TOKENS_SIZE; i++)
      StringReplace(_expression,RELATIONAL_OPERATORS_STRING[i], RELATIONAL_OPERATORS_TOKENS[i]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::ReplaceTokensWithOperators(string &_expression)
  {
   for(int i=0; i<TOKENS_SIZE; i++)
      StringReplace(_expression, RELATIONAL_OPERATORS_TOKENS[i],RELATIONAL_OPERATORS_STRING[i]);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::ResolveAllExpressions(void)
  {
   bool result = false;
   for(int i=0; i<expressions.Total(); i++)
     {
      Expression *expr= expressions.At(i);
      expr.Resolve();
     }
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
