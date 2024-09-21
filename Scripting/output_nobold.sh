# Read the content of the file
with open('output_nobold.sh', 'r') as file:
    content = file.read()

# Remove all occurrences of '######' from the beginning of each line
content = content.replace('######', '')

# Write the modified content back to the file
with open('output_nobold.sh', 'w') as file:
    file.write(content)

print("All occurrences of '######' have been removed from 'output_nobold.sh'.")


