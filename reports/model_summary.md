# Models

_This script generates the summary tables and reports statistics for the 
models in the article._







## Model Output

`lme4::summary` of the final model:


```
## Linear mixed model fit by maximum likelihood  ['lmerMod']
## Formula: 
## elogit ~ ot1 + ot2 + ot3 + (ot1 + ot2 + ot3 | Subj) + Condition +  
##     (ot1 + ot2 + ot3 | Subj:Condition) + ot1:Condition + ot2:Condition +  
##     ot3:Condition
##    Data: looks
## Weights: 1/elogit_wt
## 
##      AIC      BIC   logLik deviance df.resid 
##    561.5    703.5   -251.8    503.5      957 
## 
## Scaled residuals: 
##    Min     1Q Median     3Q    Max 
## -2.622 -0.471  0.021  0.571  3.765 
## 
## Random effects:
##  Groups         Name        Variance Std.Dev. Corr             
##  Subj:Condition (Intercept) 0.1505   0.388                     
##                 ot1         1.9619   1.401    -0.10            
##                 ot2         0.4100   0.640    -0.08  0.33      
##                 ot3         0.2330   0.483     0.18 -0.33  0.09
##  Subj           (Intercept) 0.0894   0.299                     
##                 ot1         0.9467   0.973     0.69            
##                 ot2         0.0109   0.104     0.40 -0.38      
##                 ot3         0.0563   0.237    -0.57 -0.99  0.52
##  Residual                   0.3325   0.577                     
## Number of obs: 986, groups:  Subj:Condition, 58; Subj, 29
## 
## Fixed effects:
##                           Estimate Std. Error t value
## (Intercept)                 0.4381     0.0916    4.79
## ot1                         1.8408     0.3201    5.75
## ot2                         0.5213     0.1280    4.07
## ot3                        -0.4331     0.1081   -4.01
## Conditionfacilitating       0.2111     0.1030    2.05
## ot1:Conditionfacilitating   0.5374     0.3737    1.44
## ot2:Conditionfacilitating  -0.5034     0.1792   -2.81
## ot3:Conditionfacilitating   0.1963     0.1397    1.41
## 
## Correlation of Fixed Effects:
##             (Intr) ot1    ot2    ot3    Cndtnf ot1:Cn ot2:Cn
## ot1          0.175                                          
## ot2         -0.013  0.223                                   
## ot3         -0.021 -0.447  0.117                            
## Cndtnfclttn -0.562  0.056  0.044 -0.107                     
## ot1:Cndtnfc  0.054 -0.584 -0.219  0.188 -0.094              
## ot2:Cndtnfc  0.035 -0.183 -0.698 -0.061 -0.064  0.316       
## ot3:Cndtnfc -0.093  0.170 -0.066 -0.645  0.165 -0.291  0.099
```

![](model_summary_files/figure-html/unnamed-chunk-2-1.png) 



## Write up



The log-odds of looking to target in the neutral condition over the entire 
analysis window were estimated by the intercept term, 
_&gamma;_<sub>00</sub>&nbsp;=&nbsp;0.44 
(proportion:&nbsp;.61). The linear, quadratic, and cubic orthogonal 
time terms were all significant, confirming a curvilinear, sigmoid-shape change 
in looks to target over time.

There was a significant increase in accuracy in the facilitating condition 
[<em>&gamma;</em><sub>01</sub>&nbsp;=&nbsp;0.21; SE&nbsp;=&nbsp;0.10; _t_&nbsp;=&nbsp;2.05; _p_&nbsp;=&nbsp;.04] such that the overall proportion of looking to target 
increased by .05. There was a significant effect of condition on 
the quadratic term [<em>&gamma;</em><sub>21</sub>&nbsp;=&nbsp;&minus;0.50; SE&nbsp;=&nbsp;0.18; _t_&nbsp;=&nbsp;&minus;2.81; _p_&nbsp;=&nbsp;.005]. These effects can be 
interpreted geometrically: The larger intercept increases the overall area 
under the curve, and the reduced quadratic effect decreases the bowing on the 
center of the curve, allowing the facilitating curve to obtain its positive 
slope earlier than the neutral curve. There was not a significant effect of 
condition on the linear term [<em>&gamma;</em><sub>11</sub>&nbsp;=&nbsp;0.54; SE&nbsp;=&nbsp;0.37; _t_&nbsp;=&nbsp;1.44; _p_&nbsp;=&nbsp;.15], indicating that the 
overall slopes of the growth curves did not differ significantly. These 
condition effects result in the two curves being roughly parallel at the 
center of the analysis window but with points phase-shifted by 100 ms. 



## Tables

### Fixed effects


Table: Model fixed effects

Parameter                                                                 Estimate      SE            _t_      _p_
-------------------------------------------------------------------  -------------  ------  -------------  -------
Intercept (<em>&gamma;</em><sub>00</sub>)                                    0.438   0.092          4.785   < .001
Time (<em>&gamma;</em><sub>10</sub>)                                         1.841   0.320          5.751   < .001
Time^2^ (<em>&gamma;</em><sub>20</sub>)                                      0.521   0.128          4.074   < .001
Time^3^ (<em>&gamma;</em><sub>30</sub>)                               &minus;0.433   0.108   &minus;4.008   < .001
Facilitating Cond. (<em>&gamma;</em><sub>01</sub>)                           0.211   0.103          2.050     .040
Time &times; Facilitating Cond. (<em>&gamma;</em><sub>11</sub>)              0.537   0.374          1.438     .150
Time^2^ &times; Facilitating Cond. (<em>&gamma;</em><sub>21</sub>)    &minus;0.503   0.179   &minus;2.809     .005
Time^3^ &times; Facilitating Cond. (<em>&gamma;</em><sub>31</sub>)           0.196   0.140          1.405     .160

