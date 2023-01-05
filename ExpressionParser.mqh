//+------------------------------------------------------------------+
//|                                             ExpressionParser.mqh |
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+
//--- input parameters
/*
   Supported functions: abs, arccos, arcsin, arctan, ceil, cos, exp, floor, log, log10, max, min, mod, pow, rand, round, sin, sqrt, tan
   Operations: /, %, *, +, -, >, <, >=, <=, ==, !=, &&, ||
*/
//+------------------------------------------------------------------+
//| ExpressionParserBase class                                       |
//+------------------------------------------------------------------+

#include "Indicators/Caller.mqh"

//+------------------------------------------------------------------+
//| Adapted from https://www.mql5.com/en/code/303                    |
//+------------------------------------------------------------------+
class ExpressionParserBase
  {
protected:
   string            UserVariables;
   string            UserArrays;
   void              UsersVariables()
     {
      UserVariables="a;b;c;d"; // list of variables used
      UserArrays="e;f";        // list of arrays used
     }
   string            UserFunc(string FuncName)
     {
      Alert("The function for "+FuncName+" variable is not defined");
      return("0");
     }
   //===
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ExpressionParser: public ExpressionParserBase
  {
protected:
   string            aExpression, e, a[], b[], c[], all[], r[], uv[],fn[],  an[],  av[],un[],  uan[],  t[];
   int               uri[], uvi[],   ai[],   uari[],  uavi[];
   Caller            *caller;
   CArrayObj         indicators;

   void              Prepare();
   void              AddArrays(string  &aAr1[],string  &aAr2[]);
   void              SortByLen(string  &aAr[]);
   void              SplitExprToArray(string aExp,string  &aSplitBy[],string  &aAr[]);
   void              RemUnUsed(string  &aAr[],string  &aEAr[]);
   void              CreateReplaceLists(string  &aExp[],string  &aNames[],int  &aInExpIndex[],int  &aInNamesIndex[]);
   void              CreateElementsList(string  &aExp[],string  &aUserArrays[],string  &aFull[],string  &aName[],int  &aIndex[],string  &aValues[]);
   void              SolveArguments(string  &aExp[],int aFrom,int aTo,string  &aRes[]);

   string            SolveSimple(string  &aExp[],int aFrom,int aTo);
   string            UserArray(int nameIndex,int callIndex);

   int               SolveFunc(string Func,string  &aRes[]);
   void              ReplaceVarsToValues(string  &aExp[],string  &aValues[],int  &aExpIndexes[],int  &aValIndexes[]);
   void              FillUserVariables(string  &aNames[],string  &aValues[]);
   void              FillUserArraysElements(string  &aFullNames[],string  &aNames[],int  &aIndexes[],string  &aValues[]);

   bool              ExistInArray(string aVal,string  &aAr[]);
   void              AddIfNotExist(string aVal,string  &aAr[]);
   void              AddToArrayS(string aVal,string  &aAr[]);
   void              AddToArrayI(int aVal,int  &aAr[]);
public:
                     ExpressionParser(string aExpression, Caller *_caller);
   bool              Init();
   double            SolveExpression();
  };


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ExpressionParser::ExpressionParser(string expression,Caller *_caller)
   : aExpression(expression),caller(_caller)
  {
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ExpressionParser::UserArray(int nameIndex,int callIndex)
  {
   CallableIndicator *indicator = indicators.At(nameIndex);
   return DoubleToString(indicator.GetData(callIndex));
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::Prepare()
  {
// Conversion of string with experession into the array with verification of functions
   StringTrimLeft(e);
   StringTrimRight(e);
   if(e=="")
     {
      e="0";
     }
// 1. Prepare array
   AddArrays(all,a);
   AddArrays(all,b);
   AddArrays(all,c);
// 2. Sort array by length (decreasing order)
   SortByLen(all);
// 3. Convert expression string to lower case
   StringToLower(e);
// 4. Delete all spaces
   StringReplace(e, " ", "");
// 5. Split expression to array
   SplitExprToArray(e,all,r);
// 6. Remove unused functions
   RemUnUsed(a,r);
// 7. Remove unused variables
   RemUnUsed(un,r);
   ArrayResize(uv,ArraySize(un));
// 8. Create lists for replace of the user's variables
   CreateReplaceLists(r,un,uri,uvi);
// 9. Create lists for arrays
   CreateElementsList(r,uan,fn,an,ai,av);
   ArrayResize(av,ArraySize(fn));
// 10. create replace lists for arrays (correspondence: index in the expression array - index in the element list)
   CreateReplaceLists(r,fn,uari,uavi);
// 11. prepare array
   ArrayResize(t,ArraySize(r));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionParser::Init()
  {
   ArrayResize(a,0);
   ArrayResize(b,0);
   ArrayResize(c,0);
   ArrayResize(all,0);
   ArrayResize(r,0);

   ArrayResize(uv,0);
   ArrayResize(uri,0);
   ArrayResize(uvi,0);
   ArrayResize(fn,0);
   ArrayResize(an,0);
   ArrayResize(ai,0);
   ArrayResize(av,0);
   ArrayResize(uari,0);
   ArrayResize(uavi,0);
   ArrayResize(un,0);
   ArrayResize(uan,0);
   ArrayResize(t,0);
   UserVariables="";
   UserArrays="";
   e="";

   e=aExpression;
   UsersVariables();
   StringSplit(UserVariables,';',un);

   caller.CopyKeys(uan);

   string as="abs;arccos;arcsin;arctan;ceil;cos;exp;floor;log;log10;max;min;mod;pow;rand;round;sin;sqrt;tan";
   string bs="/;%;*;+;-;>;<;>=;<=;==;!=;&&;||";
   string cs=",;(;)";
   StringSplit(as,';',a);
   StringSplit(bs,';',b);
   StringSplit(cs,';',c);
   Prepare();

   if(!caller)
      return false;

   for(int i=0; i<ArraySize(an); i++)
     {
      CallableIndicator *indicator;
      if(!caller.TryGetValue(an[i],indicator))
         return false;
      if(caller.AddCalledIndicator(an[i]) && indicators.Add(indicator))
         continue;

      return false;
     }

   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ExpressionParser::SolveFunc(string Func,string &aRes[])
  {
   if(Func=="abs")
     {
      aRes[0]=DoubleToString(MathAbs(StringToDouble(aRes[0])));
      return(1);
     }
   if(Func=="arccos")
     {
      aRes[0]=DoubleToString(MathArccos(StringToDouble(aRes[0])));
      return(1);
     }
   if(Func=="arcsin")
     {
      aRes[0]=DoubleToString(MathArcsin(StringToDouble(aRes[0])));
      return(1);
     }
   if(Func=="arctan")
     {
      aRes[0]=DoubleToString(MathArctan(StringToDouble(aRes[0])));
      return(1);
     }
   if(Func=="ceil")
     {
      aRes[0]=DoubleToString(MathCeil(StringToDouble(aRes[0])));
      return(1);
     }
   if(Func=="cos")
     {
      aRes[0]=DoubleToString(MathCos(StringToDouble(aRes[0])));
      return(1);
     }
   if(Func=="exp")
     {
      aRes[0]=DoubleToString(MathExp(StringToDouble(aRes[0])));
      return(1);
     }
   if(Func=="floor")
     {
      aRes[0]=DoubleToString(MathFloor(StringToDouble(aRes[0])));
      return(1);
     }
   if(Func=="log")
     {
      aRes[0]=DoubleToString(MathLog(StringToDouble(aRes[0])));
      return(1);
     }
   if(Func=="log10")
     {
      aRes[0]=DoubleToString(MathLog10(StringToDouble(aRes[0])));
      return(1);
     }
   if(Func=="max")
     {
      aRes[0]=DoubleToString(MathMax(StringToDouble(aRes[0]),StringToDouble(aRes[1])));
      return(1);
     }
   if(Func=="min")
     {
      aRes[0]=DoubleToString(MathMin(StringToDouble(aRes[0]),StringToDouble(aRes[1])));
      return(1);
     }
   if(Func=="mod")
     {
      aRes[0]=DoubleToString(MathMod(StringToInteger(aRes[0]),StringToInteger(aRes[1])));
      return(1);
     }
   if(Func=="pow")
     {
      aRes[0]=DoubleToString(MathPow(StringToDouble(aRes[0]),StringToDouble(aRes[1])));
      return(1);
     }
   if(Func=="rand")
     {
      aRes[0]=DoubleToString(MathRand());
      return(1);
     }
   if(Func=="round")
     {
      aRes[0]=DoubleToString(MathRound(StringToDouble(aRes[0])));
      return(1);
     }
   if(Func=="sin")
     {
      aRes[0]=DoubleToString(MathSin(StringToDouble(aRes[0])));
      return(1);
     }
   if(Func=="sqrt")
     {
      aRes[0]=DoubleToString(MathSqrt(StringToDouble(aRes[0])));
      return(1);
     }
   if(Func=="tan")
     {
      aRes[0]=DoubleToString(MathTan(StringToDouble(aRes[0])));
      return(1);
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::ReplaceVarsToValues(string &aExp[],string &aValues[],int &aExpIndexes[],int &aValIndexes[])
  {
   for(int i=0; i<ArraySize(aExpIndexes); i++)
      aExp[aExpIndexes[i]]=aValues[aValIndexes[i]];
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ExpressionParser::SolveExpression()
  {
   ArrayCopy(t,r);

// expression solver!!!
// 1. fill array with user variables with its current values
   FillUserVariables(un,uv);
// 2. fill user array elements with its current values
   FillUserArraysElements(fn,an,ai,av);
// 3. replace user variables to values
   ReplaceVarsToValues(r,uv,uri,uvi);
// 4. replace user array elements to values
   ReplaceVarsToValues(r,av,uari,uavi);

// 1. Find internal expression
   string Result="";
   string Res[];
   bool solved=true;
   int cnt=ArraySize(t);
   int cn=0;
   while(solved)
     {
      cn++;
      solved=false;
      int lb=-1;
      for(int i=0; i<cnt; i++)
        {
         if(r[i]=="(")
            lb=i;
         if(r[i]==")")
           {
            if(lb!=-1)
              {
               SolveArguments(r,lb+1,i-1,Res); // expressions separated by commas
               int func=0;
               if(lb>0)
                 {
                  func=SolveFunc(r[lb-1],Res);
                 }
               r[lb-func]=Res[0];
               ArrayCopy(r,r,lb+1-func,i+1,cnt-i-1);
               cnt=cnt-(i+1-(lb+1-func));
               solved=true;
              }
            lb=-1;
           }
        }
     }

// Result
   return StringToDouble(SolveSimple(r,0,cnt-1));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::SolveArguments(string &aExp[],int aFrom,int aTo,string &aRes[])
  {
   ArrayResize(aRes,0);
   string ex[];
   int cnt=aTo-aFrom+1;
   ArrayResize(ex,cnt);
   ArrayCopy(ex,aExp,0,aFrom,cnt);
   int strt=0;
   int i;
   for(i=0; i<ArraySize(ex); i++)
      if(ex[i]==",")
        {
         ArrayResize(aRes,ArraySize(aRes)+1);
         aRes[ArraySize(aRes)-1]=SolveSimple(ex,strt,i-1);
         strt=i+1;
        }

   ArrayResize(aRes,ArraySize(aRes)+1);
   aRes[ArraySize(aRes)-1]=SolveSimple(ex,strt,i-1);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ExpressionParser::SolveSimple(string &aExp[],int aFrom,int aTo)
  {
   string ex[];
   int cnt=aTo-aFrom+1;
   ArrayResize(ex,cnt);
   ArrayCopy(ex,aExp,0,aFrom,cnt);
   int i,j;
   bool exist;
// %
   exist=true;
   while(exist)
     {
      exist=false;
      for(i=0; i<cnt; i++)
        {
         if(ex[i]=="%")
           {
            ex[i-1]=IntegerToString(StringToInteger(ex[i-1])%StringToInteger(ex[i+1]));
            for(j=i; j<cnt-2; j++)
              {
               ex[j]=ex[j+2];
              }
            cnt--;
            cnt--;
            exist=true;
            break;
           }
        }
     }
//===
// /
   exist=true;
   while(exist)
     {
      exist=false;
      for(i=0; i<cnt; i++)
        {
         if(ex[i]=="/")
           {
            if(StringToDouble(ex[i+1])!=0)
              {
               ex[i-1]=DoubleToString(StringToDouble(ex[i-1])/StringToDouble(ex[i+1]));
              }
            else
              {
               ex[i-1]=DoubleToString(StringToDouble(ex[i-1])/0.00000001);
              }
            for(j=i; j<cnt-2; j++)
              {
               ex[j]=ex[j+2];
              }
            cnt--;
            cnt--;
            exist=true;
            break;
           }
        }
     }
// *
   exist=true;
   while(exist)
     {
      exist=false;
      for(i=0; i<cnt; i++)
        {
         if(ex[i]=="*")
           {
            ex[i-1]=DoubleToString(StringToDouble(ex[i-1])*StringToDouble(ex[i+1]));
            for(j=i; j<cnt-2; j++)
              {
               ex[j]=ex[j+2];
              }
            cnt--;
            cnt--;
            exist=true;
            break;
           }
        }
     }
// +-
   exist=true;
   while(exist)
     {
      exist=false;
      for(i=0; i<cnt; i++)
        {
         if(ex[i]=="+")
           {
            ex[i-1]=DoubleToString(StringToDouble(ex[i-1])+StringToDouble(ex[i+1]));
            for(j=i; j<cnt-2; j++)
              {
               ex[j]=ex[j+2];
              }
            cnt--;
            cnt--;
            exist=true;
            break;
           }
         if(ex[i]=="-")
           {
            ex[i-1]=DoubleToString(StringToDouble(ex[i-1])-StringToDouble(ex[i+1]));
            for(j=i; j<cnt-2; j++)
              {
               ex[j]=ex[j+2];
              }
            cnt--;
            cnt--;
            exist=true;
            break;
           }
        }
     }
//===
// >
   exist=true;
   while(exist)
     {
      exist=false;
      for(i=0; i<cnt; i++)
        {
         if(ex[i]==">")
           {
            ex[i-1]=DoubleToString(StringToDouble(ex[i-1])>StringToDouble(ex[i+1]));
            for(j=i; j<cnt-2; j++)
              {
               ex[j]=ex[j+2];
              }
            cnt--;
            cnt--;
            exist=true;
            break;
           }
        }
     }
// <
   exist=true;
   while(exist)
     {
      exist=false;
      for(i=0; i<cnt; i++)
        {
         if(ex[i]=="<")
           {
            ex[i-1]=DoubleToString(StringToDouble(ex[i-1])<StringToDouble(ex[i+1]));
            for(j=i; j<cnt-2; j++)
              {
               ex[j]=ex[j+2];
              }
            cnt--;
            cnt--;
            exist=true;
            break;
           }
        }
     }
// >=
   exist=true;
   while(exist)
     {
      exist=false;
      for(i=0; i<cnt; i++)
        {
         if(ex[i]==">=")
           {
            ex[i-1]=DoubleToString(StringToDouble(ex[i-1])>=StringToDouble(ex[i+1]));
            for(j=i; j<cnt-2; j++)
              {
               ex[j]=ex[j+2];
              }
            cnt--;
            cnt--;
            exist=true;
            break;
           }
        }
     }
// <=
   exist=true;
   while(exist)
     {
      exist=false;
      for(i=0; i<cnt; i++)
        {
         if(ex[i]=="<=")
           {
            ex[i-1]=DoubleToString(StringToDouble(ex[i-1])<=StringToDouble(ex[i+1]));
            for(j=i; j<cnt-2; j++)
              {
               ex[j]=ex[j+2];
              }
            cnt--;
            cnt--;
            exist=true;
            break;
           }
        }
     }
// ==
   exist=true;
   while(exist)
     {
      exist=false;
      for(i=0; i<cnt; i++)
        {
         if(ex[i]=="==")
           {
            ex[i-1]=DoubleToString(StringToDouble(ex[i-1])==StringToDouble(ex[i+1]));
            for(j=i; j<cnt-2; j++)
              {
               ex[j]=ex[j+2];
              }
            cnt--;
            cnt--;
            exist=true;
            break;
           }
        }
     }
// ==
   exist=true;
   while(exist)
     {
      exist=false;
      for(i=0; i<cnt; i++)
        {
         if(ex[i]=="!=")
           {
            ex[i-1]=DoubleToString(StringToDouble(ex[i-1])!=StringToDouble(ex[i+1]));
            for(j=i; j<cnt-2; j++)
              {
               ex[j]=ex[j+2];
              }
            cnt--;
            cnt--;
            exist=true;
            break;
           }
        }
     }
//===
// ||
   exist=true;
   while(exist)
     {
      exist=false;
      for(i=0; i<cnt; i++)
        {
         if(ex[i]=="||")
           {
            ex[i-1]=DoubleToString(StringToDouble(ex[i-1]) || StringToDouble(ex[i+1]));
            for(j=i; j<cnt-2; j++)
              {
               ex[j]=ex[j+2];
              }
            cnt--;
            cnt--;
            exist=true;
            break;
           }
        }
     }
// &&
   exist=true;
   while(exist)
     {
      exist=false;
      for(i=0; i<cnt; i++)
        {
         if(ex[i]=="&&")
           {
            ex[i-1]=DoubleToString(StringToDouble(ex[i-1]) && StringToDouble(ex[i+1]));
            for(j=i; j<cnt-2; j++)
              {
               ex[j]=ex[j+2];
              }
            cnt--;
            cnt--;
            exist=true;
            break;
           }
        }
     }
   return(ex[0]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::AddArrays(string &aAr1[],string &aAr2[])
  {
   int from=ArraySize(aAr1);
   int cnt=ArraySize(aAr2);
   ArrayResize(aAr1,from+cnt);
   ArrayCopy(aAr1,aAr2,from,0,cnt);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::SortByLen(string &aAr[])
  {
   for(int i=ArraySize(aAr)-1; i>0; i--)
      for(int j=0; j<i; j++)
         if(StringLen(aAr[j])<StringLen(aAr[j+1]))
           {
            string tmp=aAr[j];
            aAr[j]=aAr[j+1];
            aAr[j+1]=tmp;
           }
  }
//+------------------------------------------------------------------+
void ExpressionParser::SplitExprToArray(string aExp,string &aSplitBy[],string &aAr[])
  {
   string t_str=aExp;
   string p="";
   ArrayResize(aAr,0);
   while(t_str!="")
     {
      bool exist=false;
      for(int j=0; j<ArraySize(aSplitBy); j++)
        {
         if(StringSubstr(t_str,0,StringLen(aSplitBy[j]))==aSplitBy[j])
           {
            if(p!="")
              {
               ArrayResize(aAr,ArraySize(aAr)+1);
               aAr[ArraySize(aAr)-1]=p;
              }
            ArrayResize(aAr,ArraySize(aAr)+1);
            aAr[ArraySize(aAr)-1]=aSplitBy[j];
            p="";
            t_str=StringSubstr(t_str,StringLen(aSplitBy[j]),StringLen(t_str)-StringLen(aSplitBy[j]));
            exist=true;
            break;
           }
        }
      if(!exist)
        {
         p=p+StringSubstr(t_str,0,1);
         t_str=StringSubstr(t_str,1,StringLen(t_str)-1);
        }
     }
   if(p!="")
     {
      ArrayResize(aAr,ArraySize(aAr)+1);
      aAr[ArraySize(aAr)-1]=p;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::RemUnUsed(string &aAr[],string &aEAr[])
  {
   string tAr[];
   ArrayResize(tAr,0);
   for(int i=0; i<ArraySize(aAr); i++)
      if(ExistInArray(aAr[i],aEAr))
         AddIfNotExist(aAr[i],tAr);

   ArrayResize(aAr,ArraySize(tAr));
   if(ArraySize(tAr)!=0)
      ArrayCopy(aAr,tAr);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::CreateReplaceLists(string &aExp[],string &aNames[],int &aInExpIndex[],int &aInNamesIndex[])
  {
   ArrayResize(aInExpIndex,0);
   ArrayResize(aInNamesIndex,0);
   for(int i=0; i<ArraySize(aExp); i++)
      for(int j=0; j<ArraySize(aNames); j++)
         if(aExp[i]==aNames[j])
           {
            AddToArrayI(i,aInExpIndex);
            AddToArrayI(j,aInNamesIndex);
           }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::CreateElementsList(string &aExp[],string &aUserArrays[],string &aFull[],string &aName[],int &aIndex[],string &aValues[])
  {
   ArrayResize(aFull,0);
   ArrayResize(aName,0);
   ArrayResize(aIndex,0);
   for(int i=0; i<ArraySize(aUserArrays); i++)
     {
      string search=aUserArrays[i]+"[";
      int slen=StringLen(search);
      for(int j=0; j<ArraySize(aExp); j++)
        {
         if(StringSubstr(aExp[j],0,slen)==search)
           {
            int Index=(int)StringToInteger(StringSubstr(r[j],slen,StringLen(r[j])-slen-1));
            if(!ExistInArray(aExp[j],aFull))
              {
               AddToArrayS(aExp[j],aFull);
               AddToArrayS(uan[i],aName);
               AddToArrayI(Index,aIndex);
              }
           }
        }
     }
   ArrayResize(aValues,ArraySize(aFull));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::FillUserVariables(string &aNames[],string &aValues[])
  {
   for(int i=0; i<ArraySize(aNames); i++)
      aValues[i]=UserFunc(aNames[i]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::FillUserArraysElements(string &aFullNames[],string &aNames[],int &aIndexes[],string &aValues[])
  {
   for(int i=0; i<ArraySize(aFullNames); i++)
      aValues[i]=UserArray(i,aIndexes[i]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExpressionParser::ExistInArray(string aVal,string &aAr[])
  {
   for(int i=0; i<ArraySize(aAr); i++)
      if(aVal==aAr[i])
         return(true);
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::AddIfNotExist(string aVal,string &aAr[])
  {
   if(!ExistInArray(aVal,aAr))
     {
      ArrayResize(aAr,ArraySize(aAr)+1);
      aAr[ArraySize(aAr)-1]=aVal;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::AddToArrayS(string aVal,string &aAr[])
  {
   ArrayResize(aAr,ArraySize(aAr)+1);
   aAr[ArraySize(aAr)-1]=aVal;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExpressionParser::AddToArrayI(int aVal,int &aAr[])
  {
   ArrayResize(aAr,ArraySize(aAr)+1);
   aAr[ArraySize(aAr)-1]=aVal;
  }
//+------------------------------------------------------------------+
