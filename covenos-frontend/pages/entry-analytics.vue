<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between">
      <div>
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Entradas Analíticas</h1>
        <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">Registre as entradas de dinheiro do salão</p>
      </div>
      <button 
        @click="showCreateModal = true" 
        class="mt-4 sm:mt-0 inline-flex items-center px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium transition-all duration-200 shadow-md"
      >
        <PlusIcon class="w-5 h-5 mr-2" />
        Nova Entrada
      </button>
    </div>

    <!-- Stats -->
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-4 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600 dark:text-gray-400">Total de Entradas</p>
            <p class="text-2xl font-bold text-green-600 dark:text-green-400 mt-1">{{ entries.length }}</p>
          </div>
          <div class="p-3 bg-green-100 dark:bg-green-500/10 rounded-xl">
            <ArrowTrendingUpIcon class="w-6 h-6 text-green-600 dark:text-green-400" />
          </div>
        </div>
      </div>
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-4 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600 dark:text-gray-400">Valor Total</p>
            <p class="text-2xl font-bold text-gray-900 dark:text-white mt-1">{{ formatCurrency(totalAmount) }}</p>
          </div>
          <div class="p-3 bg-blue-100 dark:bg-blue-500/10 rounded-xl">
            <BanknotesIcon class="w-6 h-6 text-blue-600 dark:text-blue-400" />
          </div>
        </div>
      </div>
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-4 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600 dark:text-gray-400">Este Mês</p>
            <p class="text-2xl font-bold text-purple-600 dark:text-purple-400 mt-1">{{ formatCurrency(monthlyAmount) }}</p>
          </div>
          <div class="p-3 bg-purple-100 dark:bg-purple-500/10 rounded-xl">
            <CalendarIcon class="w-6 h-6 text-purple-600 dark:text-purple-400" />
          </div>
        </div>
      </div>
    </div>

    <!-- Filters -->
    <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-4 shadow-sm">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div>
          <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Data Inicial</label>
          <input
            v-model="filters.startDate"
            type="date"
            class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-green-500 dark:focus:border-green-500 transition-colors"
          />
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Data Final</label>
          <input
            v-model="filters.endDate"
            type="date"
            class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-green-500 dark:focus:border-green-500 transition-colors"
          />
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Categoria</label>
          <select
            v-model="filters.categoryId"
            class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-green-500 dark:focus:border-green-500 transition-colors"
          >
            <option value="">Todas as categorias</option>
            <option v-for="category in categories" :key="category.id" :value="category.id">
              {{ category.name }}
            </option>
          </select>
        </div>
      </div>
    </div>

    <!-- Table -->
    <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl overflow-hidden shadow-sm">
      <div v-if="loading" class="p-6 space-y-4">
        <div v-for="i in 5" :key="i" class="animate-pulse">
          <div class="h-16 bg-gray-200 dark:bg-gray-800/50 rounded-lg"></div>
        </div>
      </div>
      
      <div v-else-if="filteredEntries.length === 0" class="text-center py-16">
        <ArrowTrendingUpIcon class="w-16 h-16 mx-auto text-gray-400 dark:text-gray-600 mb-4" />
        <p class="text-lg font-medium text-gray-900 dark:text-white mb-2">Nenhuma entrada encontrada</p>
        <p class="text-sm text-gray-600 dark:text-gray-400">Adicione uma nova entrada para começar</p>
      </div>
      
      <div v-else class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-gray-50 dark:bg-gray-800/30 border-b border-gray-200 dark:border-gray-700">
            <tr>
              <th class="text-left py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Data</th>
              <th class="text-left py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Categoria</th>
              <th class="text-left py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Cliente</th>
              <th class="text-left py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Descrição</th>
              <th class="text-right py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Valor</th>
              <th class="text-right py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Ações</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-200 dark:divide-gray-800">
            <tr
              v-for="entry in filteredEntries"
              :key="entry.id"
              class="hover:bg-gray-50 dark:hover:bg-gray-800/30 transition-colors duration-150"
            >
              <td class="py-4 px-6 text-sm text-gray-700 dark:text-gray-300">
                {{ formatDate(entry.date) }}
              </td>
              <td class="py-4 px-6">
                <span class="inline-flex items-center px-2.5 py-0.5 rounded-lg text-xs font-medium bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-400 border border-green-300 dark:border-green-800">
                  {{ entry.entryMoneyCategory?.name }}
                </span>
              </td>
              <td class="py-4 px-6 text-sm text-gray-700 dark:text-gray-300">
                {{ entry.client?.name || '-' }}
              </td>
              <td class="py-4 px-6 text-sm text-gray-700 dark:text-gray-300">
                {{ entry.description || '-' }}
              </td>
              <td class="py-4 px-6 text-right">
                <span class="text-sm font-bold text-green-600 dark:text-green-400">
                  {{ formatCurrency(entry.amount) }}
                </span>
              </td>
              <td class="py-4 px-6 text-right">
                <div class="flex items-center justify-end space-x-2">
                  <button
                    @click="editEntry(entry)"
                    class="p-2 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-all duration-200"
                    title="Editar"
                  >
                    <PencilIcon class="w-4 h-4" />
                  </button>
                  <button
                    @click="confirmDelete(entry)"
                    class="p-2 text-gray-600 dark:text-gray-400 hover:text-red-600 dark:hover:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all duration-200"
                    title="Excluir"
                  >
                    <TrashIcon class="w-4 h-4" />
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Create/Edit Modal -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition ease-out duration-200"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition ease-in duration-150"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="showCreateModal || editingEntry" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <Transition
            enter-active-class="transition ease-out duration-200"
            enter-from-class="opacity-0 scale-95"
            enter-to-class="opacity-100 scale-100"
            leave-active-class="transition ease-in duration-150"
            leave-from-class="opacity-100 scale-100"
            leave-to-class="opacity-0 scale-95"
          >
            <div class="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 rounded-xl shadow-xl w-full max-w-lg">
              <div class="flex items-center justify-between p-6 border-b border-gray-200 dark:border-gray-800">
                <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
                  {{ editingEntry ? 'Editar Entrada' : 'Nova Entrada' }}
                </h3>
                <button @click="closeModal" class="p-2 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-colors">
                  <XMarkIcon class="w-5 h-5" />
                </button>
              </div>
              
              <form @submit.prevent="saveEntry" class="p-6 space-y-4">
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Data *</label>
                  <input
                    v-model="entryForm.date"
                    type="date"
                    required
                    class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-green-500 dark:focus:border-green-500 transition-colors"
                  />
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Categoria *</label>
                  <div class="relative">
                    <input
                      v-model="categorySearchTerm"
                      type="text"
                      placeholder="Pesquisar categoria..."
                      class="w-full px-4 py-2 pl-10 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none focus:border-green-500 dark:focus:border-green-500 transition-colors"
                    />
                    <MagnifyingGlassIcon class="w-5 h-5 text-gray-400 dark:text-gray-500 absolute left-3 top-1/2 transform -translate-y-1/2" />
                  </div>
                  <select
                    v-model="entryForm.entryMoneyCategoryId"
                    required
                    class="w-full mt-2 px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-green-500 dark:focus:border-green-500 transition-colors"
                  >
                    <option value="">Selecione uma categoria</option>
                    <option v-for="category in filteredCategories" :key="category.id" :value="category.id">
                      {{ category.name }}
                    </option>
                  </select>
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Cliente (opcional)</label>
                  <div class="relative">
                    <input
                      v-model="clientSearchTerm"
                      type="text"
                      placeholder="Pesquisar cliente..."
                      class="w-full px-4 py-2 pl-10 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none focus:border-green-500 dark:focus:border-green-500 transition-colors"
                    />
                    <MagnifyingGlassIcon class="w-5 h-5 text-gray-400 dark:text-gray-500 absolute left-3 top-1/2 transform -translate-y-1/2" />
                  </div>
                  <select
                    v-model="entryForm.clientId"
                    class="w-full mt-2 px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-green-500 dark:focus:border-green-500 transition-colors"
                  >
                    <option value="">Nenhum cliente</option>
                    <option v-for="client in filteredClients" :key="client.id" :value="client.id">
                      {{ client.name }}
                    </option>
                  </select>
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Valor (R$) *</label>
                  <input
                    v-model.number="entryForm.amount"
                    type="number"
                    step="0.01"
                    min="0"
                    required
                    class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-green-500 dark:focus:border-green-500 transition-colors"
                    placeholder="0,00"
                  />
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Descrição</label>
                  <textarea
                    v-model="entryForm.description"
                    rows="3"
                    class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none focus:border-green-500 dark:focus:border-green-500 transition-colors resize-none"
                    placeholder="Descrição opcional da entrada..."
                  ></textarea>
                </div>
                
                <div class="flex justify-end space-x-3 pt-4">
                  <button 
                    type="button" 
                    @click="closeModal" 
                    class="px-4 py-2 bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 dark:hover:bg-gray-700 text-gray-900 dark:text-white rounded-lg font-medium transition-colors"
                  >
                    Cancelar
                  </button>
                  <button 
                    type="submit" 
                    :disabled="saving"
                    class="px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    <span v-if="saving" class="flex items-center">
                      <svg class="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                      </svg>
                      Salvando...
                    </span>
                    <span v-else>{{ editingEntry ? 'Atualizar' : 'Salvar' }}</span>
                  </button>
                </div>
              </form>
            </div>
          </Transition>
        </div>
      </Transition>
    </Teleport>

    <!-- Delete Confirmation Modal -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition ease-out duration-200"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition ease-in duration-150"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="entryToDelete" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <Transition
            enter-active-class="transition ease-out duration-200"
            enter-from-class="opacity-0 scale-95"
            enter-to-class="opacity-100 scale-100"
            leave-active-class="transition ease-in duration-150"
            leave-from-class="opacity-100 scale-100"
            leave-to-class="opacity-0 scale-95"
          >
            <div class="bg-gray-900 border border-gray-800 rounded-xl shadow-xl w-full max-w-md">
              <div class="p-6">
                <div class="flex items-center justify-center w-12 h-12 bg-red-900/20 rounded-full mx-auto mb-4">
                  <ExclamationTriangleIcon class="w-6 h-6 text-red-400" />
                </div>
                <h3 class="text-lg font-semibold text-white text-center mb-2">Confirmar exclusão</h3>
                <p class="text-sm text-gray-400 text-center mb-6">
                  Tem certeza que deseja excluir esta entrada? Esta ação não pode ser desfeita.
                </p>
                <div class="flex space-x-3">
                  <button 
                    @click="entryToDelete = null" 
                    class="flex-1 px-4 py-2 bg-gray-800 hover:bg-gray-700 text-white rounded-lg font-medium transition-colors"
                  >
                    Cancelar
                  </button>
                  <button 
                    @click="deleteEntry" 
                    :disabled="deleting"
                    class="flex-1 px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg font-medium transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    <span v-if="deleting" class="flex items-center justify-center">
                      <svg class="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                      </svg>
                      Excluindo...
                    </span>
                    <span v-else>Excluir</span>
                  </button>
                </div>
              </div>
            </div>
          </Transition>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<script setup>
