file_names = [
    "globals",
    "styles",
    "tweens",
    "widget",
    "widgets",
    "wrappers",
    "brilliance"
]
files = []

for name in file_names:
    file = open("split/"+name+".lua", "r")
    files.append(file)

target = open("src/BrillianceUI/init.lua", "w")
target.write("-- BrillianceUI by BrightShard\n")
target.close()

target = open("src/BrillianceUI/init.lua", "a")
for file in files:
    target.write(file.read())
    target.write("\n\n\n\n\n")
    file.close()
target.close()

print("Done.")