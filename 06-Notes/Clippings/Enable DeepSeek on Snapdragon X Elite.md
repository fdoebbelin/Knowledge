---
title: "5-Part Series: Enable DeepSeek on Snapdragon X Elite"
source: "https://www.qualcomm.com/developer/project/5-part-series--enable-deepseek-on-snapdragon-x-elite"
author:
published:
created: 2025-08-24
description: "Let’s explore how to run DeepSeek on Snapdragon X Elite using ONNX Runtime. By the end of this guide, you’ll be able to fully utilize Qualcomm Hexagon NPU."
tags:
  - "clippings"
---
Step-by-Step Guide: Enable DeepSeek on Snapdragon X Elite

No need to sugar coat and delay things any further it’s finally here, albeit a little late. This is the walkthrough you’ve been waiting for, the one that takes you from a pile of disjointed.onnx files to running DeepSeek completely on Qualcomm Hexagon NPU. Yes, you read that right running on Hexagon.

Since this may get a little technical, we really have no choice, I’ve decided to break this blog down into nice bite-sized chunks. This will allow you to get to the meat of things quickly without having to sift through everything. By the end of this series, you’ll have a locally running reasoning LLM that you are able to then customize however you want. And best of all? It’s all local, no cloud, no sketchy server, your data is yours and it stays that way as it should!

As an added bonus, you’ll probably walk away with a deeper understanding of the inner workings of LLMs! We’ll get into some technical stuff, we really have no choice, I’ll do my best to keep it as clear and simple as possible. When we’re done, you’ll not only have a powerful model running locally, but you’ll also have peace of mind knowing nobody else knows that you’re running it.

Let’s go ahead and dive in!

Overview

The goal of this series is to walk you through all the necessary steps to run a LLM, DeepSeek, completely on Hexagon. My personal goal is for you to get up and running as quick as possible. I do all the initial leg work of scanning through the docs, figuring out how all the pieces go together. I want your focus to be on creating something awesome and hopefully pushing your project to our repo for us to showcase.

