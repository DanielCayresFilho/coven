<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between">
      <div>
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Lembretes</h1>
        <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">Gerencie seus lembretes personalizados</p>
      </div>
    </div>

    <!-- Container único de Lembretes -->
    <div class="max-w-4xl">
      
      <!-- Container de Lembretes -->
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl shadow-sm">
        <div class="p-6 border-b border-gray-200 dark:border-gray-800">
          <div class="flex items-center justify-between">
            <div class="flex items-center space-x-3">
              <div class="p-2 bg-yellow-100 dark:bg-gradient-to-br dark:from-yellow-600 dark:to-orange-600 rounded-lg">
                <BellIcon class="w-5 h-5 text-yellow-600 dark:text-white" />
              </div>
              <div>
                <h2 class="text-xl font-semibold text-gray-900 dark:text-white">Lembretes</h2>
                <p class="text-sm text-gray-600 dark:text-gray-400">Gerencie lembretes personalizados</p>
              </div>
            </div>
            <button 
              @click="showCreateReminderModal = true"
              class="inline-flex items-center px-3 py-2 bg-yellow-500 dark:bg-gradient-to-r dark:from-yellow-600 dark:to-orange-600 text-white rounded-lg font-medium hover:bg-yellow-600 dark:hover:from-yellow-700 dark:hover:to-orange-700 transition-all duration-200 shadow-md"
            >
              <PlusIcon class="w-4 h-4 mr-2" />
              Novo Lembrete
            </button>
          </div>
        </div>

        <!-- Filtros de Lembretes -->
        <div class="p-4 border-b border-gray-200 dark:border-gray-800 bg-gray-50 dark:bg-gray-800/30">
          <div class="grid grid-cols-1 md:grid-cols-3 gap-3">
            <div>
              <select v-model="reminderFilters.status" class="w-full px-3 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white text-sm focus:outline-none focus:border-yellow-500 dark:focus:border-yellow-500 transition-colors">
                <option value="active">Ativos</option>
                <option value="inactive">Inativos</option>
                <option value="all">Todos</option>
              </select>
            </div>
            <div>
              <input
                v-model="reminderFilters.startDate"
                type="date"
                class="w-full px-3 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white text-sm focus:outline-none focus:border-yellow-500 dark:focus:border-yellow-500 transition-colors"
              />
            </div>
            <div>
              <input
                v-model="reminderFilters.endDate"
                type="date"
                class="w-full px-3 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white text-sm focus:outline-none focus:border-yellow-500 dark:focus:border-yellow-500 transition-colors"
              />
            </div>
          </div>
        </div>

        <!-- Lista de Lembretes -->
        <div class="max-h-96 overflow-y-auto">
          <div v-if="loadingReminders" class="p-6">
            <div class="animate-pulse space-y-3">
              <div v-for="i in 3" :key="i" class="bg-gray-200 dark:bg-gray-800/50 h-16 rounded-lg"></div>
            </div>
          </div>
          
          <div v-else-if="filteredReminders.length === 0" class="p-6 text-center">
            <BellIcon class="w-12 h-12 mx-auto text-gray-400 dark:text-gray-600 mb-3" />
            <p class="text-gray-600 dark:text-gray-400">Nenhum lembrete encontrado</p>
            <p class="text-sm text-gray-500 dark:text-gray-500 mt-1">Crie um novo lembrete para começar</p>
          </div>
          
          <div v-else class="p-4 space-y-3">
            <div
              v-for="reminder in filteredReminders"
              :key="reminder.id"
              class="flex items-start space-x-4 p-4 bg-gray-50 dark:bg-gray-800/30 border border-gray-200 dark:border-gray-700 rounded-lg hover:border-gray-300 dark:hover:border-gray-600 transition-all duration-200"
            >
              <div class="flex-shrink-0 mt-1">
                <div :class="[
                  'w-3 h-3 rounded-full',
                  reminder.isActive ? 'bg-yellow-500 dark:bg-yellow-400' : 'bg-gray-400 dark:bg-gray-500'
                ]"></div>
              </div>
              
              <div class="flex-1 min-w-0">
                <div class="flex items-start justify-between">
                  <div>
                    <h4 class="text-gray-900 dark:text-white font-medium">{{ reminder.title }}</h4>
                    <p v-if="reminder.description" class="text-sm text-gray-600 dark:text-gray-400 mt-1">{{ reminder.description }}</p>
                    <div class="flex items-center space-x-4 mt-2 text-xs text-gray-500 dark:text-gray-500">
                      <span class="flex items-center">
                        <CalendarIcon class="w-3 h-3 mr-1" />
                        {{ formatDate(reminder.date) }}
                      </span>
                      <span v-if="reminder.client" class="flex items-center">
                        <UserIcon class="w-3 h-3 mr-1" />
                        {{ reminder.client.name }}
                      </span>
                      <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium" :class="getReminderTypeClass(reminder.type)">
                        {{ getReminderTypeText(reminder.type) }}
                      </span>
                      <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium" :class="getPriorityClass(reminder.priority)">
                        {{ getPriorityText(reminder.priority) }}
                      </span>
                    </div>
                  </div>
                  
                  <div class="flex items-center space-x-2 flex-shrink-0">
                    <button
                      @click="editReminder(reminder)"
                      class="p-1 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-700 rounded transition-colors"
                    >
                      <PencilIcon class="w-4 h-4" />
                    </button>
                    <button
                      v-if="reminder.isActive"
                      @click="completeReminder(reminder.id)"
                      class="p-1 text-gray-600 dark:text-gray-400 hover:text-green-600 dark:hover:text-green-400 hover:bg-green-50 dark:hover:bg-green-900/20 rounded transition-colors"
                    >
                      <CheckIcon class="w-4 h-4" />
                    </button>
                    <button
                      @click="deleteReminder(reminder.id)"
                      class="p-1 text-gray-600 dark:text-gray-400 hover:text-red-600 dark:hover:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20 rounded transition-colors"
                    >
                      <TrashIcon class="w-4 h-4" />
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal de Criar/Editar Lembrete -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition ease-out duration-200"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition ease-in duration-150"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="showCreateReminderModal || editingReminder" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <Transition
            enter-active-class="transition ease-out duration-200"
            enter-from-class="opacity-0 scale-95"
            enter-to-class="opacity-100 scale-100"
            leave-active-class="transition ease-in duration-150"
            leave-from-class="opacity-100 scale-100"
            leave-to-class="opacity-0 scale-95"
          >
            <div class="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 rounded-xl shadow-xl w-full max-w-md">
              <!-- Modal Header -->
              <div class="flex items-center justify-between p-6 border-b border-gray-200 dark:border-gray-800">
                <div class="flex items-center space-x-3">
                  <div class="p-2 bg-yellow-500 dark:bg-gradient-to-br dark:from-yellow-600 dark:to-orange-600 rounded-lg">
                    <BellIcon class="w-5 h-5 text-white" />
                  </div>
                  <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
                    {{ editingReminder ? 'Editar Lembrete' : 'Novo Lembrete' }}
                  </h3>
                </div>
                <button @click="closeReminderModal" class="p-2 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-colors">
                  <XMarkIcon class="w-5 h-5" />
                </button>
              </div>
              
              <!-- Modal Body -->
              <form @submit.prevent="saveReminder" class="p-6 space-y-4">
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Título *</label>
                  <input
                    v-model="reminderForm.title"
                    type="text"
                    required
                    class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none focus:border-yellow-500 dark:focus:border-yellow-500 transition-colors"
                    placeholder="Título do lembrete"
                  />
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Tipo</label>
                  <select v-model="reminderForm.type" class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-yellow-500 dark:focus:border-yellow-500 transition-colors">
                    <option value="MANUAL">Manual</option>
                    <option value="ANIVERSARIO">Aniversário</option>
                    <option value="AGENDAMENTO">Agendamento</option>
                    <option value="PRODUTO_BAIXO" disabled>Estoque baixo (automático)</option>
                    <option value="DESPESA_FIXA" disabled>Despesa fixa (automático)</option>
                  </select>
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Prioridade</label>
                  <select v-model="reminderForm.priority" class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-yellow-500 dark:focus:border-yellow-500 transition-colors">
                    <option value="POUCO_URGENTE">Pouco Urgente</option>
                    <option value="URGENTE">Urgente</option>
                    <option value="IMEDIATO">Imediato</option>
                  </select>
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-300 mb-2">Data e Hora *</label>
                  <input
                    v-model="reminderForm.date"
                    type="datetime-local"
                    required
                    class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white focus:outline-none focus:border-yellow-500 transition-colors"
                  />
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-300 mb-2">Cliente (Opcional)</label>
                  <select v-model="reminderForm.clientId" class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white focus:outline-none focus:border-yellow-500 transition-colors">
                    <option value="">Selecione um cliente</option>
                    <option v-for="client in clients" :key="client.id" :value="client.id">
                      {{ client.name }}
                    </option>
                  </select>
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-300 mb-2">Descrição</label>
                  <textarea
                    v-model="reminderForm.description"
                    rows="3"
                    class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:border-yellow-500 transition-colors resize-none"
                    placeholder="Descrição opcional do lembrete..."
                  ></textarea>
                </div>
                
                <!-- Modal Footer -->
                <div class="flex justify-end space-x-3 pt-4">
                  <button 
                    type="button" 
                    @click="closeReminderModal" 
                    class="px-4 py-2 bg-gray-800 hover:bg-gray-700 text-white rounded-lg font-medium transition-colors"
                  >
                    Cancelar
                  </button>
                  <button 
                    type="submit" 
                    class="px-4 py-2 bg-gradient-to-r from-yellow-600 to-orange-600 hover:from-yellow-700 hover:to-orange-700 text-white rounded-lg font-medium transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
                    :disabled="savingReminder"
                  >
                    <span v-if="savingReminder" class="flex items-center">
                      <svg class="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                      </svg>
                      Salvando...
                    </span>
                    <span v-else>
                      {{ editingReminder ? 'Atualizar' : 'Salvar' }}
                    </span>
                  </button>
                </div>
              </form>
            </div>
          </Transition>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<script setup>
