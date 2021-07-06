#!/usr/bin/python3

import sys
import re
import numpy as np
import argparse

def  get_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("-f", "--file", dest="source_file", help="File with Scan commands")
    parser.add_argument("-o", "--output", dest="output_file", help="File generated with Put Commands")
    options = parser.parse_args()

    if not options.source_file:
        parser.error("[-] Please specify a target ip, --help for more info.")
    
    return options

def get_data_lines(completeStr):
    print("Getting Data Lines")
    for dataLine in re.finditer(r".*column.*timestamp.*value.*", completeStr):
        yield dataLine.group(0)


def extract_data_in_line(line):
    key, column, value = np.array(line.split(' ')).take([1, 2, 4])
    column = column.replace('column=', '').replace(',', '')
    value = value.replace('value=', '')
    return (key, column, value)


def extract_put_data_in_string(strScan):
    patternToExtract = r"(?P<key>.*)(?: column=)(?P<column>.*)(?:\,\stimestamp=.*,\svalue=)(?P<value>.*)"
    return re.findall(patternToExtract, strScan)


def generate_put_command(table, key, column, value):
    return "put '{}','{}','{}','{}'".format(table.strip(), key.strip(), column.strip(), value.strip())


def data_to_put_commands(mapData):
    print("Generating put commands for data")
    for data in mapData:
        key, column, value = data
        yield generate_put_command(tableName, key, column, value)


def save_put_file(fileName, putList):
    print("Saving put file")
    with open(fileName, 'w') as f:
        for put in putList:
            f.write(put + "\n")


def get_table_name(fString):
    # Find Table Name
    print("Getting table name")
    searchTableName = re.search(r"(scan\s\')([\w|\.]+)", fString)
    if searchTableName:
        return searchTableName.group(2)
    print("Can't find a table name")
    sys.exit(1)

options = get_arguments()


file_name = options.source_file
put_file = options.output_file

print("Reading file {}".format(file_name))
with open(file_name) as f:
    fString = f.read()

tableName = get_table_name(fString)

save_put_file(put_file,
              [put for put in data_to_put_commands(extract_put_data_in_string(fString))])
