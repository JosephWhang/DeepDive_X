# DeepDive 安装与使用指南

----------


## 一、DeepDive简介


DeepDive 是斯坦福大学研究小组设计的一套智能化数据管理系统，旨在从大量缺乏结构的“暗数据”中挖掘出有用的、结构化的信息。该系统集成了数据提取、集成、预测等功能，能够帮助用户快速地构建出一个复杂的端到端（end-to-end）数据管道。


**系统特点**

1. DeepDive 隐藏了核心的技术算法，只需要用户给定数据流并指定必要的数据信号或特征，就能轻松地对数据进行分析。
2. DeepDive 能够使用各种来源的大量数据。使用 DeepDive 构建的应用程序已成功地从数百万个文档、网页、PDF、表格、数据库中提取数据。
3. DeepDive 能够使用数据来“远距离”学习。大多数机器学习系统需要对每个预测进行繁琐的训练。但是许多 DeepDive 应用程序，特别是在早期阶段，无需传统的训练数据。
4. DeepDive 能够学习开发人员给定的知识，通过编写简单的规则来提高结果的质量。DeepDive 还可以考虑用户对预测正确性的反馈以改善预测。


## 二、DeepDive 安装与部署

DeepDive 支持在 Mac 和 Linux（Debian 7、8, Ubuntu 12.04, 14.04, 15.04, and 16.04） 的终端上进行自动化安装。但其安装程序对依赖的安装支持不是很完善（尤其是在中国大陆地区）。笔者下面给出一套完整的安装解决方案，该方案在 ubuntu 14.04 (raw OS) 中测试通过。

### 注：DeepDive 自动化安装脚本测试版已发布，详情请见 [自动化安装](./Autoinstall_zh.md)

- ### **安装依赖（注意先后顺序）** ###

  顺利地安装依赖（包括依赖程序和依赖库）是成功配置 DeepDive 的**关键**，但过程比较复杂，执行效果不稳定且容易出错，请务必保持耐心并仔细阅读本指南以及终端输出的相关信息

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

  **curl** ： `$ sudo apt-get install curl`

  **git** ：  `$ sudo apt-get install git`

  **sbt** ： 点击 https://dl.bintray.com/sbt/debian/sbt-0.13.8.deb, 下载后直接打开安装

- ### **从 git.io 上获取 DeepDive 安装程序** ###

  执行：

      $ bash <(curl -fsSL git.io/getdeepdive)

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

   > 注：如果出现安装时下载速度过慢或卡顿，可以考虑中止后再次键入命令运行，或者使用 lantern 等软件改善网络状况 **可以参考 [Lantern 安装](./Lantern_install.md)**

- ### **安装数据库** ###

  官方建议我们安装 Postgres 数据库，可以在上面的提示后键入“6”继续安装，或者退出 DeepDive安装程序后再次输入如下命令进行安装：

      $ bash <(curl -fsSL git.io/getdeepdive) postgres

- ### **配置环境** ###

  为了后续的操作方便，建立如下三个软链接：

      $ sudo ln -s /home/$USER/local/bin/deepdive /bin
      $ sudo ln -s /home/$USER/local/bin/ddlog /bin
      $ sudo ln -s /home/$USER/local/bin/mindbender /bin

  >注：此处的文件路径必须是绝对路径

至此，DeepDive 的安装和部署就结束了，下面将指导如何运行第一个实例。

## 三、DeepDive 实例运行

DeepDive 官方提供了一个具有代表性的 demo，能够提取大量文章中的人物并预测其中的夫妇关系，我们不妨先来尝试运行这一个简单的实例。 

- ### **下载实例** ###

  在终端中输入如下命令将 demo 下载到当前工作目录（取 `/home/$USER`）：

      $ bash <(curl -fsSL git.io/getdeepdive) spouse_example

  可以看到，工作目录出现了一个名为 `spouse_example-0.8-STABLE` 的文件夹，文件夹内有几个具有明显特征的文件，如 `app.ddlog`、`deepdive.conf` 等等。为了后续操作方便，我们不妨将文件夹改名为 `spouse_example`，然后将终端路径设置到文件夹 `spouse_example/` 内。

- ### **配置实例** ###

  编辑 `spouse_example/` 中的文件 `db.url`，改为：

      postgresql://localhost/deepdive_example

  然后在终端执行初始化命令：

      $ deepdive compile

- ### **数据流导入** ###

  下载好的 demo 内部已经有了大批文章作为数据流，存放在 `spouse_example/input` 中。为了让数据流导入到本地数据库，需要执行如下操作：

      $ sudo ln -s /home/$USER/spouse_example/input/articles-100.tsv.bz2 /home/$USER/spouse_example/input/articles.tsv.bz2

      $ deepdive do articles

  > **注1**：请注意，每次使用deepdive do命令时，它都会打开要在文本编辑器中运行的命令列表。你可以不做修改，键入`Esc`键后输入“:wq”命令直接保存并退出编辑器。
  > 
  > **注2**：由于网络问题，此命令执行极慢，甚至可能永久卡顿；建议安装 lantern 或者 SSR，如果卡顿时间过长，可以尝试先按 Ctrl+C 中断后再次键入命令执行。该过程有成功率，可能需要重复多次。

