<template>
  <div class="space-y-8">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between">
      <div>
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Procedimentos</h1>
        <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">Gerencie os procedimentos e serviços oferecidos</p>
      </div>
      <button @click="showCreateModal = true" class="mt-4 sm:mt-0 inline-flex items-center px-4 py-2 bg-blue-600 dark:bg-gradient-to-r dark:from-purple-600 dark:to-pink-600 text-white rounded-lg font-medium hover:bg-blue-700 dark:hover:from-purple-700 dark:hover:to-pink-700 transition-all duration-200 shadow-md">
        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
        </svg>
        Novo Procedimento
      </button>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 hover:border-gray-300 dark:hover:border-gray-700 transition-all duration-300 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Total de Procedimentos</p>
            <p class="text-2xl font-bold text-gray-900 dark:text-white mt-2">{{ procedures.length }}</p>
            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">cadastrados</p>
          </div>
          <div class="p-3 bg-purple-100 dark:bg-purple-500/10 rounded-xl">
            <svg class="w-6 h-6 text-purple-600 dark:text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"></path>
            </svg>
          </div>
        </div>
      </div>
      
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 hover:border-gray-300 dark:hover:border-gray-700 transition-all duration-300 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Procedimentos Ativos</p>
            <p class="text-2xl font-bold text-gray-900 dark:text-white mt-2">{{ activeProcedures }}</p>
            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">disponíveis</p>
          </div>
          <div class="p-3 bg-green-100 dark:bg-green-500/10 rounded-xl">
            <svg class="w-6 h-6 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
          </div>
        </div>
      </div>
      
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 hover:border-gray-300 dark:hover:border-gray-700 transition-all duration-300 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Duração Média</p>
            <p class="text-2xl font-bold text-gray-900 dark:text-white mt-2">{{ averageDuration }}min</p>
            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">por sessão</p>
          </div>
          <div class="p-3 bg-blue-100 dark:bg-blue-500/10 rounded-xl">
            <svg class="w-6 h-6 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
          </div>
        </div>
      </div>
      
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 hover:border-gray-300 dark:hover:border-gray-700 transition-all duration-300 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Preço Médio</p>
            <p class="text-2xl font-bold text-gray-900 dark:text-white mt-2">{{ formatCurrency(averagePrice) }}</p>
            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">por procedimento</p>
          </div>
          <div class="p-3 bg-yellow-100 dark:bg-yellow-500/10 rounded-xl">
            <svg class="w-6 h-6 text-yellow-600 dark:text-yellow-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1"></path>
            </svg>
          </div>
        </div>
      </div>
    </div>

    <!-- Filters -->
    <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 shadow-sm">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div class="relative">
          <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400 dark:text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
          </svg>
          <input
            v-model="searchTerm"
            type="text"
            placeholder="Buscar procedimentos..."
            class="w-full pl-10 pr-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors"
          />
        </div>
        <select v-model="categoryFilter" class="px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors">
          <option value="">Todas as categorias</option>
          <option value="CABELO">Cabelo</option>
          <option value="ALISAMENTO">Alisamento</option>
          <option value="CORTE">Corte</option>
          <option value="TRATAMENTO">Tratamento</option>
          <option value="COLORACAO">Coloração</option>
          <option value="DESCOLORACAO">Descoloração</option>
          <option value="EPILACAO">Epilação</option>
          <option value="ESTETICA_FACIAL">Estética Facial</option>
          <option value="ESTETICA_CORPORAL">Estética Corporal</option>
          <option value="OUTROS">Outros</option>
        </select>
        <select v-model="statusFilter" class="px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors">
          <option value="">Todos os status</option>
          <option value="true">Ativo</option>
          <option value="false">Inativo</option>
        </select>
      </div>
    </div>

    <!-- Procedures List -->
    <div v-if="loading" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
      <div v-for="i in 6" :key="i" class="animate-pulse">
        <div class="bg-gray-200 dark:bg-gray-800/50 h-64 rounded-xl"></div>
      </div>
    </div>
    
    <div v-else-if="filteredProcedures.length === 0" class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-16 text-center shadow-sm">
      <svg class="w-16 h-16 mx-auto text-gray-400 dark:text-gray-600 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"></path>
      </svg>
      <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">Nenhum procedimento encontrado</h3>
      <p class="text-gray-600 dark:text-gray-400">Crie um novo procedimento para começar</p>
    </div>
    
    <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
      <div
        v-for="procedure in filteredProcedures"
        :key="procedure.id"
        class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl overflow-hidden hover:border-gray-300 dark:hover:border-gray-700 transition-all duration-300 group shadow-sm"
      >
        <div class="p-6">
          <!-- Header with Badge -->
          <div class="flex items-start justify-between mb-4">
            <div class="flex-1 min-w-0">
              <h3 class="text-lg font-semibold text-gray-900 dark:text-white group-hover:text-blue-600 dark:group-hover:text-purple-400 transition-colors truncate">
                {{ procedure.name }}
              </h3>
              <p v-if="procedure.description" class="text-sm text-gray-600 dark:text-gray-400 mt-1 line-clamp-2">
                {{ procedure.description }}
              </p>
            </div>
            <span :class="[
              'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ml-3 flex-shrink-0',
              procedure.active ? 'bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-400 border border-green-300 dark:border-green-800' : 'bg-red-100 dark:bg-red-900/50 text-red-700 dark:text-red-400 border border-red-300 dark:border-red-800'
            ]">
              {{ procedure.active ? 'Ativo' : 'Inativo' }}
            </span>
          </div>
          
          <!-- Category Badge -->
          <div class="mb-4">
            <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-400 border border-blue-300 dark:border-blue-800">
              {{ getCategoryText(procedure.category) }}
            </span>
          </div>
          
          <!-- Procedure Details -->
          <div class="space-y-3">
            <div class="flex items-center justify-between text-sm">
              <span class="text-gray-600 dark:text-gray-400">Duração:</span>
              <span class="text-gray-900 dark:text-white font-medium">{{ procedure.duration }}min</span>
            </div>
            
            <div class="flex items-center justify-between text-sm">
              <span class="text-gray-600 dark:text-gray-400">Preço:</span>
              <span class="text-gray-900 dark:text-white font-semibold">{{ formatCurrency(procedure.price) }}</span>
            </div>
            
            <div class="flex items-center justify-between text-sm">
              <span class="text-gray-600 dark:text-gray-400">Ativo:</span>
              <span :class="procedure.active ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400'">
                {{ procedure.active ? 'Sim' : 'Não' }}
              </span>
            </div>
          </div>
          
          <!-- Actions -->
          <div class="flex items-center justify-between pt-4 mt-4 border-t border-gray-200 dark:border-gray-700">
            <button
              @click="toggleProcedureStatus(procedure)"
              :class="[
                'text-sm font-medium transition-colors',
                procedure.active ? 'text-yellow-600 dark:text-yellow-400 hover:text-yellow-700 dark:hover:text-yellow-300' : 'text-green-600 dark:text-green-400 hover:text-green-700 dark:hover:text-green-300'
              ]"
            >
              {{ procedure.active ? 'Desativar' : 'Ativar' }}
            </button>
            <div class="flex space-x-1 opacity-0 group-hover:opacity-100 transition-opacity">
              <button
                @click="editProcedure(procedure)"
                class="p-2 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-all duration-200"
                title="Editar"
              >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                </svg>
              </button>
              <button
                @click="confirmDelete(procedure)"
                class="p-2 text-gray-600 dark:text-gray-400 hover:text-red-600 dark:hover:text-red-400 hover:bg-red-100 dark:hover:bg-red-900/20 rounded-lg transition-all duration-200"
                title="Excluir"
              >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                </svg>
              </button>
            </div>
          </div>
        </div>
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
        <div v-if="showCreateModal || editingProcedure" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4 overflow-y-auto">
          <Transition
            enter-active-class="transition ease-out duration-200"
            enter-from-class="opacity-0 scale-95"
            enter-to-class="opacity-100 scale-100"
            leave-active-class="transition ease-in duration-150"
            leave-from-class="opacity-100 scale-100"
            leave-to-class="opacity-0 scale-95"
          >
            <div class="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 rounded-xl shadow-xl w-full max-w-4xl my-8">
              <!-- Modal Header -->
              <div class="flex items-center justify-between p-6 border-b border-gray-200 dark:border-gray-800">
                <div class="flex items-center space-x-3">
                  <div class="p-2 bg-blue-600 dark:bg-gradient-to-br dark:from-purple-600 dark:to-pink-600 rounded-lg">
                    <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"></path>
                    </svg>
                  </div>
                  <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
                    {{ editingProcedure ? 'Editar Procedimento' : 'Novo Procedimento' }}
                  </h3>
                </div>
                <button @click="closeModal" class="p-2 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-colors">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                  </svg>
                </button>
              </div>
              
              <!-- Modal Body -->
              <form @submit.prevent="saveProcedure" class="p-6 space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Nome do Procedimento *</label>
                    <input
                      v-model="procedureForm.name"
                      type="text"
                      required
                      :class="[
                        'w-full px-4 py-2 bg-white dark:bg-gray-800/50 border rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none transition-colors',
                        fieldBorderClass(formErrors, 'name')
                      ]"
                      placeholder="Nome do procedimento"
                    />
                    <p v-if="formErrors.name" class="text-sm text-red-500 mt-1">{{ formErrors.name }}</p>
                  </div>
                  
                  <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Categoria *</label>
                    <select
                      v-model="procedureForm.category"
                      required
                      :class="[
                        'w-full px-4 py-2 bg-white dark:bg-gray-800/50 border rounded-lg text-gray-900 dark:text-white focus:outline-none transition-colors',
                        fieldBorderClass(formErrors, 'category')
                      ]"
                    >
                      <option value="">Selecione uma categoria</option>
                      <option value="CABELO">Cabelo</option>
                      <option value="ALISAMENTO">Alisamento</option>
                      <option value="CORTE">Corte</option>
                      <option value="TRATAMENTO">Tratamento</option>
                      <option value="COLORACAO">Coloração</option>
                      <option value="DESCOLORACAO">Descoloração</option>
                      <option value="EPILACAO">Epilação</option>
                      <option value="ESTETICA_FACIAL">Estética Facial</option>
                      <option value="ESTETICA_CORPORAL">Estética Corporal</option>
                      <option value="OUTROS">Outros</option>
                    </select>
                    <p v-if="formErrors.category" class="text-sm text-red-500 mt-1">{{ formErrors.category }}</p>
                  </div>
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Descrição</label>
                  <textarea
                    v-model="procedureForm.description"
                    rows="3"
                    class="w-full px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors resize-none"
                    placeholder="Descrição do procedimento..."
                  ></textarea>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Duração (minutos) *</label>
                    <input
                      v-model="procedureForm.duration"
                      type="number"
                      required
                      min="1"
                      :class="[
                        'w-full px-4 py-2 bg-white dark:bg-gray-800/50 border rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none transition-colors',
                        fieldBorderClass(formErrors, 'duration')
                      ]"
                      placeholder="60"
                    />
                    <p v-if="formErrors.duration" class="text-sm text-red-500 mt-1">{{ formErrors.duration }}</p>
                  </div>
                  
                  <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Preço *</label>
                    <div class="relative">
                      <span class="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500 dark:text-gray-400">R$</span>
                      <input
                        v-model="procedureForm.price"
                        type="number"
                        step="0.01"
                        required
                        min="0"
                        :class="[
                          'w-full pl-10 pr-4 py-2 bg-white dark:bg-gray-800/50 border rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none transition-colors',
                          fieldBorderClass(formErrors, 'price')
                        ]"
                        placeholder="0,00"
                      />
                    </div>
                    <p v-if="formErrors.price" class="text-sm text-red-500 mt-1">{{ formErrors.price }}</p>
                  </div>
                </div>

          <div class="p-4 bg-blue-50 dark:bg-blue-900/10 border border-blue-200 dark:border-blue-800 rounded-lg">
            <div class="flex items-center space-x-3 mb-3">
              <div class="p-2 bg-blue-100 dark:bg-blue-500/20 rounded-lg">
                <svg class="w-5 h-5 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
              </div>
              <div>
                <h4 class="text-sm font-medium text-blue-600 dark:text-blue-400">Produtos do Procedimento</h4>
                <p class="text-sm text-gray-600 dark:text-gray-400">
                  Os produtos serão selecionados durante a criação da comanda
                </p>
              </div>
            </div>
          </div>
                
                <div class="flex items-center space-x-3 p-4 bg-green-50 dark:bg-green-900/10 border border-green-200 dark:border-green-800 rounded-lg">
                  <input
                    v-model="procedureForm.active"
                    type="checkbox"
                    id="active"
                    class="w-4 h-4 text-blue-600 dark:text-purple-600 bg-white dark:bg-gray-800 border-gray-300 dark:border-gray-700 rounded focus:ring-blue-500 dark:focus:ring-purple-500 focus:ring-2"
                  />
                  <label for="active" class="text-sm text-gray-700 dark:text-gray-300">
                    <strong>Procedimento ativo</strong>
                    <br>
                    <span class="text-xs text-gray-600 dark:text-gray-400">
                      Procedimentos ativos ficam disponíveis para agendamento
                    </span>
                  </label>
                </div>
                
                <!-- Modal Footer -->
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
                    class="px-4 py-2 bg-blue-600 dark:bg-gradient-to-r dark:from-purple-600 dark:to-pink-600 hover:bg-blue-700 dark:hover:from-purple-700 dark:hover:to-pink-700 text-white rounded-lg font-medium transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
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
                      {{ editingProcedure ? 'Atualizar' : 'Cadastrar' }}
                    </span>
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
        <div v-if="procedureToDelete" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
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
                  <svg class="w-6 h-6 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z"></path>
                  </svg>
                </div>
                <h3 class="text-lg font-semibold text-white text-center mb-2">
                  Confirmar exclusão
                </h3>
                <p class="text-sm text-gray-400 text-center mb-6">
                  Tem certeza que deseja excluir o procedimento <span class="font-medium text-white">{{ procedureToDelete.name }}</span>? 
                  Esta ação não pode ser desfeita.
                </p>
                <div class="flex space-x-3">
                  <button 
                    @click="procedureToDelete = null" 
                    class="flex-1 px-4 py-2 bg-gray-800 hover:bg-gray-700 text-white rounded-lg font-medium transition-colors"
                  >
                    Cancelar
                  </button>
                  <button 
                    @click="deleteProcedure" 
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
  </div>
