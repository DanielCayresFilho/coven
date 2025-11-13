<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between">
      <div>
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Financeiro</h1>
        <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">Gerencie as finanças do salão</p>
      </div>
      <button @click="showCreateModal = true" class="mt-4 sm:mt-0 inline-flex items-center px-4 py-2 bg-blue-600 dark:bg-gradient-to-r dark:from-purple-600 dark:to-pink-600 text-white rounded-lg font-medium hover:bg-blue-700 dark:hover:from-purple-700 dark:hover:to-pink-700 transition-all duration-200 shadow-md">
        <BanknotesIcon class="w-5 h-5 mr-2" />
        Nova Transação
      </button>
    </div>

    <!-- Summary Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 hover:border-gray-300 dark:hover:border-gray-700 transition-all duration-300 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Receitas do Mês</p>
            <p class="text-2xl font-bold text-green-600 dark:text-green-400 mt-2">{{ formatCurrency(monthlyRevenue) }}</p>
            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">
              <span class="text-green-600 dark:text-green-400">↑ 12%</span> vs. mês anterior
            </p>
          </div>
          <div class="p-3 bg-green-100 dark:bg-green-500/10 rounded-xl">
            <ArrowTrendingUpIcon class="w-6 h-6 text-green-600 dark:text-green-400" />
          </div>
        </div>
      </div>

      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 hover:border-gray-300 dark:hover:border-gray-700 transition-all duration-300 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Despesas do Mês</p>
            <p class="text-2xl font-bold text-red-600 dark:text-red-400 mt-2">{{ formatCurrency(monthlyExpenses) }}</p>
            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">
              <span class="text-red-600 dark:text-red-400">↑ 5%</span> vs. mês anterior
            </p>
          </div>
          <div class="p-3 bg-red-100 dark:bg-red-500/10 rounded-xl">
            <ArrowTrendingDownIcon class="w-6 h-6 text-red-600 dark:text-red-400" />
          </div>
        </div>
      </div>

      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 hover:border-gray-300 dark:hover:border-gray-700 transition-all duration-300 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Lucro do Mês</p>
            <p :class="['text-2xl font-bold mt-2', monthlyProfit >= 0 ? 'text-blue-600 dark:text-blue-400' : 'text-red-600 dark:text-red-400']">
              {{ formatCurrency(monthlyProfit) }}
            </p>
            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">
              Margem de {{ ((monthlyProfit / monthlyRevenue) * 100).toFixed(1) }}%
            </p>
          </div>
          <div class="p-3 bg-blue-100 dark:bg-blue-500/10 rounded-xl">
            <CalculatorIcon class="w-6 h-6 text-blue-600 dark:text-blue-400" />
          </div>
        </div>
      </div>

      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 hover:border-gray-300 dark:hover:border-gray-700 transition-all duration-300 shadow-sm">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Saldo Total</p>
            <p :class="['text-2xl font-bold mt-2', totalBalance >= 0 ? 'text-purple-600 dark:text-purple-400' : 'text-red-600 dark:text-red-400']">
              {{ formatCurrency(totalBalance) }}
            </p>
            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">Acumulado geral</p>
          </div>
          <div class="p-3 bg-purple-100 dark:bg-purple-500/10 rounded-xl">
            <WalletIcon class="w-6 h-6 text-purple-600 dark:text-purple-400" />
          </div>
        </div>
      </div>
    </div>

    <!-- Filters -->
    <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 shadow-sm">
      <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
        <select v-model="periodFilter" class="px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors">
          <option value="all">Todos os períodos</option>
          <option value="today">Hoje</option>
          <option value="week">Esta Semana</option>
          <option value="month">Este Mês</option>
          <option value="last-month">Mês Anterior</option>
          <option value="year">Este Ano</option>
        </select>
        
        <select v-model="typeFilter" class="px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors">
          <option value="">Todos os tipos</option>
          <option value="RECEITA">Receitas</option>
          <option value="DESPESA">Despesas</option>
        </select>
        
        <select v-model="categoryFilter" class="px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors">
          <option value="">Todas as categorias</option>
          <option v-for="category in categories" :key="category" :value="category">
            {{ category }}
          </option>
        </select>
        
        <div class="relative">
          <MagnifyingGlassIcon class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400 dark:text-gray-500" />
          <input
            v-model="searchTerm"
            type="text"
            placeholder="Buscar transação..."
            class="w-full pl-10 pr-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors"
          />
        </div>
      </div>
    </div>

    <!-- Charts and Overview -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- Monthly Overview -->
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 shadow-sm">
        <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-6">Resumo Mensal</h3>
        <div class="space-y-4">
          <!-- Revenue Bar -->
          <div>
            <div class="flex justify-between items-center mb-2">
              <span class="text-sm text-gray-600 dark:text-gray-400">Receitas</span>
              <span class="text-sm font-medium text-green-600 dark:text-green-400">{{ formatCurrency(monthlyRevenue) }}</span>
            </div>
            <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
              <div 
                class="bg-gradient-to-r from-green-500 to-green-400 h-2 rounded-full transition-all duration-500"
                :style="`width: ${(monthlyRevenue / (monthlyRevenue + monthlyExpenses)) * 100}%`"
              ></div>
            </div>
          </div>
          
          <!-- Expenses Bar -->
          <div>
            <div class="flex justify-between items-center mb-2">
              <span class="text-sm text-gray-600 dark:text-gray-400">Despesas</span>
              <span class="text-sm font-medium text-red-600 dark:text-red-400">{{ formatCurrency(monthlyExpenses) }}</span>
            </div>
            <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
              <div 
                class="bg-gradient-to-r from-red-500 to-red-400 h-2 rounded-full transition-all duration-500"
                :style="`width: ${(monthlyExpenses / (monthlyRevenue + monthlyExpenses)) * 100}%`"
              ></div>
            </div>
          </div>
          
          <!-- Profit -->
          <div class="pt-4 border-t border-gray-200 dark:border-gray-700">
            <div class="flex justify-between items-center">
              <span class="text-sm text-gray-600 dark:text-gray-400">Lucro Líquido</span>
              <span :class="['text-lg font-bold', monthlyProfit >= 0 ? 'text-blue-600 dark:text-blue-400' : 'text-red-600 dark:text-red-400']">
                {{ formatCurrency(monthlyProfit) }}
              </span>
            </div>
          </div>
        </div>
      </div>

      <!-- Categories Breakdown -->
      <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-6 shadow-sm">
        <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-6">Por Categoria</h3>
        <div class="space-y-3 max-h-64 overflow-y-auto">
          <div
            v-for="category in categoryBreakdown"
            :key="category.name"
            class="flex items-center justify-between p-3 bg-gray-50 dark:bg-gray-800/30 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800/50 transition-colors"
          >
            <div class="flex items-center space-x-3">
              <div 
                class="w-3 h-3 rounded-full"
                :class="category.type === 'INCOME' ? 'bg-green-500' : 'bg-red-500'"
              ></div>
              <span class="text-sm text-gray-900 dark:text-gray-300">{{ category.name }}</span>
            </div>
            <span :class="['text-sm font-medium', category.type === 'INCOME' ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400']">
              {{ formatCurrency(category.total) }}
            </span>
          </div>
        </div>
      </div>
    </div>

    <!-- Transactions Table -->
    <div class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl overflow-hidden shadow-sm">
      <div class="p-6 border-b border-gray-200 dark:border-gray-800">
        <div class="flex items-center justify-between gap-4">
          <h3 class="text-lg font-semibold text-gray-900 dark:text-white">Transações</h3>
          <span class="text-sm text-gray-600 dark:text-gray-400">{{ displayTransactions.length }} registros</span>
        </div>
        <div class="mt-4 flex flex-wrap gap-2">
          <button
            v-for="tab in transactionTabs"
            :key="tab.key"
            @click="transactionCategoryTab = tab.key"
            :class="[
              'px-3 py-1.5 rounded-full text-xs font-medium border transition-colors',
              transactionCategoryTab === tab.key
                ? 'bg-blue-600 dark:bg-purple-600 text-white border-blue-500 dark:border-purple-500'
                : 'bg-gray-100 dark:bg-gray-800/60 text-gray-700 dark:text-gray-300 border-gray-300 dark:border-gray-700 hover:border-blue-500 dark:hover:border-purple-500/60'
            ]"
          >
            {{ tab.label }}
          </button>
        </div>
      </div>
      
      <div v-if="loading" class="p-6 space-y-4">
        <div v-for="i in 5" :key="i" class="animate-pulse">
          <div class="h-16 bg-gray-200 dark:bg-gray-800/50 rounded-lg"></div>
        </div>
      </div>
      
      <div v-else-if="displayTransactions.length === 0" class="text-center py-16">
        <BanknotesIcon class="w-16 h-16 mx-auto text-gray-400 dark:text-gray-600 mb-4" />
        <p class="text-lg font-medium text-gray-900 dark:text-white mb-2">Nenhuma transação encontrada</p>
        <p class="text-sm text-gray-600 dark:text-gray-400">Adicione uma nova transação para começar</p>
      </div>
      
      <div v-else class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-gray-50 dark:bg-gray-800/30 border-b border-gray-200 dark:border-gray-700">
            <tr>
              <th class="text-left py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Data</th>
              <th class="text-left py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Descrição</th>
              <th class="text-left py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Categoria</th>
              <th class="text-left py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Tipo</th>
              <th class="text-right py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Valor</th>
              <th class="text-right py-4 px-6 text-xs font-medium text-gray-600 dark:text-gray-400 uppercase tracking-wider">Ações</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-200 dark:divide-gray-800">
            <tr
              v-for="transaction in displayTransactions"
              :key="transaction.id"
              class="hover:bg-gray-50 dark:hover:bg-gray-800/30 transition-colors duration-150"
            >
              <td class="py-4 px-6 text-sm text-gray-700 dark:text-gray-300">
                {{ formatDate(transaction.date) }}
              </td>
              <td class="py-4 px-6">
                <p class="text-sm font-medium text-gray-900 dark:text-white">{{ transaction.description }}</p>
                <p v-if="transaction.description" class="text-xs text-gray-600 dark:text-gray-400 mt-1">{{ transaction.description }}</p>
              </td>
              <td class="py-4 px-6">
                <span class="inline-flex items-center px-2.5 py-0.5 rounded-lg text-xs font-medium bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-300">
                  {{ transaction.category }}
                </span>
              </td>
              <td class="py-4 px-6">
                <span :class="[
                  'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium',
                  transaction.type === 'RECEITA' 
                    ? 'bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-400 border border-green-300 dark:border-green-800' 
                    : 'bg-red-100 dark:bg-red-900/50 text-red-700 dark:text-red-400 border border-red-300 dark:border-red-800'
                ]">
                  {{ transaction.type === 'RECEITA' ? 'Receita' : 'Despesa' }}
                </span>
              </td>
              <td class="py-4 px-6 text-right">
                <span :class="['text-sm font-bold', transaction.type === 'RECEITA' ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400']">
                  {{ transaction.type === 'RECEITA' ? '+' : '-' }}{{ formatCurrency(transaction.amount) }}
                </span>
              </td>
              <td class="py-4 px-6 text-right">
                <div class="flex items-center justify-end space-x-1">
                  <button
                    @click="editTransaction(transaction)"
                    class="p-2 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-all duration-200"
                    title="Editar"
                  >
                    <PencilIcon class="w-4 h-4" />
                  </button>
                  <button
                    @click="confirmDelete(transaction)"
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

    <!-- Create/Edit Transaction Modal -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition ease-out duration-200"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition ease-in duration-150"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="showCreateModal || editingTransaction" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4 overflow-y-auto">
          <Transition
            enter-active-class="transition ease-out duration-200"
            enter-from-class="opacity-0 scale-95"
            enter-to-class="opacity-100 scale-100"
            leave-active-class="transition ease-in duration-150"
            leave-from-class="opacity-100 scale-100"
            leave-to-class="opacity-0 scale-95"
          >
            <div class="bg-gray-900 border border-gray-800 rounded-xl shadow-xl w-full max-w-2xl my-8">
              <!-- Modal Header -->
              <div class="flex items-center justify-between p-6 border-b border-gray-800">
                <div class="flex items-center space-x-3">
                  <div class="p-2 bg-gradient-to-br from-purple-600 to-pink-600 rounded-lg">
                    <BanknotesIcon class="w-5 h-5 text-white" />
                  </div>
                  <h3 class="text-xl font-semibold text-white">
                    {{ editingTransaction ? 'Editar Transação' : 'Nova Transação' }}
                  </h3>
                </div>
                <button @click="closeModal" class="p-2 text-gray-400 hover:text-white hover:bg-gray-800 rounded-lg transition-colors">
                  <XMarkIcon class="w-5 h-5" />
                </button>
              </div>
              
              <!-- Modal Body -->
              <form @submit.prevent="saveTransaction" class="p-6 space-y-4">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label class="block text-sm font-medium text-gray-300 mb-2">Tipo *</label>
                    <select v-model="transactionForm.type" required class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white focus:outline-none focus:border-purple-500 transition-colors">
                      <option value="">Selecione o tipo</option>
                      <option value="RECEITA">Receita</option>
                      <option value="DESPESA">Despesa</option>
                    </select>
                  </div>
                  
                  <div>
                    <label class="block text-sm font-medium text-gray-300 mb-2">Data *</label>
                    <input
                      v-model="transactionForm.date"
                      type="date"
                      required
                      class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white focus:outline-none focus:border-purple-500 transition-colors"
                    />
                  </div>
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-300 mb-2">Descrição *</label>
                  <input
                    v-model="transactionForm.description"
                    type="text"
                    required
                    class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:border-purple-500 transition-colors"
                    placeholder="Descrição da transação"
                  />
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label class="block text-sm font-medium text-gray-300 mb-2">Categoria *</label>
                    <input
                      v-model="transactionForm.category"
                      type="text"
                      required
                      list="categories-list"
                      class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:border-purple-500 transition-colors"
                      placeholder="Ex: Serviços, Produtos, Aluguel"
                    />
                    <datalist id="categories-list">
                      <option v-for="cat in categories" :key="cat" :value="cat" />
                    </datalist>
                  </div>
                  
                  <div>
                    <label class="block text-sm font-medium text-gray-300 mb-2">Valor *</label>
                    <div class="relative">
                      <span class="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400">R$</span>
                      <input
                        v-model="transactionForm.amount"
                        type="number"
                        step="0.01"
                        min="0"
                        required
                        class="w-full pl-10 pr-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:border-purple-500 transition-colors"
                        placeholder="0,00"
                      />
                    </div>
                  </div>
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-300 mb-2">Observações</label>
                  <textarea
                    v-model="transactionForm.observations"
                    rows="3"
                    class="w-full px-4 py-2 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:border-purple-500 transition-colors resize-none"
                    placeholder="Observações sobre a transação..."
                  ></textarea>
                </div>
                
                <!-- Modal Footer -->
                <div class="flex justify-end space-x-3 pt-4">
                  <button 
                    type="button" 
                    @click="closeModal" 
                    class="px-4 py-2 bg-gray-800 hover:bg-gray-700 text-white rounded-lg font-medium transition-colors"
                  >
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
                      {{ editingTransaction ? 'Atualizar' : 'Salvar' }}
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
        <div v-if="transactionToDelete" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
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
                  Tem certeza que deseja excluir esta transação? Esta ação não pode ser desfeita.
                </p>
                <div class="flex space-x-3">
                  <button 
                    @click="transactionToDelete = null" 
                    class="flex-1 px-4 py-2 bg-gray-800 hover:bg-gray-700 text-white rounded-lg font-medium transition-colors"
                  >
                    Cancelar
                  </button>
                  <button 
                    @click="deleteTransaction" 
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
import { 
  BanknotesIcon,
  ArrowTrendingUpIcon,
  ArrowTrendingDownIcon,
  CalculatorIcon,
  WalletIcon,
  PencilIcon, 
  TrashIcon, 
  XMarkIcon,
  ExclamationTriangleIcon,
  MagnifyingGlassIcon
} from '@heroicons/vue/24/outline'
import { ref, reactive, computed, onMounted } from 'vue';

