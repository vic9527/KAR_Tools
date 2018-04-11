function New_All_Actions=SetLabel(All_Actions)

 for jj=1:size(All_Actions,2)
            All_Actions(jj).Label1st=All_Actions(jj).label;
            All_Actions(jj).Label1st(All_Actions(jj).Label1st==1|All_Actions(jj).Label1st==2|All_Actions(jj).Label1st==3|All_Actions(jj).Label1st==4|All_Actions(jj).Label1st==5|All_Actions(jj).Label1st==6|All_Actions(jj).Label1st==7|All_Actions(jj).Label1st==8|All_Actions(jj).Label1st==9|All_Actions(jj).Label1st==17|All_Actions(jj).Label1st==12)=101;
            All_Actions(jj).Label1st(All_Actions(jj).Label1st==10|All_Actions(jj).Label1st==11|All_Actions(jj).Label1st==18)=102;
            All_Actions(jj).Label1st(All_Actions(jj).Label1st==14|All_Actions(jj).Label1st==15)=103;      
 end  
       %%  special case:
            All_Actions(313).Label1st=102;  
             All_Actions(314).Label1st=102;  
              All_Actions(315).Label1st=102;  
               All_Actions(322).Label1st=102;  
                All_Actions(323).Label1st=102;  
                 All_Actions(324).Label1st=102;  
                  All_Actions(328).Label1st=102;  
                   All_Actions(329).Label1st=102;  
                    All_Actions(330).Label1st=102;  
                     All_Actions(334).Label1st=102;  
                      All_Actions(335).Label1st=102;  
                       All_Actions(336).Label1st=102;  
                       
                       
      New_All_Actions=All_Actions;                 
end