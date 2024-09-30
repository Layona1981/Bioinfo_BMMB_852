#### **Category:** CC

**GO Term:** nucleus (GO:0005634)

**Definition:** A membrane-bounded organelle of eukaryotic cells in which chromosomes are housed and replicated. In most cells, the nucleus contains all of the cell's chromosomes except the organellar chromosomes, and is the site of RNA synthesis and processing. In some species, or in specialized cell types, RNA metabolism or DNA replication may be absent.

### **Parent Terms:** intracellular membrane-bounded organelle

### **Children Nodes:** 
nucleoplasm, nuclear chromosome, nuclear envelope, nuclear matrix, nuclear pore, nuclear lumen, nuclear body, nuclear periphery, nuclear part, nuclear membrane, nuclear speck, nuclear lamina, nuclear chromatin, nuclear inner membrane, nuclear outer membrane, nuclear pore membrane, nuclear pore complex, nuclear pore central transport channel, nuclear pore cytoplasmic filaments, nuclear pore nuclear basket, nuclear pore nuclear ring.

#### **Category:** MF

**GO Term:** DNA binding (GO:0003677)

**Definition:** Interacting selectively and non-covalently with DNA (deoxyribonucleic acid).

### **Parent Terms:** nucleic acid binding

### **Children Nodes:** 
sequence-specific DNA binding, double-stranded DNA binding, single-stranded DNA binding, DNA binding transcription factor activity, DNA binding transcription repressor activity, DNA binding transcription activator activity.

#### **Category:** BP

**GO Term:** DNA replication (GO:0006260)

**Definition:** The process by which a cell duplicates its DNA, usually in preparation for cell division.

### **Parent Terms:** DNA metabolic process

### **Children Nodes:** 
DNA strand elongation, DNA strand initiation, DNA strand termination, DNA strand synthesis, DNA strand repair.
import requests 

def get_go_term(term_id):
    url = f"http://www.ebi.ac.uk/QuickGO/services/ontology/go/terms/{term_id}"
    response = requests.get(url, headers={"Accept": "application/json"})
    return response.json()

def main():
    terms = {
        "CC": "GO:0005634",  # Nucleus
        "MF": "GO:0003677",  # DNA binding
        "BP": "GO:0006260"   # DNA replication
    }

    for category, term_id in terms.items():
        term_data = get_go_term(term_id)
        term_info = term_data['results'][0]
        print(f"Category: {category}")
        print(f"Term: {term_info['name']} ({term_info['id']})")
        print(f"Definition: {term_info['definition']['text']}")
        print("Parent Terms:", [parent['name'] for parent in term_info['is_a']])
        print("Children Nodes:", [child['name'] for child in term_info['children']])
        print()

if __name__ == "__main__":
    main()


import requests

def get_genes_for_go_term(term_id):
    url = f"http://www.ebi.ac.uk/QuickGO/services/annotation/search?goId={term_id}&limit=10"
    response = requests.get(url, headers={"Accept": "application/json"})
    return response.json()

def main():
    terms = {
        "CC": "GO:0005634",  # Nucleus
        "MF": "GO:0003677",  # DNA binding
        "BP": "GO:0006260"   # DNA replication
    }

    for category, term_id in terms.items():
        gene_data = get_genes_for_go_term(term_id)
        genes = [annotation['geneProductId'] for annotation in gene_data['results']]
        print(f"Category: {category}")
        print(f"GO Term: {term_id}")
        print("Genes:", genes)
        print()

if __name__ == "__main__":
    main()
