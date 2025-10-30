export default defineNuxtPlugin(({ $pinia }) => {
  // Desabilitar hidratação automática do Pinia para evitar erros de serialização
  if (import.meta.server) {
    // @ts-ignore
    $pinia._s.forEach((store) => {
      store.$subscribe = () => {}
    })
  }
})