</template>

<script setup>
definePageMeta({
  layout: 'default',
  middleware: 'auth'
})

useSeoMeta({
  title: 'Procedimentos - Coven Beauty',
  description: 'Gerenciamento de procedimentos e serviços'
})

// Estado
const procedures = ref([])
const loading = ref(true)
const saving = ref(false)
const deleting = ref(false)

const searchTerm = ref('')
const categoryFilter = ref('')
const statusFilter = ref('')

const showCreateModal = ref(false)
const editingProcedure = ref(null)
const procedureToDelete = ref(null)

const { getMessage, mapFieldErrors, fieldBorderClass, clearFormErrors } = useApiError()

const formErrors = reactive({
  name: '',
  category: '',
  duration: '',
  price: '',
})

const procedureForm = reactive({
  name: '',
  category: '',
  description: '',
  duration: '',
  price: '',
  active: true
})

// Computed
const filteredProcedures = computed(() => {
  let filtered = procedures.value

  if (searchTerm.value) {
    const term = searchTerm.value.toLowerCase()
    filtered = filtered.filter(procedure =>
      procedure.name.toLowerCase().includes(term) ||
      procedure.description?.toLowerCase().includes(term)
    )
  }

  if (categoryFilter.value) {
    filtered = filtered.filter(procedure => procedure.category === categoryFilter.value)
  }

  if (statusFilter.value !== '') {
    const isActive = statusFilter.value === 'true'
    filtered = filtered.filter(procedure => procedure.active === isActive)
  }

  return filtered.sort((a, b) => a.name.localeCompare(b.name))
})

