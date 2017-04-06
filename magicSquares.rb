require 'matrix'

m = Matrix[
 [4, 9, 2, 3, 5],
 [3, 5, 7, 4, 2],
 [8, 1, 6, 6, 2],
 [1, 1, 6, 6, 2]
]

def extractSquares(m)
 n = m.row_count()
 k = m.column_count()
 maxDegree = n # didziausias galimas kvadrato dydis
 maxDegree = k if maxDegree > k
 i = 0 #einamoji eilute
 j = 0 #einamasis stulpelis
 allSquares = Array.new
while i < n-1 do # keliaujam per visas eilutes
  currentMaxDegree = maxDegree #laikinasis didziausias laipsnis
  while j < k-1 do # keliaujam per visus stulpelius
    currentMaxDegree = (k - j) if (k-j)<maxDegree
    currentMaxDegree = (n - i) if (n-i)<currentMaxDegree
    degree = 2
    positioning = 0
    allSquares.push(Matrix[[m.[](i,j)]])
    until degree>currentMaxDegree do
      square = Matrix.rows(allSquares.last.to_a << [*2..(degree)].map{|z| m.[](degree-1+i,z-degree+positioning+j)})
      square = Matrix.columns(square.transpose.to_a << [*1..(degree)].map{|z| m.[](z-1+i, degree-1+j)})
      allSquares.push(square)
      positioning = positioning+1
      degree = degree+1
    end
    j = j+1
  end
  puts ''
  i = i+1
  j = 0
end
 return allSquares
end

def isMagicSquare(square)
  return false if square.count <= 1
  sum = 0
  tempSum = 0
  sum = square.each(:diagonal).inject(:+)
  tempSum = Matrix[*square.to_a.map(&:reverse).transpose].each(:diagonal).inject(:+)
  if tempSum == sum then
    [*0..square.row_count-1].map{|z| 
    tempSum = -1 if tempSum != square.row(z).inject(:+)
    }
    if tempSum = sum then
      [*0..square.row_count-1].map{|z| 
      tempSum = -1 if tempSum != square.column(z).inject(:+)
    }
    end
  end
  return true if tempSum == sum else return false
end

def countMagicSquares(squares)
  result = 0
  squares.each{|e| result = result + 1 if isMagicSquare(e)}
  return result
end

squares = extractSquares(m)
puts "Magiskuju kvadratu yra: #{countMagicSquares(squares)}"