# DeepDive 安装与使用指南

----------


## 一、DeepDive简介


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DeepDive 是斯坦福大学研究小组设计的一套智能化数据管理系统，旨在从大量缺乏结构的“暗数据”中挖掘出有用的、结构化的信息。该系统集成了数据提取、集成、预测等功能，能够帮助用户快速地构建出一个复杂的端到端（end-to-end）数据管道。


**系统特点**

1. DeepDive 隐藏了核心的技术算法，只需要用户给定数据流并指定必要的数据信号或特征，就能轻松地对数据进行分析。
2. DeepDive 能够使用来自各种来源的大量数据。使用 DeepDive 构建的应用程序已成功地从数百万个文档、网页、PDF、表格、数据库中提取数据。



## 二、DeepDive 安装与部署

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DeepDive 支持在 Linux 和 Mac 的终端上进行自动化安装。但其安装程序对依赖的安装支持不是很完善（尤其是在中国大陆地区）。笔者下面给出一套完整的安装解决方案，该方案在 ubuntu 14.04 (raw OS) 中测试通过。

- ### **安装依赖（注意先后顺序）** ###

  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;顺利地安装依赖（包括依赖程序和依赖库）是成功配置 DeepDive 的**关键**，但过程比较复杂，执行效果不稳定且容易出错，请务必保持耐心并仔细阅读本指南以及终端输出的相关信息

  建议首先改换阿里镜像apt源，在终端输入：

      $ sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak 
      $ sudo gedit /etc/apt/sources.list    #用自带文本编辑器修改

  把全文覆盖成如下：

      deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
      deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
      deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
      deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
      deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
      deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
      deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
      deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
      deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
      deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse

  然后再在终端配置更新源： `$ sudo apt-get update`

  接下来安装一些程序：

  **java** ： 

      $ sudo add-apt-repository ppa:webupd8team/java
      $ sudo apt-get update
      $ sudo apt-get install oracle-java8-installer

  **url** ： `$ sudo apt-get install curl`

  **git** ：  `$ sudo apt-get install git`

  **sbt** ： 点击 https://dl.bintray.com/sbt/debian/sbt-0.13.8.deb, 下载后直接打开安装

