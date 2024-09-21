# Read the content of the file
with open('output.md', 'r') as file:
    content = file.read()

# Remove all occurrences of '####'
content = content.replace('####', '')

# Write the modified content back to the file
with open('output.md', 'w') as file:
    file.write(content)

print("All occurrences of '####' have been removed from 'output.md'.")
