package API.nhyira.apivitalis.Controller;

import API.nhyira.apivitalis.DTO.Usuario.UsuarioCreateEditDto;
import API.nhyira.apivitalis.DTO.Usuario.UsuarioExibitionDto;
import API.nhyira.apivitalis.Service.CsvService;
import API.nhyira.apivitalis.Service.UsuarioService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService uService;

    @Autowired
    private CsvService csvService;

    @PostMapping
    public ResponseEntity<UsuarioExibitionDto> create(
            @RequestBody @Valid UsuarioCreateEditDto newUser
    ) {
        if (uService.cpfUnique(newUser.getCpf()) || uService.nomeUnique(newUser.getUsername()) || uService.emailUnique(newUser.getEmail())) {
            return ResponseEntity.status(409).build();
        }

        UsuarioExibitionDto user = this.uService.createUser(newUser);
        if(user == null) {
            return ResponseEntity.status(400).build();
        }

        return ResponseEntity.status(201).body(user);
    }

    @GetMapping
    public ResponseEntity<List<UsuarioExibitionDto>> showAll() {
        return uService.showAllUsers().isEmpty() ? ResponseEntity.status(204).build() : ResponseEntity.status(200).body(uService.showAllUsers());
    }

    @GetMapping("/export/csv")
    public ResponseEntity<String> exportToCsv() {
        try {
            csvService.exportUsersToCsv();
            return ResponseEntity.status(200).body("Arquivo CSV gerado com sucesso.");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Erro ao gerar o arquivo CSV.");
        }
    }



    @GetMapping("/personais")
    public ResponseEntity<List<UsuarioExibitionDto>> showAllPersonal() {
        return uService.showAllUsersPersonal().isEmpty() ? ResponseEntity.status(204).build() : ResponseEntity.status(200).body(uService.showAllUsersPersonal());
    }

    @GetMapping("/{id}")
    public ResponseEntity<UsuarioExibitionDto> showUser (
            @PathVariable int id
    ) {
        return uService.showUserById(id) == null ? ResponseEntity.status(404).build() : ResponseEntity.status(200).body(uService.showUserById(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<UsuarioExibitionDto> update(
            @PathVariable int id,
            @RequestBody @Valid UsuarioCreateEditDto updtUser
    ) {
        if (uService.cpfUnique(updtUser.getCpf()) || uService.nomeUnique(updtUser.getUsername()) || uService.emailUnique(updtUser.getEmail())) {
            return ResponseEntity.status(409).build();
        }

        UsuarioExibitionDto updatedUser = uService.updtUser(id, updtUser);
        if (updatedUser == null) {
            return ResponseEntity.status(400).build();
        }
        return ResponseEntity.status(200).body(updatedUser);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete (
            @PathVariable int id
    ) {
        return !uService.delUser(id) ? ResponseEntity.status(404).body("Usuário não encontrado!") : ResponseEntity.status(200).body("Usuário excluido com sucesso!");
    }
}