<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between">
      <div>
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Fluxo de Caixa</h1>
        <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">Acompanhe o fluxo financeiro mensal do salão</p>
      </div>
      <div class="flex items-center space-x-3 mt-4 sm:mt-0">
        <select
          v-model="selectedYear"
          @change="loadCashFlow"
          class="px-4 py-2 bg-white dark:bg-gray-800/50 border border-gray-300 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white focus:outline-none focus:border-blue-500 dark:focus:border-purple-500 transition-colors"
        >
          <option v-for="year in availableYears" :key="year" :value="year">
            {{ year }}
          </option>
        </select>
        <button
          @click="refreshData"
          class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-medium transition-all duration-200 shadow-md"
        >
          <ArrowPathIcon class="w-5 h-5" />
        </button>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl p-12 shadow-sm">
      <div class="flex flex-col items-center justify-center">
        <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 dark:border-purple-600 mb-4"></div>
        <p class="text-sm text-gray-600 dark:text-gray-400">Carregando fluxo de caixa...</p>
      </div>
    </div>

    <!-- Cash Flow Table -->
    <div v-else class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl overflow-hidden shadow-sm">
      <div class="overflow-x-auto">
        <table class="w-full border-collapse">
          <thead class="bg-gray-50 dark:bg-gray-800/30">
            <tr>
              <th class="sticky left-0 z-10 bg-gray-50 dark:bg-gray-800/30 border-r border-b border-gray-200 dark:border-gray-700 px-4 py-3 text-left text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider min-w-[200px]">
                Descrição
              </th>
              <th
                v-for="(month, index) in months"
                :key="index"
                class="border-b border-gray-200 dark:border-gray-700 px-4 py-3 text-center text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider min-w-[120px]"
              >
                {{ month }}
              </th>
              <th class="border-b border-gray-200 dark:border-gray-700 px-4 py-3 text-center text-xs font-semibold text-gray-900 dark:text-white uppercase tracking-wider min-w-[120px] bg-blue-50 dark:bg-blue-900/20">
                TOTAL
              </th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-200 dark:divide-gray-800">
            <!-- Saldo Inicial -->
            <tr class="bg-gray-50 dark:bg-gray-800/20">
              <td class="sticky left-0 z-10 bg-gray-50 dark:bg-gray-800/20 border-r border-gray-200 dark:border-gray-700 px-4 py-3 font-semibold text-gray-900 dark:text-white">
                Saldo Inicial
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-3 text-center"
              >
                <input
                  v-model.number="cashFlowData.months[index].initialBalance"
                  @blur="saveConfig(index + 1, 'initialBalance', cashFlowData.months[index].initialBalance)"
                  type="number"
                  step="0.01"
                  class="w-full px-2 py-1 text-sm text-center bg-white dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded text-gray-900 dark:text-white focus:outline-none focus:border-blue-500 dark:focus:border-purple-500"
                />
              </td>
              <td class="px-4 py-3 text-center font-semibold text-gray-900 dark:text-white bg-blue-50 dark:bg-blue-900/20">
                {{ formatCurrency(totalInitialBalance) }}
              </td>
            </tr>

            <!-- Entradas de Dinheiro -->
            <tr class="bg-green-50 dark:bg-green-900/10">
              <td class="sticky left-0 z-10 bg-green-50 dark:bg-green-900/10 border-r border-gray-200 dark:border-gray-700 px-4 py-2 font-semibold text-green-700 dark:text-green-400">
                ENTRADAS DE DINHEIRO
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-2 text-center font-semibold text-green-600 dark:text-green-400"
              >
                {{ formatCurrency(cashFlowData.months[index].entries.total) }}
              </td>
              <td class="px-4 py-2 text-center font-semibold text-green-600 dark:text-green-400 bg-blue-50 dark:bg-blue-900/20">
                {{ formatCurrency(cashFlowData.totals.entries) }}
              </td>
            </tr>

            <!-- Categorias de Entrada -->
            <tr
              v-for="category in cashFlowData.categories.entries"
              :key="`entry-${category.id}`"
              class="hover:bg-gray-50 dark:hover:bg-gray-800/30"
            >
              <td class="sticky left-0 z-10 bg-white dark:bg-gray-900/50 border-r border-gray-200 dark:border-gray-700 px-4 py-2 pl-8 text-sm text-gray-700 dark:text-gray-300">
                {{ category.name }}
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-2 text-center text-sm text-gray-600 dark:text-gray-400"
              >
                {{ formatCurrency(cashFlowData.months[index].entries.byCategory[category.id] || 0) }}
              </td>
              <td class="px-4 py-2 text-center text-sm font-medium text-gray-700 dark:text-gray-300 bg-blue-50 dark:bg-blue-900/20">
                {{ formatCurrency(getCategoryTotal('entry', category.id)) }}
              </td>
            </tr>

            <!-- Saídas de Dinheiro -->
            <tr class="bg-red-50 dark:bg-red-900/10">
              <td class="sticky left-0 z-10 bg-red-50 dark:bg-red-900/10 border-r border-gray-200 dark:border-gray-700 px-4 py-2 font-semibold text-red-700 dark:text-red-400">
                SAÍDAS DE DINHEIRO
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-2 text-center font-semibold text-red-600 dark:text-red-400"
              >
                {{ formatCurrency(cashFlowData.months[index].outs.total) }}
              </td>
              <td class="px-4 py-2 text-center font-semibold text-red-600 dark:text-red-400 bg-blue-50 dark:bg-blue-900/20">
                {{ formatCurrency(cashFlowData.totals.outs.total) }}
              </td>
            </tr>

            <!-- Custos Variáveis -->
            <tr class="bg-orange-50 dark:bg-orange-900/10">
              <td class="sticky left-0 z-10 bg-orange-50 dark:bg-orange-900/10 border-r border-gray-200 dark:border-gray-700 px-4 py-2 pl-4 font-semibold text-orange-700 dark:text-orange-400">
                Custos Variáveis
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-2 text-center font-semibold text-orange-600 dark:text-orange-400"
              >
                {{ formatCurrency(cashFlowData.months[index].outs.costVariable.total) }}
              </td>
              <td class="px-4 py-2 text-center font-semibold text-orange-600 dark:text-orange-400 bg-blue-50 dark:bg-blue-900/20">
                {{ formatCurrency(cashFlowData.totals.outs.costVariable) }}
              </td>
            </tr>

            <!-- Categorias de Custos Variáveis -->
            <tr
              v-for="category in cashFlowData.categories.outs.costVariable"
              :key="`cost-${category.id}`"
              class="hover:bg-gray-50 dark:hover:bg-gray-800/30"
            >
              <td class="sticky left-0 z-10 bg-white dark:bg-gray-900/50 border-r border-gray-200 dark:border-gray-700 px-4 py-2 pl-12 text-sm text-gray-700 dark:text-gray-300">
                {{ category.name }}
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-2 text-center text-sm text-gray-600 dark:text-gray-400"
              >
                {{ formatCurrency(cashFlowData.months[index].outs.costVariable.byCategory[category.id] || 0) }}
              </td>
              <td class="px-4 py-2 text-center text-sm font-medium text-gray-700 dark:text-gray-300 bg-blue-50 dark:bg-blue-900/20">
                {{ formatCurrency(getCategoryTotal('costVariable', category.id)) }}
              </td>
            </tr>

            <!-- Contas Fixas -->
            <tr class="bg-blue-50 dark:bg-blue-900/10">
              <td class="sticky left-0 z-10 bg-blue-50 dark:bg-blue-900/10 border-r border-gray-200 dark:border-gray-700 px-4 py-2 pl-4 font-semibold text-blue-700 dark:text-blue-400">
                Contas Fixas
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-2 text-center font-semibold text-blue-600 dark:text-blue-400"
              >
                {{ formatCurrency(cashFlowData.months[index].outs.fixesAccounts.total) }}
              </td>
              <td class="px-4 py-2 text-center font-semibold text-blue-600 dark:text-blue-400 bg-blue-50 dark:bg-blue-900/20">
                {{ formatCurrency(cashFlowData.totals.outs.fixesAccounts) }}
              </td>
            </tr>

            <!-- Categorias de Contas Fixas -->
            <tr
              v-for="category in cashFlowData.categories.outs.fixesAccounts"
              :key="`fixes-${category.id}`"
              class="hover:bg-gray-50 dark:hover:bg-gray-800/30"
            >
              <td class="sticky left-0 z-10 bg-white dark:bg-gray-900/50 border-r border-gray-200 dark:border-gray-700 px-4 py-2 pl-12 text-sm text-gray-700 dark:text-gray-300">
                {{ category.name }}
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-2 text-center text-sm text-gray-600 dark:text-gray-400"
              >
                {{ formatCurrency(cashFlowData.months[index].outs.fixesAccounts.byCategory[category.id] || 0) }}
              </td>
              <td class="px-4 py-2 text-center text-sm font-medium text-gray-700 dark:text-gray-300 bg-blue-50 dark:bg-blue-900/20">
                {{ formatCurrency(getCategoryTotal('fixesAccounts', category.id)) }}
              </td>
            </tr>

            <!-- Investimentos -->
            <tr class="bg-purple-50 dark:bg-purple-900/10">
              <td class="sticky left-0 z-10 bg-purple-50 dark:bg-purple-900/10 border-r border-gray-200 dark:border-gray-700 px-4 py-2 pl-4 font-semibold text-purple-700 dark:text-purple-400">
                Investimentos
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-2 text-center font-semibold text-purple-600 dark:text-purple-400"
              >
                {{ formatCurrency(cashFlowData.months[index].outs.investments.total) }}
              </td>
              <td class="px-4 py-2 text-center font-semibold text-purple-600 dark:text-purple-400 bg-blue-50 dark:bg-blue-900/20">
                {{ formatCurrency(cashFlowData.totals.outs.investments) }}
              </td>
            </tr>

            <!-- Categorias de Investimentos -->
            <tr
              v-for="category in cashFlowData.categories.outs.investments"
              :key="`invest-${category.id}`"
              class="hover:bg-gray-50 dark:hover:bg-gray-800/30"
            >
              <td class="sticky left-0 z-10 bg-white dark:bg-gray-900/50 border-r border-gray-200 dark:border-gray-700 px-4 py-2 pl-12 text-sm text-gray-700 dark:text-gray-300">
                {{ category.name }}
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-2 text-center text-sm text-gray-600 dark:text-gray-400"
              >
                {{ formatCurrency(cashFlowData.months[index].outs.investments.byCategory[category.id] || 0) }}
              </td>
              <td class="px-4 py-2 text-center text-sm font-medium text-gray-700 dark:text-gray-300 bg-blue-50 dark:bg-blue-900/20">
                {{ formatCurrency(getCategoryTotal('investments', category.id)) }}
              </td>
            </tr>

            <!-- Pró-labore -->
            <tr class="bg-yellow-50 dark:bg-yellow-900/10">
              <td class="sticky left-0 z-10 bg-yellow-50 dark:bg-yellow-900/10 border-r border-gray-200 dark:border-gray-700 px-4 py-3 font-semibold text-yellow-700 dark:text-yellow-400">
                Pró-labore
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-3 text-center"
              >
                <input
                  v-model.number="cashFlowData.months[index].prolabore"
                  @blur="saveConfig(index + 1, 'prolabore', cashFlowData.months[index].prolabore)"
                  type="number"
                  step="0.01"
                  class="w-full px-2 py-1 text-sm text-center bg-white dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded text-gray-900 dark:text-white focus:outline-none focus:border-yellow-500 dark:focus:border-yellow-500"
                />
              </td>
              <td class="px-4 py-3 text-center font-semibold text-yellow-600 dark:text-yellow-400 bg-blue-50 dark:bg-blue-900/20">
                {{ formatCurrency(cashFlowData.totals.prolabore) }}
              </td>
            </tr>

            <!-- Lucro Líquido -->
            <tr class="bg-indigo-50 dark:bg-indigo-900/10">
              <td class="sticky left-0 z-10 bg-indigo-50 dark:bg-indigo-900/10 border-r border-gray-200 dark:border-gray-700 px-4 py-3 font-semibold text-indigo-700 dark:text-indigo-400">
                Lucro Líquido
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-3 text-center font-semibold"
                :class="cashFlowData.months[index].profit >= 0 ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400'"
              >
                {{ formatCurrency(cashFlowData.months[index].profit) }}
              </td>
              <td class="px-4 py-3 text-center font-semibold bg-blue-50 dark:bg-blue-900/20"
                  :class="cashFlowData.totals.profit >= 0 ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400'">
                {{ formatCurrency(cashFlowData.totals.profit) }}
              </td>
            </tr>

            <!-- Margem de Lucro -->
            <tr class="bg-cyan-50 dark:bg-cyan-900/10">
              <td class="sticky left-0 z-10 bg-cyan-50 dark:bg-cyan-900/10 border-r border-gray-200 dark:border-gray-700 px-4 py-3 font-semibold text-cyan-700 dark:text-cyan-400">
                Margem de Lucro (%)
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-3 text-center font-semibold"
                :class="cashFlowData.months[index].profitMargin >= 0 ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400'"
              >
                {{ cashFlowData.months[index].profitMargin.toFixed(2) }}%
              </td>
              <td class="px-4 py-3 text-center font-semibold bg-blue-50 dark:bg-blue-900/20"
                  :class="cashFlowData.totals.profitMargin >= 0 ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400'">
                {{ cashFlowData.totals.profitMargin.toFixed(2) }}%
              </td>
            </tr>

            <!-- Saldo Final -->
            <tr class="bg-gray-100 dark:bg-gray-800 border-t-2 border-gray-300 dark:border-gray-700">
              <td class="sticky left-0 z-10 bg-gray-100 dark:bg-gray-800 border-r border-gray-300 dark:border-gray-700 px-4 py-3 font-bold text-lg text-gray-900 dark:text-white">
                Saldo Final
              </td>
              <td
                v-for="(month, index) in months"
                :key="index"
                class="px-4 py-3 text-center font-bold text-lg"
                :class="cashFlowData.months[index].finalBalance >= 0 ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400'"
              >
                {{ formatCurrency(cashFlowData.months[index].finalBalance) }}
              </td>
              <td class="px-4 py-3 text-center font-bold text-lg bg-blue-100 dark:bg-blue-900/30"
                  :class="totalFinalBalance >= 0 ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400'">
                {{ formatCurrency(totalFinalBalance) }}
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ArrowPathIcon } from '@heroicons/vue/24/outline'

