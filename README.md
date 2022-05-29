# MyTest
## 实际构造大量用例（百万级）时，发现利用Ruby提供的方法进行判断操作，耗时会比自定义实现的判断方法耗时长。
## 符合解释型语言的特点：程序不需要编译，程序在运行时才翻译成机器语言，每执行一次都要翻译一次。因此效率比较低。但是语法简单，开发十分方便。

### 打印方法的实现一：自行按照代码逻辑进行底层的判断实现
### 打印操作：用于打印出最后的结果
  def print 
    len = $rangeArray.length # 数组长度
    i = 0 # 下标索引
    flag = true # 标记位，用于判断是否开始新的一个区间
    showRes = "" # 打印结果
    while i < len do
      # 判断是否新开始的一组数据，增加“[”符号以及首个值及分隔符“,”
      if flag
        showRes += "[#{$rangeArray[i]},"
        flag = false
      # 1.flag为false说明正在一组连续的数值内遍历，当前值和下一个值不连续说明到了尾数区间
      # 2.遍历到最后一个参数时，会存在i + 1 = len的场景，允许数组越界
      # PS：越界时，数组返回的值为nil，能使不等式成立，仍然正常走完打印流程
      elsif $rangeArray[i] + 1 != $rangeArray[i + 1]
        showRes += " #{$rangeArray[i] + 1}) "
        flag = true
      end
      i += 1
    end
    puts showRes
  end
  
### 打印方法的实现二：利用Ruby提供的slice_when和each来进行实现
### 打印操作：用于打印出最后的结果
  def print
    showRes = ""
    # slice_when: 针对顺序元素x,y，当y!=x+1时，说明到了当前分区tempArray的最后一个数字x，此时需要对元素进行划分
    # each：对每一个满足slice_when条件的分区进行操作，获取当前分区tempArray的第一个数字和最后一个数字进行拼接打印
    showArray = $rangeArray.slice_when{|x,y| (y != x+1)}
                            .each{ |tempArray| (showRes += "[" + "#{tempArray.first}" + ", " + "#{(tempArray.last + 1)}" + ") ")}
    puts "#{showRes}"
  end
