// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  devtools: { enabled: true },

  // Desabilitar SSR para evitar problemas de serialização
  // Este é um CRM interno, não precisa de SEO
  ssr: false,

  typescript: {
    typeCheck: false
  },
  
  // Módulos
  modules: [
    '@nuxtjs/tailwindcss',
    '@nuxtjs/color-mode',
    '@pinia/nuxt',
    '@vueuse/nuxt'
  ],

  // Configuração do Pinia
  pinia: {
    storesDirs: ['./stores/**'],
    disableVuex: true,
    // Desabilitar hidratação automática para evitar problemas de serialização
    autoImports: ['defineStore', 'acceptHMRUpdate']
  },

  // CSS Global
  css: [
    '~/assets/css/main.css'
  ],

  // Configuração de Color Mode (Light por padrão)
  colorMode: {
    preference: 'light',
    fallback: 'light',
    classSuffix: '',
    storageKey: 'covenos-color-mode'
  },

  // Runtime Config para API
  runtimeConfig: {
    public: {
      apiBase: (() => {
        const url = process.env.NUXT_PUBLIC_API_URL || process.env.NUXT_PUBLIC_API_BASE || 'http://localhost:3009'
        // Adicionar /api se não existir
        return url.endsWith('/api') ? url : `${url}/api`
      })(),
      appName: 'Coven Beauty'
    }
  },

  // Configuração do Head
  app: {
    head: {
      title: 'Coven Beauty - Sistema de Gestão',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { 
          name: 'description', 
          content: 'Sistema profissional de gestão para salões de beleza' 
        }
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
        { 
          rel: 'preconnect', 
          href: 'https://fonts.googleapis.com' 
        },
        { 
          rel: 'preconnect', 
          href: 'https://fonts.gstatic.com', 
          crossorigin: '' 
        },
        {
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=Creepster&family=Nosifer&family=Butcherman&family=Inter:wght@300;400;500;600;700&display=swap'
        }
      ]
    }
  },

  // Configuração de desenvolvimento
  devServer: {
    port: 3010,
    host: '0.0.0.0'
  }
})
