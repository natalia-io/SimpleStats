//
//  SimpleStats.swift
//
//Copyright (c) 2018 Natália Mendonça <natalia@smartmood.io>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.


import Foundation

extension Array where Element == Double {
    
    ///Calculates the mean of the values of the array.
    public func mean() -> Double {
        return Double(self.reduce(0, +))/Double(self.count)
    }
    
    
    ///Calculates the mean of the values of the array.
    public func avg() -> Double {
        return Double(self.reduce(0, +))/Double(self.count)
    }
    
    ///Calculates the population variance
    public func varianceP() -> Double {
        
        return (self.map { pow($0 - self.mean(), 2.0)}.reduce(0, {$0 + $1}))/Double(self.count)
    }
    
    ///Calculates the sample variance
    public func variance() -> Double {
        
        return (self.map { pow($0 - self.mean(), 2.0)}.reduce(0, {$0 + $1}))/Double(self.count - 1)
    }
    
    
    ///Calculates the population standard deviation
    public func sdP() -> Double {
        return sqrt(self.varianceP())
    }
    
    
    ///Calculates the sample standard deviation
    public func sd() -> Double {
        return sqrt(self.variance())
    }

    
    
    ///Calculates the 95% confidence interval of the values given and returns a closed range.
    public func CI95() -> ClosedRange<Double>{
        
        let n = self.count
        let sqrtn = Double(n).squareRoot()
        let error = (self.sd()/sqrtn)*1.96
        let lowerEnd = round(100*(self.mean() - error))/100
        let upperEnd = round(100*(self.mean() + error))/100
        let CI95 = lowerEnd...upperEnd
        return CI95
    }
    
    ///Calculates the median.
    public func median() -> Double {
        var median = 0.0
        let sorted = self.sorted()
        let middle = (self.count)/2
        
        if self.count%2 == 0 {
            let middle = (self.count)/2
            median = sorted[middle]
        }
        if self.count % 2 == 1 {
            let x = sorted[middle]
            let y = sorted[middle+1]
            median = (x+y)/2.0
        }
        return median
        
    }
    
    public func standardError() -> Double {
        return self.sd() / sqrt(Double(self.count))
    }
    
    public func percentileofscore(_ score:Double, kind:String = "rank") -> Double {
        
        if score.isNaN {
            return Double.nan
        }
        let n = Double(self.count)
        if n == 0 {
            return 100.0
        }
        
        switch kind {
        case "rank":
            let left = Double(self.filter{$0 != 0 && $0 < score}.count)
            let right = Double(self.filter{$0 != 0 && $0 <= score}.count)
            let pct = (right + left + (right > left ? 1 : 0)) * 50.0/n
            return pct
        case "strict":
            return Double(self.filter{$0 != 0 && $0 < score}.count) / n * 100
        case "weak":
            return Double(self.filter{$0 != 0 && $0 <= score}.count) / n * 100
        case "mean":
            let pct = (Double(self.filter{$0 != 0 && $0 < score}.count) + Double(self.filter{$0 != 0 && $0 <= score}.count)) / n * 50
            return pct
        default:
            return Double.nan
        }
    }

    
    
}


extension Array where Element == Int {
    
    ///Calculates the mean of the values of the array.
    public func mean() -> Double {
        return Double(self.reduce(0, +))/Double(self.count)
    }
    
    
    ///Calculates the mean of the values of the array.
    public func avg() -> Double {
        return Double(self.reduce(0, +))/Double(self.count)
    }
    
    ///Calculates the population variance
    public func varianceP() -> Double {
        
        return (self.map { pow(Double($0) - self.mean(), 2.0)}.reduce(0, {$0 + $1}))/Double(self.count)
    }
    
    ///Calculates the sample variance
    public func variance() -> Double {
        
        return (self.map { pow(Double($0) - self.mean(), 2.0)}.reduce(0, {$0 + $1}))/Double(self.count - 1)
    }
    
    
    ///Calculates the population standard deviation
    public func sdP() -> Double {
        return sqrt(self.varianceP())
    }
    
    
    ///Calculates the sample standard deviation
    public func sd() -> Double {
        return sqrt(self.variance())
    }
    
    
    ///Calculates the 95% confidence interval of the values given and returns a closed range.
    public func CI95() -> ClosedRange<Double>{
        
        let n = self.count
        let sqrtn = Double(n).squareRoot()
        let error = (self.sd()/sqrtn)*1.96
        let lowerEnd = round(100*(self.mean() - error))/100
        let upperEnd = round(100*(self.mean() + error))/100
        let CI95 = lowerEnd...upperEnd
        return CI95
    }
    
    ///Calculates the median.
    public func median() -> Double {
        var median = 0.0
        let sorted = self.sorted()
        let middle = (self.count)/2
        
        if self.count%2 == 0 {
            let middle = (self.count)/2
            median = Double(sorted[middle])
        }
        if self.count%2 == 1 {
            let x = sorted[middle]
            let y = sorted[middle+1]
            median = Double((x+y))/2.0
        }
        print(self.count)
        return median
        
    }
}


extension Dictionary where Key == Double, Value == Double {
    
    ///Returns the population covariance between the dictionary keys and its values.
    public func covarianceP() -> Double {
        
        let x = Array(self.keys)
        let y = Array(self.values)
        
        var sum:Double = 0
        
        for (index, xElement) in x.enumerated() {
            let yElement = y[index]
            sum += (xElement - x.mean()) * (yElement - y.mean())
        }
        
        return sum / Double(self.count)
    }
    
    ///Returns the population covariance between the dictionary keys and its values.
    public func covariance() -> Double {
        let x = Array(self.keys)
        let y = Array(self.values)
        
        var sum:Double = 0
        
        for (index, xElement) in x.enumerated() {
            let yElement = y[index]
            sum += (xElement - x.mean()) * (yElement - y.mean())
        }
        
        return sum / Double(self.count)
    }
    
   
    ///Returns the population Pearson correlation coefficient between the dictionary keys and its values.
    public func rho() -> Double {
        let rho = (self.covarianceP())/(Array(self.keys).sdP()*Array(self.values).sdP())
        return rho
    }
    
    ///Returns the sample Pearson correlation coefficient between the dictionary keys and its values.
    public func r() -> Double {
        let r = (self.covariance())/(Array(self.keys).sd()*Array(self.values).sd())
        return r
    }
    
    
    public func degreesOfFreedom() -> Double {
        return Double((2*self.count) - 2)
    }
    
}

extension Array where Element == Array<Double> {
    
    ///Returns the average sample standard deviation of the arrays.
    public func sdMean() -> Double {
        let sds = self.map { $0.sd() }
        let x = sds.mean()
        return x
    }
    
    
    ///Returns the average population standard deviation of the arrays.
    public func sdPMean() -> Double {
        let sds = self.map { $0.sdP() }
        let x = sds.mean()
        return x
    }
    
    ///Returns the mean of the values of the array.
    public func mean() -> Double {
        let means = self.map { $0.mean() }
        let mean = means.mean()
        return mean
    }
//    let meanUD1 = yesLogs.mean().precisionOne
//    let meanNoUD1 = noLogs.mean().precisionOne
//    let sd1 = yesLogs.sd()
//    let sd2 = noLogs.sd()
//    let pooledSD = ((sd1*sd1 + sd2*sd2)/2).squareRoot()
//    cohensd = (meanUD1 - meanNoUD1) / pooledSD
    
}
