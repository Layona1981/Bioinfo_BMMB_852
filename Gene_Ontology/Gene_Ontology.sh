
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