const activeProcedures = computed(() => {
  return procedures.value.filter(p => p.active).length
})

const averageDuration = computed(() => {
  if (procedures.value.length === 0) return 0
  const total = procedures.value.reduce((sum, p) => sum + p.duration, 0)
  return Math.round(total / procedures.value.length)
})

const averagePrice = computed(() => {
  if (procedures.value.length === 0) return 0
  const total = procedures.value.reduce((sum, p) => sum + (parseFloat(p.price) || 0), 0)
  return total / procedures.value.length
})


// Métodos
const formatCurrency = (value) => {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(value)
}

const getCategoryText = (category) => {
  const categories = {
    CABELO: 'Cabelo',
    ALISAMENTO: 'Alisamento',
    CORTE: 'Corte',
    TRATAMENTO: 'Tratamento',
    COLORACAO: 'Coloração',
    DESCOLORACAO: 'Descoloração',
    EPILACAO: 'Epilação',
    ESTETICA_FACIAL: 'Estética Facial',
    ESTETICA_CORPORAL: 'Estética Corporal',
    OUTROS: 'Outros'
  }
  return categories[category] || category
}




const loadData = async () => {
  try {
    const { $api } = useNuxtApp()
    
    console.log('🔄 Carregando procedimentos e produtos...')
    
    const proceduresRes = await $api('/procedures').catch((error) => {
      console.error('❌ Erro ao carregar procedimentos:', error)
      return []
    })
    
    procedures.value = proceduresRes || []
    
    console.log('✅ Dados carregados:')
    console.log(`   📋 Procedimentos: ${procedures.value.length}`)
    
  } catch (error) {
    console.error('💥 Erro geral ao carregar dados:', error)
  } finally {
    loading.value = false
  }
}

