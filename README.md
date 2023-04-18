# Variant NNUE training data generator

This is a variant NNUE training data generator based on [Fairy-Stockfish](https://github.com/ianfab/Fairy-Stockfish) to generate data for the [variant NNUE trainer](https://github.com/ianfab/variant-nnue-pytorch). See the [wiki of the training code](https://github.com/ianfab/variant-nnue-pytorch/wiki/Training-data-generation) for more information.

This is a fork of [variant-nnue-tools](https://github.com/fairy-stockfish/variant-nnue-tools)

This fork would only work for the xiangqi variant.

## To compile

```
    cd src
    sh m.sh
```

## To run
```
    time ./stockfish
```
This would generate 10000000 (10 millions) positions.

This may take some time.  For example, it took 43 minutes to complete in my laptop.

Result is stored in `xiangqi.bin`

The file size is 720000000 (arround 720Mb).  Each position occupies 72 bytes.

If you run the program again, make sure to remove the existing `xiangqi.bin` first


## Default Settings
Inside the function getline() in uci.cpp
```
    void getline(string &cmd) {
      const int size=9;
      static string list[size]={
       "", 
       "ucci",
       "setoption Use_NNUE pure",
       "setoption EvalFile xiangqi-aa162e1771e5.nnue",
       "setoption Threads 8",
       "setoption Hash 512",
       "setoption UCI_Variant xiangqi",
       "generate_training_data depth 2 count 10000000"
       " random_multi_pv 4 random_multi_pv_diff 100"
       " random_move_count 8 random_move_max_ply 20"
       " write_min_ply 5 eval_limit 10000"
       " set_recommended_uci_options data_format bin"
       " output_file_name xiangqi.bin",
       "quit"
      };
```

For example, to change the number of generated positions to 5 million, modify the above function:
```
       "generate_training_data depth 2 count 5000000"
```

To use another neural network, modify this line:
```
       "setoption EvalFile xiangqi-aa162e1771e5.nnue",
```

The default settings works well as a quick start for training nnue network.

To actually train the network, run the [trainer](https://github.com/macteki/variant-nnue-pytorch)

The [trainer](https://github.com/macteki/variant-nnue-pytorch) is a fork of [variant-nnue-pytorch](https://github.com/fairy-stockfish/variant-nnue-pytorch).

The [fork](https://github.com/macteki/variant-nnue-pytorch) can be used to train xiangqi network with the data generated above (xiangqi.bin)
```
time python train.py --gpus 1 --max_epochs 10 xiangqi.bin xiangqi.bin
```

The trainer took 90 minutes to complete in my laptop

Setting up the trainer with all dependencies is a complex task for beginners, and it require a GPU capable of running CUDA.

If you have difficulties setting up a local training environment, you may follow these [instructions](https://github.com/fairy-stockfish/variant-nnue-pytorch/wiki/Training-through-Kaggle-GPU-(easier-way)) to run a trainer online
