# Task: Implement a class named 'RangeList' 
# A pair of integers define a range, for example: [1, 5). This range includes integers: 1, 2, 3, and 4. 
# A range list is an aggregate of these ranges: [1, 5), [10, 11), [100, 201) 
# NOTE: Feel free to add any extra member variables/functions you like. 
#!/usr/bin/ruby
# -*- coding: UTF-8 -*-

$rangeArray = Array.new # 全局数组，用于存储区间各个元素值

class RangeList
  # 添加操作：range 范围数组
  def add(range)
    if check(range)
      # 增加区间：根据入参转换成对应的数组，使用...运算符，不会取到上限值
      addArray = Array(range.first...range.last)
      # 取增加区间和全局数组的并集作为最后的结果，并进行排序
      $rangeArray = (addArray | $rangeArray).sort
    end
  end
  
  # 移除操作：range 范围数组
  def remove(range)
    if check(range)
      # 临时区间：根据入参转换成对应的数组
      tempArray = Array(range.first...range.last)
      # 真正要移除的元素集合：取临时区间和全局数组的交集，获取要移除的元素
      removeArray = tempArray & $rangeArray
      # 执行移除操作后排序
      $rangeArray = ($rangeArray - removeArray).sort	
    end
  end
  
  # 打印操作：用于打印出最后的结果
  def print
    showRes = ""
    # slice_when: 针对顺序元素x,y，当y!=x+1时，说明到了当前分区tempArray的最后一个数字x，此时需要对元素进行划分
    # each：对每一个满足slice_when条件的分区进行操作，获取当前分区tempArray的第一个数字和最后一个数字进行拼接打印
    showArray = $rangeArray.slice_when{|x,y| (y != x+1)}
                            .each{ |tempArray| (showRes += "[" + "#{tempArray.first}" + ", " + "#{(tempArray.last + 1)}" + ") ")}
    puts "#{showRes}"
  end

  # 判断入参合理性，必须为[a,b]，a < b；a=b时，操作无实际意义
  def check(range)
    if range.length == 2 and range.first < range.last
      return true
    else
      return nil
    end
  end
end

# 测试用例
# Should display: [1, 5) 
rl = RangeList.new
rl.add([1, 5])
rl.print
# Should display: [1, 5) [10, 20) 
rl.add([10, 20])
rl.print
# Should display: [1, 5) [10, 20)
rl.add([20, 20])
rl.print
# Should display: [1, 5) [10, 21) 
rl.add([20, 21])
rl.print
# Should display: [1, 5) [10, 21) 
rl.add([2, 4])
rl.print
# Should display: [1, 8) [10, 21) 
rl.add([3, 8])
rl.print
# Should display: [1, 8) [10, 21) 
rl.remove([10, 10])
rl.print
# Should display: [1, 8) [11, 21) 
rl.remove([10, 11])
rl.print
# Should display: [1, 8) [11, 15) [17, 21) 
rl.remove([15, 17])
rl.print
# Should display: [1, 3) [19, 21) 
rl.remove([3, 19])
rl.print