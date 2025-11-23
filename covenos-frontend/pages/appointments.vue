<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between">
      <div>
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Agendamentos</h1>
        <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">Gerencie os agendamentos do salão</p>
      </div>
      <div class="flex items-center space-x-3 mt-4 sm:mt-0">
        <button @click="openBlockModal" class="inline-flex items-center px-4 py-2 bg-gray-600 dark:bg-gray-700 text-white rounded-lg font-medium hover:bg-gray-700 dark:hover:bg-gray-600 transition-all duration-200 shadow-md">
          <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636"></path>
          </svg>
          Bloquear Horário
        </button>
        <button @click="showCreateModal = true" class="inline-flex items-center px-4 py-2 bg-blue-600 dark:bg-gradient-to-r dark:from-purple-600 dark:to-pink-600 text-white rounded-lg font-medium hover:bg-blue-700 dark:hover:from-purple-700 dark:hover:to-pink-700 transition-all duration-200 shadow-md">
          <PlusIcon class="w-5 h-5 mr-2" />
          Novo Agendamento
        </button>
      </div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 hover:border-gray-300 dark:hover:border-gray-700 transition-all duration-300 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Hoje</p>
            <p class="text-2xl font-bold text-gray-900 dark:text-white mt-2">{{ todayAppointments }}</p>
            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">agendamentos</p>
          </div>
          <div class="p-3 bg-blue-100 dark:bg-blue-500/10 rounded-xl">
            <CalendarIcon class="w-6 h-6 text-blue-600 dark:text-blue-400" />
          </div>
        </div>
      </div>

      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 hover:border-gray-300 dark:hover:border-gray-700 transition-all duration-300 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Confirmados</p>
            <p class="text-2xl font-bold text-gray-900 dark:text-white mt-2">{{ confirmedAppointments }}</p>
            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">em andamento</p>
          </div>
          <div class="p-3 bg-green-100 dark:bg-green-500/10 rounded-xl">
            <CheckCircleIcon class="w-6 h-6 text-green-600 dark:text-green-400" />
          </div>
        </div>
      </div>

      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 hover:border-gray-300 dark:hover:border-gray-700 transition-all duration-300 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Pendentes</p>
            <p class="text-2xl font-bold text-gray-900 dark:text-white mt-2">{{ pendingAppointments }}</p>
            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">aguardando</p>
          </div>
          <div class="p-3 bg-yellow-100 dark:bg-yellow-500/10 rounded-xl">
            <ClockIcon class="w-6 h-6 text-yellow-600 dark:text-yellow-400" />
          </div>
        </div>
      </div>

      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 hover:border-gray-300 dark:hover:border-gray-700 transition-all duration-300 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Receita Hoje</p>
            <p class="text-2xl font-bold text-gray-900 dark:text-white mt-2">{{ formatCurrency(todayRevenue) }}</p>
            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">faturamento</p>
          </div>
          <div class="p-3 bg-purple-100 dark:bg-purple-500/10 rounded-xl">
            <CurrencyDollarIcon class="w-6 h-6 text-purple-600 dark:text-purple-400" />
          </div>
        </div>
      </div>
    </div>

    <!-- Filters -->
    <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 shadow-sm">
      <div class="flex items-center justify-between mb-4">
        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">Filtros</h3>
        <button @click="clearFilters" class="text-sm text-blue-600 dark:text-purple-400 hover:text-blue-700 dark:hover:text-purple-300 transition-colors">
          Limpar filtros
        </button>
      </div>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <div>
          <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Status</label>
          <select v-model="statusFilter" class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors">
            <option value="">Todos</option>
            <option value="AGENDADO">Agendado</option>
            <option value="CONFIRMADO">Confirmado</option>
            <option value="BLOQUEADO">Bloqueado</option>
            <option value="CONCLUIDO">Concluído</option>
            <option value="CANCELADO">Cancelado</option>
          </select>
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Cliente</label>
          <input
            v-model="clientFilter"
            type="text"
            placeholder="Buscar cliente..."
            class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors"
          />
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Profissional</label>
          <select v-model="hairdresserFilter" class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors">
            <option value="">Todos</option>
            <option v-for="user in hairdressers" :key="user.id" :value="user.id">
              {{ user.name }}
            </option>
          </select>
        </div>
      </div>
    </div>

    <!-- FullCalendar -->
    <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl overflow-hidden shadow-lg">
      <FullCalendar :options="calendarOptions" ref="fullCalendar" />
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
        <div v-if="showCreateModal || !!editingAppointment" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <Transition
            enter-active-class="transition ease-out duration-200"
            enter-from-class="opacity-0 scale-95"
            enter-to-class="opacity-100 scale-100"
            leave-active-class="transition ease-in duration-150"
            leave-from-class="opacity-100 scale-100"
            leave-to-class="opacity-0 scale-95"
          >
            <div class="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 rounded-xl shadow-xl w-full max-w-2xl max-h-[90vh] overflow-y-auto">
              <div class="sticky top-0 bg-white dark:bg-gray-900 border-b border-gray-200 dark:border-gray-800 p-6 z-10">
                <div class="flex items-center justify-between">
                  <div>
                    <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
                      {{ editingAppointment ? 'Editar Agendamento' : 'Novo Agendamento' }}
                    </h3>
                    <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">
                      {{ editingAppointment ? 'Atualize as informações do agendamento' : 'Preencha os dados do novo agendamento' }}
                    </p>
                  </div>
                  <button @click="closeModal" class="p-2 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-colors">
                    <XMarkIcon class="w-5 h-5" />
                  </button>
                </div>
              </div>

              <form @submit.prevent="saveAppointment" class="p-6 space-y-6">
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <div class="form-group">
                    <label class="form-label">
                      <UserIcon class="w-4 h-4" />
                      Cliente *
                    </label>
                    <select v-model="appointmentForm.clientId" required class="form-input">
                      <option value="">Selecione um cliente</option>
                      <option v-for="client in clients" :key="client.id" :value="client.id">
                        {{ client.name }}
                      </option>
                    </select>
                  </div>
                  
                  <div class="form-group">
                    <label class="form-label">
                      <UserIcon class="w-4 h-4" />
                      Profissional
                    </label>
                    <select v-model="appointmentForm.userId" class="form-input">
                      <option value="">Selecione um profissional</option>
                      <option v-for="user in hairdressers" :key="user.id" :value="user.id">
                        {{ user.name }}
                      </option>
                    </select>
                  </div>
                </div>
                
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <div class="form-group">
                    <label class="form-label">
                      <CalendarIcon class="w-4 h-4" />
                      Data *
                    </label>
                    <input
                      v-model="appointmentForm.date"
                      type="date"
                      required
                      class="form-input"
                    />
                  </div>
                  
                  <div class="form-group">
                    <label class="form-label">
                      <ClockIcon class="w-4 h-4" />
                      Hora Início *
                    </label>
                    <input
                      v-model="appointmentForm.startTime"
                      type="time"
                      required
                      class="form-input"
                    />
                  </div>
                </div>
                
                <div class="form-group">
                  <label class="form-label">
                    <CubeIcon class="w-4 h-4" />
                    Procedimentos
                  </label>
                  
                  <div class="relative mb-3">
                    <input
                      v-model="procedureSearchTerm"
                      type="text"
                      placeholder="Pesquisar procedimentos..."
                      class="w-full px-4 py-2 pl-10 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors"
                    />
                    <MagnifyingGlassIcon class="w-5 h-5 text-gray-400 dark:text-gray-500 absolute left-3 top-1/2 transform -translate-y-1/2" />
                  </div>
                  
                  <div class="max-h-40 overflow-y-auto border border-gray-300 dark:border-gray-700 rounded-lg p-3 bg-gray-50 dark:bg-gray-800/30">
                    <div class="space-y-2">
                      <label
                        v-for="procedure in filteredProcedures"
                        :key="procedure.id"
                        class="flex items-center space-x-3 cursor-pointer hover:bg-gray-100 dark:hover:bg-gray-700/50 p-2 rounded transition-colors"
                      >
                        <input
                          type="checkbox"
                          :value="procedure.id"
                          v-model="appointmentForm.procedureIds"
                          class="w-4 h-4 text-blue-600 dark:text-purple-600 bg-white dark:bg-gray-700 border-gray-300 dark:border-gray-600 rounded focus:ring-blue-500 dark:focus:ring-purple-500"
                        />
                        <div class="flex-1 flex items-center justify-between">
                          <span class="text-gray-900 dark:text-white text-sm">{{ procedure.name }}</span>
                          <span class="text-sm text-blue-600 dark:text-purple-400 font-semibold">{{ formatCurrency(procedure.price) }}</span>
                        </div>
                      </label>
                    </div>
                  </div>
                </div>
                
                <div class="form-group">
                  <label class="form-label">
                    <CheckCircleIcon class="w-4 h-4" />
                    Status
                  </label>
                  <select v-model="appointmentForm.status" class="form-input">
                    <option value="AGENDADO">Agendado</option>
                    <option value="CONFIRMADO">Confirmado</option>
                    <option value="BLOQUEADO">Bloqueado</option>
                    <option value="CONCLUIDO">Concluído</option>
                    <option value="CANCELADO">Cancelado</option>
                  </select>
                </div>
                
                <div class="bg-gray-50 dark:bg-gray-800/30 border border-gray-300 dark:border-gray-700 rounded-lg p-4 space-y-3">
                  <h4 class="text-sm font-semibold text-gray-900 dark:text-gray-300 mb-3 flex items-center">
                    <CurrencyDollarIcon class="w-4 h-4 mr-2" />
                    Valores
                  </h4>
                  
                  <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div class="form-group">
                      <label class="form-label">
                        <TagIcon class="w-4 h-4" />
                        Desconto (R$)
                      </label>
                      <input
                        v-model="appointmentForm.discount"
                        type="number"
                        min="0"
                        step="0.01"
                        class="form-input"
                        placeholder="0,00"
                      />
                    </div>
                    
                    <div class="form-group">
                      <label class="form-label">
                        <CalculatorIcon class="w-4 h-4" />
                        Total
                      </label>
                      <div class="w-full px-3 py-3 bg-white dark:bg-gray-700/50 border border-gray-300 dark:border-gray-600 rounded-lg text-gray-900 dark:text-white font-semibold text-lg">
                        {{ formatCurrency(calculatedTotalPrice) }}
                      </div>
                    </div>
                  </div>
                </div>
                
                <div class="form-group">
                  <label class="form-label">
                    <DocumentTextIcon class="w-4 h-4" />
                    Observações
                  </label>
                  <textarea
                    v-model="appointmentForm.observations"
                    rows="3"
                    class="form-input resize-none"
                    placeholder="Anotações sobre o agendamento..."
                  ></textarea>
                </div>
                
                <div class="flex flex-col-reverse sm:flex-row justify-end space-y-reverse space-y-3 sm:space-y-0 sm:space-x-4 pt-6 border-t border-gray-200 dark:border-gray-700">
                  <button 
                    type="button" 
                    @click="closeModal" 
                    class="px-6 py-3 bg-gray-200 dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg font-medium hover:bg-gray-300 dark:hover:bg-gray-700 transition-colors"
                  >
                    Cancelar
                  </button>
                  <button 
                    type="submit" 
                    class="px-6 py-3 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white rounded-lg font-medium transition-all duration-200 disabled:opacity-50"
                    :disabled="saving"
                  >
                    {{ saving ? 'Salvando...' : (editingAppointment ? 'Atualizar' : 'Agendar') }}
                  </button>
                </div>
              </form>
            </div>
          </Transition>
        </div>
      </Transition>
    </Teleport>

    <!-- Block Time Modal -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition ease-out duration-200"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition ease-in duration-150"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="showBlockModal" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <Transition
            enter-active-class="transition ease-out duration-200"
            enter-from-class="opacity-0 scale-95"
            enter-to-class="opacity-100 scale-100"
            leave-active-class="transition ease-in duration-150"
            leave-from-class="opacity-100 scale-100"
            leave-to-class="opacity-0 scale-95"
          >
            <div class="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 rounded-xl shadow-xl w-full max-w-md">
              <div class="flex items-center justify-between p-6 border-b border-gray-200 dark:border-gray-800">
                <div>
                  <h3 class="text-xl font-semibold text-gray-900 dark:text-white">Bloquear Horário</h3>
                  <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">Bloqueie um horário sem precisar selecionar cliente</p>
                </div>
                <button @click="closeBlockModal" class="p-2 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-colors">
                  <XMarkIcon class="w-5 h-5" />
                </button>
              </div>

              <form @submit.prevent="saveBlock" class="p-6 space-y-4">
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <div class="form-group">
                    <label class="form-label">
                      <CalendarIcon class="w-4 h-4" />
                      Data *
                    </label>
                    <input
                      v-model="blockForm.date"
                      type="date"
                      required
                      class="form-input"
                    />
                  </div>
                  
                  <div class="form-group">
                    <label class="form-label">
                      <ClockIcon class="w-4 h-4" />
                      Hora Início *
                    </label>
                    <input
                      v-model="blockForm.startTime"
                      type="time"
                      required
                      class="form-input"
                    />
                  </div>
                </div>
                
                <div class="form-group">
                  <label class="form-label">
                    <ClockIcon class="w-4 h-4" />
                    Hora Fim (opcional)
                  </label>
                  <input
                    v-model="blockForm.endTime"
                    type="time"
                    class="form-input"
                    placeholder="Deixe vazio para 1 hora"
                  />
                </div>
                
                <div class="form-group">
                  <label class="form-label">
                    <DocumentTextIcon class="w-4 h-4" />
                    Observações
                  </label>
                  <textarea
                    v-model="blockForm.observations"
                    rows="2"
                    class="form-input resize-none"
                    placeholder="Motivo do bloqueio..."
                  ></textarea>
                </div>
                
                <div class="flex flex-col-reverse sm:flex-row justify-end space-y-reverse space-y-3 sm:space-y-0 sm:space-x-4 pt-6 border-t border-gray-200 dark:border-gray-700">
                  <button 
                    type="button" 
                    @click="closeBlockModal" 
                    class="px-6 py-3 bg-gray-200 dark:bg-gray-800 text-gray-900 dark:text-white rounded-lg font-medium hover:bg-gray-300 dark:hover:bg-gray-700 transition-colors"
                  >
                    Cancelar
                  </button>
                  <button 
                    type="submit" 
                    class="px-6 py-3 bg-gray-600 dark:bg-gray-700 hover:bg-gray-700 dark:hover:bg-gray-600 text-white rounded-lg font-medium transition-all duration-200 disabled:opacity-50"
                    :disabled="saving"
                  >
                    {{ saving ? 'Bloqueando...' : 'Bloquear Horário' }}
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
import { ref, computed, reactive, onMounted, watch } from 'vue'
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from '@fullcalendar/interaction'
import listPlugin from '@fullcalendar/list'
import ptBrLocale from '@fullcalendar/core/locales/pt-br'

