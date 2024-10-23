# Existing variables and targets...

# New targets for the assignment
.PHONY: count_unaligned count_alignments count_properly_paired filter_bam compare_flagstats

# Count unaligned reads
count_unaligned:
	@echo "Counting unaligned reads..."
	$(SAMTOOLS) view -c -f 4 $(BAM_SRA_SORTED)

# Count primary, secondary, and supplementary alignments
count_alignments:
	@echo "Counting primary, secondary, and supplementary alignments..."
	$(SAMTOOLS) view -c -F 256 $(BAM_SRA_SORTED)  # Primary
	$(SAMTOOLS) view -c -f 256 $(BAM_SRA_SORTED)  # Secondary
	$(SAMTOOLS) view -c -f 2048 $(BAM_SRA_SORTED) # Supplementary

# Count properly paired alignments on the reverse strand from the first pair
count_properly_paired:
	@echo "Counting properly paired alignments on the reverse strand from the first pair..."
	$(SAMTOOLS) view -c -f 99 $(BAM_SRA_SORTED)

# Filter BAM file for properly paired primary alignments with mapping quality > 10
filter_bam:
	@echo "Filtering BAM file for properly paired primary alignments with mapping quality > 10..."
	$(SAMTOOLS) view -h -f 2 -q 10 $(BAM_SRA_SORTED) | $(SAMTOOLS) view -Sb - > alignments/filtered.bam
	$(SAMTOOLS) sort alignments/filtered.bam -o alignments/filtered_sorted.bam
	$(SAMTOOLS) index alignments/filtered_sorted.bam

# Compare flagstats of original and filtered BAM files
compare_flagstats:
	@echo "Comparing flagstats of original and filtered BAM files..."
	$(SAMTOOLS) flagstat $(BAM_SRA_SORTED) > alignments/original_flagstat.txt
	$(SAMTOOLS) flagstat alignments/filtered_sorted.bam > alignments/filtered_flagstat.txt
	diff alignments/original_flagstat.txt alignments/filtered_flagstat.txt