definePageMeta({
  layout: 'default',
  middleware: 'auth'
})

useSeoMeta({
  title: 'Financeiro - Coven Beauty',
  description: 'Gerenciamento financeiro do salão'
})

// Estado
const transactions = ref([])
const loading = ref(true)
const saving = ref(false)
const deleting = ref(false)

const periodFilter = ref('all')
const typeFilter = ref('')
const categoryFilter = ref('')
const searchTerm = ref('')
const transactionCategoryTab = ref('ALL')

const transactionTabs = [
  { key: 'ALL', label: 'Todas' },
  { key: 'Atendimentos', label: 'Atendimentos' },
  { key: 'Vendas', label: 'Vendas' },
  { key: 'Uso Interno', label: 'Uso interno' }
]

const showCreateModal = ref(false)
const editingTransaction = ref(null)
const transactionToDelete = ref(null)

const transactionForm = reactive({
  id: null,
  type: '',
  date: new Date().toISOString().split('T')[0],
  description: '',
  category: '',
  amount: '',
  observations: ''
})

// Computed
const filteredTransactions = computed(() => {
  let filtered = transactions.value

  // FIX: Lógica de filtro de período corrigida e completada
  if (periodFilter.value !== 'all') {
    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    
    filtered = filtered.filter(transaction => {
      const transDate = new Date(transaction.date);
      
      switch (periodFilter.value) {
        case 'today':
          return transDate.toDateString() === today.toDateString();
        case 'week':
          const weekStart = new Date(today);
          weekStart.setDate(today.getDate() - today.getDay());
          return transDate >= weekStart;
        case 'month':
          return transDate.getMonth() === now.getMonth() && transDate.getFullYear() === now.getFullYear();
        case 'last-month':
          const lastMonth = new Date(now.getFullYear(), now.getMonth() - 1);
          return transDate.getMonth() === lastMonth.getMonth() && transDate.getFullYear() === lastMonth.getFullYear();
        case 'year':
          return transDate.getFullYear() === now.getFullYear();
        default:
          return true;
      }
    })
  }

  // Filter by type
  if (typeFilter.value) {
    filtered = filtered.filter(transaction => transaction.type === typeFilter.value);
  }

  // Filter by category
  if (categoryFilter.value) {
    filtered = filtered.filter(transaction => transaction.category === categoryFilter.value)
  }

  // Filter by search term
  if (searchTerm.value) {
    const term = searchTerm.value.toLowerCase()
    filtered = filtered.filter(transaction =>
      transaction.description.toLowerCase().includes(term) ||
      transaction.category?.toLowerCase().includes(term)
    )
  }

  return filtered.sort((a, b) => new Date(b.date) - new Date(a.date))
})