import {
  BellIcon,
  PlusIcon,
  CalendarIcon,
  UserIcon,
  PencilIcon,
  TrashIcon,
  CheckIcon,
  XMarkIcon
} from '@heroicons/vue/24/outline'

definePageMeta({
  layout: 'default',
  middleware: 'auth'
})

useSeoMeta({
  title: 'Lembretes - Coven Beauty',
  description: 'Gerencie seus lembretes personalizados'
})

// Estado dos lembretes
const reminders = ref([])
const clients = ref([])
const loadingReminders = ref(true)
const savingReminder = ref(false)

const showCreateReminderModal = ref(false)
const editingReminder = ref(null)

const reminderFilters = reactive({
  status: 'active',
  startDate: '',
  endDate: '',
  type: '',
  clientId: ''
})

const reminderForm = reactive({
  title: '',
  type: 'MANUAL',
  priority: 'POUCO_URGENTE',
  date: '',
  clientId: '',
  description: ''
})

// Computed
const filteredReminders = computed(() => {
  let filtered = reminders.value

  // Filtro por status
  if (reminderFilters.status !== 'all') {
    filtered = filtered.filter(r => {
      if (reminderFilters.status === 'active') {
        return r.isActive
      } else {
        return !r.isActive
      }
    })
  }

  // Filtro por data
  if (reminderFilters.startDate) {
    filtered = filtered.filter(r => new Date(r.date) >= new Date(reminderFilters.startDate))
  }
  if (reminderFilters.endDate) {
    filtered = filtered.filter(r => new Date(r.date) <= new Date(reminderFilters.endDate))
  }

  return filtered.sort((a, b) => new Date(a.date) - new Date(b.date))
})