import { 
  CalendarIcon,
  PlusIcon,
  CheckCircleIcon,
  ClockIcon,
  CurrencyDollarIcon,
  UserIcon,
  XMarkIcon,
  CubeIcon,
  TagIcon,
  CalculatorIcon,
  DocumentTextIcon,
  MagnifyingGlassIcon
} from '@heroicons/vue/24/outline'

// Estado
const appointments = ref([])
const clients = ref([])
const procedures = ref([])
const hairdressers = ref([])
const loading = ref(true)
const saving = ref(false)

const statusFilter = ref('')
const clientFilter = ref('')
const hairdresserFilter = ref('')
const procedureSearchTerm = ref('')

const showCreateModal = ref(false)
const showBlockModal = ref(false)
const editingAppointment = ref(null)
const fullCalendar = ref(null)

const blockForm = reactive({
  date: '',
  startTime: '',
  endTime: '',
  observations: 'Horário bloqueado'
})

const appointmentForm = reactive({
  clientId: '',
  userId: '',
  date: '',
  startTime: '',
  procedureIds: [],
  status: 'AGENDADO',
  observations: '',
  discount: 0
})

// Métodos auxiliares que precisam ser definidos antes do calendarOptions
const formatCurrency = (value) => {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(value)
}

const getStatusColor = (status) => {
  const colors = {
    RETORNO: '#eab308', // Amarelo
    AGENDADO: '#9333ea', // Roxo
    CONFIRMADO: '#22c55e', // Verde
    CONCLUIDO: '#3b82f6', // Azul
    CANCELADO: '#ef4444',
    BLOQUEADO: '#6b7280' // Cinza
  }
  return colors[status] || '#3b82f6'
}