const displayTransactions = computed(() => {
  if (transactionCategoryTab.value === 'ALL') {
    return filteredTransactions.value
  }
  return filteredTransactions.value.filter(
    transaction => transaction.category === transactionCategoryTab.value
  )
})

const categories = computed(() => {
  const cats = [...new Set(transactions.value.map(t => t.category).filter(Boolean))]
  return cats.sort()
})

const getMonthlyTotals = (type) => {
  const now = new Date();
  return transactions.value
    .filter(t => {
      const transDate = new Date(t.date);
      // FIX: O tipo na API é 'RECEITA'/'DESPESA'
      return t.type === type && 
             transDate.getMonth() === now.getMonth() && 
             transDate.getFullYear() === now.getFullYear();
    })
    .reduce((sum, t) => sum + parseFloat(t.amount.toString()), 0);
};

const monthlyRevenue = computed(() => getMonthlyTotals('RECEITA'));
const monthlyExpenses = computed(() => getMonthlyTotals('DESPESA'));

const monthlyProfit = computed(() => {
  return monthlyRevenue.value - monthlyExpenses.value;
})

const totalBalance = computed(() => {
  return transactions.value.reduce((sum, t) => {
    // FIX: O tipo na API é 'RECEITA'/'DESPESA'
    const amount = parseFloat(t.amount.toString());
    return t.type === 'RECEITA' ? sum + amount : sum - amount;
  }, 0)
})

