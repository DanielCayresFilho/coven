<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between">
      <div>
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Saídas Analíticas</h1>
        <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">Registre as saídas de dinheiro do salão</p>
      </div>
      <button 
        @click="showCreateModal = true" 
        class="mt-4 sm:mt-0 inline-flex items-center px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg font-medium transition-all duration-200 shadow-md"
      >
        <PlusIcon class="w-5 h-5 mr-2" />
        Nova Saída
      </button>
    </div>

    <!-- Stats -->
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-4 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600 dark:text-gray-400">Total de Saídas</p>
            <p class="text-2xl font-bold text-red-600 dark:text-red-400 mt-1">{{ outs.length }}</p>
          </div>
          <div class="p-3 bg-red-100 dark:bg-red-500/10 rounded-xl">
            <ArrowTrendingDownIcon class="w-6 h-6 text-red-600 dark:text-red-400" />
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
            class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-red-500 dark:focus:border-red-500 transition-colors"
          />
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Data Final</label>
          <input
            v-model="filters.endDate"
            type="date"
            class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-red-500 dark:focus:border-red-500 transition-colors"
          />
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Tipo de Categoria</label>
          <select
            v-model="filters.categoryType"
            class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-red-500 dark:focus:border-red-500 transition-colors"
          >
            <option value="">Todos os tipos</option>
            <option value="costVariable">Custos Variáveis</option>
            <option value="fixesAccounts">Contas Fixas</option>
            <option value="investments">Investimentos</option>
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
      
      <div v-else-if="filteredOuts.length === 0" class="text-center py-16">
        <ArrowTrendingDownIcon class="w-16 h-16 mx-auto text-gray-400 dark:text-gray-600 mb-4" />
        <p class="text-lg font-medium text-gray-900 dark:text-white mb-2">Nenhuma saída encontrada</p>
        <p class="text-sm text-gray-600 dark:text-gray-400">Adicione uma nova saída para começar</p>
      </div>
      
      <div v-else class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-gray-50 dark:bg-gray-800/30 border-b border-gray-200 dark:border-gray-700">
            <tr>
              <th class="text-left py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Data</th>
              <th class="text-left py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Tipo</th>
              <th class="text-left py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Categoria</th>
              <th class="text-left py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Descrição</th>
              <th class="text-right py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Valor</th>
              <th class="text-right py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Ações</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-200 dark:divide-gray-800">
            <tr
              v-for="out in filteredOuts"
              :key="out.id"
              class="hover:bg-gray-50 dark:hover:bg-gray-800/30 transition-colors duration-150"
            >
              <td class="py-4 px-6 text-sm text-gray-700 dark:text-gray-300">
                {{ formatDate(out.date) }}
              </td>
              <td class="py-4 px-6">
                <span :class="[
                  'inline-flex items-center px-2.5 py-0.5 rounded-lg text-xs font-medium border',
                  getCategoryTypeClass(out)
                ]">
                  {{ getCategoryTypeLabel(out) }}
                </span>
              </td>
              <td class="py-4 px-6">
                <span :class="[
                  'inline-flex items-center px-2.5 py-0.5 rounded-lg text-xs font-medium',
                  getCategoryBadgeClass(out)
                ]">
                  {{ getCategoryName(out) }}
                </span>
              </td>
              <td class="py-4 px-6 text-sm text-gray-700 dark:text-gray-300">
                {{ out.description || '-' }}
              </td>
              <td class="py-4 px-6 text-right">
                <span class="text-sm font-bold text-red-600 dark:text-red-400">
                  {{ formatCurrency(out.amount) }}
                </span>
              </td>
              <td class="py-4 px-6 text-right">
                <div class="flex items-center justify-end space-x-2">
                  <button
                    @click="editOut(out)"
                    class="p-2 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-all duration-200"
                    title="Editar"
                  >
                    <PencilIcon class="w-4 h-4" />
                  </button>
                  <button
                    @click="confirmDelete(out)"
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
        <div v-if="showCreateModal || editingOut" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
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
                  {{ editingOut ? 'Editar Saída' : 'Nova Saída' }}
                </h3>
                <button @click="closeModal" class="p-2 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-colors">
                  <XMarkIcon class="w-5 h-5" />
                </button>
              </div>
              
              <form @submit.prevent="saveOut" class="p-6 space-y-4">
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Data *</label>
                  <input
                    v-model="outForm.date"
                    type="date"
                    required
                    class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-red-500 dark:focus:border-red-500 transition-colors"
                  />
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Tipo de Categoria *</label>
                  <select
                    v-model="outForm.categoryType"
                    required
                    @change="onCategoryTypeChange"
                    class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-red-500 dark:focus:border-red-500 transition-colors"
                  >
                    <option value="">Selecione o tipo</option>
                    <option value="costVariable">Custos Variáveis</option>
                    <option value="fixesAccounts">Contas Fixas</option>
                    <option value="investments">Investimentos</option>
                  </select>
                </div>
                
                <div v-if="outForm.categoryType">
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Categoria *</label>
                  <select
                    v-model="outForm.categoryId"
                    required
                    class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-red-500 dark:focus:border-red-500 transition-colors"
                  >
                    <option value="">Selecione uma categoria</option>
                    <option v-for="category in availableCategories" :key="category.id" :value="category.id">
                      {{ category.name }}
                    </option>
                  </select>
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Valor (R$) *</label>
                  <input
                    v-model.number="outForm.amount"
                    type="number"
                    step="0.01"
                    min="0"
                    required
                    class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-red-500 dark:focus:border-red-500 transition-colors"
                    placeholder="0,00"
                  />
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Descrição</label>
                  <textarea
                    v-model="outForm.description"
                    rows="3"
                    class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none focus:border-red-500 dark:focus:border-red-500 transition-colors resize-none"
                    placeholder="Descrição opcional da saída..."
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
                    class="px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg font-medium transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    <span v-if="saving" class="flex items-center">
                      <svg class="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                      </svg>
                      Salvando...
                    </span>
                    <span v-else>{{ editingOut ? 'Atualizar' : 'Salvar' }}</span>
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
        <div v-if="outToDelete" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
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
                  Tem certeza que deseja excluir esta saída? Esta ação não pode ser desfeita.
                </p>
                <div class="flex space-x-3">
                  <button 
                    @click="outToDelete = null" 
                    class="flex-1 px-4 py-2 bg-gray-800 hover:bg-gray-700 text-white rounded-lg font-medium transition-colors"
                  >
                    Cancelar
                  </button>
                  <button 
                    @click="deleteOut" 
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
  ArrowTrendingDownIcon,
  BanknotesIcon,
  CalendarIcon,
  PlusIcon,
  PencilIcon,
  TrashIcon,
  XMarkIcon,
  ExclamationTriangleIcon
} from '@heroicons/vue/24/outline'