const resetForm = () => {
  Object.assign(procedureForm, {
    name: '',
    category: '',
    description: '',
    duration: '',
    price: '',
    active: true
  })
  clearFormErrors(formErrors)
}

const editProcedure = (procedure) => {
  editingProcedure.value = procedure
  clearFormErrors(formErrors)

  Object.assign(procedureForm, {
    name: procedure.name,
    category: procedure.category,
    description: procedure.description || '',
    duration: procedure.duration,
    price: procedure.price,
    active: procedure.active
  })
  showCreateModal.value = false
}

const closeModal = () => {
  showCreateModal.value = false
  editingProcedure.value = null
  resetForm()
}

const saveProcedure = async () => {
  saving.value = true
  clearFormErrors(formErrors)

  const price = parseFloat(procedureForm.price)
  if (Number.isNaN(price) || price < 0) {
    const message = 'Informe um preço válido maior ou igual a zero'
    formErrors.price = message
    useToast().error(message)
    saving.value = false
    return
  }

  try {
    const { $api } = useNuxtApp()
    const token = useCookie('covenos-token')

    const payload = {
      name: procedureForm.name,
      category: procedureForm.category,
      description: procedureForm.description,
      duration: parseInt(procedureForm.duration),
      price,
      active: procedureForm.active
    }

    const method = editingProcedure.value ? 'PATCH' : 'POST'
    const url = editingProcedure.value
      ? `/procedures/${editingProcedure.value.id}`
      : '/procedures'

    await $api(url, {
      method,
      headers: {
        'Authorization': `Bearer ${token.value}`
      },
      body: payload
    })

    await loadData()
    closeModal()

    const toast = useToast()
    toast.success(
      editingProcedure.value ? 'Procedimento atualizado com sucesso!' : 'Procedimento criado com sucesso!'
    )
  } catch (error) {
    console.error('Erro ao salvar procedimento:', error)
    const toast = useToast()
    const message = getMessage(error, 'Erro ao salvar procedimento')
    Object.assign(formErrors, mapFieldErrors(error))
    toast.error(message)
  } finally {
    saving.value = false
  }
}