const renderEventContent = (eventInfo) => {
  const { event } = eventInfo
  const props = event.extendedProps
  
  return {
    html: `
      <div class="fc-event-main-content p-1">
        <div class="font-bold text-xs truncate">${event.title}</div>
        <div class="text-xs opacity-90">${props.professional}</div>
        ${props.procedures ? `<div class="text-xs opacity-75 truncate">${props.procedures}</div>` : ''}
        ${props.price ? `<div class="text-xs font-semibold mt-1">${formatCurrency(props.price)}</div>` : ''}
      </div>
    `
  }
}

const handleEventClick = (info) => {
  const appointment = info.event.extendedProps.appointment
  editAppointment(appointment)
}

const handleDateSelect = (selectInfo) => {
  const startDate = selectInfo.start
  const date = startDate.toISOString().split('T')[0]
  const hours = startDate.getHours().toString().padStart(2, '0')
  const minutes = startDate.getMinutes().toString().padStart(2, '0')
  const time = `${hours}:${minutes}`

  Object.assign(appointmentForm, {
    clientId: '',
    userId: '',
    date: date,
    startTime: time,
    procedureIds: [],
    status: 'AGENDADO',
    observations: '',
    discount: 0
  })

  editingAppointment.value = null
  showCreateModal.value = true
}

