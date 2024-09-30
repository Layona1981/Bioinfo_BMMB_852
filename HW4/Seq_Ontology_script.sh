import requests

def get_so_term(term):
    url = f"http://www.sequenceontology.org/browser/current_svn/term/{term}"
    response = requests.get(url)
    return response.json()

def main():
    term = "SO:0000147"  # SO term for exon
    so_term = get_so_term(term)
    
    print("Term:", so_term['name'])
    print("Definition:", so_term['def'])
    print("Parent Terms:", [parent['name'] for parent in so_term['is_a']])
    print("Children Nodes:", [child['name'] for child in so_term['children']])

if __name__ == "__main__":
    main()
