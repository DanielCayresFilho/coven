<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between">
      <div>
        <h1 class="text-2xl font-bold text-white">Agendamentos</h1>
        <p class="text-sm text-gray-400 mt-1">Gerencie os agendamentos do salão</p>
      </div>
      <button @click="showCreateModal = true" class="mt-4 sm:mt-0 inline-flex items-center px-4 py-2 bg-gradient-to-r from-purple-600 to-pink-600 text-white rounded-lg font-medium hover:from-purple-700 hover:to-pink-700 transition-all duration-200 shadow-lg shadow-purple-500/25">
        <PlusIcon class="w-5 h-5 mr-2" />
        Novo Agendamento
      </button>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
      <div class="bg-gray-900/50 backdrop-blur border border-gray-800 rounded-xl p-6 hover:border-gray-700 transition-all duration-300">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-400">Hoje</p>
            <p class="text-2xl font-bold text-white mt-2">{{ todayAppointments }}</p>
            <p class="text-xs text-gray-500 mt-1">agendamentos</p>
          </div>
          <div class="p-3 bg-blue-500/10 rounded-xl">
            <CalendarIcon class="w-6 h-6 text-blue-400" />
          </div>
        </div>
      </div>

      <div class="bg-gray-900/50 backdrop-blur border border-gray-800 rounded-xl p-6 hover:border-gray-700 transition-all duration-300">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-400">Confirmados</p>
            <p class="text-2xl font-bold text-white mt-2">{{ confirmedAppointments }}</p>
            <p class="text-xs text-gray-500 mt-1">em andamento</p>
          </div>
          <div class="p-3 bg-green-500/10 rounded-xl">
            <CheckCircleIcon class="w-6 h-6 text-green-400" />
          </div>
        </div>
      </div>

      <div class="bg-gray-900/50 backdrop-blur border border-gray-800 rounded-xl p-6 hover:border-gray-700 transition-all duration-300">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-400">Pendentes</p>
            <p class="text-2xl font-bold text-white mt-2">{{ pendingAppointments }}</p>
            <p class="text-xs text-gray-500 mt-1">aguardando</p>
          </div>
          <div class="p-3 bg-yellow-500/10 rounded-xl">
            <ClockIcon class="w-6 h-6 text-yellow-400" />
          </div>
        </div>
      </div>

      <div class="bg-gray-900/50 backdrop-blur border border-gray-800 rounded-xl p-6 hover:border-gray-700 transition-all duration-300">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-400">Receita Hoje</p>
            <p class="text-2xl font-bold text-white mt-2">{{ formatCurrency(todayRevenue) }}</p>
            <p class="text-xs text-gray-500 mt-1">faturamento</p>
          </div>
          <div class="p-3 bg-purple-500/10 rounded-xl">
            <CurrencyDollarIcon class="w-6 h-6 text-purple-400" />
          </div>
        </div>
      </div>
    </div>

    <!-- Filters -->
    <div class="bg-gray-900/50 backdrop-blur border border-gray-800 rounded-xl p-6">
      <div class="flex items-center justify-between mb-4">
        <h3 class="text-lg font-semibold text-white">Filtros</h3>
        <button @click="clearFilters" class="text-sm text-purple-400 hover:text-purple-300 transition-colors">
          Limpar filtros
        </button>
      </div>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <div>
          <label class="block text-sm font-medium text-gray-300 mb-2">Data</label>
          <input
            v-model="dateFilter"
            type="date"
            class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white focus:outline-none focus:border-purple-500 transition-colors"
          />
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-300 mb-2">Status</label>
          <select v-model="statusFilter" class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white focus:outline-none focus:border-purple-500 transition-colors">
            <option value="">Todos</option>
            <option value="AGENDADO">Agendado</option>
            <option value="CONCLUIDO">Concluído</option>
            <option value="CANCELADO">Cancelado</option>
            <option value="BLOQUEADO">Bloqueado</option>
          </select>
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-300 mb-2">Cliente</label>
          <input
            v-model="clientFilter"
            type="text"
            placeholder="Buscar cliente..."
            class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:border-purple-500 transition-colors"
          />
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-300 mb-2">Profissional</label>
          <select v-model="hairdresserFilter" class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white focus:outline-none focus:border-purple-500 transition-colors">
            <option value="">Todos</option>
            <option v-for="user in hairdressers" :key="user.id" :value="user.id">
              {{ user.name }}
            </option>
          </select>
        </div>
      </div>
    </div>

    <!-- View Toggle -->
    <div class="flex justify-between items-center">
      <div class="flex bg-gray-900/50 backdrop-blur border border-gray-800 rounded-lg p-1">
        <button
          @click="viewMode = 'list'"
          :class="[
            'px-4 py-2 rounded-md font-medium transition-all duration-200',
            viewMode === 'list' 
              ? 'bg-gradient-to-r from-purple-600 to-pink-600 text-white shadow-lg shadow-purple-500/25' 
              : 'text-gray-400 hover:text-white'
          ]"
        >
          <ListBulletIcon  class="w-5 h-5 inline-block mr-2" />
          Lista
        </button>
        <button
          @click="viewMode = 'calendar'"
          :class="[
            'px-4 py-2 rounded-md font-medium transition-all duration-200',
            viewMode === 'calendar' 
              ? 'bg-gradient-to-r from-purple-600 to-pink-600 text-white shadow-lg shadow-purple-500/25' 
              : 'text-gray-400 hover:text-white'
          ]"
        >
          <CalendarDaysIcon class="w-5 h-5 inline-block mr-2" />
          Calendário
        </button>
      </div>
      
      <div v-if="viewMode === 'calendar'" class="flex items-center space-x-3">
        <button @click="previousWeek" class="p-2 text-gray-400 hover:text-white hover:bg-gray-800 rounded-lg transition-all duration-200">
          <ChevronLeftIcon class="w-5 h-5" />
        </button>
        <span class="text-white font-medium px-4">
          {{ formatWeekRange(currentWeekStart) }}
        </span>
        <button @click="nextWeek" class="p-2 text-gray-400 hover:text-white hover:bg-gray-800 rounded-lg transition-all duration-200">
          <ChevronRightIcon class="w-5 h-5" />
        </button>
      </div>
    </div>

    <!-- List View -->
    <div v-if="viewMode === 'list'" class="space-y-4">
      <div v-if="loading" class="space-y-4">
        <div v-for="i in 5" :key="i" class="animate-pulse">
          <div class="bg-gray-800/50 h-24 rounded-xl"></div>
        </div>
      </div>
      
      <div v-else-if="filteredAppointments.length === 0" class="bg-gray-900/50 backdrop-blur border border-gray-800 rounded-xl p-16 text-center">
        <CalendarIcon class="w-16 h-16 mx-auto text-gray-600 mb-4" />
        <h3 class="text-lg font-semibold text-white mb-2">Nenhum agendamento encontrado</h3>
        <p class="text-gray-400">Crie um novo agendamento para começar</p>
      </div>
      
      <div v-else class="space-y-3">
        <div
          v-for="appointment in filteredAppointments"
          :key="appointment.id"
          class="bg-gray-900/50 backdrop-blur border border-gray-800 rounded-xl p-5 hover:border-gray-700 transition-all duration-300 cursor-pointer group"
          @click="editAppointment(appointment)"
        >
          <div class="flex items-center justify-between">
            <div class="flex items-center space-x-4">
              <div class="relative">
                <div class="w-12 h-12 bg-gradient-to-br from-purple-500 to-pink-500 rounded-full flex items-center justify-center text-white font-medium">
                  {{ appointment.client?.name?.charAt(0) || 'C' }}
                </div>
                <div class="absolute -bottom-1 -right-1 w-4 h-4 rounded-full border-2 border-gray-900" :class="getStatusColor(appointment.status)"></div>
              </div>
              <div class="flex-1">
                <div class="flex items-center space-x-3 mb-1">
                  <h3 class="text-lg font-semibold text-white">{{ appointment.client?.name }}</h3>
                  <span :class="[
                    'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium',
                    getStatusBadgeClass(appointment.status)
                  ]">
                    {{ getStatusText(appointment.status) }}
                  </span>
                </div>
                <div class="flex items-center space-x-4 text-sm text-gray-400">
                  <span class="flex items-center">
                    <ClockIcon class="w-4 h-4 mr-1" />
                    {{ formatDateTime(appointment.startTime) }} - {{ formatTime(appointment.endTime) }}
                  </span>
                  <span v-if="appointment.user" class="flex items-center">
                    <UserIcon class="w-4 h-4 mr-1" />
                    {{ appointment.user.name }}
                  </span>
                  <span v-if="appointment.procedures?.length" class="flex items-center">
                    <SparklesIcon class="w-4 h-4 mr-1" />
                    {{ appointment.procedures[0]?.procedure?.name || 'Procedimento' }}
                    <span v-if="appointment.procedures.length > 1" class="ml-1">
                      +{{ appointment.procedures.length - 1 }} outros
                    </span>
                  </span>
                </div>
              </div>
            </div>
            
            <div class="flex items-center space-x-4">
              <div class="text-right">
                <p class="text-xl font-bold text-white">{{ formatCurrency(appointment.totalPrice || 0) }}</p>
                <p v-if="appointment.paymentMethod" class="text-xs text-gray-400 mt-1">{{ appointment.paymentMethod }}</p>
              </div>
              <div class="opacity-0 group-hover:opacity-100 transition-opacity flex space-x-1">
                <button
                  @click.stop="editAppointment(appointment)"
                  class="p-2 text-gray-400 hover:text-white hover:bg-gray-800 rounded-lg transition-all duration-200"
                >
                  <PencilIcon class="w-4 h-4" />
                </button>
                <button
                  @click.stop="confirmDelete(appointment)"
                  class="p-2 text-gray-400 hover:text-red-400 hover:bg-red-900/20 rounded-lg transition-all duration-200"
                >
                  <TrashIcon class="w-4 h-4" />
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Weekly Calendar View - iPhone Style -->
    <div v-if="viewMode === 'calendar'" class="bg-gray-900/50 backdrop-blur border border-gray-800 rounded-xl overflow-hidden">
      <!-- Week Header with Days and Dates -->
      <div class="bg-gray-800/50 border-b border-gray-700">
        <div class="grid grid-cols-8 gap-0">
          <!-- Time Column Header -->
          <div class="p-4 border-r border-gray-700">
            <div class="text-xs text-gray-400 font-medium">Horário</div>
          </div>
          
          <!-- Day Headers -->
          <div
            v-for="day in weekDays"
            :key="day.date"
            class="p-4 text-center border-r border-gray-700 last:border-r-0"
            :class="{ 'bg-purple-900/20': day.isToday }"
          >
            <div class="text-xs font-medium text-gray-400 mb-1">{{ day.dayName }}</div>
            <div 
              class="text-lg font-bold"
              :class="day.isToday ? 'text-purple-400' : 'text-white'"
            >
              {{ day.dayNumber }}
            </div>
          </div>
        </div>
      </div>

      <!-- Time Grid -->
      <div class="overflow-auto max-h-[800px]">
        <div class="relative">
          <!-- Hour Lines -->
          <div
            v-for="hour in timeSlots"
            :key="hour"
            class="grid grid-cols-8 gap-0 border-b border-gray-800/50"
            :style="`height: ${HOUR_HEIGHT}px`"
          >
            <!-- Time Label -->
            <div class="flex items-center justify-center border-r border-gray-700 bg-gray-800/30">
              <span class="text-sm text-gray-400 font-medium">{{ formatHour(hour) }}</span>
            </div>
            
            <!-- Day Columns -->
            <div
              v-for="day in weekDays"
              :key="`${day.date}-${hour}`"
              class="border-r border-gray-700/30 last:border-r-0 relative cursor-pointer hover:bg-purple-900/10 transition-colors"
              :class="{ 'bg-purple-900/5': day.isToday }"
              @click="handleTimeSlotClick(day.date, hour)"
              :title="`Clique para agendar ou bloquear às ${formatHour(hour)} de ${day.dayNumber}/${day.fullDate.getMonth() + 1}`"
            >
              <!-- Half-hour line -->
              <div class="absolute top-1/2 left-0 right-0 border-t border-gray-800/30 pointer-events-none"></div>
            </div>
          </div>

          <!-- Appointments Overlay -->
          <div class="absolute inset-0 pointer-events-none">
            <div
              v-for="appointment in weekAppointments"
              :key="appointment.id"
              @click="handleAppointmentClick(appointment)"
              class="absolute rounded-lg shadow-lg transition-all duration-200 hover:shadow-xl cursor-pointer pointer-events-auto group"
              :style="getAppointmentStyle(appointment)"
              :class="getAppointmentClass(appointment.status)"
            >
              <!-- Blocked time slot content -->
              <div v-if="appointment.status === 'BLOQUEADO'" class="p-2 h-full flex flex-col justify-center items-center">
                <div class="text-center">
                  <div class="text-lg mb-1">🔒</div>
                  <div class="text-xs font-medium text-white opacity-90">BLOQUEADO</div>
                  <div v-if="appointment.observations" class="text-xs text-gray-300 opacity-75 mt-1 truncate">
                    {{ appointment.observations }}
                  </div>
                  <div class="text-xs text-gray-400 opacity-60 mt-1">
                    {{ formatTimeRange(appointment.startTime, appointment.endTime) }}
                  </div>
                </div>
              </div>
              
              <!-- Normal appointment content - Melhorado -->
              <div v-else class="p-2.5 h-full flex flex-col justify-between overflow-hidden">
                <div class="space-y-1.5 flex-1">
                  <div class="flex items-center justify-between">
                    <div class="text-xs font-bold text-white truncate group-hover:scale-105 transition-transform flex-1">
                      {{ appointment.client?.name }}
                    </div>
                    <div v-if="appointment.totalPrice" class="text-xs font-semibold text-white/90 ml-2">
                      {{ formatCurrency(appointment.totalPrice) }}
                    </div>
                  </div>
                  <div class="flex items-center space-x-2">
                    <div class="w-1.5 h-1.5 rounded-full bg-white/80"></div>
                    <div class="text-xs text-white/90 truncate">
                      {{ appointment.user?.name || 'Sem profissional' }}
                    </div>
                  </div>
                  <div v-if="appointment.procedures?.[0]?.procedure?.name" class="flex items-center space-x-2">
                    <div class="w-1.5 h-1.5 rounded-full bg-white/60"></div>
                    <div class="text-xs text-white/80 truncate">
                      {{ appointment.procedures[0].procedure.name }}
                      <span v-if="appointment.procedures.length > 1" class="text-white/60">
                        +{{ appointment.procedures.length - 1 }}
                      </span>
                    </div>
                  </div>
                </div>
                
                <div class="space-y-1 pt-1 border-t border-white/20">
                  <div class="text-xs font-medium text-white/90">
                    {{ formatTimeRange(appointment.startTime, appointment.endTime) }}
                  </div>
                  <div class="flex items-center justify-between">
                    <span 
                      v-if="appointment.status !== 'AGENDADO'"
                      class="inline-flex items-center px-1.5 py-0.5 rounded text-xs font-semibold bg-white/20 text-white"
                    >
                      {{ getStatusLabel(appointment.status) }}
                    </span>
                    <span v-else class="text-xs text-white/70">Agendado</span>
                    <div v-if="appointment.paymentMethod" class="text-xs text-white/70">
                      💳 {{ appointment.paymentMethod }}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Create/Edit Modal -->
    <Modal 
          :show="showCreateModal || !!editingAppointment"
          @close="closeModal"
          :title="editingAppointment ? 'Editar Agendamento' : 'Novo Agendamento'"
          :subtitle="editingAppointment ? 'Atualize as informações do agendamento' : 'Preencha os dados do novo agendamento'"
          :icon="CalendarIcon"
          size="xl"
          variant="default"
        >
          <form @submit.prevent="saveAppointment" class="space-y-4 sm:space-y-6">
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 sm:gap-4">
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
                
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 sm:gap-4">
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
                  
                  <!-- Barra de Pesquisa -->
                  <div class="relative mb-3">
                    <input
                      v-model="procedureSearchTerm"
                      type="text"
                      placeholder="Pesquisar procedimentos..."
                      class="w-full px-4 py-2 pl-10 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:border-purple-500 transition-colors"
                    />
                    <MagnifyingGlassIcon class="w-5 h-5 text-gray-400 absolute left-3 top-1/2 transform -translate-y-1/2" />
                  </div>
                  
                  <div class="max-h-32 sm:max-h-40 overflow-y-auto border border-gray-700 rounded-lg p-2 sm:p-3 bg-gray-800/30">
                    <div class="space-y-1 sm:space-y-2">
                      <label
                        v-for="procedure in filteredProcedures"
                        :key="procedure.id"
                        class="flex items-center space-x-2 sm:space-x-3 cursor-pointer hover:bg-gray-700/50 p-1.5 sm:p-2 rounded transition-colors"
                      >
                        <input
                          type="checkbox"
                          :value="procedure.id"
                          v-model="appointmentForm.procedureIds"
                          class="w-4 h-4 text-purple-600 bg-gray-700 border-gray-600 rounded focus:ring-purple-500 flex-shrink-0"
                        />
                        <div class="flex-1 flex flex-col sm:flex-row sm:items-center sm:justify-between min-w-0">
                          <div class="flex flex-col">
                            <span class="text-white text-sm font-medium truncate">{{ procedure.name }}</span>
                            <span v-if="procedure.category" class="text-xs text-gray-400">{{ procedure.category }}</span>
                          </div>
                          <span class="text-xs sm:text-sm text-purple-400 font-semibold">{{ formatCurrency(procedure.price) }}</span>
                        </div>
                      </label>
                      
                      <div v-if="filteredProcedures.length === 0" class="text-center py-4">
                        <p class="text-gray-400 text-sm">Nenhum procedimento encontrado</p>
                      </div>
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
                    <option value="CONCLUIDO">Concluído</option>
                    <option value="CANCELADO">Cancelado</option>
                  </select>
                </div>
                
                <!-- Seção de Preços -->
                <div class="bg-gray-800/30 border border-gray-700 rounded-lg p-3 sm:p-4 space-y-3">
                  <h4 class="text-sm font-semibold text-gray-300 mb-3 flex items-center">
                    <CurrencyDollarIcon class="w-4 h-4 mr-2" />
                    Valores
                  </h4>
                  
                  <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 sm:gap-4">
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
                      <div class="w-full px-3 py-3 bg-gray-700/50 border border-gray-600 rounded-lg text-white font-semibold text-base sm:text-lg">
                        {{ formatCurrency(calculatedTotalPrice) }}
                      </div>
                      <p v-if="appointmentForm.procedureIds.length === 0" class="text-xs text-gray-400 mt-1">
                        Selecione procedimentos para calcular o valor
                      </p>
                    </div>
                  </div>
                  
                  <div v-if="appointmentForm.procedureIds.length > 0" class="mt-3 pt-3 border-t border-gray-700">
                    <p class="text-xs text-gray-400 mb-2">Detalhamento:</p>
                    <div class="space-y-1">
                      <div 
                        v-for="procedure in procedures.filter(p => appointmentForm.procedureIds.includes(p.id))" 
                        :key="procedure.id"
                        class="flex justify-between text-sm"
                      >
                        <span class="text-gray-300">{{ procedure.name }}</span>
                        <span class="text-purple-400">{{ formatCurrency(procedure.price) }}</span>
                      </div>
                      <div v-if="appointmentForm.discount > 0" class="flex justify-between text-sm text-red-400">
                        <span>Desconto</span>
                        <span>-{{ formatCurrency(appointmentForm.discount) }}</span>
                      </div>
                      <div class="flex justify-between text-sm font-semibold text-white pt-2 border-t border-gray-700">
                        <span>Total</span>
                        <span>{{ formatCurrency(calculatedTotalPrice) }}</span>
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
                
                <!-- Modal Footer -->
                <div class="flex flex-col-reverse sm:flex-row justify-end space-y-reverse space-y-3 sm:space-y-0 sm:space-x-4 pt-4 sm:pt-6 border-t border-gray-700/50">
                  <button 
                    type="button" 
                    @click="closeModal" 
                    class="btn-secondary px-4 sm:px-6 py-3 w-full sm:w-auto"
                  >
                    <XMarkIcon class="w-4 h-4 mr-2" />
                    Cancelar
                  </button>
                  <button 
                    type="submit" 
                    class="px-4 py-2 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white rounded-lg font-medium transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
                    :disabled="saving"
                  >
                    <span v-if="saving" class="flex items-center">
                      <svg class="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                      </svg>
                      Salvando...
                    </span>
                    <span v-else>
                      {{ editingAppointment ? 'Atualizar' : 'Agendar' }}
                    </span>
                  </button>
                </div>
              </form>
        </Modal>

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
        <div v-if="appointmentToDelete" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
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
                <h3 class="text-lg font-semibold text-white text-center mb-2">
                  Confirmar exclusão
                </h3>
                <p class="text-sm text-gray-400 text-center mb-6">
                  Tem certeza que deseja excluir este agendamento? Esta ação não pode ser desfeita.
                </p>
                <div class="flex space-x-3">
                  <button 
                    @click="appointmentToDelete = null" 
                    class="flex-1 px-4 py-2 bg-gray-800 hover:bg-gray-700 text-white rounded-lg font-medium transition-colors"
                  >
                    Cancelar
                  </button>
                  <button 
                    @click="deleteAppointment" 
                    class="flex-1 px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg font-medium transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                    :disabled="deleting"
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

    <!-- Reschedule Modal -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition ease-out duration-200"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition ease-in duration-150"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="showRescheduleModal" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <Transition
            enter-active-class="transition ease-out duration-200"
            enter-from-class="opacity-0 scale-95"
            enter-to-class="opacity-100 scale-100"
            leave-active-class="transition ease-in duration-150"
            leave-from-class="opacity-100 scale-100"
            leave-to-class="opacity-0 scale-95"
          >
            <div class="bg-gray-900 border border-gray-800 rounded-xl shadow-xl w-full max-w-md p-6">
              <div class="text-center mb-6">
                <div class="p-3 bg-gradient-to-br from-green-600 to-emerald-600 rounded-full mx-auto w-12 h-12 flex items-center justify-center mb-4">
                  <CalendarIcon class="w-6 h-6 text-white" />
                </div>
                <h3 class="text-xl font-semibold text-white mb-2">
                  Agendamento Concluído!
                </h3>
                <p class="text-sm text-gray-400 mb-4">
                  Deseja reagendar <strong class="text-white">{{ completedClient?.name }}</strong> para uma próxima consulta?
                </p>
                
                <div class="text-left mb-4">
                  <label class="block text-sm font-medium text-gray-300 mb-2">Data sugerida (30 dias)</label>
                  <input 
                    v-model="rescheduleDate" 
                    type="date" 
                    class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white focus:outline-none focus:border-purple-500 transition-colors"
                  />
                </div>
              </div>
              
              <div class="flex space-x-3">
                <button 
                  @click="closeRescheduleModal" 
                  class="flex-1 px-4 py-2 bg-gray-800 hover:bg-gray-700 text-white rounded-lg font-medium transition-colors"
                >
                  Não, obrigado
                </button>
                <button 
                  @click="confirmReschedule" 
                  class="flex-1 px-4 py-2 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white rounded-lg font-medium transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                  :disabled="rescheduling"
                >
                  <span v-if="rescheduling" class="flex items-center justify-center">
                    <svg class="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                      <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    Reagendando...
                  </span>
                  <span v-else>Sim, reagendar</span>
                </button>
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
  CalendarIcon,
  PlusIcon,
  CalendarDaysIcon,
  CheckCircleIcon,
  ClockIcon,
  CurrencyDollarIcon,
  UserIcon,
  SparklesIcon,
  PencilIcon,
  TrashIcon,
  XMarkIcon,
  CheckIcon,
  CubeIcon,
  CreditCardIcon,
  TagIcon,
  CalculatorIcon,
  DocumentTextIcon,
  ExclamationTriangleIcon,
  ChevronLeftIcon,
  ChevronRightIcon,
  Squares2X2Icon,
  ListBulletIcon,
  MagnifyingGlassIcon 
} from '@heroicons/vue/24/outline'