definePageMeta({
  layout: 'default',
  middleware: 'auth'
})

useSeoMeta({
  title: 'Fluxo de Caixa - Coven Beauty',
  description: 'Fluxo de caixa mensal do salão'
})

// Estado
const loading = ref(true)
const selectedYear = ref(new Date().getFullYear())
const cashFlowData = ref({
  year: new Date().getFullYear(),
  months: [],
  categories: {
    entries: [],
    outs: {
      costVariable: [],
      fixesAccounts: [],
      investments: [],
    },
  },
  totals: {
    entries: 0,
    outs: {
      costVariable: 0,
      fixesAccounts: 0,
      investments: 0,
      total: 0,
    },
    prolabore: 0,
    profit: 0,
    profitMargin: 0,
  },
})

const months = [
  'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun',
  'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'
]

// Computed
const availableYears = computed(() => {
  const currentYear = new Date().getFullYear()
  const years = []
  for (let i = currentYear; i >= currentYear - 5; i--) {
    years.push(i)
  }
  return years
})

const totalInitialBalance = computed(() => {
  return cashFlowData.value.months.reduce((sum, month) => sum + (Number(month.initialBalance) || 0), 0)
})

const totalFinalBalance = computed(() => {
  // Saldo final total = saldo inicial total + entradas totais - saídas totais - pró-labore total
  const totalInitial = totalInitialBalance.value
  const totalEntries = cashFlowData.value.totals.entries || 0
  const totalOuts = cashFlowData.value.totals.outs.total || 0
  const totalProlabore = cashFlowData.value.totals.prolabore || 0
  
  return totalInitial + totalEntries - totalOuts - totalProlabore
})

