<template>
  <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 shadow-sm">
    <!-- Header -->
    <div class="flex items-center justify-between mb-6">
      <div class="flex items-center space-x-3">
        <div :class="[
          'p-3 rounded-xl',
          colorClasses[color].bg,
          colorClasses[color].icon
        ]">
          <component :is="icon" class="w-6 h-6" />
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
        {{ categories.length }}
      </span>
    </div>

    <!-- Form de criação -->
    <form @submit.prevent="handleCreate" class="mb-4">
      <div class="flex gap-2">
        <input
          v-model="newCategoryName"
          type="text"
          :placeholder="`Nova categoria (ex: Água)`"
          :disabled="saving"
          class="flex-1 px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors disabled:opacity-50"
          required
        />
        <button
          type="submit"
          :disabled="saving || !newCategoryName.trim()"
          :class="[
            'px-4 py-2 rounded-lg font-medium transition-all disabled:opacity-50 disabled:cursor-not-allowed',
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
          <span v-else>Adicionar</span>
        </button>
      </div>
    </form>

    <!-- Lista de categorias -->
    <div v-if="loading" class="space-y-2">
      <div v-for="i in 3" :key="i" class="animate-pulse">
        <div class="h-12 bg-gray-200 dark:bg-gray-800/50 rounded-lg"></div>
      </div>
    </div>

    <div v-else-if="categories.length === 0" class="text-center py-8">
      <p class="text-sm text-gray-600 dark:text-gray-400">Nenhuma categoria cadastrada</p>
      <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">Adicione uma categoria acima</p>
    </div>

    <div v-else class="space-y-2 max-h-96 overflow-y-auto">
      <div
        v-for="category in categories"
        :key="category.id"
        class="group flex items-center justify-between p-3 bg-gray-50 dark:bg-gray-800/30 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800/50 transition-colors"
      >
        <div class="flex items-center space-x-3 flex-1 min-w-0">
          <div :class="[
            'w-2 h-2 rounded-full flex-shrink-0',
            colorClasses[color].dot
          ]"></div>
          <span v-if="!editingId || editingId !== category.id" class="text-sm font-medium text-gray-900 dark:text-white truncate">
            {{ category.name }}
          </span>
          <input
            v-else
            v-model="editingName"
            @blur="handleUpdate(category.id)"
            @keyup.enter="handleUpdate(category.id)"
            @keyup.esc="cancelEdit"
            type="text"
            class="flex-1 px-2 py-1 bg-white dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded text-sm text-gray-900 dark:text-white focus:outline-none focus:border-blue-500 dark:focus:border-purple-500"
            @click.stop
          />
        </div>
        <div class="flex items-center space-x-2 flex-shrink-0">
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
      </div>
    </div>
  </div>
</template>

<script setup>
import { PencilIcon, TrashIcon } from '@heroicons/vue/24/outline'

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