import { 
  ArrowTrendingUpIcon,
  BanknotesIcon,
  CalendarIcon,
  PlusIcon,
  PencilIcon,
  TrashIcon,
  XMarkIcon,
  ExclamationTriangleIcon,
  MagnifyingGlassIcon
} from '@heroicons/vue/24/outline'

definePageMeta({
  layout: 'default',
  middleware: 'auth'
})

useSeoMeta({
  title: 'Entradas Analíticas - Coven Beauty',
  description: 'Gerenciamento de entradas analíticas'
})

// Estado
const entries = ref([])
const categories = ref([])
const clients = ref([])
const loading = ref(true)
const saving = ref(false)
const deleting = ref(false)

const filters = reactive({
  startDate: '',
  endDate: '',
  categoryId: ''
})

const showCreateModal = ref(false)
const editingEntry = ref(null)
const entryToDelete = ref(null)
const categorySearchTerm = ref('')
const clientSearchTerm = ref('')

const entryForm = reactive({
  date: new Date().toISOString().split('T')[0],
  entryMoneyCategoryId: '',
  clientId: '',
  description: '',
  amount: 0
})

// Computed
const filteredEntries = computed(() => {
  let filtered = entries.value

  if (filters.startDate) {
    filtered = filtered.filter(entry => {
      const entryDate = new Date(entry.date).toISOString().split('T')[0]
      return entryDate >= filters.startDate
    })
  }

  if (filters.endDate) {
    filtered = filtered.filter(entry => {
      const entryDate = new Date(entry.date).toISOString().split('T')[0]
      return entryDate <= filters.endDate
    })
  }

  if (filters.categoryId) {
    filtered = filtered.filter(entry => entry.entryMoneyCategoryId === filters.categoryId)
  }

  return filtered
})

