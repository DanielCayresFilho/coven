<template>
  <div class="space-y-6">
    <!-- Header Section -->
    <div>
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 shadow-sm">
        <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
          <div>
            <h1 class="text-2xl font-bold text-gray-900 dark:text-white mb-2">Comandas</h1>
            <p class="text-gray-600 dark:text-gray-400">Gerencie comandas de serviços e produtos utilizados</p>
          </div>
        </div>

        <!-- Stats Overview -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mt-6">
          <div class="bg-green-50 dark:bg-green-600/20 border border-green-200 dark:border-green-600/30 rounded-xl p-4">
            <div class="flex items-center">
              <div class="p-2 bg-green-100 dark:bg-green-600/20 rounded-lg">
                <CheckCircleIcon class="w-5 h-5 text-green-600 dark:text-green-400" />
              </div>
              <div class="ml-3">
                <p class="text-sm text-green-600 dark:text-green-400 font-medium">Comandas Abertas</p>
                <p class="text-xl font-bold text-gray-900 dark:text-white">{{ openCommandsCount }}</p>
              </div>
            </div>
          </div>

          <div class="bg-blue-50 dark:bg-blue-600/20 border border-blue-200 dark:border-blue-600/30 rounded-xl p-4">
            <div class="flex items-center">
              <div class="p-2 bg-blue-100 dark:bg-blue-600/20 rounded-lg">
                <ClockIcon class="w-5 h-5 text-blue-600 dark:text-blue-400" />
              </div>
              <div class="ml-3">
                <p class="text-sm text-blue-600 dark:text-blue-400 font-medium">Comandas Finalizadas</p>
                <p class="text-xl font-bold text-gray-900 dark:text-white">{{ closedCommandsCount }}</p>
              </div>
            </div>
          </div>

          <div class="bg-purple-50 dark:bg-purple-600/20 border border-purple-200 dark:border-purple-600/30 rounded-xl p-4">
            <div class="flex items-center">
              <div class="p-2 bg-purple-100 dark:bg-purple-600/20 rounded-lg">
                <CurrencyDollarIcon class="w-5 h-5 text-purple-600 dark:text-purple-400" />
              </div>
              <div class="ml-3">
                <p class="text-sm text-purple-600 dark:text-purple-400 font-medium">Receita Hoje</p>
                <p class="text-xl font-bold text-gray-900 dark:text-white">{{ formatCurrency(todayRevenue) }}</p>
              </div>
            </div>
          </div>

          <div class="bg-yellow-50 dark:bg-yellow-600/20 border border-yellow-200 dark:border-yellow-600/30 rounded-xl p-4">
            <div class="flex items-center">
              <div class="p-2 bg-yellow-100 dark:bg-yellow-600/20 rounded-lg">
                <CubeIcon class="w-5 h-5 text-yellow-600 dark:text-yellow-400" />
              </div>
              <div class="ml-3">
                <p class="text-sm text-yellow-600 dark:text-yellow-400 font-medium">Produtos Usados</p>
                <p class="text-xl font-bold text-gray-900 dark:text-white">{{ totalProductsUsed }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Filters -->
    <div>
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-4 shadow-sm">
        <div class="flex flex-wrap gap-4">
          <div class="flex-1 min-w-64">
            <input
              v-model="clientFilter"
              type="text"
              placeholder="Buscar por cliente..."
              class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors"
            />
          </div>
          
          <div class="min-w-40">
            <select 
              v-model="statusFilter" 
              class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors"
            >
              <option value="ABERTA">Abertas</option>
              <option value="FINALIZADA">Finalizadas</option>
              <option value="CANCELADO">Canceladas</option>
              <option value="">Todos os status</option>
            </select>
          </div>

          <div class="min-w-40">
            <select 
              v-model="hairdresserFilter" 
              class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors"
            >
              <option value="">Todos os profissionais</option>
              <option v-for="hairdresser in hairdressers" :key="hairdresser.id" :value="hairdresser.id">
                {{ hairdresser.name }}
              </option>
            </select>
          </div>

          <div class="min-w-48">
            <input
              v-model="dateFilter"
              type="date"
              class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors"
            />
          </div>
        </div>
      </div>
    </div>

    <!-- Commands List -->
    <div>
      <div v-if="loading" class="text-center py-12">
        <div class="animate-spin w-8 h-8 border-2 border-blue-500 dark:border-purple-500 border-t-transparent rounded-full mx-auto mb-4"></div>
        <p class="text-gray-600 dark:text-gray-400">Carregando comandas...</p>
      </div>

      <div v-else-if="filteredCommands.length === 0" class="text-center py-12">
        <div class="text-6xl text-gray-400 dark:text-gray-600 mb-4">📋</div>
        <h3 class="text-xl font-medium text-gray-900 dark:text-gray-300 mb-2">Nenhuma comanda encontrada</h3>
        <p class="text-gray-600 dark:text-gray-500">Não há comandas que correspondam aos filtros selecionados.</p>
      </div>

      <div v-else class="space-y-4">
        <div
          v-for="command in filteredCommands"
          :key="command.id"
          class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 hover:border-blue-500 dark:hover:border-purple-500/50 transition-all duration-200 group cursor-pointer shadow-sm"
          @click="viewCommand(command)"
        >
          <div class="flex items-center justify-between">
            <div class="flex-1">
              <div class="flex items-center gap-3 mb-3">
                <div class="p-2 bg-blue-100 dark:bg-purple-600/20 rounded-lg">
                  <UserIcon class="w-5 h-5 text-blue-600 dark:text-purple-400" />
                </div>
                <div>
                  <h3 class="text-lg font-semibold text-gray-900 dark:text-white">{{ command.client?.name }}</h3>
                  <p class="text-sm text-gray-600 dark:text-gray-400">{{ command.user?.name }}</p>
                </div>
                <span 
                  class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium"
                  :class="getStatusBadgeClass(command)"
                >
                  {{ getStatusLabel(command) }}
                </span>
              </div>
              
              <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 text-sm">
                <div class="flex items-center text-gray-700 dark:text-gray-300">
                  <CalendarIcon class="w-4 h-4 mr-2 text-gray-600 dark:text-gray-400" />
                  {{ formatDate(command.date) }}
                </div>
                <div class="flex items-center text-gray-700 dark:text-gray-300">
                  <ClockIcon class="w-4 h-4 mr-2 text-gray-600 dark:text-gray-400" />
                  {{ formatTime(command.startTime) }}
                </div>
                <div class="flex items-center text-gray-700 dark:text-gray-300">
                  <SparklesIcon class="w-4 h-4 mr-2 text-gray-600 dark:text-gray-400" />
                  {{ command.procedures?.length || 0 }} procedimento(s)
                </div>
                <div class="flex items-center text-gray-700 dark:text-gray-300">
                  <CubeIcon class="w-4 h-4 mr-2 text-gray-600 dark:text-gray-400" />
                  {{ command.productUsages?.length || 0 }} produto(s)
                </div>
              </div>
            </div>
            
            <div class="flex items-center space-x-4">
              <div class="text-right">
                <p class="text-xl font-bold text-gray-900 dark:text-white">{{ formatCurrency(command.totalPrice || 0) }}</p>
                <p v-if="command.paymentMethod" class="text-xs text-gray-600 dark:text-gray-400 mt-1">{{ command.paymentMethod }}</p>
              </div>
              <div class="opacity-0 group-hover:opacity-100 transition-opacity flex space-x-1">
                <button
                  @click.stop="editCommand(command)"
                  class="p-2 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-all duration-200"
                >
                  <PencilIcon class="w-4 h-4" />
                </button>
                <button
                  v-if="(command.comandaClosedAt || command.status === 'CONCLUIDO') && command.status !== 'CANCELADO'"
                  @click.stop="rescheduleCommand(command)"
                  class="p-2 text-gray-600 dark:text-gray-400 hover:text-green-600 dark:hover:text-green-400 hover:bg-green-100 dark:hover:bg-green-900/20 rounded-lg transition-all duration-200"
                  title="Reagendar cliente"
                >
                  <CalendarIcon class="w-4 h-4" />
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Command Detail Modal -->
    <Modal 
      :show="!!selectedCommand"
      @close="closeCommandModal"
      :title="selectedCommand ? `Comanda - ${selectedCommand.client?.name}` : 'Detalhes da Comanda'"
      :subtitle="selectedCommand ? `${formatDate(selectedCommand.date)} às ${formatTime(selectedCommand.startTime)}` : ''"
      :icon="CalendarIcon"
    >
      <div v-if="selectedCommand" class="space-y-6">
        <!-- Command Info -->
        <div class="bg-gray-800/30 rounded-lg p-4">
          <div class="grid grid-cols-2 gap-4 text-sm">
            <div>
              <span class="text-gray-400">Cliente:</span>
              <p class="text-white font-medium">{{ selectedCommand.client?.name }}</p>
            </div>
            <div>
              <span class="text-gray-400">Profissional:</span>
              <p class="text-white font-medium">{{ selectedCommand.user?.name }}</p>
            </div>
            <div>
              <span class="text-gray-400">Data:</span>
              <p class="text-white font-medium">{{ formatDateTime(selectedCommand.startTime) }}</p>
            </div>
            <div>
              <span class="text-gray-400">Status:</span>
              <span 
                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium"
                :class="getStatusBadgeClass(selectedCommand)"
              >
                {{ getStatusLabel(selectedCommand) }}
              </span>
            </div>
          </div>
        </div>

        <!-- Procedures -->
        <div>
          <h4 class="text-lg font-medium text-white mb-3">Procedimentos</h4>
          <div class="space-y-2">
            <div
              v-for="procedure in selectedCommand.procedures"
              :key="procedure.id"
              class="flex items-center justify-between bg-gray-800/30 rounded-lg p-3"
            >
              <span class="text-gray-300">{{ procedure.procedure?.name }}</span>
              <span class="text-white font-medium">{{ formatCurrency(procedure.price) }}</span>
            </div>
          </div>
        </div>

        <!-- Products Used -->
        <div v-if="selectedCommand.productUsages?.length">
          <h4 class="text-lg font-medium text-white mb-3">Produtos Utilizados</h4>
          <div class="space-y-2">
            <div
              v-for="usage in selectedCommand.productUsages"
              :key="usage.id"
              class="flex items-center justify-between bg-gray-800/30 rounded-lg p-3"
            >
              <div>
                <span class="text-gray-300">{{ usage.product?.name }}</span>
                <p class="text-xs text-gray-500">Quantidade: {{ usage.quantityUsed }}{{ usage.product?.unitMeasurement }}</p>
              </div>
              <span class="text-white font-medium">{{ formatCurrency(usage.totalCost || 0) }}</span>
            </div>
          </div>
        </div>

        <!-- Payment Info -->
        <div class="bg-gray-800/30 rounded-lg p-4">
          <div class="flex items-center justify-between">
            <span class="text-gray-400">Total da Comanda:</span>
            <span class="text-xl font-bold text-white">{{ formatCurrency(selectedCommand.totalPrice || 0) }}</span>
          </div>
          <div v-if="selectedCommand.paymentMethod" class="flex items-center justify-between mt-2">
            <span class="text-gray-400">Forma de Pagamento:</span>
            <span class="text-white">{{ selectedCommand.paymentMethod }}</span>
          </div>
        </div>

        <!-- Observations -->
        <div v-if="selectedCommand.observations">
          <h4 class="text-lg font-medium text-white mb-3">Observações</h4>
          <div class="bg-gray-800/30 rounded-lg p-4">
            <p class="text-gray-300">{{ selectedCommand.observations }}</p>
          </div>
        </div>
      </div>
    </Modal>

    <!-- Reschedule Modal -->
    <Modal 
      :show="showRescheduleModal"
      @close="closeRescheduleModal"
      :title="`Reagendar - ${commandToReschedule?.client?.name || 'Cliente'}`"
      subtitle="Criar novo agendamento"
      :icon="CalendarIcon"
      size="large"
    >
      <form @submit.prevent="confirmReschedule" class="space-y-6">
        <!-- Client Selection -->
        <div>
          <label class="block text-sm font-medium text-gray-300 mb-2">Cliente</label>
          <select 
            v-model="rescheduleForm.clientId"
            class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white focus:outline-none focus:border-purple-500 transition-colors"
            required
            disabled
          >
            <option value="">Selecione um cliente</option>
            <option v-for="client in clients" :key="client.id" :value="client.id">
              {{ client.name }}
            </option>
          </select>
        </div>

        <!-- Professional Selection -->
        <div>
          <label class="block text-sm font-medium text-gray-300 mb-2">Profissional</label>
          <select 
            v-model="rescheduleForm.userId"
            class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white focus:outline-none focus:border-purple-500 transition-colors"
            required
          >
            <option value="">Selecione um profissional</option>
            <option v-for="hairdresser in hairdressers" :key="hairdresser.id" :value="hairdresser.id">
              {{ hairdresser.name }}
            </option>
          </select>
        </div>

        <!-- Date -->
        <div>
          <label class="block text-sm font-medium text-gray-300 mb-2">Data</label>
          <input
            v-model="rescheduleForm.date"
            type="date"
            class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white focus:outline-none focus:border-purple-500 transition-colors"
            required
          />
        </div>

        <!-- Time Range -->
        <div class="grid grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-300 mb-2">Início</label>
            <input
              v-model="rescheduleForm.startTime"
              type="time"
              class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white focus:outline-none focus:border-purple-500 transition-colors"
              required
            />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-300 mb-2">Fim</label>
            <input
              v-model="rescheduleForm.endTime"
              type="time"
              class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white focus:outline-none focus:border-purple-500 transition-colors"
              required
            />
          </div>
        </div>

        <!-- Procedures (from original command) -->
        <div v-if="commandToReschedule?.procedures?.length">
          <label class="block text-sm font-medium text-gray-300 mb-2">Procedimentos</label>
          <div class="bg-gray-800/30 rounded-lg p-4 space-y-2">
            <div
              v-for="procedure in commandToReschedule.procedures"
              :key="procedure.id"
              class="flex items-center justify-between text-sm"
            >
              <span class="text-gray-300">{{ procedure.procedure?.name }}</span>
              <span class="text-white font-medium">{{ formatCurrency(procedure.price) }}</span>
            </div>
          </div>
        </div>

        <!-- Observations -->
        <div>
          <label class="block text-sm font-medium text-gray-300 mb-2">Observações</label>
          <textarea
            v-model="rescheduleForm.observations"
            rows="3"
            class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:border-purple-500 transition-colors resize-none"
            placeholder="Observações para o novo agendamento..."
          ></textarea>
        </div>

        <!-- Total Price Display -->
        <div class="bg-gray-800/30 rounded-lg p-4">
          <div class="flex items-center justify-between">
            <span class="text-gray-400">Total Estimado:</span>
            <span class="text-xl font-bold text-white">{{ formatCurrency(rescheduleForm.totalPrice) }}</span>
          </div>
        </div>

        <!-- Action Buttons -->
        <div class="flex space-x-4 pt-4">
          <button
            type="button"
            @click="closeRescheduleModal"
            class="flex-1 px-6 py-3 bg-gray-600 hover:bg-gray-700 text-white rounded-lg transition-colors"
          >
            Cancelar
          </button>
          <button
            type="submit"
            class="flex-1 px-6 py-3 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white rounded-lg transition-colors font-medium"
          >
            Reagendar Cliente
          </button>
        </div>
      </form>
    </Modal>
  </div>
</template>

<script setup>
import { 
  CalendarIcon,
  CheckCircleIcon,
  ClockIcon,
  CurrencyDollarIcon,
  UserIcon,
  SparklesIcon,
  PencilIcon,
  CubeIcon
} from '@heroicons/vue/24/outline'
import Modal from '~/components/Modal.vue'

definePageMeta({
  layout: 'default',
  middleware: 'auth'
})

useSeoMeta({
  title: 'Comandas - Coven Beauty',
  description: 'Gerenciamento de comandas de serviços'
})

// State
const commands = ref([])
const clients = ref([])
const hairdressers = ref([])
const loading = ref(true)
const selectedCommand = ref(null)
const commandToReschedule = ref(null)
const showRescheduleModal = ref(false)
const rescheduleForm = reactive({
  clientId: '',
  userId: '',
  date: '',
  startTime: '',
  endTime: '',
  procedureIds: [],
  observations: '',
  totalPrice: 0
})

// Filters
const clientFilter = ref('')
const statusFilter = ref('ABERTA') // Padrão: Abertas
const hairdresserFilter = ref('')
const dateFilter = ref('')

// Computed
const filteredCommands = computed(() => {
  let filtered = commands.value
  const today = new Date()
  today.setHours(0, 0, 0, 0)
  const sixtyDaysLater = new Date(today)
  sixtyDaysLater.setDate(sixtyDaysLater.getDate() + 60)

  if (clientFilter.value) {
    const term = clientFilter.value.toLowerCase()
    filtered = filtered.filter(cmd =>
      cmd.client?.name.toLowerCase().includes(term)
    )
  }

  if (statusFilter.value) {
    filtered = filtered.filter(cmd => {
      if (statusFilter.value === 'CANCELADO') {
        return cmd.status === 'CANCELADO'
      }

      if (statusFilter.value === 'ABERTA') {
        const isOpen = !cmd.comandaClosedAt && cmd.status !== 'CONCLUIDO' && cmd.status !== 'CANCELADO'
        if (!isOpen) return false

        const cmdDate = new Date(cmd.date || cmd.startTime)
        cmdDate.setHours(0, 0, 0, 0)

        return cmdDate <= sixtyDaysLater
      }

      return (!!cmd.comandaClosedAt || cmd.status === 'CONCLUIDO') && cmd.status !== 'CANCELADO'
    })
  } else {
    filtered = filtered.filter(cmd => {
      const isOpen = !cmd.comandaClosedAt && cmd.status !== 'CONCLUIDO' && cmd.status !== 'CANCELADO'
      if (isOpen) {
        const cmdDate = new Date(cmd.date || cmd.startTime)
        cmdDate.setHours(0, 0, 0, 0)
        return cmdDate <= sixtyDaysLater
      }
      return true
    })
  }

  if (hairdresserFilter.value) {
    filtered = filtered.filter(cmd => cmd.userId === hairdresserFilter.value)
  }

  if (dateFilter.value) {
    filtered = filtered.filter(cmd => 
      cmd.date?.startsWith(dateFilter.value)
    )
  }

  // Ordenar do mais recente para o mais antigo
  return filtered.sort((a, b) => new Date(b.startTime) - new Date(a.startTime))
})

const openCommandsCount = computed(() => {
  return commands.value.filter(cmd => !cmd.comandaClosedAt && cmd.status !== 'CONCLUIDO').length
})

const closedCommandsCount = computed(() => {
  return commands.value.filter(cmd => !!cmd.comandaClosedAt || cmd.status === 'CONCLUIDO').length
})

const todayRevenue = computed(() => {
  const today = new Date()
  const todayStr = today.getFullYear() + '-' + String(today.getMonth() + 1).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0')
  
  return commands.value
    .filter(cmd => {
      const cmdDate = cmd.date?.split('T')[0]
      return cmdDate === todayStr && cmd.comandaClosedAt && cmd.status !== 'CANCELADO'
    })
    .reduce((sum, cmd) => sum + (parseFloat(cmd.totalPrice) || 0), 0)
})

const totalProductsUsed = computed(() => {
  return commands.value.reduce((sum, cmd) => sum + (cmd.productUsages?.length || 0), 0)
})

// Methods
const loadData = async () => {
  try {
    const { $api } = useNuxtApp()
    
    console.log('🔄 Carregando comandas da API...')
    
    const [commandsRes, clientsRes, usersRes] = await Promise.all([
      $api('/appointments?includeCommands=true').catch((error) => {
        console.error('❌ Erro ao carregar comandas:', error)
        return []
      }),
      $api('/clients').catch((error) => {
        console.error('❌ Erro ao carregar clientes:', error)
        return []
      }),
      $api('/users').catch((error) => {
        console.error('❌ Erro ao carregar usuários:', error)
        return []
      })
    ])
    
    // Show all appointments that have procedures (commands), including old ones
    commands.value = (commandsRes || []).filter(apt =>
      apt.procedures && apt.procedures.length > 0,
    )
    clients.value = clientsRes || []
    hairdressers.value = (usersRes || []).filter(user => user.role === 'CABELEIREIRO')
    
    console.log('✅ Dados carregados:')
    console.log(`   📋 Comandas: ${commands.value.length}`)
    console.log(`   👥 Clientes: ${clients.value.length}`)
    console.log(`   💇 Profissionais: ${hairdressers.value.length}`)
    
  } catch (error) {
    console.error('❌ Erro ao carregar dados:', error)
    useToast().add({
      type: 'error',
      title: 'Erro ao carregar dados',
      description: 'Não foi possível carregar as comandas. Tente novamente.'
    })
  } finally {
    loading.value = false
  }
}

const viewCommand = (command) => {
  selectedCommand.value = command
}

const editCommand = (command) => {
  // Navegar para a página de comandas ou agendamentos - precisa abrir a comanda diretamente
  // Como a comanda está relacionada a um agendamento, vamos redirecionar para abrir a comanda
  if (command.status === 'CONFIRMADO' && !command.comandaClosedAt) {
    // Se a comanda está aberta, redirecionar para a página de comanda
    navigateTo(`/appointments?viewComanda=${command.id}`)
  } else {
    // Caso contrário, editar o agendamento
    navigateTo(`/appointments?edit=${command.id}`)
  }
}

const rescheduleCommand = (command) => {
  commandToReschedule.value = command
  
  // Pre-fill form with suggested values
  const suggestedDate = new Date()
  suggestedDate.setDate(suggestedDate.getDate() + 30)
  
  Object.assign(rescheduleForm, {
    clientId: command.clientId,
    userId: command.userId,
    date: suggestedDate.toISOString().split('T')[0],
    startTime: '09:00',
    endTime: '10:00',
    procedureIds: command.procedures?.map(p => p.procedureId) || [],
    observations: `Reagendamento da comanda de ${formatDate(command.date)}`,
    totalPrice: command.totalPrice || 0
  })
  
  showRescheduleModal.value = true
}

const closeCommandModal = () => {
  selectedCommand.value = null
}

const closeRescheduleModal = () => {
  showRescheduleModal.value = false
  commandToReschedule.value = null
  Object.assign(rescheduleForm, {
    clientId: '',
    userId: '',
    date: '',
    startTime: '',
    endTime: '',
    procedureIds: [],
    observations: '',
    totalPrice: 0
  })
}

const confirmReschedule = async () => {
  try {
    const { $api } = useNuxtApp()
    
    const startDateTime = new Date(`${rescheduleForm.date}T${rescheduleForm.startTime}:00`)
    const endDateTime = new Date(`${rescheduleForm.date}T${rescheduleForm.endTime}:00`)
    
    const newAppointment = {
      clientId: rescheduleForm.clientId,
      userId: rescheduleForm.userId,
      date: rescheduleForm.date,
      startTime: startDateTime.toISOString(),
      endTime: endDateTime.toISOString(),
      procedureIds: rescheduleForm.procedureIds,
      observations: rescheduleForm.observations,
      status: 'AGENDADO'
    }
    
    await $api('/appointments', {
      method: 'POST',
      body: newAppointment
    })
    
    useToast().add({
      type: 'success',
      title: 'Reagendamento criado!',
      description: `${commandToReschedule.value.client?.name} foi reagendado com sucesso.`
    })
    
    closeRescheduleModal()
    
  } catch (error) {
    console.error('❌ Erro ao reagendar:', error)
    useToast().add({
      type: 'error',
      title: 'Erro no reagendamento',
      description: 'Não foi possível criar o reagendamento. Tente novamente.'
    })
  }
}

const getStatusLabel = (command) => {
  if (command.status === 'CANCELADO') {
    return 'Cancelada'
  }

  if (command.comandaClosedAt || command.status === 'CONCLUIDO') {
    return 'Finalizada'
  }
  return 'Aberta'
}

const getStatusBadgeClass = (command) => {
  if (command.status === 'CANCELADO') {
    return 'bg-red-100 text-red-700'
  }

  if (command.comandaClosedAt || command.status === 'CONCLUIDO') {
    return 'bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-300 border border-green-300 dark:border-green-600/30'
  }
  return 'bg-yellow-100 dark:bg-yellow-900/30 text-yellow-700 dark:text-yellow-300 border border-yellow-300 dark:border-yellow-600/30'
}

// Utility functions
const formatCurrency = (value) => {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(value || 0)
}

const formatDate = (dateString) => {
  if (!dateString) return ''
  return new Date(dateString).toLocaleDateString('pt-BR')
}

const formatTime = (timeString) => {
  if (!timeString) return ''
  return new Date(timeString).toLocaleTimeString('pt-BR', { 
    hour: '2-digit', 
    minute: '2-digit' 
  })
}

const formatDateTime = (dateTimeString) => {
  if (!dateTimeString) return ''
  return new Date(dateTimeString).toLocaleString('pt-BR')
}

// Load data on mount
onMounted(() => {
  loadData()
})
</script>