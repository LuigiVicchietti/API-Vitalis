package API.nhyira.apivitalis.Pagamento.Service;


import API.nhyira.apivitalis.Entity.Usuario;
import API.nhyira.apivitalis.Pagamento.DTO.PagamentoMapper;
import API.nhyira.apivitalis.Pagamento.Entity.Pagamento;
import API.nhyira.apivitalis.Pagamento.DTO.PagamentoCreateEditDto;
import API.nhyira.apivitalis.Pagamento.Repository.PagamentoRepository;
import API.nhyira.apivitalis.Repository.AssinaturaRepository;
import API.nhyira.apivitalis.Repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.server.ResponseStatusException;
import java.math.BigDecimal;

import java.time.LocalDateTime;
import java.util.*;

import static com.mercadopago.MercadoPagoConfig.getAccessToken;

@Service
public class MercadoPagoService {

    private static final Logger logger = LoggerFactory.getLogger(MercadoPagoService.class);

    @Autowired
    private PagamentoRepository pagamentoRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private AssinaturaRepository assinaturaRepository;

    @Autowired
    private PagamentoMapper pagamentoMapper;

    @Value("${mercado_pago_access_token}")
    private String accessToken;

    public ResponseEntity<String> buscarPagamentos() {
        String url = "https://api.mercadopago.com/v1/payments/search";

        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
        return response;
    }


    public Map<String, Object> criarPagamento(PagamentoCreateEditDto dto) {

        Pagamento pagamento = pagamentoMapper.mapCreateDtoToEntity(dto);

        Usuario usuario = usuarioRepository.findById(dto.getUsuarioId())
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));

        List<Pagamento> pagamentosDoUsuario = pagamentoRepository.findByUsuario(usuario);
        if (!pagamentosDoUsuario.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Usuário já possui um pagamento");
        }

        RestTemplate restTemplate = new RestTemplate();
        String[] nomeSplit = usuario.getNome().split(" ", 2);
        String firstName = nomeSplit[0];
        String lastName = nomeSplit.length > 1 ? nomeSplit[1] : "";

        BigDecimal transactionAmount = BigDecimal.valueOf(pagamento.getAssinatura().getValor()).setScale(2, BigDecimal.ROUND_HALF_UP);

        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("transaction_amount", transactionAmount);
        requestBody.put("description", pagamento.getAssinatura().getNome());
        requestBody.put("payment_method_id", dto.getTipo().toString().toLowerCase());

        Map<String, Object> payer = new HashMap<>();
        payer.put("email", usuario.getEmail());
        payer.put("first_name", firstName);
        payer.put("last_name", lastName);

        Map<String, String> identification = new HashMap<>();
        identification.put("type", "CPF");
        identification.put("number", usuario.getCpf());
        payer.put("identification", identification);

        requestBody.put("payer", payer);

        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("x-idempotency-key", UUID.randomUUID().toString());

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

        String url = "https://api.mercadopago.com/v1/payments";

        try {
            ResponseEntity<Map<String, Object>> response = restTemplate.exchange(url, HttpMethod.POST, entity, new ParameterizedTypeReference<Map<String, Object>>() {});
            Map<String, Object> paymentResponse = response.getBody();

            pagamento.setDataPagamento(LocalDateTime.now());
            pagamentoRepository.save(pagamento);

            return paymentResponse;
        } catch (HttpClientErrorException e) {
            logger.error("Erro ao criar pagamento: " + e.getResponseBodyAsString(), e);
            throw new RuntimeException("Erro ao criar pagamento", e);
        } catch (Exception e) {
            logger.error("Erro ao criar pagamento: ", e);
            throw new RuntimeException("Erro ao criar pagamento", e);
        }
    }

}