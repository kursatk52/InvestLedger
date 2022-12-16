//
//  SettingsView.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 15.12.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settingsViewModal : SettingsViewModel
    
    
    @State var langSelection : String = "Türkçe"
    @State var moneyTypeSelection : String = "₺"
    private var languages : [String] = ["Türkçe","English"]
    private var moneyTypes : [String] = ["₺","$"]
    
    
    
    init(settingsViewModal: SettingsViewModel) {
        self.settingsViewModal = settingsViewModal
    }
    
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Ayarlar")
                .font(.title)
                .bold(true)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            HStack {
                Spacer()
                VStack(spacing: 17){
                    Text("Dil: ")
                        .font(.title3)
                        .bold(true)
                        .foregroundColor(.white)
                    Text("Para Birimi: ")
                        .font(.title3)
                        .bold(true)
                        .foregroundColor(.white)
                }
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(.white)
                            .opacity(0.3)
                            .frame(width: 120,height: 35)
                            .cornerRadius(.infinity)
                        Picker("Dil Seçimi", selection: $langSelection) {
                            ForEach(languages, id: \.self) { elem in
                                Text(elem).foregroundColor(.red)
                            }
                        }.pickerStyle(MenuPickerStyle())
                            .tint(.black)
                        
                    }
                    
                    ZStack{
                        Rectangle()
                            .fill(.white)
                            .opacity(0.3)
                            .frame(width: 120,height: 35)
                            .cornerRadius(.infinity)
                        Picker("Para Birimi Seçimi", selection: $moneyTypeSelection) {
                            ForEach(moneyTypes, id: \.self) { elem in
                                Text(elem).foregroundColor(.red)
                            }
                        }.pickerStyle(MenuPickerStyle())
                            .tint(.black)
                    }
                }
                Spacer()
            }
            
            Button {
                // TODO: Kaydet Button
                var tempSetting = SettingsModel()
                tempSetting.currency = moneyTypeSelection
                tempSetting.lang = langSelection
                if SettingsViewModel.saveSettings(settingsModelWillSave: tempSetting){
                    settingsViewModal.settings = SettingsViewModel.loadSettings()
                }else{
                    print("An error occured and save file couldn't saved!")
                }
                
            } label: {
                Text("Kaydet")
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity)
                    .bold(true)
            }
            .frame(maxWidth: .infinity)
            .background(Color("colorSaveButton"))
            .cornerRadius(10)
            .padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
            
            HStack {
                Button {
                    // TODO: İptal Button
                } label: {
                    Text("İptal")
                        .foregroundColor(.black)
                        .padding(.vertical,10)
                        .frame(maxWidth: .infinity)
                        .bold(true)
                }
                .frame(maxWidth: 150)
                .background(Color("colorDiscardButton"))
                .cornerRadius(10)
                .padding(.horizontal)
                Spacer()
                
            }
            
            Spacer()
        }.background(LinearGradient(stops: [
            Gradient.Stop(color: Color("colorOne"),location: 0),
            Gradient.Stop(color: Color("colorTwo"), location: 0.8),
            Gradient.Stop(color: Color("colorThree"), location: 1)],startPoint: .topTrailing, endPoint: .bottomLeading))
        .onAppear(){
            langSelection = settingsViewModal.settings.lang
            moneyTypeSelection = settingsViewModal.settings.currency
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsViewModal: SettingsViewModel())
    }
}