- ### **数据语义处理** ###

  接下来，利用 `stanford-nlp (斯坦福大学开发的一套自然语言处理系统)` 将数据库中的文章分解成句子、单词，并且为这些词标注词性，标签等，以便识别出文章中提到的人物姓名：

      $ deepdive do sentences

      $ deepdive do spouse_candidate

  >这两个命令执行过程较长，需要耐心等待。同时，命令会占用大量内存，为避免发生内存交换拖慢速度，请至少分配 4GB (建议8GB)  的内存供使用。

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

     文章代号可以参照压缩包 `/home/$USER/spouse_example/input/articles.tsv.bz2` 中的tsv文件（可以用 Excel 打开）

  2. **自然语言解析数据查询**
 
     下述的命令用于查询代号为“fc6a……”文章的自然语言解析后数据：

         $ deepdive query '?- sentences("fc6ad33a-ae70-41ff-9f0e-7283f85878f6", _, _, tokens, _, _, ner_tags, _, _, _).' format=csv | grep PERSON | tail

  3. **配偶候选人查询**
 
     下述的命令用于查询代号为“4385……”文章中辨认出的配偶候选人：

         $ deepdive query 'name1, name2 ?-
              spouse_candidate(p1, name1, p2, name2),
              person_mention(p1, _, "43859f9c-178c-4df5-9bc7-af2aa5c3a57f", _, _, _).'

  4. **配偶预测概率查询**

     下述的命令用于概率大于 0.5 的配偶候选人：

         $ deepdive sql "
              SELECT p1.mention_text, p2.mention_text, expectation
              FROM has_spouse_label_inference i, person_mention p1, person_mention p2
              WHERE expectation >= 0.5
              AND p1_id = p1.mention_id AND p2_id = p2.mention_id"

- ### **数据可视化** ###

  DeepDive 的团队开发了一套名为 `Mindbender` 的可视化工具，已伴随 DeepDive 一并安装到了系统之中。下面我们来看一下如何利用这一套工具。

  1. 首先将要浏览的数据和关系添加到由 Elasticsearch 驱动的搜索索引（内置）中，执行：

         $ mindbender search update

  2. 成功后，运行本地服务器，启动 GUI，放在后台运行：

         $ mindbender search gui

  3. 用浏览器打开链接 http://localhost:8000 即可开始浏览和搜索数据与关系。
  
     >关于查询字符串的语法可以参照 Elasticsearch 手册（链接为https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html#query-string-syntax）

至此，整个项目的安装、运行与检验都已经介绍完毕。用户如果想进一步挖掘 DeepDive 的特性与功能或者希望自己完整定制 app 的话，可以参考 DeepDive 的官方文档，地址是 http://deepdive.stanford.edu/#documentation ，也可以和笔者合作交流。

## Q&A

**1. 为什么在安装或者运行的时候终端会卡住不动，甚至长达数十分钟？**

   &nbsp;&nbsp;&nbsp;&nbsp;A：很大程度上源于网络问题；尤其是 sbt 工具的配置异常缓慢。可以考虑用 VPN 改善网络环境，或者搜索一些关于 sbt 加速的方法。另外，不建议用终端 `apt` 命令自动安装 sbt 工具。

**2. 在运行命令 `$ sudo apt-get update` 过程中出错中断？**

   &nbsp;&nbsp;&nbsp;&nbsp;A：更换镜像源（如163、ali）可以解决该问题

**3. Linux 没有 GUI 环境如何安装 deb 包？**

   &nbsp;&nbsp;&nbsp;&nbsp;A：利用命令 `$ wget -c http://www.example/package.deb` 下载，之后运行命令 `$ dpkg -i package.deb` 安装。

**4. 执行 `$ bash <(curl -fsSL git.io/getdeepdive)` 进行安装的时候出错？**

   &nbsp;&nbsp;&nbsp;&nbsp;A：如果是超时错误，建议改善网络环境或者重复执行命令进行安装；如果非超时错误，请检查你的安装的 Linux 版本（目前仅支持 Debian 7 and 8, Ubuntu 12.04, 14.04, 15.04, and 16.04），如非支持版本可能会出现依赖包的缺失问题。

**5. 执行 `$ mindbender search update` 时出现 `role "root" does not exist` 或者 `database "deepdive_spouse_root" does not exist` 错误？**

   &nbsp;&nbsp;&nbsp;&nbsp;A：根据观察，该错误源于 DeepDive 系统与 mindbender 系统之间的互动方式缺陷。因此，在运行 app 之前要首先修改 `db.url` 文件中的数据库路径，尤其注意路径中不可以出现 `$USER` 字眼。

**6. 进行数据查询的时候显示空结果？**

   &nbsp;&nbsp;&nbsp;&nbsp;A：首先检查查询语句是否过于严苛或者指向不存在的文章id、人物id等，导致无匹配项；另外可以运行 mindbender 参看数据库情况。如果空结果仍然存在，先检查链接`/home/$USER/spouse_example/input/articles.tsv.bz2` 是否指向明确，之后可以考虑重新进行数据分析。

----------

**笔者邮箱**：wakafa@126.com

**参考文献：**

> DeepDive 官方文档：http://deepdive.stanford.edu/#documentation
> 
> mindbender 项目：https://github.com/HazyResearch/mindbender
> 
> sbt 官方下载链接：http://www.scala-sbt.org/0.13/docs/Installing-sbt-on-Linux.html
> 
> java安装：http://blog.csdn.net/hanshileiai/article/details/46968275
> 
> 阿里源更换：http://blog.csdn.net/jinguangliu/article/details/46539639

