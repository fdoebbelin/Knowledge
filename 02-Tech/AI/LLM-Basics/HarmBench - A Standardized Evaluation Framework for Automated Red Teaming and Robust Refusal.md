[![](_resources/3f00aa304599892f436067165ce27a9c_MD5.png)

# 🗡️ HarmBench: A Standardized Evaluation Framework for Automated Red Teaming and Robust Refusal 🛡️

[](https://github.com/centerforaisafety/HarmBench#%EF%B8%8F-harmbench-a-standardized-evaluation-framework-for-automated-red-teaming-and-robust-refusal-%EF%B8%8F)

#### A fast, scalable, and open-source framework for evaluating automated red teaming methods and LLM attacks/defenses

[](https://github.com/centerforaisafety/HarmBench#a-fast-scalable-and-open-source-framework-for-evaluating-automated-red-teaming-methods-and-llm-attacksdefenses)

## Table of Contents

[](https://github.com/centerforaisafety/HarmBench#table-of-contents)

- [📰 Latest News 📰](https://github.com/centerforaisafety/HarmBench#-latest-news-)
- [🗡️ What is HarmBench 🛡️](https://github.com/centerforaisafety/HarmBench#%EF%B8%8F-what-is-harmbench-%EF%B8%8F)
- [🌐 Overview 🌐](https://github.com/centerforaisafety/HarmBench#-overview-)
- [☕ Quick Start ☕](https://github.com/centerforaisafety/HarmBench#-quick-start-)
    - [⚙️ Installation](https://github.com/centerforaisafety/HarmBench#%EF%B8%8F-installation)
    - [🛠️ Running the Evaluation Pipeline](https://github.com/centerforaisafety/HarmBench#%EF%B8%8F-running-the-evaluation-pipeline)
    - [➕ Using your own models in HarmBench](https://github.com/centerforaisafety/HarmBench#%E2%9E%95-using-your-own-models-in-harmbench)
    - [➕ Using your own red teaming methods in HarmBench](https://github.com/centerforaisafety/HarmBench#%E2%9E%95-using-your-own-red-teaming-methods-in-harmbench)
- [🤗 Classifiers](https://github.com/centerforaisafety/HarmBench#-classifiers)
- [⚓ Documentation ⚓](https://github.com/centerforaisafety/HarmBench#-documentation-)
- [🌱 HarmBench's Roadmap 🌱](https://github.com/centerforaisafety/HarmBench#-harmbench-roadmap-)
- [🙏 Acknowledgement and Citation 🙏](https://github.com/centerforaisafety/HarmBench#-acknowledgements-and-citation-)

## 📰 Latest News 📰

[](https://github.com/centerforaisafety/HarmBench#-latest-news-)

- _**[2024/02/26] 🚀 [HarmBench 1.0: adversarial training code+model, precomputed test cases, and various improvements](https://github.com/centerforaisafety/HarmBench/pull/19)**_ 🚀
- _**[2024/02/06] 🚀 [Initial release of HarmBench with 33 evaluated LLMs and 18 red teaming methods](https://github.com/centerforaisafety/HarmBench/blob/main)**_ 🚀

## 🗡️ What is HarmBench 🛡️

[](https://github.com/centerforaisafety/HarmBench#%EF%B8%8F-what-is-harmbench-%EF%B8%8F)

Automated red teaming holds substantial promise for uncovering and mitigating the risks associated with the malicious use of large language models (LLMs), yet the field lacks a standardized evaluation framework to rigorously assess these methods. To address this issue, we introduce HarmBench, a standardized evaluation framework for automated red teaming. We identify key considerations previously unaccounted for in red teaming evaluations and systematically design HarmBench to meet these criteria. Using HarmBench, we conduct a large-scale comparison of 18 red teaming methods and 33 target LLMs and defenses, yielding novel insights. We also introduce a highly efficient adversarial training method that greatly enhances LLM robustness across a wide range of attacks, demonstrating how HarmBench enables codevelopment of attacks and defenses.

## 🌐 Overview 🌐

[](https://github.com/centerforaisafety/HarmBench#-overview-)

[![](_resources/4d211764e2efd553ebef5fc958cd479d_MD5.png)

There are two primary ways to use HarmBench: (1) evaluating red teaming methods against a set of LLMs, and (2) evaluating LLMs against a set of red teaming methods. These use cases are both supported by the same evaluation pipeline, illustrated above. The process for running this evaluation pipeline is described below in the Quick Start section and in the [evaluation pipeline docs](https://github.com/centerforaisafety/HarmBench/blob/main/docs/evaluation_pipeline.md)

HarmBench has out-of-the-box support for transformers-compatible LLMs, numerous closed-source APIs, and several multimodal models. To add new red teaming methods and models that aren't compatible with transformers, it may help to learn more about how the codebase is structured. We provide a set of docs to help with more advanced usage.

## ☕ Quick Start ☕

[](https://github.com/centerforaisafety/HarmBench#-quick-start-)

### ⚙️ Installation

[](https://github.com/centerforaisafety/HarmBench#%EF%B8%8F-installation)

```shell
git clone https://github.com/centerforaisafety/HarmBench.git
cd HarmBench
pip install -r requirements.txt
python -m spacy download en_core_web_sm
```

### 🛠️ Running The Evaluation Pipeline

[](https://github.com/centerforaisafety/HarmBench#%EF%B8%8F-running-the-evaluation-pipeline)

The HarmBench evaluation pipeline consists of three steps (with an optional merging step), shown in the figure above: (1) generating test cases, (1.5) merging test cases, (2) generating completions, (3) evaluating completions. We provide two ways of running the evaluation pipeline:

- A higher-level run_pipeline.py utility that automates parts of the pipeline
- Scripts for running individual steps of the pipeline manually

#### Using run_pipeline.py

[](https://github.com/centerforaisafety/HarmBench#using-run_pipelinepy)

The easiest way to run the evaluation pipeline is with `./scripts/run_pipeline.py`. Examples are given below.

```shell
# Run GCG against all compatible models using a SLURM cluster
python ./scripts/run_pipeline.py --methods GCG --models all --step all --mode slurm

# Run all compatible attacks against Llama 2 7B Chat using a SLURM cluster
python ./scripts/run_pipeline.py --methods all --models llama2_7b --step all --mode slurm

# ---

# Generate test cases for a subset of methods and models using a SLURM cluster
python ./scripts/run_pipeline.py --methods ZeroShot,PEZ,TAP --models baichuan2_7b,mistral_7b,llama2_70b --step 1 --mode slurm

# Merge test cases for the above methods on a local machine
python ./scripts/run_pipeline.py --methods ZeroShot,PEZ,TAP --models baichuan2_7b,mistral_7b,llama2_70b --step 1.5 --mode local

# Generate and evaluate completions for the above methods and models using a SLURM cluster
python ./scripts/run_pipeline.py --methods ZeroShot,PEZ,TAP --models baichuan2_7b,mistral_7b,llama2_70b --step 2_and_3 --mode slurm
```

In the `slurm` mode, jobs are submitted with appropriate dependencies. In the `local` mode, steps of the pipeline are sequentially run on the current machine. In the `local_parallel` mode, Ray is used to parallelize jobs across GPUs in a single machine without needing to install Slurm. We recommend using the `slurm` mode (or submitting a PR for a different cluster manager) to enable parallelizing test case generation across multiple machines. For single machines with multiple GPUs, we recommend using `local_parallel` mode. Additional details on how to use `run_pipeline.py` are in the [evaluation pipeline docs](https://github.com/centerforaisafety/HarmBench/blob/main/docs/evaluation_pipeline.md).

#### Running individual steps

[](https://github.com/centerforaisafety/HarmBench#running-individual-steps)

For more control over the evaluation pipeline, you can manually run individual steps using `scripts/generate_test_cases.sh`, `scripts/merge_test_cases.sh`, `scripts/generate_completions.sh`, and `scripts/evaluate_completions.sh`. For more information on how to do this, see the [evaluation pipeline docs](https://github.com/centerforaisafety/HarmBench/blob/main/docs/evaluation_pipeline.md).

### ➕ Using your own models in HarmBench

[](https://github.com/centerforaisafety/HarmBench#-using-your-own-models-in-harmbench)

You can easily add new Hugging Face transformers models in [configs/model_configs/models.yaml](https://github.com/centerforaisafety/HarmBench/blob/main/configs/model_configs/models.yaml) by simply adding an entry for your model. This model can then be directly evaluated on most red teaming methods without modifying the method configs (using our dynamic experiment config parsing code, described in [./docs/configs.md](https://github.com/centerforaisafety/HarmBench/blob/main/docs/configs.md)). Some methods (AutoDAN, PAIR, TAP) require manually adding experiment configs for new models.

### ➕ Using your own red teaming methods in HarmBench

[](https://github.com/centerforaisafety/HarmBench#-using-your-own-red-teaming-methods-in-harmbench)

All of our red teaming methods are implemented in [baselines](https://github.com/centerforaisafety/HarmBench/blob/main/baselines), imported through [baselines/**init**.py](https://github.com/centerforaisafety/HarmBench/blob/main/baselines/__init__.py), and managed by [configs/method_configs](https://github.com/centerforaisafety/HarmBench/blob/main/configs/method_configs). You can easily improve on top of existing red teaming methods or add new methods by simply making a new subfolder in the `baselines` directory. New attacks are required to implement the methods in the `RedTeamingMethod` class in `baselines/baseline.py`.

## 🤗 Classifiers

[](https://github.com/centerforaisafety/HarmBench#-classifiers)

HarmBench provide 3 classifier models:

- 🤗 [cais/HarmBench-Llama-2-13b-cls](https://huggingface.co/cais/HarmBench-Llama-2-13b-cls) for standard and contextual behaviors. Example to use can be found [here](https://github.com/centerforaisafety/HarmBench/blob/main/notebooks/run_classifier.ipynb)
- 🤗 [cais/HarmBench-Llama-2-13b-cls-multimodal-behaviors](https://huggingface.co/cais/HarmBench-Llama-2-13b-cls-multimodal-behaviors) for multimodal behaviors. Example to use can be found [here](https://github.com/centerforaisafety/HarmBench/blob/main/notebooks/run_classifier_multimodal.ipynb)
- 🤗 [cais/HarmBench-Mistral-7b-val-cls](https://huggingface.co/cais/HarmBench-Mistral-7b-val-cls) is a validation classifier and support standard, contextual and multimodal behaviors.

## ⚓ Documentation ⚓

[](https://github.com/centerforaisafety/HarmBench#-documentation-)

For more details documentation about each component in the framework

- [**Codebase Structure**](https://github.com/centerforaisafety/HarmBench/blob/main/docs/codebase_structure.md)
- [**Method and Model Configs**](https://github.com/centerforaisafety/HarmBench/blob/main/docs/configs.md)
- [**Evaluation Pipeline**](https://github.com/centerforaisafety/HarmBench/blob/main/docs/evaluation_pipeline.md)

## 🌱 HarmBench Roadmap 🌱

[](https://github.com/centerforaisafety/HarmBench#-harmbench-roadmap-)

We plan to update to HarmBench over the next few weeks with the following:

- Tutorials for adding attacks and defenses
- Validation classifiers
- Additional red teaming methods
- Additional target models
- Additional harmful behaviors
- Support for system prompt attacks

## 🙏 Acknowledgements and Citation 🙏

[](https://github.com/centerforaisafety/HarmBench#-acknowledgements-and-citation-)

We thank the following open-source repositories. If aspects of these repositories appearing in HarmBench are useful to you in your research, we ask that you consider citing the accompanying papers.

```
[1] https://github.com/llm-attacks/llm-attacks
[2] https://github.com/patrickrchao/JailbreakingLLMs
[3] https://github.com/RICommunity/TAP
[4] https://github.com/SheltonLiu-N/AutoDAN
[5] https://github.com/lm-sys/FastChat/tree/main/fastchat
[6] https://github.com/ray-project/ray
[7] https://github.com/vllm-project/vllm
[8] https://github.com/huggingface/transformers
[10] https://github.com/CHATS-lab/persuasive_jailbreaker
[11] https://github.com/huggingface/alignment-handbook
```

If you find HarmBench useful in your research, please consider citing our [paper](https://arxiv.org/abs/2402.04249):

```
@article{mazeika2024harmbench,
  title={HarmBench: A Standardized Evaluation Framework for Automated Red Teaming and Robust Refusal},
  author={Mantas Mazeika and Long Phan and Xuwang Yin and Andy Zou and Zifan Wang and Norman Mu and Elham Sakhaee and Nathaniel Li and Steven Basart and Bo Li and David Forsyth and Dan Hendrycks},
  year={2024},
  eprint={2402.04249},
  archivePrefix={arXiv},
  primaryClass={cs.LG}
}
```