const categoryBreakdown = computed(() => {
  const breakdown = {}
  
  filteredTransactions.value.forEach(transaction => {
    const key = `${transaction.category}-${transaction.type}`
    if (!breakdown[key]) {
      breakdown[key] = {
        name: transaction.category,
        type: transaction.type,
        total: 0
      }
    }
    breakdown[key].total += parseFloat(transaction.amount.toString())
  })
  
  return Object.values(breakdown).sort((a, b) => b.total - a.total).slice(0, 10)
})

// Métodos
const formatCurrency = (value) => {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(value || 0)
}

const formatDate = (dateString) => {
  const date = new Date(dateString);
  // Adiciona o timezone para corrigir a exibição da data
  const userTimezoneOffset = date.getTimezoneOffset() * 60000;
  return new Date(date.getTime() + userTimezoneOffset).toLocaleDateString('pt-BR', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  });
}

const loadTransactions = async () => {
  loading.value = true
  try {
    const { $api } = useNuxtApp()
    
    console.log('🔄 Carregando transações financeiras...')
    
    const response = await $api('/financial')
    
    console.log('📋 Resposta da API financeira:', response)
    console.log('📋 Tipo da resposta:', typeof response)
    console.log('📋 É array?', Array.isArray(response))
    
    transactions.value = Array.isArray(response) ? response : []
    
    console.log('✅ Transações carregadas:', transactions.value.length)
    
  } catch (error) {
    console.error('❌ Erro ao carregar transações financeiras:', error)
    const errorMessage = error.response?.data?.message || error.message || 'Erro desconhecido'
    useToast().error('Erro ao carregar transações: ' + errorMessage)
    transactions.value = []
  } finally {
    loading.value = false
  }
}