// Métodos
const formatCurrency = (value) => {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL',
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  }).format(value || 0)
}

const getCategoryTotal = (type, categoryId) => {
  let total = 0
  
  cashFlowData.value.months.forEach(month => {
    if (type === 'entry') {
      total += Number(month.entries.byCategory[categoryId] || 0)
    } else if (type === 'costVariable') {
      total += Number(month.outs.costVariable.byCategory[categoryId] || 0)
    } else if (type === 'fixesAccounts') {
      total += Number(month.outs.fixesAccounts.byCategory[categoryId] || 0)
    } else if (type === 'investments') {
      total += Number(month.outs.investments.byCategory[categoryId] || 0)
    }
  })
  
  return total
}

const loadCashFlow = async () => {
  loading.value = true
  try {
    const { $api } = useNuxtApp()
    const data = await $api(`/cash-flow/calculate/${selectedYear.value}`)
    
    // Garantir que todos os meses existam
    const monthsData = []
    for (let i = 0; i < 12; i++) {
      const monthData = data.months.find(m => m.month === i + 1)
      if (monthData) {
        monthsData.push(monthData)
      } else {
        // Criar mês vazio se não existir
        monthsData.push({
          month: i + 1,
          monthName: months[i],
          initialBalance: 0,
          entries: { byCategory: {}, total: 0 },
          outs: {
            costVariable: { byCategory: {}, total: 0 },
            fixesAccounts: { byCategory: {}, total: 0 },
            investments: { byCategory: {}, total: 0 },
            total: 0,
          },
          prolabore: 0,
          profit: 0,
          profitMargin: 0,
          finalBalance: 0,
        })
      }
    }
    
    cashFlowData.value = {
      ...data,
      months: monthsData,
    }
  } catch (error) {
    console.error('Erro ao carregar fluxo de caixa:', error)
    useToast().error('Erro ao carregar fluxo de caixa')
  } finally {
    loading.value = false
  }
}

