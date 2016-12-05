//
//  BlueColorEffect.swift
//  Grade Calculator
//
//  Created by M. Ahmed on 6/20/15.
//  Copyright (c) 2015 M. Ahmed. All rights reserved.
//
//Referencing Website: http://www.google.com/design/spec/style/color.html#color-color-palette
//Greys & Yellows: 800, 700, 500, 400
//All Other Colors: 800, 600, 400, 300


import UIKit
import Foundation

private let reds: [UIColor] = [UIColor(0xC62828), UIColor(0xE53935), UIColor(0xEF5350), UIColor(0xE57373)]
private let blues: [UIColor] = [UIColor(0x1565C0), UIColor(0x1E88E5), UIColor(0x42A5F5), UIColor(0x64B5F6)]
private let cyans: [UIColor] = [UIColor(0x00838F), UIColor(0x00ACC1), UIColor(0x26C6DA), UIColor(0x4DD0E1)]
private let deepOranges: [UIColor] = [UIColor(0xD84315), UIColor(0xF4511E), UIColor(0xFF7043), UIColor(0xFF8A65)]
private let greys: [UIColor] = [UIColor(0x424242), UIColor(0x616161), UIColor(0x9E9E9E), UIColor(0xBDBDBD)]
private let blueGreys: [UIColor] = [UIColor(0x37474F), UIColor(0x546E7A), UIColor(0x78909C), UIColor(0x90A4AE)]
private let yellows: [UIColor] = [UIColor(0xF9A825), UIColor(0xFBC02D), UIColor(0xFFEB3B), UIColor(0xFFEE58)]
private let lightBlues: [UIColor] = [UIColor(0x0277BD), UIColor(0x039BE5), UIColor(0x29B6F6), UIColor(0x4FC3F7)]
private var switcher = 1
private var termsInYear = [Int]()
private let colors: [[UIColor]] = [lightBlues, reds, cyans,  blueGreys, blues, yellows, greys, deepOranges]
class ColorEffect {
   
    func populateColors(terms: [Term]) -> [UIColor]{
        var t = [UIColor]()
        var x = Int()
        var y = Int()
        var z = 1
        t.append(colors[x][y])
        while z < terms.count {
            if terms[z-1].year != terms[z].year{
                x++
                y = 0
            }
            else {
                y++
            }
            z++
            while x >= colors.count{
                x -= colors.count
            }
            if y >= colors.count {
                print("FATAL ERROR")
            }
            t.append(colors[x][y])

        }
        return t
    }
    
    
    
    
    
    
    func colorFor(i: Int) -> UIColor{ // e.g ColorEffect().colorFor(4)
        if i == 0 {
            return colors[1][0]
        }
        
        var colorInt: Int = Int(ceil(Double(i)/3))
        while colorInt >= colors.count{
            colorInt = Int(ceil(Double(colorInt)/3))
        }
        print("Section = \(i) colorInt = \(colorInt)")
        return colors[colorInt][i%4]
        
    }
    
    func blue(i: Int) -> UIColor{
        return blues[i]
    }
    func cyan(i: Int) -> UIColor{
        return cyans[i]
    }
    func red(i: Int) -> UIColor{
        return reds[i]
    }
    func deepOrange(i: Int) -> UIColor{
        return deepOranges[i]
    }
    func grey(i: Int) -> UIColor{
        return greys[i]
    }
    func blueGrey(i: Int) -> UIColor{
        return blueGreys[i]
    }
    func yellow(i: Int) -> UIColor{
        return yellows[i]
    }
    func lightBlue(i: Int) -> UIColor{
        return lightBlues[i]
    }
    
}

// UIColorHex.swift
//
//
extension UIColor {
    
    /// Initializes UIColor with an integer.
    ///
    /// - parameter value: The integer value of the color. E.g. 0xFF0000 is red, 0x0000FF is blue.
    public convenience init(_ value: Int) {
        let components = getColorComponents(value)
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: 1.0)
    }
    
    /// Initializes UIColor with an integer and alpha value.
    ///
    /// - parameter value: The integer value of the color. E.g. 0xFF0000 is red, 0x0000FF is blue.
    /// - parameter alpha: The alpha value.
    public convenience init(_ value: Int, alpha: CGFloat) {
        let components = getColorComponents(value)
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: alpha)
    }
    
    /// Creates a new color with the given alpha value
    ///
    /// For example, (0xFF0000).alpha(0.5) defines a red color with 50% opacity.
    ///
    /// - returns: A UIColor representation of the Int with the given alpha value
    public func alpha(value:CGFloat) -> UIKit.UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return UIKit.UIColor(red: red, green: green, blue: blue, alpha: value)
    }
    
    /// Mixes the color with another color
    ///
    /// - parameter color: The color to mix with
    /// - parameter amount: The amount (0-1) to mix the new color in.
    /// - returns: A new UIColor instance representing the resulting color
    public func mixWithColor(color:UIColor, amount:Float) -> UIColor {
        var comp1: [CGFloat] = Array(count: 4, repeatedValue: 0);
        self.getRed(&comp1[0], green: &comp1[1], blue: &comp1[2], alpha: &comp1[3])
        
        var comp2: [CGFloat] = Array(count: 4, repeatedValue: 0);
        color.getRed(&comp2[0], green: &comp2[1], blue: &comp2[2], alpha: &comp2[3])
        
        var comp: [CGFloat] = Array(count: 4, repeatedValue: 0);
        for i in 0...3 {
            comp[i] = comp1[i] + (comp2[i] - comp1[i]) * CGFloat(amount)
        }
        
        return UIColor(red:comp[0], green: comp[1], blue: comp[2], alpha: comp[3])
    }
}

private func getColorComponents(value: Int) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
    let r = CGFloat(value >> 16 & 0xFF) / 255.0
    let g = CGFloat(value >> 8 & 0xFF) / 255.0
    let b = CGFloat(value & 0xFF) / 255.0
    
    return (r, g, b)
}
