//
//  SettingsView.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 15.12.2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var sessionController : SessionController
    var settingsViewModal : SettingsViewModel
    @Binding var tabSelect : Int
   
    @State var langSelection : String = "Türkçe"
    @State var moneyTypeSelection : String = "$"
    
    private var languages : [String] = ["Türkçe","English"]
    private var moneyTypes : [String] = ["₺","$"]
    
    init(settingsViewModal: SettingsViewModel, tabSelect: Binding<Int>) {
        self.settingsViewModal = settingsViewModal
        self._tabSelect = tabSelect
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("settings",tableName: langSelection)
                .font(.title.bold())
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            HStack {
                Spacer()
                VStack(spacing: 17){
                    Text("language",tableName: langSelection)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                    Text("currency",tableName: langSelection)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                }
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(.white)
                            .opacity(0.3)
                            .frame(width: 120,height: 35)
                            .cornerRadius(.infinity)
                        Picker("Langugages", selection: $langSelection) {
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
                        Picker("Currencies", selection: $moneyTypeSelection) {
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
                    tabSelect = 0
                }else{
                    print("An error occured and save file couldn't saved!")
                }
                
            } label: {
                Text("save",tableName: langSelection)
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity)
                    .font(.body.bold())
            }
            .frame(maxWidth: .infinity)
            .background(Color("colorSaveButton"))
            .cornerRadius(10)
            .padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
            
            HStack {
                Button {
                    // TODO: İptal Button
                } label: {
                    Text("discard",tableName: langSelection)
                        .foregroundColor(.black)
                        .padding(.vertical,10)
                        .frame(maxWidth: .infinity)
                        .font(Font.headline.bold())
                }
                .frame(maxWidth: 150)
                .background(Color("colorDiscardButton"))
                .cornerRadius(10)
                .padding(.horizontal)
                Spacer()
                
            }
            
            Button {
                // TODO: LogOut
                sessionController.signOut()
                
            } label: {
                Text("logout",tableName: langSelection)
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity)
                    .font(.body.bold())
            }
            .frame(maxWidth: .infinity)
            .background(Color("colorSaveButton"))
            .cornerRadius(10)
            .padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
            
            
            
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
    
    @ObservedObject static var sett = SettingsViewModel()
    @State static var tab : Int = 0
    
    static var previews: some View {
        SettingsView(settingsViewModal: sett, tabSelect: $tab)
    }
}
