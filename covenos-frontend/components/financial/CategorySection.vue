<template>
  <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl overflow-hidden shadow-sm">
    <!-- Header -->
    <div class="px-6 py-4 border-b border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800/30">
      <div class="flex items-center justify-between">
        <div class="flex items-center space-x-3">
          <div :class="[
            'p-2 rounded-lg',
            colorClasses[color].bg,
            colorClasses[color].icon
          ]">
            <component :is="icon" class="w-5 h-5" />
          </div>
          <div>
            <h3 class="text-lg font-semibold text-gray-900 dark:text-white">{{ title }}</h3>
            <p class="text-xs text-gray-600 dark:text-gray-400">{{ description }}</p>
          </div>
        </div>
        <span :class="[
          'px-3 py-1 rounded-full text-xs font-medium',
          colorClasses[color].badge
        ]">
          {{ categories.length }} {{ categories.length === 1 ? 'categoria' : 'categorias' }}
        </span>
      </div>
    </div>

    <!-- Tabela estilo planilha -->
    <div class="overflow-x-auto">
      <table class="w-full">
        <thead>
          <tr class="bg-gray-50 dark:bg-gray-800/30 border-b border-gray-200 dark:border-gray-700">
            <th class="px-4 py-3 text-left text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider w-12">
              #
            </th>
            <th class="px-4 py-3 text-left text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider">
              Nome da Categoria
            </th>
            <th class="px-4 py-3 text-center text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider w-24">
              Ações
            </th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-200 dark:divide-gray-800">
          <!-- Loading State -->
          <tr v-if="loading">
            <td colspan="3" class="px-4 py-8 text-center">
              <div class="flex flex-col items-center">
                <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 dark:border-purple-600 mb-2"></div>
                <p class="text-sm text-gray-600 dark:text-gray-400">Carregando...</p>
              </div>
            </td>
          </tr>

          <!-- Linha para adicionar nova categoria -->
          <tr class="bg-blue-50 dark:bg-blue-900/10 hover:bg-blue-100 dark:hover:bg-blue-900/20">
            <td class="px-4 py-3 text-center text-gray-500 dark:text-gray-400">
              <PlusIcon class="w-5 h-5 mx-auto" />
            </td>
            <td class="px-4 py-3">
              <form @submit.prevent="handleCreate" class="flex gap-2">
                <input
                  v-model="newCategoryName"
                  type="text"
                  :placeholder="`Digite o nome da categoria...`"
                  :disabled="saving"
                  class="flex-1 px-3 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded text-sm text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-purple-500 focus:border-transparent disabled:opacity-50"
                  required
                />
                <button
                  type="submit"
                  :disabled="saving || !newCategoryName.trim()"
                  :class="[
                    'px-4 py-2 rounded text-sm font-medium transition-all disabled:opacity-50 disabled:cursor-not-allowed whitespace-nowrap',
                    colorClasses[color].button
                  ]"
                >
                  <span v-if="saving" class="flex items-center">
                    <svg class="animate-spin -ml-1 mr-2 h-4 w-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                      <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    Salvando...
                  </span>
                  <span v-else class="flex items-center">
                    <PlusIcon class="w-4 h-4 mr-1" />
                    Adicionar
                  </span>
                </button>
              </form>
            </td>
            <td class="px-4 py-3"></td>
          </tr>

          <!-- Lista de categorias existentes -->
          <tr
            v-for="(category, index) in categories"
            :key="category.id"
            class="hover:bg-gray-50 dark:hover:bg-gray-800/30 transition-colors"
          >
            <td class="px-4 py-3 text-center text-sm text-gray-500 dark:text-gray-400">
              {{ index + 1 }}
            </td>
            <td class="px-4 py-3">
              <span v-if="!editingId || editingId !== category.id" class="text-sm font-medium text-gray-900 dark:text-white">
                {{ category.name }}
              </span>
              <input
                v-else
                v-model="editingName"
                @blur="handleUpdate(category.id)"
                @keyup.enter="handleUpdate(category.id)"
                @keyup.esc="cancelEdit"
                type="text"
                class="w-full px-3 py-2 bg-white dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded text-sm text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-purple-500 focus:border-transparent"
                @click.stop
                autofocus
              />
            </td>
            <td class="px-4 py-3">
              <div class="flex items-center justify-center space-x-2">
                <button
                  v-if="!editingId || editingId !== category.id"
                  @click="startEdit(category)"
                  class="p-1.5 text-gray-600 dark:text-gray-400 hover:text-blue-600 dark:hover:text-purple-400 hover:bg-blue-50 dark:hover:bg-purple-900/20 rounded transition-colors"
                  title="Editar"
                >
                  <PencilIcon class="w-4 h-4" />
                </button>
                <button
                  @click="handleDelete(category.id)"
                  class="p-1.5 text-gray-600 dark:text-gray-400 hover:text-red-600 dark:hover:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20 rounded transition-colors"
                  title="Excluir"
                >
                  <TrashIcon class="w-4 h-4" />
                </button>
              </div>
            </td>
          </tr>

          <!-- Mensagem quando não há categorias -->
          <tr v-if="!loading && categories.length === 0">
            <td colspan="3" class="px-4 py-8 text-center">
              <p class="text-sm text-gray-600 dark:text-gray-400">Nenhuma categoria cadastrada</p>
              <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">Use a linha acima para adicionar uma categoria</p>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { PencilIcon, TrashIcon, PlusIcon } from '@heroicons/vue/24/outline'