- ### **从 git.io 上获取 DeepDive 安装程序** ###

  执行：
      $ bash <(curl -fsSL git.io/getdeepdive)`

  此后会出现安装界面（以 Ubuntu 为例）：

      ### DeepDive installer for Ubuntu
      1) deepdive		      6) postgres
      2) deepdive_docker_sandbox    7) postgres_xl
      3) deepdive_example_notebook  8) run_deepdive_tests
      4) deepdive_from_release      9) spouse_example
      5) jupyter_notebook
      # Install what (enter to repeat options, a to see all, q to quit, or a number)?

  键入“1”，按回车执行，静候一段时间等待安装完成，出现如下提示：

      ## Finished installation for deepdive
      # Install what (enter to repeat options, a to see all, q to quit, or a number)? 

   > 注：如果出现安装时下载速度过慢或卡顿，可以考虑中止后再次键入命令运行，或者使用 lantern 等软件改善网络状况

- ### **安装数据库** ###

  官方建议我们安装 Postgres 数据库，可以在上面的提示后键入“6”继续安装，或者退出 DeepDive安装程序后再次输入如下命令进行安装：

      $ bash <(curl -fsSL git.io/getdeepdive) postgres

- ### **配置环境** ###

  为了后续的操作方便，建立如下三个软链接：

      $ sudo ln -s /home/John/local/bin/deepdive /bin
      $ sudo ln -s /home/John/local/bin/ddlog /bin
      $ sudo ln -s /home/John/local/bin/mindbender /bin

  >注：此处的文件路径必须是绝对路径

至此，DeepDive 的安装和部署就结束了，下面将指导如何运行第一个实例。

## 三、DeepDive 实例运行

DeepDive 官方提供了一个具有代表性的 demo，能够提取大量文章中的人物并预测其中的夫妇关系，我们不妨先来尝试运行这一个简单的实例。 （以下不妨取用户名为 John）

- ### **下载实例** ###

  在终端中输入如下命令将 demo 下载到当前工作目录：

      $ bash <(curl -fsSL git.io/getdeepdive) spouse_example

  可以看到，工作目录出现了一个名为 `spouse_example-0.8-STABLE` 的文件夹，文件夹内有几个具有明显特征的文件，如 `app.ddlog`、`deepdive.conf` 等等。为了后续操作方便，我们不妨将文件夹改名为 `spouse_example`，然后将终端路径设置到文件夹 `spouse_example/` 内。

- ### **配置实例** ###

  编辑 `spouse_example/` 中的文件 `db.url`，改为：

      postgresql://localhost/deepdive_example

  然后在终端执行初始化命令：

      $ deepdive compile

- ### **数据流导入** ###

  下载好的 demo 内部已经有了大批文章作为数据流，存放在 `spouse_example/input` 中。为了让数据流导入到本地数据库，需要执行如下操作：

      $ sudo ln -s /home/John/spouse_example/input/articles-100.tsv.bz2 /home/John/spouse_example/input/articles.tsv.bz2
      $ deepdive do articles

 > **注1**：请注意，每次使用deepdive do命令时，它都会打开要在文本编辑器中运行的命令列表。你可以不做修改，键入`Esc`键后输入“:wq”命令直接保存并退出编辑器。
 > 
 > **注2**：由于网络问题，此命令执行极慢，甚至可能永久卡顿；建议安装 lantern 或者 SSR，如果卡顿时间过长，可以尝试先按 Ctrl+C 中断后再次键入命令执行。该过程有成功率，可能需要重复多次。

- ### **数据语义处理** ###

  接下来，利用 `stanford-nlp (斯坦福大学开发的一套自然语言处理系统)` 将数据库中的文章分解成句子、单词，并且为这些词标注词性，标签等，以便识别出文章中提到的人物姓名：

      $ deepdive do sentences

      $ deepdive do spouse_candidate

  >这两个命令执行过程较长，需要耐心等待，可以先去喝杯咖啡

- ### **数据预测分析** ###

  经过上面的准备工作，终于轮到 DeepDive 运行核心的代码进行预测分析了。在终端里输入：

      $ deepdive do probabilities

命令执行结束后，我们终于可以松一口气了，整个实例已经完全运行完毕。过程比较漫长，不过这些时间得到的成果不会让你失望。

## 四、信息查询与可视化

经过了上面的一系列步骤，DeepDive 的分析工作已经完成，提取出的信息存放在了数据库中。下面我们来介绍一下如何将这些数据可视化。

- ### **数据查询** ###

  尽管可以直接在 Postgres 数据库中直接进行查询，但是人性化的 DeepDive 提供了更加方便的查询命令。

  1. **原始文章库查询**
 
     下述的命令用于查询代号为“fc6a……”的原始文章：

         $ deepdive query '?- articles("fc6ad33a-ae70-41ff-9f0e-7283f85878f6", content).' format=csv | grep -v '^$' | tail -n +16 | head

     文章代号可以参照压缩包 `/home/John/spouse_example/input/articles.tsv.bz2` 中的tsv文件（可以用 Excel 打开）

  2. **自然语言解析数据查询**
 
     下述的命令用于查询代号为“fc6a……”文章的自然语言解析后数据：

         $ deepdive query '?- sentences("fc6ad33a-   ae70-41ff-9f0e-7283f85878f6", _, _, tokens, _, _, ner_tags, _, _, _).' format=csv | grep PERSON | tail

  3. **配偶候选人查询**
 
     下述的命令用于查询代号为“fc6a……”文章中辨认出的配偶候选人：

         $ deepdive query 'name1, name2 ?-
              spouse_candidate(p1, name1, p2, name2),
              person_mention(p1, _, "fc6ad33a-ae70-41ff-9f0e-7283f85878f6", _, _, _).'

  4. **配偶预测概率查询**

     下述的命令用于查询代号为“fc6a……”文章中配偶候选人是配偶的概率：

         $ deepdive sql "
              SELECT p1.mention_text, p2.mention_text, expectation
              FROM has_spouse_label_inference i, person_mention p1, person_mention p2
              WHERE p1_id LIKE 'fc6ad33a-ae70-41ff-9f0e-7283f85878f6%'
              AND p1_id = p1.mention_id AND p2_id = p2.mention_id"

- ### **数据可视化** ###

  DeepDive 的团队开发了一套名为 `Mindbender` 的可视化工具，已伴随 DeepDive 一并安装到了系统之中。下面我们来看一下如何利用这一套工具。

- ## 另附 lantern 安装方法

  下载文件：https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb 直接点击安装

  安装成功后直接在终端中输入 `lantern`，然后一直开在后台即可。

  期间会弹出一个lantern的网页，不用在意，可以关闭