const resetForm = () => {
  Object.assign(transactionForm, {
    id: null,
    type: '',
    date: new Date().toISOString().split('T')[0],
    description: '',
    category: '',
    amount: '',
    observations: ''
  })
}

const editTransaction = (transaction) => {
  editingTransaction.value = transaction
  Object.assign(transactionForm, {
    ...transaction,
    date: transaction.date.split('T')[0],
    observations: transaction.observations || ''
  })
  showCreateModal.value = true
}

const closeModal = () => {
  showCreateModal.value = false
  editingTransaction.value = null
  resetForm()
}

const saveTransaction = async () => {
  saving.value = true
  try {
    const { $api } = useNuxtApp()
    const toast = useToast()
    
    const method = editingTransaction.value ? 'PATCH' : 'POST'
    const url = editingTransaction.value ? `/financial/${editingTransaction.value.id}` : '/financial'
    
    const payload = {
      type: transactionForm.type,
      date: new Date(transactionForm.date).toISOString(),
      description: transactionForm.description,
      category: transactionForm.category,
      amount: parseFloat(transactionForm.amount),
      isPaid: true, // Por padrão, considerar como pago
      recurrent: false // Por padrão, não recorrente
    }
    
    // Adicionar observações se existir
    if (transactionForm.observations && transactionForm.observations.trim()) {
      payload.observations = transactionForm.observations.trim()
    }
    
    console.log('💾 Salvando transação:', { method, url, payload })
    
    // Remove campos vazios/undefined
    Object.keys(payload).forEach(key => {
      if (payload[key] === '' || payload[key] === undefined || payload[key] === null) {
        delete payload[key]
      }
    })
    
    const response = await $api(url, {
      method,
      body: payload
    })
    
    console.log('✅ Transação salva:', response)
    
    await loadTransactions()
    closeModal()
    toast.success(editingTransaction.value ? 'Transação atualizada!' : 'Transação criada!')
  } catch (error) {
    console.error('❌ Erro ao salvar transação:', error)
    const errorMessage = error.response?.data?.message || error.message || 'Erro desconhecido'
    useToast().error('Erro ao salvar transação: ' + errorMessage)
  } finally {
    saving.value = false
  }
}

const confirmDelete = (transaction) => {
  transactionToDelete.value = transaction
}

const deleteTransaction = async () => {
  deleting.value = true
  try {
    const { $api } = useNuxtApp()
    const toast = useToast()

    // FIX: A chamada da API estava comentada. Agora está ativa.
    await $api(`/financial/${transactionToDelete.value.id}`, {
      method: 'DELETE',
    })
    
    await loadTransactions()
    transactionToDelete.value = null
    toast.success('Transação excluída!')
  } catch (error) {
    console.error('Erro ao excluir transação:', error)
    useToast().error('Erro ao excluir transação')
  } finally {
    deleting.value = false
  }
}

// Lifecycle
onMounted(() => {
  loadTransactions()
})
</script>