### Random effects


Table: Model random effects

Group                     Parameter                                        Variance      SD   Correlations       &nbsp;    &nbsp;     &nbsp;
------------------------  ----------------------------------------------  ---------  ------  -------------  -----------  --------  ---------
Child                     Intercept (<em>U</em><sub>0<em>j</em></sub>)        0.089   0.299           1.00                                  
                          Time (<em>U</em><sub>1<em>j</em></sub>)             0.947   0.973            .69         1.00                     
                          Time^2^ (<em>U</em><sub>2<em>j</em></sub>)          0.011   0.104            .40   &minus;.38      1.00           
                          Time^3^ (<em>U</em><sub>3<em>j</em></sub>)          0.056   0.237     &minus;.57   &minus;.99       .52       1.00
Child &times; Condition   Intercept (<em>W</em><sub>0<em>jk</em></sub>)       0.151   0.388           1.00                                  
                          Time (<em>W</em><sub>1<em>jk</em></sub>)            1.962   1.401     &minus;.10         1.00                     
                          Time^2^ (<em>W</em><sub>2<em>jk</em></sub>)         0.410   0.640     &minus;.08          .33      1.00           
                          Time^3^ (<em>W</em><sub>3<em>jk</em></sub>)         0.233   0.483            .18   &minus;.33       .09       1.00
Residual                  <em>R</em><sub><em>tjk</em></sub>                   0.332   0.577                                                 



## Model Comparisons

The effects are age and vocabulary are tested by using nested model comparisons 
via the `anova` function. 


### Age Models


Table: Age models

          Df     AIC     BIC   logLik   deviance   Chisq   Chi Df   Pr(>Chisq)
-------  ---  ------  ------  -------  ---------  ------  -------  -----------
MODEL1    29   561.5   703.5   -251.8      503.6      NA       NA           NA
MODEL2    30   560.9   707.7   -250.4      500.9    2.64        1         0.10
MODEL3    31   562.8   714.5   -250.4      500.8    0.14        1         0.71
MODEL4    32   564.7   721.3   -250.4      500.7    0.03        1         0.87
MODEL5    33   566.5   727.9   -250.2      500.4    0.29        1         0.59


Table: Age x Condition models

          Df     AIC     BIC   logLik   deviance   Chisq   Chi Df   Pr(>Chisq)
-------  ---  ------  ------  -------  ---------  ------  -------  -----------
MODEL1    29   561.5   703.5   -251.8      503.6      NA       NA           NA
MODEL2    31   562.8   714.5   -250.4      500.8    2.70        2         0.26
MODEL3    33   566.3   727.8   -250.2      500.3    0.54        2         0.76
MODEL4    35   567.0   738.3   -248.5      497.0    3.28        2         0.19
MODEL5    37   570.7   751.7   -248.3      496.7    0.36        2         0.83


### Vocabulary models


Table: Vocabulary models

          Df     AIC     BIC   logLik   deviance   Chisq   Chi Df   Pr(>Chisq)
-------  ---  ------  ------  -------  ---------  ------  -------  -----------
MODEL1    29   561.5   703.5   -251.8      503.6      NA       NA           NA
MODEL2    30   560.7   707.5   -250.3      500.7    2.86        1         0.09
MODEL3    31   562.4   714.1   -250.2      500.4    0.32        1         0.57
MODEL4    32   564.2   720.8   -250.1      500.2    0.13        1         0.72
MODEL5    33   566.2   727.7   -250.1      500.2    0.00        1         0.96


Table: Vocabulary x Condition models

          Df     AIC     BIC   logLik   deviance   Chisq   Chi Df   Pr(>Chisq)
-------  ---  ------  ------  -------  ---------  ------  -------  -----------
MODEL1    29   561.5   703.5   -251.8      503.6      NA       NA           NA
MODEL2    31   562.5   714.2   -250.2      500.5    3.05        2         0.22
MODEL3    33   564.4   725.9   -249.2      498.4    2.09        2         0.35
MODEL4    35   568.3   739.6   -249.1      498.3    0.12        2         0.94
MODEL5    37   572.3   753.3   -249.1      498.3    0.01        2         1.00


### Write up for article

Participant-level variables were tested by comparing nested models. There was
no effect of vocabulary size on the intercept 
(_&chi;_^2^(1)&nbsp;=&nbsp;2.9, _p_&nbsp;=&nbsp;.091), nor did vocabulary size interact 
with the condition effect (_&chi;_^2^(2)&nbsp;=&nbsp;3.1, _p_&nbsp;=&nbsp;.217). 
There was also no effect of age on the intercept term 
(_&chi;_^2^(1)&nbsp;=&nbsp;2.6, _p_&nbsp;=&nbsp;.104), nor did age interact with 
condition (_&chi;_^2^(2)&nbsp;=&nbsp;2.7, _p_&nbsp;=&nbsp;.259). Model fit did not 
significantly improve when vocabulary size or age were allowed to interact with 
Time or Time-by-Condition parameters.
