import csv
import math

#filename = argv

# txt = open(filename)
gene = [[-1 for x in range(25)] for x in range(25)] 
temp = [[-1 for x in range(25)] for x in range(25)]
comb = ['' for x in range(25)]
samp = ['' for x in range(25)]
uni = ['' for x in range(25)]

def pro(i, j):
    return i.count(j)/20

# def distinct(l):

# 	print  [''.join(x) for x in product('01', repeat=3)]
# 	if l == 1:
# 		comb = ['0','1']
# 	elif l == 2:
# 		comb = ['00','01','10','11']
# 	elif l == 3:
# 		comb = ['000','001','010','011','100','101','110','111']
# 	elif l == 4:
# 		comb = ['0000','0001','0010','0011','0100','0101','0110','0111','1000','1001',]



def h(*args):

	i = 0
	j = 0
	ent = 0
	for arg in args:
		j = 0
		while j < 20:
			temp[j][i] = gene[j][arg]
			#print(temp[j][i])
			j = j + 1
		i = i + 1
	
	#distinct(len(args))
	i = i - 1
	j = j - 1
	t = i

	while j > -1:
		#print(i,j)
		i = t
		while i > -1:
			#print(i,j)
			samp[j] = samp[j] + temp[j][i]
			i = i - 1

		#print(samp[j])
		j = j - 1

	uni = list(set(samp))

	for c in uni:
	
		#print(c)
		p = pro(samp, c)
		#print(p)
		ent += p * math.log2(p)
	
	return -1 * ent


if __name__ == "__main__":
	
	i = 0
	j = 0

	with open("formatted_data.csv") as csvfile:
	    csvreader = csv.reader(csvfile, delimiter=",")
	    
	    while i < 21:
	    	#print("Hello")
	    	j = 0
	    	csvfile.seek(0)
	    	for line in csvreader:
	    		gene[j][i] = line[i]
	    		#print(gene[j][i])
	    		j = j + 1
	    	i = i + 1

	csvfile.close()
	i = 0;
	j = 11
	# for k = 1
	while j < 21:
		i = 0
		while i < 10:
			if(h(i) == h(j,i)):
				# print(h(i))
				print(j, "<-", i)
				# print("%d is determined by %d" %(i,j))
			i = i + 1
		j = j + 1