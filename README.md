# Promo & Preço Video Processor

Processador público e sem segredos do projeto Promo & Preço.

Responsabilidade: baixar vídeos oficiais selecionados pelo sistema principal, aplicar a marca d'água `https://promoepreco.shop/` com FFmpeg e devolver o MP4 processado para publicação automática.

## Segurança

- nenhum token do Supabase ou credencial social fica neste repositório;
- o processador consome apenas jobs temporários autorizados pelo sistema principal;
- o artefato final é temporário e deve ser removido após a publicação;
- o texto da marca d'água é fixo e não aceita entrada arbitrária.

## Marca d'água

- texto: `https://promoepreco.shop/`
- posição: rodapé centralizado
- duração: vídeo inteiro
- estilo: branco, borda/sombra escura e margem de segurança

## Execução

O workflow roda a cada 5 minutos e processa no máximo dois jobs por execução, além de aceitar execução manual e em pushes na `main`.

## Fluxo

`Promo & Preço -> job de vídeo -> GitHub Actions + FFmpeg -> MP4 marcado -> publicação -> limpeza`
