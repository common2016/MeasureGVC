
<!-- README.md is generated from README.Rmd. Please edit that file -->

# 计算内循环

## 1. 安装

``` r
devtools::install_github('common2016/MeasureGVC')
```

## 2. 使用

-   内循环计算，

``` r
library(MeasureGVC)
library(decompr)
data(leather)
# create intermediate object (class decompr)
decompr_object <- load_tables_vectors(leather)
partici_idx(decompr_object, 'inner')
#>        cnts            industry  up_inner  dw_inner
#> 1 Argentina         Agriculture 0.4038616 0.5305546
#> 2 Argentina Textile_and_Leather 0.3903601 0.5284692
#> 3 Argentina Transport_Equipment 0.7705770 0.6034136
#> 4    Turkey         Agriculture 0.3963190 0.4703428
#> 5    Turkey Textile_and_Leather 0.3233576 0.3881702
#> 6    Turkey Transport_Equipment 0.6168995 0.4924149
#> 7   Germany         Agriculture 0.5511430 0.5474953
#> 8   Germany Textile_and_Leather 0.5349052 0.5513404
#> 9   Germany Transport_Equipment 0.4765277 0.3367365
```

-   下游行业GVC参与度计算（前向链接），

``` r
partici_idx(decompr_object, 'forward')
#>        cnts            industry        up
#> 1 Argentina         Agriculture 0.3445419
#> 2 Argentina Textile_and_Leather 0.4516613
#> 3 Argentina Transport_Equipment 0.1223946
#> 4    Turkey         Agriculture 0.3170871
#> 5    Turkey Textile_and_Leather 0.3754873
#> 6    Turkey Transport_Equipment 0.1429043
#> 7   Germany         Agriculture 0.1343714
#> 8   Germany Textile_and_Leather 0.1688435
#> 9   Germany Transport_Equipment 0.1236333
```

-   上游行业GVC参与度计算（后向链接）,

``` r
partici_idx(decompr_object, 'backward')
#>        cnts            industry        dw
#> 1 Argentina         Agriculture 0.1116295
#> 2 Argentina Textile_and_Leather 0.2431799
#> 3 Argentina Transport_Equipment 0.3252739
#> 4    Turkey         Agriculture 0.1836763
#> 5    Turkey Textile_and_Leather 0.2096294
#> 6    Turkey Transport_Equipment 0.3452213
#> 7   Germany         Agriculture 0.1627172
#> 8   Germany Textile_and_Leather 0.1908901
#> 9   Germany Transport_Equipment 0.3664037
```

## 3. 参考文献

-   
-   Wang, Z., Shang-Jin Wei, Xinding Yu, Kunfu Zhu, Measures of
    Participation in Glabal Value Chains and Global Business Cycles.
    2017, NBER. Number:23222.