definePageMeta({
  layout: 'default',
  middleware: 'auth'
})

useSeoMeta({
  title: 'Saídas Analíticas - Coven Beauty',
  description: 'Gerenciamento de saídas analíticas'
})

// Estado
const outs = ref([])
const costVariableCategories = ref([])
const fixesAccountsCategories = ref([])
const investmentsCategories = ref([])
const loading = ref(true)
const saving = ref(false)
const deleting = ref(false)

const filters = reactive({
  startDate: '',
  endDate: '',
  categoryType: ''
})

const showCreateModal = ref(false)
const editingOut = ref(null)
const outToDelete = ref(null)

const outForm = reactive({
  date: new Date().toISOString().split('T')[0],
  categoryType: '',
  categoryId: '',
  description: '',
  amount: 0
})

// Computed
const availableCategories = computed(() => {
  switch (outForm.categoryType) {
    case 'costVariable':
      return costVariableCategories.value
    case 'fixesAccounts':
      return fixesAccountsCategories.value
    case 'investments':
      return investmentsCategories.value
    default:
      return []
  }
})

const filteredOuts = computed(() => {
  let filtered = outs.value

  if (filters.startDate) {
    filtered = filtered.filter(out => {
      const outDate = new Date(out.date).toISOString().split('T')[0]
      return outDate >= filters.startDate
    })
  }

  if (filters.endDate) {
    filtered = filtered.filter(out => {
      const outDate = new Date(out.date).toISOString().split('T')[0]
      return outDate <= filters.endDate
    })
  }

  if (filters.categoryType) {
    filtered = filtered.filter(out => {
      switch (filters.categoryType) {
        case 'costVariable':
          return !!out.costVariableCategoryId
        case 'fixesAccounts':
          return !!out.fixesAccountsCategoryId
        case 'investments':
          return !!out.investmentsCategoryId
        default:
          return true
      }
    })
  }

  return filtered
})

const totalAmount = computed(() => {
  return outs.value.reduce((sum, out) => sum + Number(out.amount), 0)
})

