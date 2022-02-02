import SwiftUI

struct ColorPickerView: View {
    private var initialColor: Binding<Color>
    private var colorPickerText: String
    private var colorPickerWidth: CGFloat
    
    init(color: Binding<Color>, text: String, width: CGFloat) {
        initialColor = color
        colorPickerText = text
        colorPickerWidth = width
    }
    
    var body: some View {
        ColorPicker(colorPickerText, selection: initialColor)
            .padding()
            .frame(width: colorPickerWidth)
            .cornerRadius(Constants.cornerRadius)
            .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius).strokeBorder(.indigo))
            .mask(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(color: .constant(.indigo), text: "Damn", width: UIScreen.main.bounds.width)
    }
}