const props = defineProps({
  title: String,
  description: String,
  icon: [String, Object],
  color: {
    type: String,
    default: 'blue',
    validator: (value) => ['green', 'orange', 'blue', 'purple'].includes(value)
  },
  categories: {
    type: Array,
    default: () => []
  },
  loading: Boolean,
  saving: Boolean
})

const emit = defineEmits(['create', 'update', 'delete'])

const newCategoryName = ref('')
const editingId = ref(null)
const editingName = ref('')

const colorClasses = {
  green: {
    bg: 'bg-green-100 dark:bg-green-500/10',
    icon: 'text-green-600 dark:text-green-400',
    badge: 'bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-400 border border-green-300 dark:border-green-800',
    button: 'bg-green-600 hover:bg-green-700 text-white',
    dot: 'bg-green-500 dark:bg-green-400'
  },
  orange: {
    bg: 'bg-orange-100 dark:bg-orange-500/10',
    icon: 'text-orange-600 dark:text-orange-400',
    badge: 'bg-orange-100 dark:bg-orange-900/50 text-orange-700 dark:text-orange-400 border border-orange-300 dark:border-orange-800',
    button: 'bg-orange-600 hover:bg-orange-700 text-white',
    dot: 'bg-orange-500 dark:bg-orange-400'
  },
  blue: {
    bg: 'bg-blue-100 dark:bg-blue-500/10',
    icon: 'text-blue-600 dark:text-blue-400',
    badge: 'bg-blue-100 dark:bg-blue-900/50 text-blue-700 dark:text-blue-400 border border-blue-300 dark:border-blue-800',
    button: 'bg-blue-600 hover:bg-blue-700 text-white',
    dot: 'bg-blue-500 dark:bg-blue-400'
  },
  purple: {
    bg: 'bg-purple-100 dark:bg-purple-500/10',
    icon: 'text-purple-600 dark:text-purple-400',
    badge: 'bg-purple-100 dark:bg-purple-900/50 text-purple-700 dark:text-purple-400 border border-purple-300 dark:border-purple-800',
    button: 'bg-purple-600 hover:bg-purple-700 text-white',
    dot: 'bg-purple-500 dark:bg-purple-400'
  }
}

const handleCreate = () => {
  if (!newCategoryName.value.trim()) return
  emit('create', newCategoryName.value.trim())
  newCategoryName.value = ''
}

const startEdit = (category) => {
  editingId.value = category.id
  editingName.value = category.name
}

const cancelEdit = () => {
  editingId.value = null
  editingName.value = ''
}

const handleUpdate = (id) => {
  if (editingName.value.trim() && editingName.value.trim() !== props.categories.find(c => c.id === id)?.name) {
    emit('update', id, editingName.value.trim())
  }
  cancelEdit()
}

const handleDelete = (id) => {
  if (confirm('Tem certeza que deseja excluir esta categoria?')) {
    emit('delete', id)
  }
}
</script>

