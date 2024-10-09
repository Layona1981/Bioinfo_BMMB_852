!/bin/bash

# Lina Sallam
# FASTQ Quality Control

# Activate your bioinfo environment
source ~/.bashrc
eval "$(micromamba shell hook --shell bash)"
micromamba activate bioinfo

# Set Paths for reproducibility
HOME_DIR="/Users/Las7033/BMMB_852/HW_6"
QUALITY="${HOME_DIR}/Quality"
SRR="SRRSRR12345678"
FASTERQ_INDIR="${HOME_DIR}/Data"
FASTP_OUTDIR="${HOME_DIR}/fastp_filt"

# Move to the desired directory to download your files
cd ${HOME_DIR}

# Check if fasterq-dump is installed
if ! command -v fasterq-dump &> /dev/null
then
    echo "fasterq-dump not found, installing sra-tools..."
    micromamba install -c bioconda sra-tools
fi

# Get FASTQ files from NCBI via SRR number
fasterq-dump ${SRR} --outdir ${FASTERQ_INDIR} --split-files --threads 4

# Compress files for storage sake
gzip ${FASTERQ_INDIR}/*.fastq

# Create directory for quality checks
mkdir -p ${QUALITY}

# Run fastqc on all .fastq.gz files
fastqc ${FASTERQ_INDIR}/*.fastq.gz -o ${QUALITY}

# Define fastp output directory
mkdir -p ${FASTP_OUTDIR}

# Get list of sample names (remove the _1.fastq.gz or _2.fastq.gz part)
ls ${FASTERQ_INDIR} | sed -E 's/_[12]\.fastq\.gz//' | uniq > ${HOME_DIR}/names.txt

# Run fastp in parallel with correct filename formatting
cat ${HOME_DIR}/names.txt | \
parallel /Users/sls6550/micromamba/envs/bioinfo/bin/fastp \
-i ${FASTERQ_INDIR}/{}_1.fastq.gz \
-I ${FASTERQ_INDIR}/{}_2.fastq.gz \
-o ${FASTP_OUTDIR}/{}_fastp_1.fastq \
-O ${FASTP_OUTDIR}/{}_fastp_2.fastq 

echo "done"