definePageMeta({
  layout: 'default',
  middleware: 'auth'
})

useSeoMeta({
  title: 'Agendamentos - Coven Beauty',
  description: 'Gerenciamento de agendamentos do salão'
})

// Estado
const appointments = ref([])
const clients = ref([])
const procedures = ref([])
const hairdressers = ref([])
const loading = ref(true)
const saving = ref(false)
const deleting = ref(false)

const viewMode = ref('calendar') // Calendário como padrão
const dateFilter = ref('')
const statusFilter = ref('')
const clientFilter = ref('')
const hairdresserFilter = ref('')

const currentWeekStart = ref(new Date())

// Constants for calendar
const HOUR_HEIGHT = 60 // Height of each hour in pixels
const START_HOUR = 8 // 8:00
const END_HOUR = 20 // 20:00 (8:00 PM)

// Time slots for the calendar
const timeSlots = Array.from({ length: END_HOUR - START_HOUR }, (_, i) => START_HOUR + i)

const showCreateModal = ref(false)
const editingAppointment = ref(null)
const appointmentToDelete = ref(null)

// Rescheduling modal state
const showRescheduleModal = ref(false)
const completedClient = ref(null)
const rescheduleDate = ref('')
const rescheduling = ref(false)
const procedureSearchTerm = ref('')

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

