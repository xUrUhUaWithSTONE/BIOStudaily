rule all:
    input:
        expand("fastq/stringtie/{sample}.gtf", 
        sample=
        ["CRR463144", "CRR463145", "CRR463146", 
        "CRR463147", "CRR463148", "CRR463149",
         "CRR463150", "CRR463151", "CRR463152",
         "CRR463153", "CRR463154", "CRR463155"])

rule fastp_map:
    input:
        R1 = "fastq/{sample}_f1.fq.gz",
        R2 = "fastq/{sample}_r2.fq.gz"
    output:
        R1 = "fastq/cleaned/{sample}_f1_cleaned.fq.gz",
        R2 = "fastq/cleaned/{sample}_r2_cleaned.fq.gz",
        log = "fastq/cleaned/{sample}_fastp.html"
    shell:
        "fastp -i {input.R1} -I {input.R2} -o {output.R1} -O {output.R2} -h {output.log}"

rule hisat2_build_map:
    input:
        genome_fasta = "reference/GCF_034140825.1_ASM3414082v1_genomic.fna"
    output:
        index1 = "reference/hisat2_index/genome_index.1.ht2",
        index2 = "reference/hisat2_index/genome_index.2.ht2",
        index3 = "reference/hisat2_index/genome_index.3.ht2",
        index4 = "reference/hisat2_index/genome_index.4.ht2",
        index5 = "reference/hisat2_index/genome_index.5.ht2",
        index6 = "reference/hisat2_index/genome_index.6.ht2",
        index7 = "reference/hisat2_index/genome_index.7.ht2",
        index8 = "reference/hisat2_index/genome_index.8.ht2"
    shell:
        "mkdir -p reference/hisat2_index && hisat2-build {input.genome_fasta} reference/hisat2_index/genome_index"

rule hisat2_map:
    input:
        index = "reference/hisat2_index/genome_index.1.ht2",  
        R1 = "fastq/cleaned/{sample}_f1_cleaned.fq.gz",
        R2 = "fastq/cleaned/{sample}_r2_cleaned.fq.gz"
    params:
        idx_prefix = "reference/hisat2_index/genome_index",   
    output:
        bam = "fastq/mapped/{sample}.bam"
    shell:
        "hisat2 -x {params.idx_prefix} -1 {input.R1} -2 {input.R2} | samtools sort -o {output.bam}"

rule stringtie_map:
    input:
        bam = "fastq/mapped/{sample}.bam",
        gtf = "reference/GCF_clean.gtf"
    output:
        gtf_out = "fastq/stringtie/{sample}.gtf"
    shell:
        "stringtie -e  {input.bam} -G {input.gtf} -o {output.gtf_out} -force"

            input:
        bam = "",
        gtf = ""
    output:
        gtf_out = ""
    shell:
        "stringtie -e  fastq/mapped/CRR463145.bam -G reference/GCF_clean.gtf -o fastq/stringtie/CRR463145.gtf -force"