const openBlockModal = () => {
  const now = new Date()
  const today = now.toISOString().split('T')[0]
  const hours = now.getHours().toString().padStart(2, '0')
  const minutes = now.getMinutes().toString().padStart(2, '0')
  const time = `${hours}:${minutes}`
  
  Object.assign(blockForm, {
    date: today,
    startTime: time,
    endTime: '',
    observations: 'Horário bloqueado'
  })
  showBlockModal.value = true
}

const closeBlockModal = () => {
  showBlockModal.value = false
  Object.assign(blockForm, {
    date: '',
    startTime: '',
    endTime: '',
    observations: 'Horário bloqueado'
  })
}

const saveBlock = async () => {
  if (!blockForm.date || !blockForm.startTime) {
    useToast().add({ type: 'error', title: 'Data e hora inicial são obrigatórias' })
    return
  }

  saving.value = true
  try {
    const { $api } = useNuxtApp()
    
    // Buscar ou criar cliente "BLOQUEADO"
    let blockedClientId = null
    try {
      const clientsList = await $api('/clients')
      const blockedClient = clientsList.find(c => c.name === 'BLOQUEADO' || c.name === 'Bloqueado')
      
      if (blockedClient) {
        blockedClientId = blockedClient.id
      } else {
        // Criar cliente bloqueado se não existir
        const newClient = await $api('/clients', {
          method: 'POST',
          body: {
            name: 'BLOQUEADO',
            active: true
          }
        })
        blockedClientId = newClient.id
      }
    } catch (error) {
      console.error('Erro ao buscar/criar cliente bloqueado:', error)
      useToast().add({ type: 'error', title: 'Erro ao criar bloqueio' })
      return
    }

    // Buscar primeiro usuário disponível para o bloqueio
    let defaultUserId = null
    try {
      const usersList = await $api('/users')
      const firstUser = usersList.find(u => u.active !== false) || usersList[0]
      if (firstUser) {
        defaultUserId = firstUser.id
      } else {
        throw new Error('Nenhum usuário disponível')
      }
    } catch (error) {
      console.error('Erro ao buscar usuário padrão:', error)
      useToast().add({ type: 'error', title: 'Erro ao buscar usuário para bloqueio' })
      return
    }

    // Calcular hora final
    const [year, month, day] = blockForm.date.split('-')
    const [startHours, startMinutes] = blockForm.startTime.split(':')
    const startTimeLocal = new Date(
      parseInt(year),
      parseInt(month) - 1,
      parseInt(day),
      parseInt(startHours),
      parseInt(startMinutes),
      0
    )
    
    let endTimeLocal
    if (blockForm.endTime) {
      const [endHours, endMinutes] = blockForm.endTime.split(':')
      endTimeLocal = new Date(
        parseInt(year),
        parseInt(month) - 1,
        parseInt(day),
        parseInt(endHours),
        parseInt(endMinutes),
        0
      )
    } else {
      // Se não informou hora final, bloqueia por 1 hora
      endTimeLocal = new Date(startTimeLocal.getTime() + (60 * 60 * 1000))
    }
    
    const startTimeISO = startTimeLocal.toISOString()
    const endTimeISO = endTimeLocal.toISOString()

    const payload = {
      clientId: blockedClientId,
      userId: defaultUserId,
      date: blockForm.date,
      startTime: startTimeISO,
      endTime: endTimeISO,
      status: 'BLOQUEADO',
      procedureIds: [], // Bloqueios não têm procedimentos
      observations: blockForm.observations || 'Horário bloqueado'
    }

    await $api('/appointments', { method: 'POST', body: payload })
    
    await loadData()
    closeBlockModal()
    useToast().add({ type: 'success', title: 'Horário bloqueado com sucesso!' })
  } catch (error) {
    console.error('Erro ao bloquear horário:', error)
    useToast().add({ type: 'error', title: 'Erro ao bloquear horário' })
  } finally {
    saving.value = false
  }
}

