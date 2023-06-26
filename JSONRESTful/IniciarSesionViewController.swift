//
//  ViewController.swift
//  JSONRESTful
//
//  Created by MacBook Pro on 21/06/23.
//

import UIKit

class IniciarSesionViewController: UIViewController {

    @IBOutlet weak var userLbl: UITextField!
    @IBOutlet weak var passwrdLbl: UITextField!
    var users = [Users]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func validarUsuario(ruta: String, completed: @escaping () -> ()) {
        let url = URL(string: ruta)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do{
                    self.users = try JSONDecoder().decode([Users].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("Error en JSON")
                }
            }
        }.resume()
    }

    @IBAction func iniciarSesionTapped(_ sender: Any) {
        let ruta = "http://localhost:3000/usuarios?"
        let usuario = userLbl.text!
        let contraseña = passwrdLbl.text!
        let url = ruta + "nombre=\(usuario)&clave=\(contraseña)"
        let crearURL = url.replacingOccurrences(of: " ", with: "%20")
        validarUsuario(ruta: crearURL){
            if self.users.count <= 0 {
                print("Nombre de usuario y/o contraseña incorrectos")
            }else{
                print("Logeo exitoso")
                
                self.performSegue(withIdentifier: "segueLogeo", sender: nil)
                for data in self.users{
                    print("id:\(data.id),nombre:\(data.nombre),nombre:\(data.email)")
                }
            }
        }
    }
}