const toggleProcedureStatus = async (procedure) => {
  try {
    const { $api } = useNuxtApp()
    const token = useCookie('covenos-token')

    await $api(`/procedures/${procedure.id}`, {
      method: 'PATCH',
      headers: {
        'Authorization': `Bearer ${token.value}`
      },
      body: {
        active: !procedure.active
      }
    })

    await loadData()
  } catch (error) {
    console.error('Erro ao alterar status do procedimento:', error)
    useToast().error(getMessage(error, 'Erro ao alterar status do procedimento'))
  }
}

const confirmDelete = (procedure) => {
  procedureToDelete.value = procedure
}

const deleteProcedure = async () => {
  deleting.value = true
  
  try {
    const { $api } = useNuxtApp()
    const token = useCookie('covenos-token')
    
    await $api(`/procedures/${procedureToDelete.value.id}`, {
      method: 'DELETE',
      headers: {
        'Authorization': `Bearer ${token.value}`
      }
    })
    
    await loadData()
    procedureToDelete.value = null
    useToast().success('Procedimento excluído com sucesso!')
  } catch (error) {
    console.error('Erro ao excluir procedimento:', error)
    useToast().error(getMessage(error, 'Erro ao excluir procedimento'))
  } finally {
    deleting.value = false
  }
}

// Lifecycle
onMounted(() => {
  loadData()
})
</script>