const handleEventDrop = async (info) => {
  const appointment = info.event.extendedProps.appointment
  const newStart = info.event.start
  const newEnd = info.event.end

  try {
    const { $api } = useNuxtApp()
    await $api(`/appointments/${appointment.id}`, {
      method: 'PATCH',
      body: {
        startTime: newStart.toISOString(),
        endTime: newEnd ? newEnd.toISOString() : undefined,
        date: newStart.toISOString().split('T')[0]
      }
    })
    
    await loadData()
    useToast().add({ type: 'success', title: 'Agendamento movido!' })
  } catch (error) {
    info.revert()
    useToast().add({ type: 'error', title: 'Erro ao mover agendamento' })
  }
}

const handleEventResize = async (info) => {
  const appointment = info.event.extendedProps.appointment
  const newEnd = info.event.end

  try {
    const { $api } = useNuxtApp()
    await $api(`/appointments/${appointment.id}`, {
      method: 'PATCH',
      body: {
        endTime: newEnd.toISOString()
      }
    })
    
    await loadData()
    useToast().add({ type: 'success', title: 'Duração atualizada!' })
  } catch (error) {
    info.revert()
    useToast().add({ type: 'error', title: 'Erro ao redimensionar' })
  }
}

// FullCalendar Options - agora as funções já estão definidas
const calendarOptions = ref({
  plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin, listPlugin],
  initialView: 'timeGridWeek',
  locale: ptBrLocale,
  headerToolbar: {
    left: 'prev,next today',
    center: 'title',
    right: 'timeGridWeek,timeGridDay,listWeek'
  },
  buttonText: {
    today: 'Hoje',
    week: 'Semana',
    day: 'Dia',
    list: 'Lista'
  },
  slotMinTime: '08:00:00',
  slotMaxTime: '20:00:00',
  slotDuration: '00:30:00',
  slotLabelInterval: '01:00',
  expandRows: true,
  nowIndicator: true,
  editable: true,
  selectable: true,
  selectMirror: true,
  dayMaxEvents: true,
  weekends: true,
  allDaySlot: false,
  height: 'auto',
  contentHeight: 800,
  events: [],
  eventClick: handleEventClick,
  select: handleDateSelect,
  eventDrop: handleEventDrop,
  eventResize: handleEventResize,
  eventContent: renderEventContent,
  slotLabelFormat: {
    hour: '2-digit',
    minute: '2-digit',
    hour12: false
  },
  eventTimeFormat: {
    hour: '2-digit',
    minute: '2-digit',
    hour12: false
  }
})

