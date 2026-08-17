# **Glossary of NGS terms**
## ——生物信息新手的必备常识
</p title = "抄袭？？">全文转载自deepTools文档中的Glossary of NGS terms</p>[前往文档](https://deeptools.readthedocs.io/en/latest/index.html)

### 目录
+ [Abbreviations](#abbreviations)
+ [NGS and generic terminology](#ngs)
  - [bin](#bin)
  - [Input](#input)
  - [read](#read)
+ [File Formats](#file)
  - [2bit](#2bit)
  - [BAM](#bam)
  - [BED](#bad)
  - [bedGraph](#bedgraph)
  - [bigWig](#bigwig)
  - [FASTA](#fasta)
  - [FASTQ](#fastq)
  - [SAM](#sam)
+ [SAM header section](#samhs)
+ [SAM alignment section](#samas)

### Abbreviations <span id="abbreviations"></span>

Reference genomes are usually referred to by their abbreviations, such as:

  + hg19 = human genome, version 19
  + mm9 = Mus musculus genome, version 9
  + dm3 = Drosophila melanogaster, version 3
  + ce10 = Caenorhabditis elegans, version 10
  
For a more comprehensive list of available reference genomes and their abbreviations, see the [UCSC data base](https://hgdownload.soe.ucsc.edu/downloads.html#others).
| Acronym | Full Phrase | Synonyms/Explanation |
| :--- | :--- | :--- |
| `<ANYTHING>-seq` | -sequencing | indicates that an experiment was completed by DNA sequencing using NGS |
| `ChIP-seq` | chromatin immunoprecipitation sequencing | NGS technique for detecting transcription factor binding sites and histone modifications (see entry Input for more information) |
| `DNase` | deoxyribonuclease I | DNase I digestion is used to determine active (“open”) chromatin regions |
| `HTS` | high-throughput sequencing | next-generation sequencing, massive parallel short read sequencing, deep sequencing |
| `MNase` | micrococcal nuclease | MNase digestion is used to determine sites with nucleosomes |
| `NGS` | next-generation sequencing | high-throughput (DNA) sequencing, massive parallel short read sequencing, deep sequencing |
| `RPGC` | reads per genomic content | normalize reads to 1x sequencing depth, sequencing depth is defined as: (mapped reads x fragment length) / effective genome size |
| `RPKM` | reads per kilobase per million reads | normalize read numbers: RPKM (per bin) = reads per bin / ( mapped reads (in millions) x bin length (kb)) |

For a review of popular *-seq applications, see [Zentner and Henikoff].

### NGS and generic terminology<span id="ngs"></span>

The following are terms that may be new to some:
 - #### bin<span id="bin"></span>

synonyms: window, region

A ‘bin’ is a subset of a larger grouping. Many calculations calculation are performed by first dividing the genome into small regions (bins), on which the calculations are actually performed.

 - #### Input<span id="input"></span>
Control experiment typically done for ChIP-seq experiments

While ChIP-seq relies on antibodies to enrich for DNA fragments bound to a certain protein, the input sample should be processed exactly the same way, excluding the antibody. This allows one to account for biases introduced by sample handling and the general chromatin structure of the cells

 - #### read<span id="read"></span>

synonym: tag

This term refers to the piece of DNA that is sequenced (“read”) by the sequencers. We try to differentiate between “read” and “DNA fragment” as the fragments that are put into the sequencer tend to be in the range of 200-1000 bases, of which only the first 50 to 300 bases are typically sequenced. Most of the deepTools will not only take these reads into account, but also extend them to match the original DNA fragment size. (The original size will either be given by you or, if you used paired-end sequencing, be calculated from the distance between the two read mates).

### File Formats<span id="file"></span>

Data obtained from next-generation sequencing data must be processed several times. Most of the processing steps are aimed at extracting only that information needed for a specific down-stream analysis, with redundant entries often discarded. Therefore, specific data formats are often associated with different steps of a data processing pipeline.

Here, we just want to give very brief key descriptions of the file, for elaborate information we will link to external websites. Be aware, that the file name sorting here is alphabetical, not according to their usage within an analysis pipeline that is depicted here:
<img width="1305" height="1004" alt="image" src="https://github.com/user-attachments/assets/ad5a2fce-610f-488a-9785-6e23eb494c44" />

Follow the links for more information on the different tool collections mentioned in the figure:

 - #### 2bit
compressed, binary version of genome sequences that are often stored in FASTA

most genomes in 2bit format can be found at UCSC

FASTA files can be converted to 2bit using the UCSC programm faToTwoBit, which is available for different platforms at UCSC

more information can be found here

 - #### BAM
typical file extension: .bam

binary file format (complement to SAM)

contains information about sequenced reads (typically) after alignment to a reference genome

each line = 1 mapped read, with information about:
its mapping quality (how likelihood that the reported alignment is correct)

its sequencing quality (the probability that each base is correct)

its sequence

its location in the genome

etc.

highly recommended format for storing data

to make a BAM file human-readable, one can, for example, use the program samtools view

for more information, see below for the definition of SAM files

 - #### BED
typical file extension: .bed

text file

used for genomic intervals, e.g. genes, peak regions etc.

the format can be found at UCSC

for deepTools, the first 3 columns are important: chromosome, start position of the region, end position of the genome

do not confuse it with the bedGraph format (although they are related)

example lines from a BED file of mouse genes (note that the start position is 0-based, the end-position 1-based, following UCSC conventions for BED files):
