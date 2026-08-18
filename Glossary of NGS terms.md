# **NGS 术语表（Glossary of NGS terms）**
## ——生物信息新手的必备常识

> 全文转载自 [deepTools 文档](https://deeptools.readthedocs.io/en/latest/index.html) 中的 *Glossary of NGS terms*。

### 目录

+ [缩写（Abbreviations）](#abbreviations)
+ [NGS 与通用术语（NGS and generic terminology）](#ngs)
  - [bin（区间）](#bin)
  - [Input（对照输入样本）](#input)
  - [read（读段）](#read)
+ [文件格式（File Formats）](#file)
  - [2bit](#2bit)
  - [BAM](#bam)
  - [BED](#bed)
  - [bedGraph](#bedgraph)
  - [bigWig](#bigwig)
  - [FASTA](#fasta)
  - [FASTQ](#fastq)
  - [SAM](#sam)
    - [SAM 头部区域（header section）](#samhs)
    - [SAM 比对区域（alignment section）](#samas)

### 缩写（Abbreviations）<span id="abbreviations"></span>

参考基因组（reference genome）通常以其缩写（abbreviation）来指代，例如：

  + hg19 = 人类基因组（human genome），第 19 版
  + mm9 = 小家鼠（Mus musculus）基因组，第 9 版
  + dm3 = 黑腹果蝇（Drosophila melanogaster）基因组，第 3 版
  + ce10 = 秀丽隐杆线虫（Caenorhabditis elegans）基因组，第 10 版
  
如需更完整的可用参考基因组及其缩写列表，请参见 [UCSC 数据库](https://hgdownload.soe.ucsc.edu/downloads.html#others)。
| 缩写（Acronym） | 全称（Full Phrase） | 同义词 / 解释（Synonyms/Explanation） |
| :--- | :--- | :--- |
| `<ANYTHING>-seq` | -sequencing | 表示该实验是通过 NGS 进行 DNA 测序（sequencing）完成的 |
| `ChIP-seq` | chromatin immunoprecipitation sequencing | 染色质免疫沉淀测序；用于检测转录因子（transcription factor）结合位点和组蛋白修饰（histone modification）的 NGS 技术（更多信息见 Input 条目） |
| `DNase` | deoxyribonuclease I | 脱氧核糖核酸酶 I；DNase I 消化实验用于鉴定活性（“开放”）染色质区域 |
| `HTS` | high-throughput sequencing | 高通量测序；即下一代测序、大规模平行短读段测序（massive parallel short read sequencing）、深度测序（deep sequencing） |
| `MNase` | micrococcal nuclease | 微球菌核酸酶；MNase 消化实验用于鉴定核小体（nucleosome）所在位置 |
| `NGS` | next-generation sequencing | 下一代测序；即高通量（DNA）测序、大规模平行短读段测序、深度测序 |
| `RPGC` | reads per genomic content | 每基因组含量读段数；将读段归一化至 1× 测序深度，测序深度定义为：（比对读段数 × 片段长度）/ 有效基因组大小 |
| `RPKM` | reads per kilobase per million reads | 每百万读段中每千碱基的读段数；读段数归一化方式：RPKM（每个 bin）= 每个 bin 的读段数 /（比对读段数（百万）× bin 长度（kb）） |

关于常见 *-seq 应用的综述，请参见 Zentner and Henikoff。

### NGS 与通用术语（NGS and generic terminology）<span id="ngs"></span>

以下是一些对部分读者来说可能较为陌生的术语：

 - #### bin（区间）<span id="bin"></span>

同义词：window（窗口）、region（区域）

“bin”是较大分组的一个子集。许多计算都是先将基因组划分为若干小区域（bin），再在这些区域上实际进行计算。

 - #### Input（对照输入样本）<span id="input"></span>

ChIP-seq 实验通常需要设置的对照实验（control experiment）。

ChIP-seq 依赖抗体（antibody）来富集与特定蛋白结合的 DNA 片段；而 Input 样本除不使用抗体外，处理方式应与实验组完全相同。这样便可以校正由样本处理过程以及细胞整体染色质结构（chromatin structure）引入的偏差（bias）。

 - #### read（读段）<span id="read"></span>

同义词：tag（标签）

该术语指被测序仪测序（“读取”）的那段 DNA。我们尽量区分“read”与“DNA 片段（fragment）”：放入测序仪的片段长度通常在 200–1000 个碱基之间，而通常只有其中的前 50–300 个碱基会被测序。deepTools 中的大多数工具不仅会使用这些 read，还会将其延伸以匹配原始 DNA 片段的长度。（原始长度既可以由你自己提供；如果使用双端测序（paired-end sequencing），也可以根据两条配对 read 之间的距离计算得出。）

### 文件格式（File Formats）<span id="file"></span>

下一代测序（NGS）获得的数据必须经过多轮处理。大多数处理步骤旨在仅提取特定下游分析所需的信息，冗余条目往往会被丢弃。因此，特定的数据格式通常与数据处理流程（pipeline）中的不同步骤相对应。

这里我们只想对各类文件给出非常简要的关键描述；如需更详尽的信息，我们会链接到外部网站。请注意，此处的文件名按字母顺序排列，而不是按照下图所示分析流程中的使用顺序排列：

<img width="870" height="669.33" alt="image" src="https://github.com/user-attachments/assets/ad5a2fce-610f-488a-9785-6e23eb494c44" />

如需了解图中提到的不同工具集合的更多信息，请点击对应链接：

 - #### 2bit（压缩二进制序列格式）<span id="2bit"></span>

通常以 FASTA 存储的基因组序列的压缩二进制（binary）版本。

大多数 2bit 格式的基因组都可以在 UCSC 上找到。

可使用 UCSC 的程序 faToTwoBit 将 FASTA 文件转换为 2bit 格式，该程序在 UCSC 上提供适用于不同平台的版本。

更多信息见此处。

 - #### BAM（二进制比对格式）<span id="bam"></span>

常见文件扩展名：.bam

二进制（binary）文件格式（与 SAM 互补）。

包含测序读段（read）比对（alignment）到参考基因组之后的信息（通常情况）。

每行 = 1 条比对上的读段（mapped read），包含以下信息：

+ 其比对质量（mapping quality，即所报告的比对位置正确的可能性）
+ 其测序质量（sequencing quality，即每个碱基被正确识别的概率）
+ 其序列（sequence）
+ 其在基因组中的位置
+ 等等

强烈推荐用于存储数据的格式。

若要使 BAM 文件可读，可使用程序 samtools view 进行查看。

更多信息参见下文对 SAM 文件的定义。

 - #### BED（区间注释格式）<span id="bed"></span>

常见文件扩展名：.bed

文本（text）文件。

用于表示基因组区间（interval），如基因（gene）、峰区域（peak region）等。

格式规范见 UCSC。

对 deepTools 而言，前三列最为重要：染色体（chromosome）、区域起始位置、区域终止位置。

请勿将其与 bedGraph 格式混淆（尽管二者相关）。

小鼠基因 BED 文件示例行（注意：遵循 UCSC 对 BED 文件的约定，起始位置为 0-based，终止位置为 1-based）：

```
chr1    3204562 3661579 NM_001011874 Xkr4   -
chr1    4481008 4486494 NM_011441    Sox17  -
chr1    4763278 4775807 NM_001177658 Mrpl15 -
chr1    4797973 4836816 NM_008866    Lypla1 +
```

 - #### bedGraph（区间分值格式）<span id="bedgraph"></span>

常见文件扩展名：.bg、.bedGraph

文本文件。

与 BED 文件相似（但并不相同！），它只能包含 4 列，且第 4 列必须是分数（score）。

同样，更多细节请阅读 UCSC 的说明。

bedGraph 文件 4 行示例（与 BED 文件一样遵循 UCSC 约定，起始位置为 0-based，终止位置为 1-based）：

```
chr1 10 20 1.5
chr1 20 30 1.7
chr1 30 40 2.0
chr1 40 50 1.8
```

 - #### bigWig（二进制区间分值格式）<span id="bigwig"></span>

常见文件扩展名：.bw、.bigwig

bedGraph 或 wig 文件的二进制版本。

包含区间的坐标以及与之关联的分数（score）。

分数可以是任何值，例如平均读段覆盖度（coverage）。

更多细节见 UCSC 说明。

 - #### FASTA（文本序列格式）<span id="fasta"></span>

常见文件扩展名：.fasta

文本文件，常以 gzip 压缩（.fasta.gz）。

一种非常简单的 DNA/RNA 或蛋白质序列格式；内容可以是任何序列，从短小的 DNA 或蛋白质片段到整个基因组（你所研究生物的基因组序列很可能就是以 FASTA 格式提供的）。

如需压缩的替代格式，请参见 2bit 文件格式条目。

来自维基百科、只包含一条序列的示例：

```
>gi|5524211|gb|AAD44166.1| cytochrome b [Elephas maximus maximus]
 LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
 EWIWGGFSVDKATLNRFFAFHFILPFTMVALAGVHLTFLHETGSNNPLGLTSDSDKIPFHPYYTIKDFLG
 LLILILLLLLLALLSPDMLGDPDNHMPADPLNTPLHIKPEWYFLFAYAILRSVPNKLGGVLALFLSIVIL
 GLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX
 IENY
```

 - #### FASTQ（含质量值的读段格式）<span id="fastq"></span>

常见文件扩展名：.fastq、.fq

文本文件，常以 gzip 压缩（→ .fastq.gz）。

包含原始读段（read）信息——每条读段占 4 行：

+ 读段 ID
+ 碱基序列（base call）
+ 附加信息或空行
+ 测序质量值（sequencing quality）——每个碱基对应一个

注意：其中不包含读段来源于基因组何处的信息。

来自维基百科（含更多信息）的示例：

```
@read001                                                                                                            # 读段 ID
GATTTGGGGTTCAAAGCAGTATCGATCAAATAGTAAATCCATTTGTTCAACTCACAGTTT        # 读段序列
+                                                                                                                           # 通常为空行
!''*((((***+))%%%++)(%%%%).1***-+*''))**55CCF>>>>>>CCCCCCC65        # ASCII 编码的质量分数
```

如需了解你的 .fastq 文件使用的是哪种 ASCII 编码（ASCII-encoding），只需运行 FastQC——其汇总报告（summary）会告诉你答案。

 - #### SAM（比对结果文本格式）<span id="sam"></span>

常见文件扩展名：.sam

通常是测序读段比对到参考基因组的结果。

包含一个简短的头部区域（header section，条目以 @ 符号标记）和一个比对区域（alignment section）；比对区域中每一行对应一条读段（因此其中可能有数百万行）。

<img width="1124.5" height="672" alt="image" src="https://github.com/user-attachments/assets/2ccb8e2d-2003-410f-ad8a-acbe4a1a16ce" />


 - ##### SAM 头部区域（header section）<span id="samhs"></span>

以制表符（tab）分隔的行，以 @ 开头，后接 标签:值（tag:value）对。

tag = 由两个字母组成的字符串，用于定义值的内容和格式。

 - ##### SAM 比对区域（alignment section）<span id="samas"></span>

每一行包含其比对质量、序列、基因组位置等信息。

```
r001 163 chr1 7 30 8M2I4M1D3M = 37 39 TTAGATAAAGGATACTG *
r002 0 chr1 9 30 3S6M1P1I4M * 0 0 AAAAGATAAGGATA *
```

第 2 个字段中的 flag 以单个数字编码了多个“是 / 否”判断的结果。

关于 flag 的更多细节，请参见这份详尽的说明或这份更偏技术的说明。

第 6 个字段中的 CIGAR 字符串表示将读段比对到基因组特定位置所需的各种操作类型：

+ 插入（insertion）
+ 缺失（deletion，小片段缺失用 D 表示；较大的缺失——例如剪接读段（spliced read）中的缺失——用 N 表示）
+ 剪切（clipping，即读段末端的截除）
