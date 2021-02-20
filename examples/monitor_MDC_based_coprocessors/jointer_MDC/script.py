from sys import version_info
from pathlib import Path
import shutil
import os
import tarfile
import requests

if version_info.major == 2:
	# Python 2.x
	from Tkinter import *
	from ttk import *
elif version_info.major == 3:
	# Python 3.x
	from tkinter import *
	from tkinter.ttk import *


def check_board():
	import time
	tcl_url = os.path.join(cwd, project.get(), "scripts", "generate_ip.tcl")
	with open(tcl_url) as file:
		for line in file:
			if line.startswith("set partname"):
				partname.set(line.split('"')[1])
			if line.startswith("set boardpart"):
				bardpart.set(line.split('"')[1])
				b = line.split('"')[1].split(":")  # get only string between quote splitted by :
				if b[0] == 'em.avnet.com' and b[1] == 'zed':
					return 'zedboard'
				if b[0] == 'digilentinc.com' and b[1] == 'arty-z7-20':
					return 'arty_z720'


def update_bar(percent):
	progress['value'] = percent
	window.update_idletasks()


def check_array(arr):
	maxi = len(arr)
	for a in range(maxi):
		if a < maxi-1:
			if arr[a] > arr[a+1]:
				return False
	return True


def calc_sum_previus_val(arr):
	ret_arr = [0] * len(arr)
	for a in range(len(arr)):
		if a == 0:
			ret_arr[a] = int(arr[a])
		else:
			ret_arr[a] = int(arr[a])+int(ret_arr[a-1])
	return ret_arr



def calc_sum_rr_val(arr1, arr2):
	ret_arr = [0] * 9
	temp = [0] * 9
	inc = 0
	count = 1
	for a in range(0, len(arr1)):
		if a > 0 and arr1[a] == arr1[a-1]:
			count += 1
			temp[inc] = count
		else:
			inc = int(arr1[a])-1
			count = 1
			temp[int(arr1[a])-1] = count
	p = 0
	for a in range(0, len(temp)):
		var = temp[a]
		while var != 0:
			ret_arr[a] += int(arr2[p])
			p += 1
			var -= 1
	return ret_arr

def calc_last_nrr_val(arr1, arr2):
	ret_arr = [0] * 9
	temp = [0] * 9
	inc = 0
	count = 1
	for a in range(0, len(arr1)):
		if a > 0 and arr1[a] == arr1[a - 1]:
			count += 1
			temp[inc] = count
		else:
			inc = int(arr1[a]) - 1
			count = 1
			temp[int(arr1[a]) - 1] = count
	p = 0
	for a in range(0, len(temp)):
		var = temp[a]
		if var != 0:
			while var != 0:
				if int(arr2[p]) >= int(ret_arr[a]):
					ret_arr[a] = int(arr2[p])
					p += 1
					var -= 1
				else:
					var = 0
	ret_arr1 = [0] * 9
	ret_arr1[0] = ret_arr[0]
	for a in range(1, len(ret_arr)-1):
		if ret_arr[a] == 0:
			if ret_arr[a+1] != 0:
				ret_arr1[a] = ret_arr[a-1]
		else:
			ret_arr1[a] = ret_arr[a]
	return ret_arr1


def calc_miss_21_val(arr):
	ret_arr = [0] * 9
	for a in range(0, len(arr)):
		if arr[a] != 0:
			ret_arr[a] = int(arr[a]) + 1
		else:
			ret_arr[a] = 0
	return ret_arr