const monthlyAmount = computed(() => {
  const now = new Date()
  const thisMonth = now.getMonth()
  const thisYear = now.getFullYear()
  
  return outs.value
    .filter(out => {
      const outDate = new Date(out.date)
      return outDate.getMonth() === thisMonth && outDate.getFullYear() === thisYear
    })
    .reduce((sum, out) => sum + Number(out.amount), 0)
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

const getCategoryTypeLabel = (out) => {
  if (out.costVariableCategoryId) return 'Custo Variável'
  if (out.fixesAccountsCategoryId) return 'Conta Fixa'
  if (out.investmentsCategoryId) return 'Investimento'
  return '-'
}

const getCategoryTypeClass = (out) => {
  if (out.costVariableCategoryId) return 'bg-orange-100 dark:bg-orange-900/50 text-orange-700 dark:text-orange-400 border-orange-300 dark:border-orange-800'
  if (out.fixesAccountsCategoryId) return 'bg-blue-100 dark:bg-blue-900/50 text-blue-700 dark:text-blue-400 border-blue-300 dark:border-blue-800'
  if (out.investmentsCategoryId) return 'bg-purple-100 dark:bg-purple-900/50 text-purple-700 dark:text-purple-400 border-purple-300 dark:border-purple-800'
  return ''
}

const getCategoryName = (out) => {
  return out.costVariableCategory?.name || 
         out.fixesAccountsCategory?.name || 
         out.investmentsCategory?.name || 
         '-'
}

const getCategoryBadgeClass = (out) => {
  if (out.costVariableCategoryId) return 'bg-orange-100 dark:bg-orange-900/50 text-orange-700 dark:text-orange-400 border border-orange-300 dark:border-orange-800'
  if (out.fixesAccountsCategoryId) return 'bg-blue-100 dark:bg-blue-900/50 text-blue-700 dark:text-blue-400 border border-blue-300 dark:border-blue-800'
  if (out.investmentsCategoryId) return 'bg-purple-100 dark:bg-purple-900/50 text-purple-700 dark:text-purple-400 border border-purple-300 dark:border-purple-800'
  return ''
}

const loadOuts = async () => {
  loading.value = true
  try {
    const { $api } = useNuxtApp()
    outs.value = await $api('/out-analytics')
  } catch (error) {
    console.error('Erro ao carregar saídas:', error)
    outs.value = []
  } finally {
    loading.value = false
  }
}

const loadCategories = async () => {
  try {
    const { $api } = useNuxtApp()
    const [costVariable, fixesAccounts, investments] = await Promise.all([
      $api('/financial-categories/cost-variable'),
      $api('/financial-categories/fixes-accounts'),
      $api('/financial-categories/investments')
    ])
    costVariableCategories.value = costVariable
    fixesAccountsCategories.value = fixesAccounts
    investmentsCategories.value = investments
  } catch (error) {
    console.error('Erro ao carregar categorias:', error)
  }
}

const onCategoryTypeChange = () => {
  outForm.categoryId = ''
}

const resetForm = () => {
  Object.assign(outForm, {
    date: new Date().toISOString().split('T')[0],
    categoryType: '',
    categoryId: '',
    description: '',
    amount: 0
  })
}

const editOut = (out) => {
  editingOut.value = out
  
  // Determinar o tipo de categoria
  let categoryType = ''
  let categoryId = ''
  
  if (out.costVariableCategoryId) {
    categoryType = 'costVariable'
    categoryId = out.costVariableCategoryId
  } else if (out.fixesAccountsCategoryId) {
    categoryType = 'fixesAccounts'
    categoryId = out.fixesAccountsCategoryId
  } else if (out.investmentsCategoryId) {
    categoryType = 'investments'
    categoryId = out.investmentsCategoryId
  }
  
  Object.assign(outForm, {
    date: out.date.split('T')[0],
    categoryType,
    categoryId,
    description: out.description || '',
    amount: Number(out.amount)
  })
  showCreateModal.value = true
}

const closeModal = () => {
  showCreateModal.value = false
  editingOut.value = null
  resetForm()
}

const saveOut = async () => {
  saving.value = true
  try {
    const { $api } = useNuxtApp()
    const toast = useToast()
    
    const method = editingOut.value ? 'PATCH' : 'POST'
    const url = editingOut.value ? `/out-analytics/${editingOut.value.id}` : '/out-analytics'
    
    // Montar o payload baseado no tipo de categoria
    const payload: any = {
      date: outForm.date,
      description: outForm.description,
      amount: outForm.amount
    }
    
    // Limpar todas as categorias primeiro
    payload.costVariableCategoryId = null
    payload.fixesAccountsCategoryId = null
    payload.investmentsCategoryId = null
    
    // Definir apenas a categoria selecionada
    switch (outForm.categoryType) {
      case 'costVariable':
        payload.costVariableCategoryId = outForm.categoryId
        break
      case 'fixesAccounts':
        payload.fixesAccountsCategoryId = outForm.categoryId
        break
      case 'investments':
        payload.investmentsCategoryId = outForm.categoryId
        break
    }
    
    await $api(url, {
      method,
      body: payload
    })
    
    await loadOuts()
    closeModal()
    toast.success(editingOut.value ? 'Saída atualizada!' : 'Saída criada!')
  } catch (error) {
    console.error('Erro ao salvar saída:', error)
    useToast().error(error.response?.data?.message || 'Erro ao salvar saída')
  } finally {
    saving.value = false
  }
}

const confirmDelete = (out) => {
  outToDelete.value = out
}

const deleteOut = async () => {
  deleting.value = true
  try {
    const { $api } = useNuxtApp()
    const toast = useToast()
    
    await $api(`/out-analytics/${outToDelete.value.id}`, {
      method: 'DELETE'
    })
    
    await loadOuts()
    outToDelete.value = null
    toast.success('Saída excluída!')
  } catch (error) {
    console.error('Erro ao excluir saída:', error)
    useToast().error('Erro ao excluir saída')
  } finally {
    deleting.value = false
  }
}

// Lifecycle
onMounted(async () => {
  await Promise.all([loadOuts(), loadCategories()])
})
</script>

