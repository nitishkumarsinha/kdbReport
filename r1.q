formatTabForBodyMail:{[tab;rDict]

    / This function can be written in better way, will fix in next version
    comma:{if[not type[x]=10h;x:string[x]]; n:"." vs x; if[(cnt:count n[0]) < 3;:`$x]; i:cnt-til[cnt]; n[0]:"," sv (0j,til[cnt] where (i mod 3)=0) cut n[0]; if[n[0] like ",*";n[0]:1_n[0]]; `$"." sv n};

    fcols:exec c from (meta tab) where t in "fij";
    ccols:exec c from (meta tab) where t in "cC";
    dcols:fcols except where rDict = 0j;

    dataDict:flip tab;
    dataDict[ccols]:`$''dataDict[ccols];
    dataDict[dcols]:{.Q.f[(2^y[z]);]each x[z]}[dataDict;rDict;]each dcols;
    dataDict[fcols]:{x each y}[comma;] each dataDict[fcols];
    flip dataDict
    };

/ Test Cases
testTab:([]sym:10?`3;time:.z.p + til 10;usdVolume:10?40000f;rate:10?25f;cnt:10?30000;name:string 10?`7;side:10#"B");

/ CASE 1: With default precisions
formatTabForBodyMail[testTab;(enlist`)!(enlist 0Nj)]

/ CASE 2: With configured precisions
formatTabForBodyMail[testTab;(`usdVolume`rate`cnt)!(2j;3j;0j)]