This DeepSeek Application will be built in Python, and we’ll use onnxruntime-qnn, Jupyter Notebook, NumPy, and optionally Netron to get a deeper understanding of all the pieces to the puzzle. No need to build anything from source like the last walkthrough, see [Pose Detection Walkthrough](https://www.qualcomm.com/developer/blog/2025/03/enable-pose-detection-snapdragon-x-elite-step-by-step-tutorial), the setup will be smooth as butter.

## Part 1: Prerequisites and Environment Setup

Let’s get the entire development environment set up, we will assume that you have a completely new laptop with Snapdragon X Elite. All of these requirements can be skipped if you’re system is already setup from the [Pose Detection Walkthrough](https://www.qualcomm.com/developer/blog/2025/03/enable-pose-detection-snapdragon-x-elite-step-by-step-tutorial).

**Requirements:**

1. Visual Studio Installer
	1. https://learn.microsoft.com/en-us/cpp/build/vscpp-step-0-installation?view=msvc-170
	2. Workloads - Desktop development with C++
	3. Components - MSVC v143 – VS 2022 C++ ARM64/ARM64EC compatible build tools (latest)
2. Python 3.11.x
	1. Windows installer (Windows on Snapdragon)
		1. Python 3.11 Windows on Snapdragon
3. Rust (tokenizers module is built in Rust)
	1. Rust Installer
		1. [https://www.rust-lang.org/tools/install](https://www.rust-lang.org/tools/install)
4. DeepSeek Model (quantized version)
	1. [https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek\_r1\_7b\_ctx\_v1.0.onnx\_ctx.onnx](https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek_r1_7b_ctx_v1.0.onnx_ctx.onnx)
	2. [https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek\_r1\_7b\_embeddings\_quant\_v1.0.onnx](https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek_r1_7b_embeddings_quant_v1.0.onnx)
	3. [https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek\_r1\_7b\_head\_quant\_v1.0.onnx](https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek_r1_7b_head_quant_v1.0.onnx)
	4. [https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek\_r1\_7b\_iter\_v1.0.onnx\_ctx.onnx](https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek_r1_7b_iter_v1.0.onnx_ctx.onnx)
	5. [https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek\_r1\_7b\_cb\_1.bin](https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek_r1_7b_cb_1.bin)
	6. [https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek\_r1\_7b\_cb\_2.bin](https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek_r1_7b_cb_2.bin)
	7. [https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek\_r1\_7b\_cb\_3.bin](https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek_r1_7b_cb_3.bin)
	8. [https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek\_r1\_7b\_cb\_4.bin](https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek_r1_7b_cb_4.bin)
	9. Example:
		1. curl -O --ssl-no-revoke [https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek\_r1\_7b\_iter\_v1.0.onnx\_ctx.onnx](https://qnn-sample-app-models.s3.us-west-2.amazonaws.com/qnn-deepseek-r1-distill-qwen-7b/deepseek_r1_7b_iter_v1.0.onnx_ctx.onnx)
5. Python Packages
	1. virtualenv
	2. Onnxruntime-qnn
	3. Jupyter Notebook
	4. NumPy
	5. tokenizers

**Setup:**

If this is a brand new Snapdragon X Elite we’ll need to install Visual Studio Installer as well as a Python version (>=3.11) compatible with Windows on Snapdragon (WOS), [Python 3.11 Windows on Snapdragon](https://qualcomm-my.sharepoint.com/personal/derrjohn_qti_qualcomm_com/Documents/Desktop/DEV_FIRST_BLOGS/DeepSeek/ii.%09https:/www.python.org/ftp/python/3.11.0/python-3.11.0-arm64.exe).

When installing Python be sure to select py launcher from Optional Features.

![](_resources/a0b4004dd741f2823462f39741c7cd4b_MD5.png)

This allows us to easily select the Python version we intend to use, extremely useful if you have multiple Python versions installed on your system.

Once Visual Studio Installer is downloaded, install the necessary workloads and components mentioned above (1a, 1b).

Since we added py launcher to our Python install we can easily identify and create a virtual environment using the correct Python version. We’ll walk through that process now.

First let’s bring up PowerShell and run the command,

```
>> py -0
```

which should return something similar to,

![](_resources/334ba68ced3b4f41b17cb8c40edc16b7_MD5.png)

Now that we’ve verified that the correct Python version is installed, we can now move along in the process and setup the virtual environment.

As I’ve said before and will continue to say I highly recommend using a virtual environment. It keeps your dependencies in check and your development setup clean, organized, and isolated from all the mess that always finds its way into the global Python install.

The first thing we’ll do is install the virtualenv module, which we’ll use to create our environment,

```powershell
py -V:3.11-arm64 -m pip install virtualenv
```

We’ll then create a virtual environment,

```powershell
py -V:3.11-arm64 -m virtualenv env_local_llm
```

Let’s activate the virtual environment we just created and make sure we are using the correct Python version.

```powershell
env_local_llm/Scripts/activate.ps1
```

```powershell
python -c "import platform;print(platform.machine());print(platform.processor())"
```

If you’re seeing AMD64, you’ve likely downloaded the wrong Python version. Download the version linked above which is a version for WOS.

Now that we’re within our virtual environment let’s quickly pip install the necessary modules we’ll need to develop the application.

```powershell
pip install onnxruntime-qnn
pip install notebook
pip install numpy
pip install tokenizers
```

*Part 2: Building the Foundation*

**Quick Recap**

In Part 1, we assumed you just bought a new Snapdragon X Elite. We walked through all the essential setup steps, not just for this app but really to do anything meaningful on the platform.

Before building anything great we need ensure we start with a strong foundation, here we’ll take care of all the plumbing.

**Sanity Checks**

Let’s first check again to make sure we’re within the correct Python environment. This is important because if the Python environment isn’t set up for Windows on Snapdragon, we won’t be able to use Hexagon NPU.

Let’s quickly do this by running,

**import** platform

```
arch = platform.machine()
sys = platform.system()
processor = platform.processor()
print(f"{arch}\n{sys}\n{processor}")
```

**Output**:

<<  
ARM64  
Windows  
ARMv8 (64-bit) Family 8 Model 1 Revision 201, Qualcomm Technologies Inc  
\>>

Let’s be sure that we are able to import all the necessary modules,

**import**  onnxruntime  **as** ort  
**import** os  
**import**  numpy  **as** np

**from**  pathlib  **import** Path  
**from**  tokenizers  **import** Tokenizer

With everything set up and tools ready to do some work, the stage is set and we’re ready to begin……... kind of.

**Plumbing**

Before diving in, let’s establish the paths we’ll need for execution, including the parent directory, Hexagon driver, the various.onnx files, and tokenizer mapping.

We’ll establish the path to our root directory and onnxruntime-qnn directory. The onnxruntime-qnn directory is necessary because when we pip install onnxruntime-qnn we also downloaded the driver needed to run on Hexagon.

```
root_dir = Path.cwd().parent.parent
root_dir
```

**Output:**

```
<< WindowsPath('C:/Users/DFS/Desktop/gitrepo/qnn_sample_apps') >>

onnx_root = Path(ort.__file__).parent
onnx_root
```

**Output:**

```
<< WindowsPath('C:/Users/DFS/Desktop/gitrepo/env_arm64/Lib/site-packages/onnxruntime') >>
```

Then all of the model graphs as well as tokenizer.json

```
# Subdirectory where all .onnx dependencies are located
model_subdirectory = "qnn-deepseek-r1-distill-qwen-7b"

# The embeddings model is entry point, use netron to visualize
model_name = "deepseek_r1_7b_embeddings_quant_v1.0.onnx"

# This graph is used to process initial prompt, initial sequence length max(64 tokens)
context_model = "deepseek_r1_7b_ctx_v1.0.onnx_ctx.onnx"

# This graph is used to perform next word inference after the initial prompt
context_model_iter = "deepseek_r1_7b_iter_v1.0.onnx_ctx.onnx"

# This graph allows us to take hidden states and return logits
head_model = "deepseek_r1_7b_head_quant_v1.0.onnx"

# Tokenizer
tokenizer_json = "tokenizer.json"
```

Okay, we’ll solidify all paths now

```
model_path = root_dir/"models"/model_subdirectory/model_name
ctx_path = root_dir/"models"/model_subdirectory/context_model
ctx_path_itr = root_dir/"models"/model_subdirectory/context_model_iter
head_path = root_dir/"models"/model_subdirectory/head_model
tokenizer_path = root_dir/"models"/model_subdirectory/tokenizer_json
config_path = root_dir/"models"/model_subdirectory/configuration_json
hexagon_driver = onnx_root/"capi"/"QnnHtp.dll"
```

Part 3: Integrating Hexagon with ONNX Runtime for Accelerated Inference

**Quick Recap**

In Part 2, we did some quick sanity checks to make sure that we were using the correct Python version, specifically one compatible with Windows on Snapdragon. Afterwards, we checked that all the necessary modules were imported and finally setup paths to necessary files and directories.

**Hexagon Configuration**

Although we won’t use any ONNX Runtime specific configurations for this DeepSeek Application, let us instantiate session options in case you want to explore that later.

```
session_options = ort.SessionOptions()
```

Now, we’ll configure the Hexagon specific configurations via a variable called qnn\_provider\_options.

This is where we set up our backend path, identify the soc type, performance mode, profiling, and whether we want to use graph optimization. More options can be found in the QNN Execution Provider docs on the ONNX Runtime website.

```
qnn_provider_options = {
    "backend_path": hexagon_driver,
    # https://onnxruntime.ai/docs/execution-providers/QNN-ExecutionProvider.html#configuration-options
    "htp_performance_mode": "burst",
    "soc_model": "60",
    
    "profiling_level": "detailed",
    "profiling_file_path": root_dir/"models"/model_subdirectory/"profiling_deepseek_7b.csv"
    "htp_graph_finalization_optimization_mode": "2",
}
```

**Inference Sessions**

Now that we’ve added our QNN provider options, let us now move on to creating our different inference sessions.

Due to the model’s size, the full graph is split into four smaller, more manageable parts.

```
embedding_session = ort.InferenceSession(model_path,
                                providers= [("QNNExecutionProvider",qnn_provider_options)],
                               sess_options= session_options
                              )

ctx_session = ort.InferenceSession(ctx_path,
                                    providers=[("QNNExecutionProvider",qnn_provider_options)],
                                    sess_options= session_options
                                        )

ctx_session = ort.InferenceSession(ctx_path,
                                    providers=[("QNNExecutionProvider",qnn_provider_options)],
                                    sess_options= session_options
                                        )

head_session = ort.InferenceSession(head_path,
                                providers= [("QNNExecutionProvider",qnn_provider_options)],
                               sess_options= session_options
                              )
```

We’ll then just print out get\_providers() to make sure we’re able to see the QNNExecutionProvider.

```
embedding_session.get_providers()
```

**Output:**

<< \['QNNExecutionProvider', 'CPUExecutionProvider'\] >>

If you don’t see the QNNExecutionProvider in the list you’re likely using the wrong Python version or pointing to the Hexagon Driver.

Part 4: DeepSeek Model Deployment and Execution

**Recap**

In Part 3, we configured Hexagon NPU and we established our connections to the different ONNX graphs we’ll use to perform inference.

Now, we’ll put everything together and get our LLM running on Hexagon NPU.

**Tokenizing and Initializing**

The first action item is to load the tokenizer.json file into the Tokenizer module. This file contains the complete vocabulary size and maps tokens to their respective token ID.

```
tokenizer = Tokenizer.from_file(str(tokenizer_path))
```

Now let’s decide what we should do as an initial query ….

Well, I think we should ask the LLM why it believes LLMs should be run locally,

init\_query **\=** "<｜User｜>\\nImagine you are a cyber security professional. Provide step by step reasons why AI models should be ran locally. Please consider all aspects of data privacy and cyber security\\n<｜Assistant｜><think>\\n"

Okay I admit, maybe this is leading the “witness” a little bit. I’m still sure it’ll make a compelling argument.

Now we should encode this initial query then we can take a peek at the encoding ids,

```
encoding = tokenizer.encode(init_query)

print("Token IDs:", encoding.ids)
```

**Output:**

```
<<
Token IDs: [151646, 151644, 198, 51057, 498, 525, 264, 20847, 4763, 6584, 13, 39565, 3019, 553, 3019, 7966, 3170, 15235, 4119, 1265, 387, 10613, 23490, 13, 5209, 2908, 678, 13566, 315, 821, 12345, 323, 20847, 4763, 198, 151645, 151648, 198]
>>
```

Let’s now store the token IDs to be used later,

```
input_ids = encoding.ids
input_ids = np.array([input_ids], dtype=np.int64)
input_ids.shape
```

**Output:**

```
<<
(1, 38)
>>
```

We’re now ready to pass these input IDs to the embedding\_session, remember this layer expects (batch, seq\_len) which we have verified above.

```
embedding_output = embedding_session.run(None, {"input_ids":input_ids})[0]
print("(batch, sequence length, embedding dimension)")
embedding_output.shape
```

**Output:**

```
<<
(batch, sequence length, embedding dimension)
(1, 38, 3584)
>>
```

Okay and our output is as expected. We’ve passed our token IDs through the embedding matrix and the result is the vector embedding associated with each token. In other word each of our token IDs now have an embedding vector of dimension 3584.

Before getting knee-deep in the weeds let’s define some key variables that we’ll use throughout the rest of the application. These variables will probably be different depending on which model and model size you use, these values are for 7B.

```
# Preparing inputs for prompt

# Number of input sequences processed simultaneously
batch_size = 1

# Current sequence length for initial prompt (number of tokens in current sequence)
seq_len = embedding_output.shape[1]

# Dimensionality of each token embedding vector
hidden_size = embedding_output.shape[2]

# Number of attention heads in each transformer layer
num_heads = 28

# Size of each attention head (should be hidden_size // num_heads)
attn_head_size = 128 # e.g. 1536/12 = 128

# Total number of transformer layers
num_layers = 28

# This is NOT the model's full context window (131072), this is the max number of tokens passed in the first forward pass
max_seq_len = 64

# Sampling temperature for softmax-based logit scaling
temp = 0.7

# Number of key/value heads (used for grouped query attention, may be < num_heads)
num_key_value_heads = 4
```

Last but not least, for this section let’s initialize an empty KV cache for each transformer layer.

```
# Let's initialize our KV cache for all transformer layers
empty_kv = {}
for i in range(num_layers):
    # Shape of key and value tensors for each transformer layer
    past_shape = (batch_size, num_key_value_heads, max_seq_len, attn_head_size)

    # Initialize past keys for layer i (used in attention mechanism to avoid recomputation
    empty_kv[f"past_keys_{i}"] = np.zeros(past_shape, dtype=np.float32)

    # Initialize past values for layer i
    empty_kv[f"past_values_{i}"] = np.zeros(past_shape, dtype=np.float32)

len(empty_kv)
```

**Output:**

```
<<
56
>>

empty_kv.keys()
```

**Output:**

```
<<
dict_keys(['past_keys_0', 'past_values_0', 'past_keys_1', 'past_values_1', 'past_keys_2', 'past_values_2', 'past_keys_3', 'past_values_3', 'past_keys_4', 'past_values_4', 'past_keys_5', 'past_values_5', 'past_keys_6', 'past_values_6', 'past_keys_7', 'past_values_7', 'past_keys_8', 'past_values_8', 'past_keys_9', 'past_values_9', 'past_keys_10', 'past_values_10', 'past_keys_11', 'past_values_11', 'past_keys_12', 'past_values_12', 'past_keys_13', 'past_values_13', 'past_keys_14', 'past_values_14', 'past_keys_15', 'past_values_15', 'past_keys_16', 'past_values_16', 'past_keys_17', 'past_values_17', 'past_keys_18', 'past_values_18', 'past_keys_19', 'past_values_19', 'past_keys_20', 'past_values_20', 'past_keys_21', 'past_values_21', 'past_keys_22', 'past_values_22', 'past_keys_23', 'past_values_23', 'past_keys_24', 'past_values_24', 'past_keys_25', 'past_values_25', 'past_keys_26', 'past_values_26', 'past_keys_27', 'past_values_27'])
>>
```

In addition to the past keys/values we’ll also want to keep track of the past sequence length and total sequence length. This isn’t just for bookkeeping, the model used by ctx\_session expects us to pass this information during inference.

```
# Subtract 1 to get the index of the last token in the sequence (since indexing is 0-based)
init_sequence_length = np.array(embedding_output.shape[1]-1, dtype=np.int32).reshape(1,1)

# Set the maximum sequence length for the model's current forward pass
max_seq_length = np.array([max_seq_len], dtype=np.int32)

seq_lens = {
    "past_seq_len": init_sequence_length,
    "total_seq_len": max_seq_length 
}
seq_lens
```

**Output:**

```
<<
{'past_seq_len': array([[37]]), 'total_seq_len': array([64])}
>>
```

**Into the Belly of the Beast**

We’re finally here, the foundation is set. We understand what we need, and after this we’ll understand how we need to do it.

But first,

We’ll now pad the embedding output to go from shape size (1, 38, 3584) to (1, 64, 3584). We can find the token ID designated for padding by looking at the tokenizer.json file. This token ID is 151643.

```
batch_size, seq_len, embed_dim = embedding_output.shape
padding_id = 151643
padded_embedding = np.full((batch_size, max_seq_len[0], embed_dim), padding_id, dtype=embedding_output.dtype)

padded_embedding[:, :seq_len, :] = embedding_output
padded_embedding.shape
```

**Output:**

```
<<
(1, 64, 3584)
>>
```

And because only the paranoid survives, let’s check that our padding ID got applied to the embedding output

```
padded_embedding[:,:seq_len+1,:]
```

**Output:**

```
<<
array([[[-3.0272333e-03,  3.7840416e-03, -1.5136166e-03, ...,
          4.5743864e-03,  7.6239771e-04, -5.3367838e-03],
        [-4.2586653e-03,  2.8391103e-03,  5.6782207e-03, ...,
          3.0445447e-03,  4.5668171e-03,  2.2834085e-03],
        [ 1.7522871e-02,  1.7522871e-02,  4.6727657e-02, ...,
         -6.5324926e-03,  0.0000000e+00,  3.9194956e-02],
        ...,
        [ 3.1730570e-03, -2.1153714e-03,  8.4614856e-03, ...,
         -2.6563108e-03,  1.7708738e-03, -5.3126216e-03],
        [ 1.7522871e-02,  1.7522871e-02,  4.6727657e-02, ...,
         -6.5324926e-03,  0.0000000e+00,  3.9194956e-02],
        [ 1.5164300e+05,  1.5164300e+05,  1.5164300e+05, ...,
          1.5164300e+05,  1.5164300e+05,  1.5164300e+05]]], dtype=float32)
>>
```

\*\* Note \*\* Another approach, probably better approach, is to pad immediately after tokenization.

Then we’ll just put it all together,

```
init_prompt_inputs = {
    **empty_kv,
    **seq_lens,
    "input_hidden_states": padded_embedding,
}
```

This is what we will pass directly to ctx\_session,

```
prompt_outputs = ctx_session.run(None, init_prompt_inputs)

print("Batch, sequence length (up to max 64 tokens), embedding size")
output_hidden_states = prompt_outputs[0]
output_hidden_states.shape
```

**Output:**

```
<<
Batch, sequence length (up to max 64 tokens), embedding size
(1, 64, 3584)
>>
```

```
print("Batch, key/value heads, sequence length, head dimension (size of projection for each head)")
print("Note: Total embedding size is 1536, this is split amongst 12 attention heads")
prompt_outputs[1].shape
```

**Output:**

```
<<
Batch, key/value heads, sequence length, head dimension (size of projection for each head)
(1, 4, 64, 128)
>>
```

Now that we’ve run our initial forward pass, we now extract the freshly computed key/value tensors and initialize our KV Cache. This will serve as the starting point for all future attention computations

```
present_kv = {f"past_keys_{i}": prompt_outputs[1 + i * 2] for i in range(num_layers)}
present_kv.update({f"past_values_{i}": prompt_outputs[1 + i * 2 + 1] for i in range(num_layers)})
```

I want to pause right here to explain what’s going on because we will see this again in the autoregression loop.

The hidden states are always located at index 0 of the prompt output. Therefore, we start storing past keys/values at index 1 and iterate through all the transformer layers.

All that’s left to complete our initial forward pass is to pass the hidden states from ctx\_session and pass them through the head\_session to get our logits.

```
logits = head_session.run(None, {"output_hidden_states": output_hidden_states})[0]
logits
```

**Output:**

```
<<
array([[[ 0.4885341 ,  1.6607397 ,  1.5486224 , ..., -1.0167408 ,
         -1.030018  , -1.0079873 ],
        [-0.25004292,  0.5250312 ,  0.7671132 , ..., -1.2984138 ,
         -1.3143336 , -1.2883482 ],
        [-3.3622322 , -2.3342173 ,  0.6993563 , ..., -5.661934  ,
         -5.667201  , -5.658406  ],
        ...,
        [ 8.143536  ,  2.0092702 ,  4.6678557 , ...,  1.0106617 ,
          1.0103338 ,  1.0059891 ],
        [ 2.0986278 ,  1.1941836 ,  0.19812799, ..., -1.9375137 ,
         -1.9365011 , -1.9398892 ],
        [ 0.35625243,  1.9104402 ,  0.97467124, ..., -0.6109984 ,
         -0.5937128 , -0.6216756 ]]], dtype=float32)
>>
```

logits**.**shape

**Output:**

```
<<
(1, 64, 152064)
>>
```

The shape above corresponds to (batch, seq\_len, logits) the logits span the entire vocabulary size. In other words, we have a logit value for every token in our vocabulary and we’ll use these to predict our next token.

We could just do greedy sampling in which we say, “hey out of the giant list of logits (152064), find the highest one and we’ll use that as our next token.” But trust me, if you do this, you’re LLM will either have a develop a terrible stuttering problem or will start speaking in complete nonsense. We’re not going on the greedy route, I went the greedy route initially, and the stuff the LLM started spewing was…. interesting.

So instead of going full-greedy, we’ll introduce some knobs we can use to help tame this beast. The first knob will be temperature.

First up: Temperature

I’ll implement these two ways, using a one-liner because hey who doesn’t like a good one-liner. Then a way that’s easier to see exactly what’s happening.

```
softmax = lambda x, temperature=1: np.exp((x-np.max(x))/temperature)/np.sum(np.exp((x-np.max(x))/temperature), axis=-1)

def softmax_numpy(x: np.array, temperature: float=1) -> np.array:
    # stabilize x in case of large numbers 
    x = x - np.max(x)

    # Apply temperature
    x = x/temperature

    # Apply Softmax
    return np.exp(x)/np.sum(np.exp(x), axis=-1)
```

We’ve successfully implemented temperature.

Next up: Top K

Implementation is as follows,

```
def top_k_probas(probas: np.array, k: int=5) -> np.array:
    # Copy probas so in-place operations don't work on original variable
    probas = probas.copy()
    # Normalize probabilities
    probas /= np.sum(probas)
    # Using -probas to get in descending order
    top_indices_sorted = np.argsort(-probas)[:k]
    top_k_probas = probas[top_indices_sorted]

    # Renormalize top-k probabilites to sum to 1 (probabilites must sum to 1 to use np.random.choice
    top_k_probas /= np.sum(top_k_probas)

    # Return top k probabilities
    return top_indices_sorted, top_k_probas
```

Lastly: Repetition Penalty

```
def apply_repetition_penalty(logits, generated_ids, penalty=1.1):
    for token_id in set(generated_ids):
        logits[token_id] /= penalty
    return logits
```

We’re almost on the home stretch, let’s make our first prediction after our initial forward pass. Oh and remember we only need to grab the last token.

```
temp = 0.6
probas = softmax(logits[0,-1], temperature=temp)
next_token_id = int(np.random.choice(len(probas), p=probas)) 
next_token_id
```

**Output:**

```
<<
65004
>>

tokenizer.decode([next_token_id])
```

**Output:**

```
<<
'-aware'
>>
```

And there we have it, our next token ID based on our initial query. I only applied temperature scaling for this initial prediction but that’s it.

At this point, we have touched on all the necessary parts for inference. The final step is to tie everything together and build our autoregressive loop.

```
max_tokens = 1000
top_k = 5
generated_ids = [next_token_id]
prev_seq_len = 64

print("\nInitial Query:\n", my_query)
print("Generated:")
for _ in range(max_tokens):
    input_ids = np.array([[next_token_id]], dtype=np.int64)
    # print(tokenizer.decode(generated_ids, skip_special_tokens=True))
    print(tokenizer.decode([next_token_id], skip_special_tokens=True),end="")
    embedding_output = embedding_session.run(None, {"input_ids": input_ids})[0]

    # print(embedding_output.shape)

    lengths = {
    "past_seq_len": np.array([[prev_seq_len]], dtype=np.int32),
    "total_seq_len": np.array([prev_seq_len + 1], dtype=np.int32)
    }

    iter_inputs = {
    "input_hidden_states": embedding_output,
    **present_kv,
    **lengths,
    }

    iter_outputs = ctx_itr_session.run(None, iter_inputs)

    # Hidden states are stored in last index of iter outputs
    output_hidden_states = iter_outputs[0]

    # For output tensor update key/value layers start at index = 0 
    # NOTE: Remember output of ctx_itr_session has output_hidden_states at 0th index, start with 1
    present_kv = {f"past_keys_{i}": iter_outputs[1 + i * 2] for i in range(num_layers)}
    present_kv.update({f"past_values_{i}":iter_outputs[1 + i * 2 + 1] for i in range(num_layers)})
    logits = head_session.run(None, {"output_hidden_states": output_hidden_states})[0]

    token_logits = logits[0,-1]
    token_logits = apply_repetition_penalty(token_logits, generated_ids, penalty=1.1)
    # Get probabilities
    probas = softmax(token_logits, temperature=temp)
    top_indices, top_probas = top_k_probas(probas, k=top_k) 
    next_token_id = int(np.random.choice(top_indices, p=top_probas)) #int(np.argmax(probas))
    generated_ids.append(next_token_id)
    prev_seq_len += 1

    if next_token_id == tokenizer.token_to_id("< | end_of_sentence | >"):
        break

output_text = tokenizer.decode(generated_ids, skip_special_tokens=True)
print("*"*100)
```

AND FOR THE FINALE!!!!

**Output:**

<<

Initial Query:

<｜User｜>

Imagine you are a cyber security professional. Provide step by step reasons why AI models should be ran locally. Please consider all aspects of data privacy and cyber security

<｜Assistant｜><think>

Generated:

\-aware AI models should be run locally to ensure data privacy and cyber security. Here are some key reasons:

1. \*\*Data Privacy\*\*: Running AI models locally means the data stays within your own network, reducing the risk of unauthorized access or breaches.
2. \*\*Compliance with Regulations\*\*: Many industries have strict data protection regulations that must be met, which is easier to do when the model runs on your local infrastructure.
3. \*\*Security\*\*: Local execution minimizes the attack surface since you don't have to worry about external servers being targets for cyber threats.
4. \*\*Privacy Preservation\*\*: Local running ensures that sensitive information isn't exposed in training datasets or during inference.
5. \*\*Regulation Adherence\*\*: Many organizations are required to maintain control over their data, which is naturally achieved by keeping AI models local.
6. \*\*Model Accountability\*\*: Local models allow better tracking of how decisions were made, enhancing transparency and accountability.
7. \*\*Compliance with NIST and GDPR\*\*: Both standards require organizations to implement measures to protect personal data, which aligns with running models locally.
8. \*\*Minimizing Third-Party Risks\*\*: By avoiding external cloud servers, you reduce potential vulnerabilities associated with third-party services.
9. \*\*Reduced Costs and Overhead\*\*: Local execution can lower operational costs compared to managing cloud resources, especially for smaller organizations.
10. \*\*Enhanced Control and Auditability\*\*: Keeping models local gives more control and makes auditing and compliance simpler.
11. \*\*Improved Data Anonymization Practices\*\*: Local models facilitate stronger anonymization techniques as needed for privacy concerns.
12. \*\*Better Collaboration with Govern bodies\*\*: Local models support smoother integration with government surveillance programs focused on domestic data.
13. \*\*Avoiding Export Controls and Restrictions\*\*: Staying local avoids issues related to exporting technology or facing international sanctions.
14. \*\*Compliance with ISO 27001 and CCP2\*\*: Both standards emphasize controlling access to sensitive information, which is achievable through local model deployment.
15. \*\*Minimized Cyber Threat Exposures\*\*: Running models locally lowers the chances of a breach impacting your critical assets.
16. \*\*Supporting Zero Trust Architecture\*\*: Local models enhance security by enforcing least privilege principles under a zero trust framework.
17. \*\*Preventing Data Leakage\*\*: Local execution reduces the chance of accidental or intentional data exposure, lowering risks of unintended sharing.
18. \*\*Facilitating Data Masking Techniques\*\*: Local models make it easier to apply masking methods like federated learning without compromising model functionality.
19. \*\*Ensuring Compliance with Payment Card Industry (PCI) Standards\*\*: Running models locally helps meet PCI DSS requirements regarding secure handling of payment card data.
20. \*\*Improving Operational Efficiency\*\*: Local deployment allows for better monitoring, optimization, and management of AI systems, boosting overall efficiency.

</think>

To ensure comprehensive data privacy and cybersecurity, AI models should ideally be executed locally rather than relying on remote servers.

</think>

\*\*Step-by-Step Explanation:\*\*

1. \*\*Understand the Importance of Data Locality\*\*:  
	\- Running AI models locally keeps all relevant data within your organization's internal networks, minimizing external exposure and threats.
2. \*\*Adhere to Data Protection Regulations\*\*:  
	\- Comply with laws like GDPR, CCPA, and PCI DSS, which mandate protecting personal data and securing financial transactions, respectively.
3. \*\*Mitigate Cyber Threats\*\*:  
	\- Local execution reduces potential attack surfaces by eliminating dependency on external servers as potential targets.
4. \*\*Preserve Sensitive Information\*\*:  
	\- Ensures that sensitive data remains encrypted and accessible only within your controlled environment, preventing unauthorized use or breaches.
5. \*\*Ensure Model Accountability\*\*:  
	\- Local models provide traceability into decision-making processes, aiding audits and ensuring fairness and transparency in outcomes.
6. \*\*Optimize Resource Utilization\*\*:  
	\- Leverage existing IT infrastructure efficiently, avoiding unnecessary costs associated with migrating workloads to public clouds.
7. \*\*Facilitate Compliance with Industry Standards\*\*:  
	\- Fulfill governance frameworks such as ISO 27001 and CCP2, which emphasize controlling access to sensitive information.
8. \*\*Enhance Security Postures\*\*:  
	\- Implement multi-layered defenses by combining local AI with additional layers like cloud-based backups and threat detection mechanisms.

By adhering to these principles, organizations not only safeguard their data but also build trust with customers and partners who value privacy and security.What are the main factors affecting the adoption of AI technologies? How does the lack of proper AI governance affect the effectiveness of AI initiatives?

The main factors influencing the adoption of AI technologies include technical complexity, cost barriers, regulatory compliance, ethical considerations, and scalability across different sectors. Additionally, inadequate AI governance leads to misalignment between AI strategy and organizational goals, resulting in ineffective AI initiatives due to poor alignment and limited measurable impact.

\>>

Well, there you have it, the LLM itself just gave you a compelling reason for running everything locally. I believe somewhere in that response it mentions specifically that Snapdragon X Elite is the best platform as well, I’m pretty sure I wasn’t hallucinating.

**Wrapping Up**

And just like that we’ve just gone through the entire process of running DeepSeek completely locally using nothing but Onnxruntime-qnn, Hexagon, and a little bit of technical knowledge. Hopefully, you leave this walkthrough with the power to create your own custom use cases for LLMs, and/or a deeper understanding of LLMs.

I encourage you to use this guide as a template, a starting point for whatever you envision and once you create something awesome, please loop us back in so we can showcase it on our Repo.

Although we went pretty deep and got a little technical with this walkthrough if you just want the ability to run locally, as you should, there are off the shelf solutions to get you up and running relatively quickly. Two companies that quickly come to mind are LM Studio and AnythingLLM.

**Now Go Build Something Cool!**

If you enjoy this format, please head over to our Discord server and suggest models you’d like to see comprehensive walkthroughs, and if you joined our live coding session you know we always have a special treat at the end.

Part 5: Deep Dive and Advanced Optimizations

**Hexagon Configurations**

Let’s talk about what each of these options are. The backend path just points to the driver for Hexagon. HTP Performance Mode determines which mode you want to run the device at, at a high level the higher the mode the more power required thus reducing battery life. Below is a chart of the different modes available,

![](_resources/8ebb0df1424e67418c40fd070b77053c_MD5.png)

Figure 1:

As you can see from the chart above, running in BURST mode uses the maximum voltage possible. Then the voltage corners go as follows, in descending order, TURBO => NOM\_PLUS => NOM => SVS\_PLUS => SVS => SVS2.

We then define the soc model, for Snapdragon X Elite the model number is 60 and this information can be found below,

![](_resources/58af8aedd4c59c2c2d677c7e633405c0_MD5.png)

Figure 2:

For this walkthrough I also enabled profiling which will provide us a detailed report of Hexagon execute events which will be saved as the path added to profiling\_file\_path.

Lastly, I’ll leave the htp\_graph\_finalization\_optimization\_mode at 2. The available options are below,

![](_resources/8eade8fdef68732b97e27d7d4e0cde38_MD5.png)

Figure 3: [https://onnxruntime.ai/docs/execution-providers/QNN-ExecutionProvider.html](https://onnxruntime.ai/docs/execution-providers/QNN-ExecutionProvider.html)

**Session Explanations**

The first of these is the embedding graph, which is relatively straightforward. This graph is relatively simple as it takes our input sequence and applies the embedding layer.

```
embedding_session = ort.InferenceSession(model_path,
                                providers= [("QNNExecutionProvider",qnn_provider_options)],
                               sess_options= session_options
                              )
```

The second graph is our initial context graph, we’ll only run this once on our initial query. This processes the embedded input from above and returns the initial hidden states as well as key and value tensors that we’ll use as the starting point of our KV cache when predicting next tokens.

```
ctx_session = ort.InferenceSession(ctx_path,
                                    providers=[("QNNExecutionProvider",qnn_provider_options)],
                                    sess_options= session_options
                                        )
```

The third graph is our context iteration graph, this will run for every next token prediction. This processes the previously predicted token along with the current KV cache. This graph returns the next predicted token as well as an updated key/value tensor that’ll be used to extend the KV cache.

```
ctx_session = ort.InferenceSession(ctx_path,
                                    providers=[("QNNExecutionProvider",qnn_provider_options)],
                                    sess_options= session_options
                                        )
```

The fourth and final graph is the model head. This graph will process the hidden states from the current iteration and return the logits. These logits will then be used to predict the next token, either updating the input sequence for next iteration or signaling the end of generation.

The fourth and final graph is the model head. This graph will process the hidden states from the current iteration and return the logits. These logits will then be used to predict the next token, either updating the input sequence for next iteration or signaling the end of generation.

**Session Inspection**

Let’s take a peek at each graph to gain an understanding of what the expected input shape/name/type and expected output shape/name/type. Remember in the [Pose Detection Walkthrough](https://www.qualcomm.com/developer/blog/2025/03/enable-pose-detection-snapdragon-x-elite-step-by-step-tutorial) we can also do this using Netron.

One thing to note, we’re only looking at the first layer of the graph. Some graphs for like the ctx/ctx\_itr actually have multiple layers. You’ll need to iterate through each layer to understand all expected inputs.

Let’s begin the inspection by looking into embedding\_session first,

```
inputs = embedding_session.get_inputs()
outputs = embedding_session.get_outputs()
input_0 = inputs[0]
output_0 = outputs[0]

print(f"Expected Input Shape: {input_0.shape}")
print(f"Expected Input Type: {input_0.type}")
print(f"Expected Input Name: {input_0.name}")
```

**Output:**

<<  
Expected Input Shape: \[1, 'seq\_len'\]  
Expected Input Type: tensor(int64)  
Expected Input Name: input\_ids  
\>>

```
print(f"Expected Output Shape: {output_0.shape}")
print(f"Expected Output Type: {output_0.type}")
print(f"Expected Output Name: {output_0.name}")
```

**Output:**

<<  
Expected Output Shape: \[1, 'seq\_len', 3584\]  
Expected Output Type: tensor(float)  
Expected Output Name: input\_hidden\_states  
\>>

As we see above, we expect the input to this graph to be (1, sequence length) and although this model has a context window of 32,768 tokens, its architecture uses a sliding attention window scheme that only attends to the most recent 64 tokens during inference

The rest of the inputs are pretty self-explanatory. The expected outputs are well, as expected. The resulting tensor has shape (batch, sequence length, embedding dimension), giving us a set of vector embeddings corresponding to each token in the input sequence.

Now let’s inspect ctx\_session

```
inputs_ctx = ctx_session.get_inputs()
outputs_ctx = ctx_session.get_outputs()
input_0_ctx = inputs_ctx[0]
output_0_ctx = outputs_ctx[0]

print(f"Expected Input Shape: {input_0_ctx.shape}")
print(f"Expected Input Type: {input_0_ctx.type}")
print(f"Expected Input Name: {input_0_ctx.name}")
```

**Output:**

<<  
Expected Input Shape: \[1, 4, 'max\_seq\_len', 128\]  
Expected Input Type: tensor(float)  
Expected Input Name: past\_keys\_0  
\>>

```
print(f"Expected Output Shape: {output_0_ctx.shape}")
print(f"Expected Output Type: {output_0_ctx.type}")
print(f"Expected Output Name: {output_0_ctx.name}")
```

**Output:**

<<  
Expected Output Shape: \[1, 64, 3584\]  
Expected Output Type: tensor(float)  
Expected Output Name: output\_hidden\_states  
\>>

The input to this session gets a little more interesting, we’ll dig into the details later. For now, just note that the input tensor shape is (batch, num\_key\_val\_heads, max\_seq\_len, attn\_head\_dim). The output? This one is relatively straightforward (batch, max\_seq\_len, embedding dimension).

Nothing too interesting happening with ctx\_itr\_session and head\_session so I’ll provide the code snippet then quickly explain the tensor shapes for both input and output.

```
inputs_ctx_itr = ctx_itr_session.get_inputs()
outputs_ctx_itr = ctx_itr_session.get_outputs()
input_0_ctx_itr = inputs_ctx_itr[0]
output_0_ctx_itr = outputs_ctx_itr[0]

print(f"Expected Input Shape: {input_0_ctx_itr.shape}")
print(f"Expected Input Type: {input_0_ctx_itr.type}")
print(f"Expected Input Name: {input_0_ctx_itr.name}")
```

**Output**:

<<  
Expected Input Shape: \[1, 1, 3584\]  
Expected Input Type: tensor(float)  
Expected Input Name: input\_hidden\_states  
\>>

```
print(f"Expected Output Shape: {output_0_ctx_itr.shape}")
print(f"Expected Output Type: {output_0_ctx_itr.type}")
print(f"Expected Output Name: {output_0_ctx_itr.name}")
```

**Output:**

<<  
Expected Output Shape: \[1, 1, 3584\]  
Expected Output Type: tensor(float)  
Expected Output Name: output\_hidden\_states  
\>>

```
inputs_head = head_session.get_inputs()
outputs_head = head_session.get_outputs()
input_0_head = inputs_head[0]
output_0_head = outputs_head[0]

print(f"Expected Input Name: {input_0_head.name}")
print(f"Expected Input Shape: {input_0_head.shape}")
print(f"Expected Input Type: {input_0_head.type}")
```

**Output:**

<<  
Expected Input Name: output\_hidden\_states  
Expected Input Shape: \[1, 'seq\_len', 3584\]  
Expected Input Type: tensor(float)  
\>>

```
print(f"Expected Output Name: {output_0_head.name}")
print(f"Expected Output Shape: {output_0_head.shape}")
print(f"Expected Output Type: {output_0_head.type}")
```

**Output:**

<<  
Expected Output Name: logits  
Expected Output Shape: \[1, 'seq\_len', 152064\]  
Expected Output Type: tensor(float)  
\>>

The input and output tensor shape to ctx\_itr\_session is (batch, token, embed\_dimension).

Then the tensor to head\_session is (batch, seq\_len, embed\_dimension) and the output tensor shape is (batch, seq\_len, vocab\_size). Just a reminder that the vocab size usually equals the number of tokens on our embedding table. Also notice that we’re outputting the raw logits.

Model Architecture

```
# Preparing inputs for prompt

# Number of input sequences processed simultaneously
batch_size = 1

# Current sequence length for initial prompt (number of tokens in current sequence)
seq_len = embedding_output.shape[1]

# Dimensionality of each token embedding vector
hidden_size = embedding_output.shape[2]

# Number of attention heads in each transformer layer
num_heads = 28

# Size of each attention head (should be hidden_size // num_heads)
attn_head_size = 128 # e.g. 1536/12 = 128

# Total number of transformer layers
num_layers = 28

# This is NOT the model's full context window (131072), this is the max number of tokens passed in the first forward pass
max_seq_len = 64

# Sampling temperature for softmax-based logit scaling
temp = 0.7

# Number of key/value heads (used for grouped query attention, may be < num_heads)
num_key_value_heads = 4
```

Let’s start from the lowest level and build up. The first thing we need to understand is that the sequence length is our initial prompt, well our initial prompt after we tokenize. After we run these tokens through our embedding layer, we’ll now have an embedding vector associated with each token.

This model is using multi-head attention, and for this particular architecture we have 28 attention heads. At a high level each head is able to extract different details from the initial sequence.

Each attention head has a size of128, this means that our embedding matrix will be projected from 3584 (our vector embedding size) to a size of 128.

If we jump down to num\_key\_value\_heads, we see that we only have 4. This is odd because we expect there to be a Query, Key, Value matrix for each attention head so this number should be 28. This model is using a scheme called Grouped Query Attention, what this means is that while each attention head will have a Query, the Key and Value will be shared. So, since we have 4 key/value heads, that means that 7 attention heads will share the same key/value head.

Then lastly, we have 28 transformer layers.

Putting it all together, we have 28 transformer layers, that each have 28 attention heads with a size of 128 which share 4 KV heads amongst them.

Understanding this architecture helps explain why DeepSeek performs well on Snapdragon X Elite. The Grouped Query Attention reduces memory bandwidth requirements which is crucial for edge inference.

**Padding**

The ctx\_session, has an expected input shape (1, 4, ’max\_seq\_len’, 128), when creating our empty kv cache we already initialized to this shape.

There is another subtle requirement on the shape of the hidden\_states that you’ll notice when exploring graph expections programmatically or using Netron.app.

The expected shape of input\_hidden\_states to ctx\_session is (1, 64, 3584).

Now, recall that after running our token IDs through the embedding layer we ended up with an embedding output of shape (1, 38, 3584) if we try to pass this directly ctx\_session we will error out due to the shape mismatch.

The remedy…… Padding.

**Sampling**

*Temperature*

What exactly is temperature you may ask? Well let’s think about what happens when the temperature increases in almost any context.

What happens to molecules as you increase the temperature? Entropy increases (i.e they start going crazy)

What happens to college students as the temperature increases? So do parties and some start to act crazy.

And finally,

What happens to your model when the temperature goes up? The model starts talking crazy, it’s more creative, more random. The probability that the token that should be selected becomes less and others have a higher chance of being selected.

I’ll implement these two ways, using a one-liner because hey who doesn’t like a good one-liner. Then a way that’s easier to see exactly what’s happening.

*Top-K*

Top K is a really simple concept. After we run softmax and obtain our huge list of probabilities we say.

“Hold up, I only want you to consider the top K probabilities from this list. Everything else, fahgetaboutit.”

So, if K = 20, we’re only going to let the model choose from the 20 most likely tokens no matter how big the vocabulary size is.

*Repetition Penalty*

It turns out DeepSeek is notorious for repeating itself during inference. We create a quick penalty function in which we penalize the logits if repetition starts to occur. This discourages the model from getting stuck in a loop.

**Autoregression Is All We Need**

Throughout the series we’ve already touched on the individual pieces we need for inference, this autoregressive loop just ties everything together and uses ctx\_itr graph instead of ctx.

Before entering the loop, we establish our max tokens, top\_k, a list that we’ll keep appending our predicted token ids and initialize our sequence length.

Here’s what we’re doing in this loop, step by step,

1. Embed our newly predicted token using embedding session
2. Update the past sequence and total sequence length.
3. Update current KV cache and lengths into the input (iter\_inputs)
4. Perform inference using ctx\_itr\_session.
5. Extract hidden states and update KV cache with new keys/values
6. Run the inference through head\_session to get latest logits.
7. Post process logits using temperature, top-k, repetition penalty, or whatever else you may add.
8. Append new token ID to generated ID list
9. Update previous sequence length, this is important for model to know how many tokens it’s already seen.
10. Also add a few print statements to see what’s happening in real time.

Snapdragon and Qualcomm branded products are products of Qualcomm Technologies, Inc. and/or its subsidiaries.