// Métodos dos lembretes
const formatDate = (dateString) => {
  return new Date(dateString).toLocaleString('pt-BR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

const getReminderTypeClass = (type) => {
  const classes = {
    MANUAL: 'bg-blue-900/50 text-blue-400 border border-blue-800',
    ANIVERSARIO: 'bg-pink-900/50 text-pink-400 border border-pink-800',
    AGENDAMENTO: 'bg-purple-900/50 text-purple-400 border border-purple-800',
    PRODUTO_BAIXO: 'bg-yellow-900/40 text-yellow-300 border border-yellow-800',
    DESPESA_FIXA: 'bg-emerald-900/40 text-emerald-300 border border-emerald-800'
  }
  return classes[type] || 'bg-gray-900/50 text-gray-400 border border-gray-800'
}

const getReminderTypeText = (type) => {
  const texts = {
    MANUAL: 'Manual',
    ANIVERSARIO: 'Aniversário',
    AGENDAMENTO: 'Agendamento',
    PRODUTO_BAIXO: 'Estoque baixo',
    DESPESA_FIXA: 'Despesa fixa'
  }
  return texts[type] || type
}

const getPriorityClass = (priority) => {
  const classes = {
    POUCO_URGENTE: 'bg-green-900/50 text-green-400 border border-green-800',
    URGENTE: 'bg-yellow-900/50 text-yellow-400 border border-yellow-800', 
    IMEDIATO: 'bg-red-900/50 text-red-400 border border-red-800'
  }
  return classes[priority] || 'bg-gray-900/50 text-gray-400 border border-gray-800'
}

const getPriorityText = (priority) => {
  const texts = {
    POUCO_URGENTE: 'Pouco Urgente',
    URGENTE: 'Urgente',
    IMEDIATO: 'Imediato'
  }
  return texts[priority] || priority
}

// Métodos dos lembretes
const loadReminders = async () => {
  try {
    const { $api } = useNuxtApp()
    
    console.log('🔄 Carregando lembretes...')
    
    const [remindersRes, clientsRes] = await Promise.all([
      $api('/reminders', {
        method: 'GET',
        query: {
          status: reminderFilters.status,
          startDate: reminderFilters.startDate || undefined,
          endDate: reminderFilters.endDate || undefined,
          type: reminderFilters.type || undefined,
          clientId: reminderFilters.clientId || undefined
        }
      }).catch((error) => {
        console.error('❌ Erro ao carregar lembretes:', error)
        return []
      }),
      $api('/clients').catch((error) => {
        console.error('❌ Erro ao carregar clientes:', error)
        return []
      })
    ])
    
    reminders.value = remindersRes || []
    clients.value = clientsRes || []
    
    console.log('✅ Lembretes carregados:', reminders.value.length)
    
  } catch (error) {
    console.error('💥 Erro ao carregar dados:', error)
  } finally {
    loadingReminders.value = false
  }
}

const resetReminderForm = () => {
  Object.assign(reminderForm, {
    title: '',
    type: 'MANUAL',
    priority: 'POUCO_URGENTE',
    date: '',
    clientId: '',
    description: ''
  })
}

const editReminder = (reminder) => {
  editingReminder.value = reminder
  Object.assign(reminderForm, {
    title: reminder.title,
    type: reminder.type,
    priority: reminder.priority || 'POUCO_URGENTE',
    date: reminder.date ? new Date(reminder.date).toISOString().slice(0, 16) : '',
    clientId: reminder.clientId || '',
    description: reminder.description || ''
  })
  showCreateReminderModal.value = false
}

const closeReminderModal = () => {
  showCreateReminderModal.value = false
  editingReminder.value = null
  resetReminderForm()
}

const saveReminder = async () => {
  savingReminder.value = true
  
  try {
    const { $api } = useNuxtApp()
    const toast = useToast()
    
    const payload = {
      title: reminderForm.title,
      type: reminderForm.type,
      priority: reminderForm.priority,
      date: new Date(reminderForm.date).toISOString(),
      clientId: reminderForm.clientId || undefined,
      description: reminderForm.description || undefined
    }
    
    Object.keys(payload).forEach(key => {
      if (payload[key] === undefined || payload[key] === '') {
        delete payload[key]
      }
    })
    
    console.log('💾 Salvando lembrete:', payload)
    
    const method = editingReminder.value ? 'PATCH' : 'POST'
    const url = editingReminder.value 
      ? `/reminders/${editingReminder.value.id}` 
      : '/reminders'
    
    await $api(url, {
      method,
      body: payload
    })
    
    await loadReminders()
    closeReminderModal()
    toast.success(editingReminder.value ? 'Lembrete atualizado!' : 'Lembrete criado!')
  } catch (error) {
    console.error('💥 Erro ao salvar lembrete:', error)
    const toast = useToast()
    toast.error('Erro ao salvar lembrete')
  } finally {
    savingReminder.value = false
  }
}

const completeReminder = async (reminderId) => {
  try {
    const { $api } = useNuxtApp()
    const toast = useToast()
    
    await $api(`/reminders/${reminderId}/complete`, {
      method: 'PATCH'
    })
    
    await loadReminders()
    toast.success('Lembrete marcado como concluído!')
  } catch (error) {
    console.error('💥 Erro ao completar lembrete:', error)
    const toast = useToast()
    toast.error('Erro ao completar lembrete')
  }
}

const deleteReminder = async (reminderId) => {
  if (!confirm('Tem certeza que deseja excluir este lembrete?')) {
    return
  }
  
  try {
    const { $api } = useNuxtApp()
    const toast = useToast()
    
    await $api(`/reminders/${reminderId}`, {
      method: 'DELETE'
    })
    
    await loadReminders()
    toast.success('Lembrete excluído!')
  } catch (error) {
    console.error('💥 Erro ao excluir lembrete:', error)
    const toast = useToast()
    toast.error('Erro ao excluir lembrete')
  }
}

// Watch para recarregar lembretes quando filtros mudarem
watch(reminderFilters, () => {
  loadReminders()
}, { deep: true })

// Lifecycle
onMounted(() => {
  loadReminders()
})
</script>