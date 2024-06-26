package API.nhyira.apivitalis.Service;


import API.nhyira.apivitalis.Entity.RotinaDiaria;
import API.nhyira.apivitalis.Entity.RotinaSemanal;
import API.nhyira.apivitalis.Exception.NaoEncontradoException;
import API.nhyira.apivitalis.Repository.RotinaSemanalRepository;
import API.nhyira.apivitalis.Repository.RotinaDiarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class RotinaDiariaService {


    private final RotinaDiarioRepository diarioRepository;

    private final RotinaSemanalService semanalService;

    public RotinaDiaria show(int id) {
        Optional<RotinaDiaria> rotinaDiario = diarioRepository.findById(id);
        rotinaDiario.orElseThrow(() -> new NaoEncontradoException("Rotina Diario"));
        return rotinaDiario.get();
    }

    public List<RotinaDiaria> showPorSemanal(int id) {
        RotinaSemanal rotinaSemanal = semanalService.show(id);
        List<RotinaDiaria> rotinaDiaria = diarioRepository.findByRotinaSemanalIdIs(rotinaSemanal);
        return rotinaDiaria;
    }

}