const saveConfig = async (month, field, value) => {
  try {
    const { $api } = useNuxtApp()
    
    // Verificar se já existe configuração para este mês/ano
    const existing = await $api(`/cash-flow/config/month/${selectedYear.value}/${month}`)
    
    if (existing) {
      // Atualizar
      await $api(`/cash-flow/config/${existing.id}`, {
        method: 'PATCH',
        body: { [field]: value }
      })
    } else {
      // Criar
      await $api('/cash-flow/config', {
        method: 'POST',
        body: {
          year: selectedYear.value,
          month,
          initialBalance: field === 'initialBalance' ? value : 0,
          prolabore: field === 'prolabore' ? value : 0,
        }
      })
    }
    
    // Recarregar dados para atualizar cálculos
    await loadCashFlow()
    useToast().success('Configuração salva!')
  } catch (error) {
    console.error('Erro ao salvar configuração:', error)
    useToast().error('Erro ao salvar configuração')
  }
}

const refreshData = async () => {
  await loadCashFlow()
  useToast().info('Dados atualizados!')
}

// Lifecycle
onMounted(async () => {
  await loadCashFlow()
})
</script>

<style scoped>
/* Garantir que a primeira coluna fique fixa */
.sticky {
  position: sticky;
  left: 0;
  z-index: 10;
}

/* Scroll horizontal suave */
.overflow-x-auto {
  scrollbar-width: thin;
  scrollbar-color: rgba(156, 163, 175, 0.5) transparent;
}

.overflow-x-auto::-webkit-scrollbar {
  height: 8px;
}

.overflow-x-auto::-webkit-scrollbar-track {
  background: transparent;
}

.overflow-x-auto::-webkit-scrollbar-thumb {
  background-color: rgba(156, 163, 175, 0.5);
  border-radius: 4px;
}

.overflow-x-auto::-webkit-scrollbar-thumb:hover {
  background-color: rgba(156, 163, 175, 0.7);
}
</style>