// Computed
const filteredProcedures = computed(() => {
  if (!procedureSearchTerm.value.trim()) {
    return procedures.value
  }
  
  const searchTerm = procedureSearchTerm.value.toLowerCase().trim()
  return procedures.value.filter(procedure => 
    procedure.name.toLowerCase().includes(searchTerm) ||
    (procedure.category && procedure.category.toLowerCase().includes(searchTerm))
  )
})

const calendarEvents = computed(() => {
  let filtered = appointments.value

  if (statusFilter.value) {
    filtered = filtered.filter(apt => apt.status === statusFilter.value)
  }

  if (clientFilter.value) {
    const term = clientFilter.value.toLowerCase()
    filtered = filtered.filter(apt =>
      apt.client?.name.toLowerCase().includes(term)
    )
  }

  if (hairdresserFilter.value) {
    filtered = filtered.filter(apt => apt.userId === hairdresserFilter.value)
  }

  return filtered.map(appointment => ({
    id: appointment.id,
    title: appointment.client?.name || 'Cliente',
    start: appointment.startTime,
    end: appointment.endTime,
    backgroundColor: getStatusColor(appointment.status),
    borderColor: getStatusColor(appointment.status),
    textColor: '#ffffff',
    extendedProps: {
      appointment: appointment,
      professional: appointment.user?.name || 'Sem profissional',
      procedures: appointment.procedures?.map(p => p.procedure?.name).filter(Boolean).join(', ') || '',
      price: appointment.totalPrice,
      status: appointment.status
    }
  }))
})

const todayAppointments = computed(() => {
  const today = new Date().toISOString().split('T')[0]
  return appointments.value.filter(apt => 
    apt.startTime?.startsWith(today)
  ).length
})

const confirmedAppointments = computed(() => {
  return appointments.value.filter(apt => apt.status === 'CONFIRMADO').length
})

const pendingAppointments = computed(() => {
  return appointments.value.filter(apt => apt.status === 'AGENDADO').length
})

