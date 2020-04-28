import sys
import json
import ast


def main():
    input_file, out_id_c, out_c_id = sys.argv[1:]
    collection_dict = {}
    movie_id_dict = {}
    collection_movie_dict = {}

    fout1 = open(out_id_c, "w")
    fout1.write("#movie_id\tcol_id\tcol_name\n")

    with open(input_file) as fin:
        next(fin)
        for line in fin:
            tmp = line.strip().split("\t")
            if len(tmp) > 1:
                movie_id = int(tmp[0])
                if movie_id not in movie_id_dict:
                    movie_id_dict[movie_id] = 1
                    res = ast.literal_eval(ast.literal_eval(tmp[1]))
                    
                    col_id = int(res['id'])
                    col_name = res['name']
                    if col_id not in collection_dict:
                        collection_dict[col_id] = col_name
                    if col_id in collection_movie_dict:
                        collection_movie_dict[col_id].add(movie_id)
                    else :
                        collection_movie_dict[col_id] = set([movie_id])

                    out1 = [str(movie_id), str(col_id), col_name]
                    fout1.write("\t".join(out1)+"\n")
    fout1.close()
    fout2 = open(out_c_id, "w")
    fout2.write("#col_id\tmovie_ids\n")
    for col_id in collection_movie_dict:
        fout2.write(str(col_id)+"\t")
        fout2.write(",".join(list(map(str, collection_movie_dict[col_id])))+"\n")
    fout2.close()
main()

