module cymometer(seg7,scan,sysclk,clkin);
output[6:0]seg7;
output[7:0]scan;
input sysclk;  //50MHz时钟输入
input clkin;  //待测频率信号输入
reg[6:0]seg7; //七段显示控制信号
reg[7:0]scan; //数码管地址选择信号
reg[24:0]cnt;
reg clk_cnt;
reg clk_s;
reg[3:0] cntp1,cntp2,cntp3,cntp4,cntp5,cntp6,cntp7,cntp8;
reg[3:0] cntq1,cntq2,cntq3,cntq4,cntq5,cntq6,cntq7,cntq8;
reg[3:0]dat;
//0.5Hz分频
always @(posedge sysclk)
begin
 if(cnt==25'b1_0111_1101_0111_1000_0100_0000)
 begin clk_cnt<=~clk_cnt;cnt<=0;end
 else
  begin cnt<=cnt+1;end
end
reg[3:0] clk_ten;
//在10s内计数
always @(posedge clk_cnt)
begin
if(clk_ten=='b1001)
 begin
  clk_ten<='b0000;clk_s<=~clk_s;end
  else
  clk_ten<=clk_ten+1;
end
 //10s计数
always @(posedge clkin)
begin
 if(clk_s)
 begin
  if(cntp1=='b1001)
   begin cntp1<='b0000;cntp2<=cntp2+1;
    if(cntp2=='b1001)
     begin cntp2<='b0000;cntp3<=cntp3+1;
      if(cntp3=='b1001)
       begin cntp3<='b0000;cntp4<=cntp4+1;
	     if(cntp4=='b1001)
		   begin cntp4<='b0000;cntp5<=cntp5+1;
	       if(cntp5=='b1001)
		     begin cntp5<='b0000;cntp6<=cntp6+1;
			   if(cntp6=='b1001)
		       begin cntp6<='b0000;cntp7<=cntp7+1;
		        if(cntp7=='b1001)
			      begin cntp7<='b0000;cntp8<=cntp8+1;
		          if(cntp8=='b1001)
			        begin cntp8<='b0000;end
				   end
			    end
		     end
		   end
       end
     end
	end
  else begin cntp1<=cntp1+1;end
 end
else
 begin
 if(cntp1!='b0000|cntp2!='b0000|cntp3!='b0000|cntp4!='b0000|cntp5!='b0000|cntp6!='b0000|cntp7!='b0000|cntp8!='b0000)//对数值锁存
  begin
   cntq1<=cntp1;cntq2<=cntp2;cntq3<=cntp3;
   cntq4<=cntp4;cntq5<=cntp5;cntq6<=cntp6;
   cntq7<=cntp7;cntq8<=cntp8;
   cntp1<='b0000;cntp2<='b0000;cntp3<='b0000;
   cntp4<='b0000;cntp5<='b0000;cntp6<='b0000;
   cntp7<='b0000;cntp8<='b0000;
  end
 end
 end
//扫描数码管

 endmodule
 
	 
	




	