def edit_conf():
	with open('config.vhd', 'r') as file:
		data = file.readlines()

	if level1.get() == 1:
		data[6] = 'constant MON_1ST : integer := 1;\n'
	if level2.get() == 1:
		data[7] = 'constant mon_2nd : integer := 1;\n'
	if level3.get() == 1:
		data[8] = 'constant mon_3rd : integer := 1;\n'
		event = int(numEvent.get())
		nrr_val = nrrVal.get().split(',')
		size_counters = sizeCountersVall.get().split(',')
		if len(nrr_val) != len(size_counters):  # verifico la dimensione dei due array
			print("le dimensioni sono diverse")
			msgError['background'] = 'red'
			msgError['text'] = "Dimensioni array diverse"
			return False
		if not check_array(nrr_val):    # verifico che l'array nrr sia crescente
			print("array errato")
			msgError['background'] = 'red'
			msgError['text'] = "Primo array errato"
			return False
		if len(nrr_val) == 1 and len(size_counters) == 1 :
			nrr_val.append(nrr_val[0])
			size_counters.append('0')
		sum_previous_val = calc_sum_previus_val(size_counters)
		sum_rr_val = calc_sum_rr_val(nrr_val, size_counters)
		#sum_rr_val = calc_sum_rr_val(size_counters)
		miss_21_val = calc_miss_21_val(sum_rr_val)
		last_nrr_val = calc_last_nrr_val(nrr_val, sum_previous_val)
		print("NRR_VAL: ", *nrr_val)
		print("SIZE_COUNTERS: ", *size_counters)
		print("SUM_PREVIUS_VAL ", *sum_previous_val)
		print("SUM_RR_VAL: ", *sum_rr_val)
		print("MISS 21 VAL: ", *miss_21_val)
		print("LAST_NRR_VAL: ", *last_nrr_val)
		nrr_val_string = ", ".join(map(str, nrr_val))
		size_counters_string = ", ".join(map(str, size_counters))
		sum_previous_val_string  = ", ".join(map(str, sum_previous_val))
		sum_rr_val_string = ", ".join(map(str, sum_rr_val))
		miss_21_val_string = ", ".join(map(str, miss_21_val))
		last_nrr_val_string = ", ".join(map(str, last_nrr_val))
		data[45] = 'constant NRR_VAL: array_of_integers := (' + nrr_val_string + ');'
		data[48] = 'constant SIZE_COUNTERS_VAL: array_of_integers := (' + size_counters_string + ');'
		data[52] = 'constant SUM_PREVIOUS_VAL: array_of_integers := (' + sum_previous_val_string + ');'
		data[57] = 'constant SUM_RR_VAL: array_of_integers := (' + sum_rr_val_string + ');'
		data[61] = 'constant MISS_21_VAL: array_of_integers := (' + miss_21_val_string + ');'
		data[66] = 'constant LAST_NRR_VAL: array_of_integers := (' + last_nrr_val_string + ');'
	with open('config.vhd', 'w') as file:
		file.writelines(data)
	return True


def check_tree():
	lista = filter(os.path.isdir, os.listdir(cwd))
	s = False
	for lis in list(lista):
		if lis == 'source':
			s = True
		else:
			src_dir = lis
	if not s:
		url = 'https://github.com/alkalir/storage_monitor_accelerators/raw/master/monitor_sources.tar.gz'
		target_path = 'source.tar.gz'
		response = requests.get(url, stream=True)
		if response.status_code == 200:
			with open(target_path, 'wb') as f:
				f.write(response.raw.read())
			tar = tarfile.open('source.tar.gz', "r:gz")
			tar.extractall(cwd)
			tar.close()
			os.unlink("source.tar.gz")
	return src_dir


def replace_filter():
	fil = open("filter.tcl", "rt")
	data = fil.read()
	data = data.replace('$$1$$', project.get() + '_monitored')
	data = data.replace('$$2$$', partname.get())
	data = data.replace('$$3$$', bardpart.get())

	fil.close()

	fil = open("filter.tcl", "wt")
	fil.write(data)
	fil.close()


def close_window():
	if exp.get() == '':
		print("no example selected")
		selectexp.grid(column=1, row=1, sticky='W')
		return
	# mv old version of mdc_out
	source = os.path.join(cwd, project.get())
	destin = os.path.join(cwd, project.get() + "_monitored")
	# delete old version of mdc_out
	if os.path.exists(destin):
		shutil.rmtree(destin)  # delete if only exist
	update_bar(10)
	shutil.copytree(source, destin)
	update_bar(20)
	# copy sniffer, extract it and remove tar.gz
	snf_url = os.path.join(cwd, "source", exp.get(), "app_src", "monitoring_system", board.get(), "sniffer_generic_1.0.tar.gz")
	shutil.copy2(snf_url, destin)
	destin_temp = os.path.join(destin, "sniffer_generic_1.0.tar.gz")
	update_bar(30)
	tar = tarfile.open(destin_temp, "r:gz")
	tar.extractall(destin)
	tar.close()
	update_bar(40)
	os.unlink(destin_temp)
	# copy config.vhd, edit it and move in sniffer directory
	cnf_url = os.path.join(cwd, "source", exp.get(), "app_src", "config.vhd")
	shutil.copy2(cnf_url, cwd)
	if not edit_conf():
		# selectexp.grid(column=1, row=1, sticky='W')
		return
	update_bar(50)
	cnf_dst = os.path.join(destin, "sniffer_generic_1.0", "hdl")
	cnf_src = os.path.join(cwd, "config.vhd")
	shutil.copy2(cnf_src, cnf_dst)
	os.unlink("config.vhd")
	update_bar(80)
	tcl_url = os.path.join(cwd, "source", exp.get(), "app_src", "filter.tcl")
	shutil.copy2(tcl_url, cwd)
	update_bar(90)
	replace_filter()
	window.destroy()
	# check system operator
	if os.name == 'nt':  # case windows
		viv_url = os.path.join("c:\\", "Xilinx", "Vivado")
		files = os.listdir(viv_url)
		for name in files:
			viv_url = os.path.join(viv_url, name)
		settings = os.path.join(viv_url, "settings64.bat")
		os.system(settings + '& vivado -mode batch -source filter.tcl')
	if os.name == 'posix':  # case linux
		tmp1_url = os.path.join("/opt", "Xilinx", "Vivado")
		tmp2_url = os.path.join("/opt", "Xilinx", "SDx")
		if os.path.isdir(tmp2_url):
			viv_url = tmp2_url
		else:
			viv_url = tmp1_url
		files = os.listdir(viv_url)
		for name in files:
			viv_url = os.path.join(viv_url, name)
		settings = os.path.join(viv_url, "settings64.sh")
		shutil.copy2(os.path.join(cwd, "source", exp.get(), "app_src", "load.sh"), cwd)
		os.system('./load.sh ' + settings)
		os.unlink("load.sh")
	os.unlink("filter.tcl")


