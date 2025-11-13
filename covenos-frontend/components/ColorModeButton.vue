<template>
  <button 
    @click="toggleColorMode" 
    class="relative p-2 rounded-lg transition-all duration-200 hover:scale-110"
    :class="[
      colorMode.preference === 'dark' 
        ? 'text-yellow-400 hover:bg-yellow-400/10' 
        : 'text-gray-700 hover:bg-gray-200 dark:text-gray-400 dark:hover:bg-gray-800/50'
    ]"
    title="Alternar tema"
  >
    <SunIcon v-if="colorMode.preference === 'dark'" class="w-5 h-5" />
    <MoonIcon v-else class="w-5 h-5" />
  </button>
</template>

<script setup lang="ts">
import { SunIcon, MoonIcon } from '@heroicons/vue/24/outline'

const colorMode = useColorMode()

const toggleColorMode = () => {
  colorMode.preference = colorMode.preference === 'dark' ? 'light' : 'dark'
}
</script>