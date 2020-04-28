import csv
import sys
from ast import literal_eval

def main():
    input_csv, out_csv = sys.argv[1:]
    fout = open(out_csv,"w")
    fout.write("#movie_id|tdirector|cast\n")
    f = open(input_csv)
    next(f)
    for line in csv.reader(f, quotechar='"', delimiter=',',quoting=csv.QUOTE_ALL):
        cast_list, crew_list, movie_id = line
        cast_out_list = []
        dire_out_list = []
        cast_list = literal_eval(cast_list)
        for cast_dict in cast_list:
            cast_out_list.append(cast_dict['name'])
        crew_list = literal_eval(crew_list)
        for crew_dict in crew_list:
            if (crew_dict['job']=='Director'):
                dire_out_list.append(crew_dict['name'])
        if len(dire_out_list) == 0:
            dire_out_list.append("NA")
        if len(cast_out_list) == 0:
            cast_out_list.append("NA")
        out_list = [movie_id, dire_out_list[0], "$".join(cast_out_list[:10])]
        fout.write("|".join(out_list)+"\n")
main()