def show_option():
	global i
	if (i % 2) == 0:
		numEventL.grid(column=0, row=8, sticky='W')
		numEvent.grid(column=1, row=8)
		nrrValL.grid(column=0, row=9, sticky='W')
		nrrVal.grid(column=1, row=9, sticky='W')
		sizeCountersVallL.grid(column=0, row=10, sticky='W')
		sizeCountersVall.grid(column=1, row=10, sticky='W')
		msgError.grid(column=1, row=11, sticky='W')
	else:
		numEventL.grid_forget()
		numEvent.grid_forget()
		nrrValL.grid_forget()
		nrrVal.grid_forget()
		sizeCountersVallL.grid_forget()
		sizeCountersVall.grid_forget()
		msgError.grid_forget()
	i += 1


i = 0
# root project path
cwd = os.getcwd()

window = Tk()
window.title("Monitor ")
window.geometry('350x550')

partname = StringVar()
bardpart = StringVar()

project = StringVar()
project.set(check_tree())
print(project.get())
# label text

board = StringVar()
board.set(check_board())

# label text
Label(window, text='Select the Example').grid(column=0, row=0, sticky='W')
exp = StringVar()
arty = Radiobutton(window, text="Custom Multiplications", variable=exp, value="toy_ex").grid(column=0, row=1, sticky='W')
zed = Radiobutton(window, text="Sobel/Roberts", variable=exp, value="sobel_roberts").grid(column=0, row=2, sticky='W')
selectexp = Label(window, text='< -- Please select a Example')
selectexp.grid_forget()


# check buttons
Label(window, text='Select Monitor level').grid(column=0, row=4, sticky='W')
level1 = IntVar()
level2 = IntVar()
level3 = IntVar()
first = Checkbutton(window, text='1st', variable=level1, onvalue=1, offvalue=0).grid(column=0, row=5, sticky='W')
second = Checkbutton(window, text='2nd', variable=level2, onvalue=1, offvalue=0).grid(column=0, row=6, sticky='W')
third = Checkbutton(window, text='3rd', variable=level3, onvalue=1, offvalue=0, command=show_option).grid(column=0, row=7, sticky='W')

# element of third monitor
numEventL = Label(window, text='Numero di eventi')
numEventL.grid_forget()
numEvent = Entry(window, width=4)
numEvent.grid_forget()
nrrValL = Label(window, text='numero del registro \nrelativo associato allo \nstorage del risultato \ndi ogni evento\n(separati da virgola)')
nrrValL.grid_forget()
nrrValL['background'] = ''
nrrVal = Entry(window, width=18)
nrrVal.grid_forget()

sizeCountersVallL = Label(window, text='size del risultato\n associata ad ogni evento\n(separati da virgola)')
sizeCountersVallL.grid_forget()
sizeCountersVallL['background'] = ''
sizeCountersVall = Entry(window, width=18)
sizeCountersVall.grid_forget()

msgError = Label(window, text='')
msgError.grid_forget()
msgError['background'] = ''



# Progress bar widget
white = Label(window, text='').grid(column=0, row=11)
progress = Progressbar(window, orient=HORIZONTAL, length=100, mode='determinate')
progress.grid(column=0, row=14, columnspan=2, sticky='NSEW')

# button widget
button1 = Button(window, text="Close", command=window.destroy).grid(column=0, row=15, sticky='W')
button2 = Button(window, text="Generate", command=close_window).grid(column=1, row=15, sticky='W')
window.mainloop()