const todayRevenue = computed(() => {
  const today = new Date().toISOString().split('T')[0]
  return appointments.value
    .filter(apt => apt.startTime?.startsWith(today) && apt.status !== 'CANCELADO')
    .reduce((sum, apt) => sum + (parseFloat(apt.totalPrice) || 0), 0)
})

const calculatedTotalPrice = computed(() => {
  if (!appointmentForm.procedureIds || appointmentForm.procedureIds.length === 0) {
    return 0
  }
  
  const selectedProcedures = procedures.value.filter(proc => 
    appointmentForm.procedureIds.includes(proc.id)
  )
  
  const subtotal = selectedProcedures.reduce((sum, proc) => {
    return sum + parseFloat(proc.price || 0)
  }, 0)
  
  const discount = parseFloat(appointmentForm.discount || 0)
  return Math.max(0, subtotal - discount)
})

// Watch para atualizar eventos do calendário
watch(calendarEvents, (newEvents) => {
  if (fullCalendar.value) {
    const calendarApi = fullCalendar.value.getApi()
    calendarApi.removeAllEvents()
    calendarApi.addEventSource(newEvents)
  }
})

// Métodos
const clearFilters = () => {
  statusFilter.value = ''
  clientFilter.value = ''
  hairdresserFilter.value = ''
}

const loadData = async () => {
  try {
    const { $api } = useNuxtApp()
    
    const [appointmentsRes, clientsRes, proceduresRes, usersRes] = await Promise.all([
      $api('/appointments'),
      $api('/clients'),
      $api('/procedures'),
      $api('/users')
    ])
    
    appointments.value = appointmentsRes || []
    clients.value = clientsRes || []
    procedures.value = proceduresRes || []
    hairdressers.value = (usersRes || []).filter(user => user.role === 'CABELEIREIRO')
    
  } catch (error) {
    console.error('Erro ao carregar dados:', error)
    useToast().add({ type: 'error', title: 'Erro ao carregar dados' })
  } finally {
    loading.value = false
  }
}

const resetForm = () => {
  Object.assign(appointmentForm, {
    clientId: '',
    userId: '',
    date: '',
    startTime: '',
    procedureIds: [],
    status: 'AGENDADO',
    observations: '',
    discount: 0
  })
  procedureSearchTerm.value = ''
}

const editAppointment = (appointment) => {
  editingAppointment.value = appointment
  
  const appointmentStartTime = new Date(appointment.startTime)
  const year = appointmentStartTime.getFullYear()
  const month = String(appointmentStartTime.getMonth() + 1).padStart(2, '0')
  const day = String(appointmentStartTime.getDate()).padStart(2, '0')
  const formattedDate = `${year}-${month}-${day}`
  
  const hours = String(appointmentStartTime.getHours()).padStart(2, '0')
  const minutes = String(appointmentStartTime.getMinutes()).padStart(2, '0')
  const formattedTime = `${hours}:${minutes}`
  
  Object.assign(appointmentForm, {
    clientId: appointment.clientId,
    userId: appointment.userId || '',
    date: formattedDate,
    startTime: formattedTime,
    procedureIds: appointment.procedures?.map(p => p.procedureId) || [],
    status: appointment.status,
    observations: appointment.observations || '',
    discount: appointment.discount || 0
  })
  procedureSearchTerm.value = ''
  showCreateModal.value = true
}

const closeModal = () => {
  showCreateModal.value = false
  editingAppointment.value = null
  resetForm()
}