const totalAmount = computed(() => {
  return entries.value.reduce((sum, entry) => sum + Number(entry.amount), 0)
})

const monthlyAmount = computed(() => {
  const now = new Date()
  const thisMonth = now.getMonth()
  const thisYear = now.getFullYear()
  
  return entries.value
    .filter(entry => {
      const entryDate = new Date(entry.date)
      return entryDate.getMonth() === thisMonth && entryDate.getFullYear() === thisYear
    })
    .reduce((sum, entry) => sum + Number(entry.amount), 0)
})

const filteredCategories = computed(() => {
  if (!categorySearchTerm.value.trim()) {
    return categories.value
  }
  const term = categorySearchTerm.value.toLowerCase().trim()
  return categories.value.filter(cat => cat.name.toLowerCase().includes(term))
})

const filteredClients = computed(() => {
  if (!clientSearchTerm.value.trim()) {
    return clients.value
  }
  const term = clientSearchTerm.value.toLowerCase().trim()
  return clients.value.filter(client => client.name.toLowerCase().includes(term))
})

// Métodos
const formatCurrency = (value) => {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(value || 0)
}

const formatDate = (dateString) => {
  return new Date(dateString).toLocaleDateString('pt-BR', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  })
}

const loadEntries = async () => {
  loading.value = true
  try {
    const { $api } = useNuxtApp()
    entries.value = await $api('/entry-analytics')
  } catch (error) {
    console.error('Erro ao carregar entradas:', error)
    entries.value = []
  } finally {
    loading.value = false
  }
}

