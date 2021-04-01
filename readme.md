## 计算Wang et al. (2017) 的GVC参与度



Wang et al. (2017)利用世界投入产出表，如WIOT，计算了国家行业层面参与全球价值链的程度。本包的`partici_idx`函数对该算法进行了实现。

### 安装

```R
devtools::install_github('common2016/MeasureGVC')
```

### 使用

下游行业GVC参与度计算，

```R
library(decompr)
data(leather)
# create intermediate object (class decompr)
decompr_object <- load_tables_vectors(inter,
                                      final,
                                      countries,
                                      industries,
                                      out)
partici_idx(decompr_object, 'forward')
```

上游行业GVC参与度计算,

```R
partici_idx(decompr_object, 'backward')
```

### 参考文献

Wang, Z., et al., MEASURES OF PARTICIPATION IN GLOBAL VALUE CHAINS AND GLOBAL BUSINESS CYCLES. 2017, NBER.