const saveAppointment = async () => {
  saving.value = true

  try {
    const { $api } = useNuxtApp()
    
    // Cria a data/hora considerando o timezone local
    // Formato: YYYY-MM-DDTHH:mm (sem timezone, será tratado como local)
    const [year, month, day] = appointmentForm.date.split('-')
    const [hours, minutes] = appointmentForm.startTime.split(':')
    
    // Cria Date no timezone local
    const startTimeLocal = new Date(
      parseInt(year),
      parseInt(month) - 1, // mês é 0-indexed
      parseInt(day),
      parseInt(hours),
      parseInt(minutes),
      0
    )
    
    const selectedProcedures = procedures.value.filter(proc => 
      appointmentForm.procedureIds.includes(proc.id)
    )
    const totalDuration = selectedProcedures.reduce((sum, proc) => 
      sum + (proc.duration || 60), 0
    )
    
    const endTimeLocal = new Date(startTimeLocal.getTime() + (totalDuration * 60 * 1000))
    
    // Envia como ISO string (com timezone) para o backend
    const startTimeISO = startTimeLocal.toISOString()
    const endTimeISO = endTimeLocal.toISOString()

    const payload = {
      clientId: appointmentForm.clientId,
      userId: appointmentForm.userId || undefined,
      date: appointmentForm.date,
      startTime: startTimeISO,
      endTime: endTimeISO,
      procedureIds: appointmentForm.procedureIds,
      discount: appointmentForm.discount ? parseFloat(appointmentForm.discount) : undefined,
      observations: appointmentForm.observations || undefined,
    }

    Object.keys(payload).forEach((key) => {
      if (payload[key] === undefined || payload[key] === null || payload[key] === '') {
        delete payload[key]
      }
    })

    const method = editingAppointment.value ? 'PATCH' : 'POST'
    const url = editingAppointment.value
      ? `/appointments/${editingAppointment.value.id}`
      : '/appointments'

    await $api(url, { method, body: payload })

    if (editingAppointment.value && appointmentForm.status !== editingAppointment.value.status) {
      await $api(`/appointments/${editingAppointment.value.id}/status`, {
        method: 'PATCH',
        body: { status: appointmentForm.status }
      })
    }

    await loadData()
    closeModal()
    useToast().add({ 
      type: 'success', 
      title: editingAppointment.value ? 'Agendamento atualizado!' : 'Agendamento criado!' 
    })
  } catch (error) {
    console.error('Erro ao salvar agendamento:', error)
    useToast().add({ type: 'error', title: 'Erro ao salvar agendamento' })
  } finally {
    saving.value = false
  }
}

onMounted(async () => {
  await loadData()
})
</script>

<style>
/* Custom FullCalendar Dark Mode Styles */
.dark .fc {
  --fc-border-color: rgb(55, 65, 81);
  --fc-button-bg-color: rgb(107, 114, 128);
  --fc-button-border-color: rgb(107, 114, 128);
  --fc-button-hover-bg-color: rgb(75, 85, 99);
  --fc-button-hover-border-color: rgb(75, 85, 99);
  --fc-button-active-bg-color: rgb(55, 65, 81);
  --fc-button-active-border-color: rgb(55, 65, 81);
  --fc-page-bg-color: rgb(17, 24, 39);
  --fc-neutral-bg-color: rgb(31, 41, 55);
  --fc-neutral-text-color: rgb(255, 255, 255);
  --fc-list-event-hover-bg-color: rgb(55, 65, 81);
}

.dark .fc-theme-standard td,
.dark .fc-theme-standard th {
  border-color: rgb(55, 65, 81);
}

.dark .fc-theme-standard .fc-scrollgrid {
  border-color: rgb(55, 65, 81);
}

.dark .fc .fc-col-header-cell-cushion,
.dark .fc .fc-daygrid-day-number,
.dark .fc .fc-list-day-cushion {
  color: rgb(229, 231, 235);
}

.dark .fc .fc-timegrid-slot-label-cushion {
  color: rgb(156, 163, 175);
}

.dark .fc-theme-standard .fc-list-day-cushion {
  background-color: rgb(31, 41, 55);
}

/* Event styling */
.fc-event {
  border-radius: 0.375rem;
  border-width: 2px;
  font-size: 0.75rem;
  padding: 2px;
}

.fc-event-main {
  padding: 2px 4px;
}

/* Slot styling */
.fc .fc-timegrid-slot {
  height: 3rem;
}

.dark .fc-timegrid-slot-minor {
  border-top-style: dashed;
  border-top-color: rgb(55, 65, 81);
}

/* Form styling */
.form-group {
  display: flex;
  flex-direction: column;
}

.form-label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.875rem;
  font-weight: 500;
  color: rgb(55, 65, 81);
  margin-bottom: 0.5rem;
}

.dark .form-label {
  color: rgb(209, 213, 219);
}

.form-input {
  width: 100%;
  padding: 0.625rem 1rem;
  background-color: white;
  border: 1px solid rgb(209, 213, 219);
  border-radius: 0.5rem;
  color: rgb(17, 24, 39);
  font-size: 0.875rem;
  transition: all 0.2s;
}

.form-input:focus {
  outline: none;
  border-color: rgb(59, 130, 246);
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.dark .form-input {
  background-color: rgba(31, 41, 55, 0.5);
  border-color: rgb(55, 65, 81);
  color: white;
}

.dark .form-input:focus {
  border-color: rgb(147, 51, 234);
  box-shadow: 0 0 0 3px rgba(147, 51, 234, 0.1);
}
</style>