const loadCategories = async () => {
  try {
    const { $api } = useNuxtApp()
    categories.value = await $api('/financial-categories/entry-money')
  } catch (error) {
    console.error('Erro ao carregar categorias:', error)
    categories.value = []
  }
}

const loadClients = async () => {
  try {
    const { $api } = useNuxtApp()
    clients.value = await $api('/clients')
  } catch (error) {
    console.error('Erro ao carregar clientes:', error)
    clients.value = []
  }
}

const resetForm = () => {
  Object.assign(entryForm, {
    date: new Date().toISOString().split('T')[0],
    entryMoneyCategoryId: '',
    clientId: '',
    description: '',
    amount: 0
  })
}

const editEntry = (entry) => {
  editingEntry.value = entry
  Object.assign(entryForm, {
    date: entry.date.split('T')[0],
    entryMoneyCategoryId: entry.entryMoneyCategoryId,
    clientId: entry.clientId || '',
    description: entry.description || '',
    amount: Number(entry.amount)
  })
  showCreateModal.value = true
}

const closeModal = () => {
  showCreateModal.value = false
  editingEntry.value = null
  categorySearchTerm.value = ''
  clientSearchTerm.value = ''
  resetForm()
}

const saveEntry = async () => {
  saving.value = true
  try {
    const { $api } = useNuxtApp()
    const toast = useToast()
    
    const method = editingEntry.value ? 'PATCH' : 'POST'
    const url = editingEntry.value ? `/entry-analytics/${editingEntry.value.id}` : '/entry-analytics'
    
    const payload = {
      ...entryForm,
      clientId: entryForm.clientId || undefined
    }
    
    await $api(url, {
      method,
      body: payload
    })
    
    await loadEntries()
    closeModal()
    toast.success(editingEntry.value ? 'Entrada atualizada!' : 'Entrada criada!')
  } catch (error) {
    console.error('Erro ao salvar entrada:', error)
    useToast().error(error.response?.data?.message || 'Erro ao salvar entrada')
  } finally {
    saving.value = false
  }
}

const confirmDelete = (entry) => {
  entryToDelete.value = entry
}

const deleteEntry = async () => {
  deleting.value = true
  try {
    const { $api } = useNuxtApp()
    const toast = useToast()
    
    await $api(`/entry-analytics/${entryToDelete.value.id}`, {
      method: 'DELETE'
    })
    
    await loadEntries()
    entryToDelete.value = null
    toast.success('Entrada excluída!')
  } catch (error) {
    console.error('Erro ao excluir entrada:', error)
    useToast().error('Erro ao excluir entrada')
  } finally {
    deleting.value = false
  }
}

// Lifecycle
onMounted(async () => {
  await Promise.all([loadEntries(), loadCategories(), loadClients()])
})
</script>

