//
//  FirebaseBackupService.swift
//  NoteMe
//
//  Created by PavelKrm on 9.04.24.
//

import Foundation
import Storage
import FirebaseAuth
import FirebaseDatabase
import FirebaseDatabaseInternal

final class FirebaseBackupService {
    
    private var ref: DatabaseReference {
        return Database.database().reference()
    }
    
    private var userId: String? {
        return Auth.auth().currentUser?.uid
    }
    
    func backup(dto: any DTODescription) {
        guard let userId else { return }
        
        let backupModel = BackupModel(dto: dto)
        let dict = backupModel.buildDict()
        ref
            .child("notifications")
            .child(userId)
            .child(dto.id)
            .setValue(dict)
    }
    
    func loadBackup() {
        guard let userId else { return }
        ref
            .child("notifications")
            .child(userId)
            .getData { error, snapshot in
                guard
                    let snapshotDict = snapshot?.value as? [String: Any]
                else {
                    if let error {
                        print("[BACKUPSRVC]: ERROR " + error.localizedDescription)
                    } else {
                        print("[BACKUPSRVC]: ERROR snapshotDict and error is nil")
                    }
                    return
                }
                
                let value = snapshotDict.map { _, value in value }
                
                guard
                    let data = try? JSONSerialization.data(withJSONObject: value),
                    let backupModels = try? JSONDecoder().decode(
                        [BackupModel].self,
                        from: data
                    )
                else {
                    print("[BACKUPSRVC]: ERROR data or backupModel is nil")
                    return
                }
                print(backupModels)
            }
    }
}