const filteredAppointments = computed(() => {
  let filtered = appointments.value

  // Não mostrar cancelados por padrão (a menos que seja explicitamente selecionado)
  if (!statusFilter.value) {
    filtered = filtered.filter(apt => apt.status !== 'CANCELADO')
  } else if (statusFilter.value) {
    filtered = filtered.filter(apt => apt.status === statusFilter.value)
  }

  if (dateFilter.value) {
    filtered = filtered.filter(apt =>
      apt.date?.startsWith(dateFilter.value)
    )
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

  // Ordenar do mais recente para o mais antigo
  return filtered.sort((a, b) => new Date(b.startTime) - new Date(a.startTime))
})

// Week days with proper formatting for weekly view (Monday to Sunday)
const weekDays = computed(() => {
  const start = new Date(currentWeekStart.value)
  const days = []
  const today = new Date().toDateString()
  const dayNames = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom']
  
  for (let i = 0; i < 7; i++) {
    const date = new Date(start)
    date.setDate(start.getDate() + i)
    
    days.push({
      date: date.toISOString().split('T')[0],
      dayName: dayNames[i], // Use array index for Monday-first week
      dayNumber: date.getDate(),
      isToday: date.toDateString() === today,
      fullDate: date
    })
  }
  
  return days
})

// Appointments for the current week filtered and positioned - INCLUINDO CONCLUÍDOS
const weekAppointments = computed(() => {
  const start = new Date(currentWeekStart.value)
  const end = new Date(start)
  end.setDate(start.getDate() + 7)
  
  // Incluir TODOS os agendamentos (agendados, confirmados, concluídos) - não filtrar por status
  return appointments.value.filter(apt => {
    // Use startTime for more accurate date comparison
    const aptDateTime = new Date(apt.startTime)
    const aptDate = new Date(aptDateTime.getFullYear(), aptDateTime.getMonth(), aptDateTime.getDate())
    const startDate = new Date(start.getFullYear(), start.getMonth(), start.getDate())
    const endDate = new Date(end.getFullYear(), end.getMonth(), end.getDate())
    
    return aptDate >= startDate && aptDate < endDate
  })
})

const todayAppointments = computed(() => {
  const today = new Date()
  const todayStr = today.getFullYear() + '-' + String(today.getMonth() + 1).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0')
  
  return appointments.value.filter(apt => {
    const aptDate = apt.date.split('T')[0] // Pega apenas a parte da data (YYYY-MM-DD)
    return aptDate === todayStr
  }).length
})

const confirmedAppointments = computed(() => {
  return appointments.value.filter(apt => apt.status === 'CONFIRMADO').length
})

const pendingAppointments = computed(() => {
  return appointments.value.filter(apt => apt.status === 'AGENDADO').length
})

const todayRevenue = computed(() => {
  const today = new Date()
  const todayStr = today.getFullYear() + '-' + String(today.getMonth() + 1).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0')
  
  return appointments.value
    .filter(apt => {
      const aptDate = apt.date.split('T')[0] // Pega apenas a parte da data (YYYY-MM-DD)
      const isToday = aptDate === todayStr
      const isNotCancelled = apt.status !== 'CANCELADO'
      return isToday && isNotCancelled
    })
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

// Métodos
const formatCurrency = (value) => {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(value)
}

const formatDateTime = (dateTime) => {
  return new Date(dateTime).toLocaleString('pt-BR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

const formatTime = (dateTime) => {
  return new Date(dateTime).toLocaleString('pt-BR', {
    hour: '2-digit',
    minute: '2-digit'
  })
}

const formatWeekRange = (startDate) => {
  const start = new Date(startDate)
  const end = new Date(start)
  end.setDate(start.getDate() + 6)
  
  const options = { day: '2-digit', month: 'short' }
  return `${start.toLocaleDateString('pt-BR', options)} - ${end.toLocaleDateString('pt-BR', options)}`
}

// New methods for weekly calendar
const formatHour = (hour) => {
  return `${hour.toString().padStart(2, '0')}:00`
}

const formatTimeRange = (startTime, endTime) => {
  const start = formatTime(startTime)
  const end = endTime ? formatTime(endTime) : ''
  return end ? `${start} - ${end}` : start
}

const getAppointmentStyle = (appointment) => {
  // Converter startTime para Date, garantindo fuso horário local
  const startTime = new Date(appointment.startTime)
  
  // Se não tiver endTime, calcular baseado na duração dos procedimentos ou usar 1 hora padrão
  let endTime
  if (appointment.endTime) {
    endTime = new Date(appointment.endTime)
  } else if (appointment.procedures && appointment.procedures.length > 0) {
    // Calcular endTime baseado na duração dos procedimentos
    const totalDuration = appointment.procedures.reduce((sum, ap) => 
      sum + (ap.procedure?.duration || 60), 0
    )
    endTime = new Date(startTime.getTime() + (totalDuration * 60 * 1000))
  } else {
    // Default 1 hour
    endTime = new Date(startTime.getTime() + (60 * 60 * 1000))
  }
  
  // Criar datas locais para comparação (sem fuso horário)
  const startDateLocal = new Date(startTime.getFullYear(), startTime.getMonth(), startTime.getDate())
  
  // Find which day column this appointment belongs to - usar data local
  const dayIndex = weekDays.value.findIndex(day => {
    const dayDate = new Date(day.date + 'T00:00:00') // Garantir hora local
    return startDateLocal.getTime() === dayDate.getTime()
  })
  
  if (dayIndex === -1) return { display: 'none' }
  
  // Calcular posição usando hora local
  const startHour = startTime.getHours()
  const startMinute = startTime.getMinutes()
  const endHour = endTime.getHours()
  const endMinute = endTime.getMinutes()
  
  // Verificar se está dentro do horário de trabalho
  if (startHour < START_HOUR || startHour >= END_HOUR) {
    return { display: 'none' }
  }
  
  // Calcular posição vertical em pixels (considerando minutos)
  const topOffset = (startHour - START_HOUR) * HOUR_HEIGHT + (startMinute / 60) * HOUR_HEIGHT
  
  // Calcular duração em horas (considerando que pode passar da meia-noite)
  let durationInHours = 0
  if (endTime >= startTime) {
    // Duração normal (não passou da meia-noite)
    durationInHours = (endTime - startTime) / (1000 * 60 * 60) // Converter ms para horas
  } else {
    // Se endTime for menor que startTime, assumir que passou da meia-noite (caso raro, mas possível)
    durationInHours = ((endTime.getHours() + 24) - startHour) + (endMinute - startMinute) / 60
  }
  
  const height = Math.max(durationInHours * HOUR_HEIGHT, 40) // Altura mínima de 40px
  
  // Posição da coluna
  const columnWidth = 100 / 8 // 8 colunas (1 hora + 7 dias)
  const leftPercent = (dayIndex + 1) * columnWidth
  const widthPercent = columnWidth - 0.5 // Margem pequena para separação visual
  
  return {
    top: `${topOffset}px`,
    left: `${leftPercent}%`,
    width: `${widthPercent}%`,
    height: `${height}px`,
    zIndex: 10,
    marginLeft: '2px',
    marginRight: '2px'
  }
}

const getAppointmentClass = (status) => {
  const baseClasses = 'border-l-4 shadow-md'
  
  switch (status) {
    case 'AGENDADO':
      return `${baseClasses} bg-gradient-to-r from-blue-500 to-blue-600 border-blue-400 hover:from-blue-400 hover:to-blue-500 text-white`
    case 'CONFIRMADO':
      return `${baseClasses} bg-gradient-to-r from-yellow-500 to-yellow-600 border-yellow-400 hover:from-yellow-400 hover:to-yellow-500 text-white`
    case 'CONCLUIDO':
      return `${baseClasses} bg-gradient-to-r from-green-500 to-green-600 border-green-400 hover:from-green-400 hover:to-green-500 text-white`
    case 'CANCELADO':
      return `${baseClasses} bg-gradient-to-r from-red-500 to-red-600 border-red-400 hover:from-red-400 hover:to-red-500 text-white opacity-60`
    case 'BLOQUEADO':
      return `${baseClasses} bg-gradient-to-r from-gray-600 to-gray-700 border-gray-500 hover:from-gray-500 hover:to-gray-600 text-white`
    default:
      return `${baseClasses} bg-gradient-to-r from-blue-500 to-blue-600 border-blue-400 hover:from-blue-400 hover:to-blue-500 text-white`
  }
}

const getStatusBadgeClass = (status) => {
  switch (status) {
    case 'AGENDADO':
      return 'bg-blue-900/50 text-blue-400 border border-blue-800'
    case 'CONFIRMADO':
      return 'bg-yellow-900/50 text-yellow-400 border border-yellow-800'
    case 'CONCLUIDO':
      return 'bg-purple-900/50 text-purple-400 border border-purple-800'
    case 'CANCELADO':
      return 'bg-red-900/50 text-red-400 border border-red-800'
    case 'BLOQUEADO':
      return 'bg-gray-900/50 text-gray-400 border border-gray-800'
    default:
      return 'bg-blue-900/50 text-blue-400 border border-blue-800'
  }
}

const getStatusLabel = (status) => {
  switch (status) {
    case 'AGENDADO': return 'Agendado'
    case 'CONFIRMADO': return 'Confirmado'
    case 'CONCLUIDO': return 'Concluído'
    case 'CANCELADO': return 'Cancelado'
    case 'BLOQUEADO': return 'Bloqueado'
    default: return status
  }
}

const handleAppointmentClick = (appointment) => {
  // Handle different actions based on appointment status
  switch (appointment.status) {
    case 'AGENDADO':
      // Option to confirm or edit
      editAppointment(appointment)
      break
    case 'CONFIRMADO':
      // Option to open comanda
      openComanda(appointment)
      break
    case 'BLOQUEADO':
      // Option to remove block or edit reason
      handleBlockedSlot(appointment)
      break
    default:
      // Default to edit
      editAppointment(appointment)
  }
}

const handleTimeSlotClick = (date, hour) => {
  // Formato da data para o input (YYYY-MM-DD)
  const formattedDate = date
  
  // Formato do horário (HH:MM)
  const formattedTime = hour.toString().padStart(2, '0') + ':00'
  
  // Check if there's already an appointment at this time slot
  const existingAppointment = weekAppointments.value.find(apt => {
    const aptDate = new Date(apt.startTime)
    const slotDate = new Date(`${date}T${formattedTime}`)
    return Math.abs(aptDate - slotDate) < 60000 // Within 1 minute
  })
  
  if (existingAppointment) {
    // If there's an existing appointment, open it for editing
    handleAppointmentClick(existingAppointment)
    return
  }
  
  // Show context menu for empty slot
  const action = confirm('O que deseja fazer neste horário?\n\nOK = Agendar cliente\nCancelar = Bloquear horário')
  
  if (action) {
    // User chose to create appointment
    Object.assign(appointmentForm, {
      clientId: '',
      userId: '',
      date: formattedDate,
      startTime: formattedTime,
      procedureIds: [],
      status: 'AGENDADO',
      observations: '',
      discount: 0
    })
    
    editingAppointment.value = null
    showCreateModal.value = true
  } else {
    // User chose to block time slot
    createTimeBlock(date, hour)
  }
}

const handleBlockedSlot = async (appointment) => {
  const action = confirm(`Horário bloqueado: "${appointment.observations || 'Sem motivo especificado'}"\n\nO que deseja fazer?\n\nOK = Remover bloqueio\nCancelar = Editar motivo`)
  
  if (action) {
    // Remove block
    await removeTimeBlock(appointment)
  } else {
    // Edit block reason
    await editTimeBlock(appointment)
  }
}

const removeTimeBlock = async (appointment) => {
  try {
    const { $api } = useNuxtApp()
    deleting.value = true
    
    const confirmed = confirm('Tem certeza que deseja remover este bloqueio?')
    if (!confirmed) return
    
    await $api(`/appointments/${appointment.id}`, {
      method: 'DELETE'
    })
    
    useToast().add({
      type: 'success',
      title: 'Bloqueio removido!',
      description: 'O horário foi desbloqueado com sucesso.'
    })
    
    // Reload appointments
    await loadData()
    
  } catch (error) {
    console.error('❌ Erro ao remover bloqueio:', error)
    useToast().add({
      type: 'error',
      title: 'Erro ao remover bloqueio',
      description: 'Não foi possível remover o bloqueio. Tente novamente.'
    })
  } finally {
    deleting.value = false
  }
}

const editTimeBlock = async (appointment) => {
  try {
    const { $api } = useNuxtApp()
    
    const newReason = prompt('Novo motivo do bloqueio:', appointment.observations || 'Horário bloqueado')
    if (newReason === null) return // User cancelled
    
    await $api(`/appointments/${appointment.id}`, {
      method: 'PATCH',
      body: {
        observations: newReason
      }
    })
    
    useToast().add({
      type: 'success',
      title: 'Bloqueio atualizado!',
      description: 'O motivo do bloqueio foi atualizado.'
    })
    
    // Reload appointments
    await loadData()
    
  } catch (error) {
    console.error('❌ Erro ao editar bloqueio:', error)
    useToast().add({
      type: 'error',
      title: 'Erro ao editar bloqueio',
      description: 'Não foi possível editar o bloqueio. Tente novamente.'
    })
  }
}

const createTimeBlock = async (date, hour) => {
  try {
    const { $api } = useNuxtApp()
    saving.value = true
    
    // Get block reason from user
    const reason = prompt('Motivo do bloqueio (opcional):', 'Horário bloqueado')
    if (reason === null) return // User cancelled
    
    const formattedTime = hour.toString().padStart(2, '0') + ':00'
    const startTime = new Date(`${date}T${formattedTime}`)
    const endTime = new Date(startTime.getTime() + (60 * 60 * 1000)) // 1 hour duration
    
    const blockData = {
      clientId: null, // No client for blocks
      userId: hairdressers.value[0]?.id || null, // Default to first hairdresser or null
      date: date,
      startTime: startTime.toISOString(),
      endTime: endTime.toISOString(),
      status: 'BLOQUEADO',
      observations: reason,
      totalPrice: 0,
      procedureIds: [] // No procedures for blocks
    }
    
    await $api('/appointments', {
      method: 'POST',
      body: blockData
    })
    
    useToast().add({
      type: 'success',
      title: 'Horário bloqueado!',
      description: `Horário das ${hour}:00 foi bloqueado com sucesso.`
    })
    
    // Reload appointments to show the new block
    await loadData()
    
  } catch (error) {
    console.error('❌ Erro ao bloquear horário:', error)
    useToast().add({
      type: 'error',
      title: 'Erro ao bloquear horário',
      description: 'Não foi possível bloquear o horário. Tente novamente.'
    })
  } finally {
    saving.value = false
  }
}

const openComanda = async (appointment) => {
  try {
    const { $api } = useNuxtApp()
    await $api(`/appointments/${appointment.id}/open-comanda`, {
      method: 'PATCH',
      headers: {
        'Authorization': `Bearer ${useCookie('covenos-token').value}`
      }
    })
    
    useToast().success('Comanda aberta com sucesso!')
    await loadAppointments()
  } catch (error) {
    console.error('Erro ao abrir comanda:', error)
    useToast().error('Erro ao abrir comanda')
  }
}

const goToComanda = (appointment) => {
  // This would navigate to a comanda management page
  // For now, we'll edit the appointment
  editAppointment(appointment)
}

const getStatusColor = (status) => {
  const colors = {
    AGENDADO: 'bg-blue-500',
    CONFIRMADO: 'bg-yellow-500',
    CONCLUIDO: 'bg-purple-500',
    CANCELADO: 'bg-red-500',
  }
  return colors[status] || 'bg-blue-500'
}

const getStatusText = (status) => {
  const texts = {
    AGENDADO: 'Agendado',
    CONFIRMADO: 'Confirmado',
    CONCLUIDO: 'Concluído',
    CANCELADO: 'Cancelado',
  }
  return texts[status] || status
}

const clearFilters = () => {
  dateFilter.value = ''
  statusFilter.value = ''
  clientFilter.value = ''
  hairdresserFilter.value = ''
}

const previousWeek = () => {
  const newDate = new Date(currentWeekStart.value)
  newDate.setDate(newDate.getDate() - 7)
  currentWeekStart.value = newDate
}

const nextWeek = () => {
  const newDate = new Date(currentWeekStart.value)
  newDate.setDate(newDate.getDate() + 7)
  currentWeekStart.value = newDate
}

const loadData = async () => {
  try {
    const { $api } = useNuxtApp()
    
    console.log('🔄 Carregando dados da API...')
    
    const [appointmentsRes, clientsRes, proceduresRes, usersRes] = await Promise.all([
      $api('/appointments').catch((error) => {
        console.error('❌ Erro ao carregar agendamentos:', error)
        return []
      }),
      $api('/clients').catch((error) => {
        console.error('❌ Erro ao carregar clientes:', error)
        return []
      }),
      $api('/procedures').catch((error) => {
        console.error('❌ Erro ao carregar procedimentos:', error)
        return []
      }),
      $api('/users').catch((error) => {
        console.error('❌ Erro ao carregar usuários:', error)
        return []
      })
    ])
    
    appointments.value = appointmentsRes || []
    clients.value = clientsRes || []
    procedures.value = proceduresRes || []
    hairdressers.value = (usersRes || []).filter(user => user.role === 'CABELEIREIRO')
    
    console.log('✅ Dados carregados:')
    console.log(`   📅 Agendamentos: ${appointments.value.length}`)
    console.log('   📅 Raw appointments data:', appointmentsRes)
    console.log(`   👥 Clientes: ${clients.value.length}`)
    console.log(`   ✨ Procedimentos: ${procedures.value.length}`)
    console.log(`   💇 Profissionais: ${hairdressers.value.length}`)
    
    // Debug appointments data
    if (appointments.value.length > 0) {
      console.log('🔍 First appointment:', appointments.value[0])
    }
    
    // Log dos procedimentos para verificar se têm produtos associados
    procedures.value.forEach((procedure, index) => {
      if (procedure.procedureProducts?.length > 0) {
        console.log(`   🧪 Procedimento "${procedure.name}" tem ${procedure.procedureProducts.length} produtos`)
      }
    })
    
  } catch (error) {
    console.error('💥 Erro geral ao carregar dados:', error)
    const toast = useToast()
    toast.error('Erro ao carregar dados da API')
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
  
  // Formatar data corretamente para o input date (YYYY-MM-DD)
  // Usar a data do startTime para garantir consistência
  const appointmentStartTime = new Date(appointment.startTime)
  const year = appointmentStartTime.getFullYear()
  const month = String(appointmentStartTime.getMonth() + 1).padStart(2, '0')
  const day = String(appointmentStartTime.getDate()).padStart(2, '0')
  const formattedDate = `${year}-${month}-${day}`
  
  // Formatar horário corretamente para o input time (HH:MM) usando hora local
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
  showCreateModal.value = true // Abrir modal para editar
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
    const toast = useToast()

    const startDateTime = `${appointmentForm.date}T${appointmentForm.startTime}:00`
    
    // Calcular duração total dos procedimentos selecionados
    const selectedProcedures = procedures.value.filter(proc => 
      appointmentForm.procedureIds.includes(proc.id)
    )
    const totalDuration = selectedProcedures.reduce((sum, proc) => 
      sum + (proc.duration || 60), 0 // Duração padrão de 60 minutos se não especificada
    )
    
    // Calcular endTime automaticamente
    const startTime = new Date(startDateTime)
    const endTime = new Date(startTime.getTime() + (totalDuration * 60 * 1000))
    const endDateTime = endTime.toISOString()

    const payload = {
      clientId: appointmentForm.clientId,
      userId: appointmentForm.userId || undefined,
      date: appointmentForm.date,
      startTime: startDateTime,
      endTime: endDateTime, // Calculado automaticamente
      procedureIds: appointmentForm.procedureIds,
      discount: appointmentForm.discount
        ? parseFloat(appointmentForm.discount)
        : undefined,
      observations: appointmentForm.observations || undefined,
    }

    // Remove apenas campos inválidos (null, undefined, string vazia)
    Object.keys(payload).forEach((key) => {
      if (
        payload[key] === undefined ||
        payload[key] === null ||
        payload[key] === ''
      ) {
        delete payload[key]
      }
    })

    console.log('💾 Salvando agendamento (payload final):', payload)
    console.log('⏱️ Duração total calculada:', totalDuration, 'minutos')

    const method = editingAppointment.value ? 'PATCH' : 'POST'
    const url = editingAppointment.value
      ? `/appointments/${editingAppointment.value.id}`
      : '/appointments'

    await $api(url, {
      method,
      body: payload,
    })

    // Detectar se o status mudou para CONCLUIDO
    const wasCompleted = editingAppointment.value &&
      appointmentForm.status === 'CONCLUIDO' &&
      appointmentForm.status !== editingAppointment.value.status

    if (
      editingAppointment.value &&
      appointmentForm.status !== editingAppointment.value.status
    ) {
      await $api(`/appointments/${editingAppointment.value.id}/status`, {
        method: 'PATCH',
        body: {
          status: appointmentForm.status,
        },
      })
    }

    await loadData()
    closeModal()

    // Se agendamento foi concluído, mostrar popup de reagendamento
    if (wasCompleted) {
      const client = clients.value.find(c => c.id === appointmentForm.clientId)
      if (client) {
        completedClient.value = client
        // Calcular data para 30 dias no futuro
        const futureDate = new Date()
        futureDate.setDate(futureDate.getDate() + 30)
        rescheduleDate.value = futureDate.toISOString().split('T')[0]
        showRescheduleModal.value = true
      }
    }

    toast.success(
      editingAppointment.value
        ? 'Agendamento atualizado!'
        : 'Agendamento criado!'
    )
  } catch (error) {
    console.error('💥 Erro ao salvar agendamento:', error)
    const toast = useToast()
    toast.error('Erro ao salvar agendamento')
  } finally {
    saving.value = false
  }
}

const confirmDelete = (appointment) => {
  appointmentToDelete.value = appointment
}

const deleteAppointment = async () => {
  deleting.value = true
  
  try {
    const { $api } = useNuxtApp()
    const toast = useToast()
    
    console.log('🗑️ Excluindo agendamento:', appointmentToDelete.value.id)
    
    await $api(`/appointments/${appointmentToDelete.value.id}`, {
      method: 'DELETE'
    })
    
    await loadData()
    appointmentToDelete.value = null
    toast.success('Agendamento excluído!')
  } catch (error) {
    console.error('💥 Erro ao excluir agendamento:', error)
    const toast = useToast()
    toast.error('Erro ao excluir agendamento')
  } finally {
    deleting.value = false
  }
}

// Rescheduling functions
const closeRescheduleModal = () => {
  showRescheduleModal.value = false
  completedClient.value = null
  rescheduleDate.value = ''
}

const confirmReschedule = async () => {
  if (!completedClient.value || !rescheduleDate.value) return
  
  rescheduling.value = true
  
  try {
    const { $api } = useNuxtApp()
    const toast = useToast()
    
    console.log('📅 Reagendando cliente:', completedClient.value.name)
    
    // Usar o primeiro usuário (hairdresser) disponível como padrão
    const defaultUserId = hairdressers.value[0]?.id || null
    
    // Criar novo agendamento para reagendamento
    await $api('/appointments', {
      method: 'POST',
      body: {
        clientId: completedClient.value.id,
        date: rescheduleDate.value,
        startTime: `${rescheduleDate.value}T10:00:00`, // Horário padrão 10h
        userId: defaultUserId,
        procedureIds: [], // Será preenchido ao editar o agendamento
        status: 'AGENDADO'
      }
    })
    
    await loadData()
    closeRescheduleModal()
    toast.success(`Cliente ${completedClient.value.name} reagendado para ${new Date(rescheduleDate.value).toLocaleDateString('pt-BR')}!`)
  } catch (error) {
    console.error('💥 Erro ao reagendar cliente:', error)
    const toast = useToast()
    toast.error('Erro ao reagendar cliente')
  } finally {
    rescheduling.value = false
  }
}

// Lifecycle
onMounted(async () => {
  const today = new Date()
  const dayOfWeek = today.getDay()
  // Calculate days to subtract to get to Monday (day 1)
  // If today is Sunday (0), subtract 6 days; otherwise subtract (dayOfWeek - 1)
  const daysToSubtract = dayOfWeek === 0 ? 6 : dayOfWeek - 1
  const lastMonday = new Date(today)
  lastMonday.setDate(today.getDate() - daysToSubtract)
  currentWeekStart.value = lastMonday
  
  await loadData()
  
  // Check for edit parameter from comandas page
  const route = useRoute()
  if (route.query.edit) {
    const appointmentId = route.query.edit
    const appointment = appointments.value.find(apt => apt.id === appointmentId)
    if (appointment) {
      setTimeout(() => {
        editAppointment(appointment)
      }, 500) // Wait a bit for UI to settle
    }
  }
  
  // Check for reschedule parameters
  if (route.query.client && route.query.reschedule) {
    // Pre-fill form for reschedule
    setTimeout(() => {
      appointmentForm.clientId = route.query.client
      showCreateModal.value = true
    }, 1000) // Wait for data to load
  }
})
</script>