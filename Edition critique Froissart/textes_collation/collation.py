from collatex import *

with open('./Austin_48.txt') as f:
    austin = " ".join(f.readlines())
with open('./Besancon864.txt') as f:
    besancon = " ".join(f.readlines())
with open('./Brussels2_88.txt') as f:
    brussels = " ".join(f.readlines())
with open('./Chicago_f37.txt') as f:
    chicago = " ".join(f.readlines())

collation = Collation()
collation.add_plain_witness("A", austin)
collation.add_plain_witness("Be", besancon)
collation.add_plain_witness("Br", brussels)
collation.add_plain_witness("C", chicago)


alignment_table = collate(collation, output="tei", segmentation=False, near_match=True)

with open("collation.xml", "w") as output:
	output.write(alignment_table)