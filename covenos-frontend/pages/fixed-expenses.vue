<template>
  <div class="space-y-6">
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
      <div>
        <h1 class="text-2xl font-bold text-white">Despesas Fixas</h1>
        <p class="text-sm text-gray-400 mt-1">
          Cadastre despesas recorrentes e receba lembretes automáticos 15 dias antes do vencimento.
        </p>
      </div>
      <div class="flex items-center gap-2">
        <button
          @click="refreshData"
          class="px-4 py-2 rounded-lg border border-gray-700 text-sm text-gray-300 hover:text-white hover:border-gray-500 flex items-center gap-2 transition-colors"
        >
          <ArrowPathIcon
            :class="['w-4 h-4', { 'animate-spin': loadingExpenses || loadingUpcoming }]"
          />
          Atualizar
        </button>
        <button
          @click="openCreateModal"
          class="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white text-sm font-medium shadow-lg shadow-purple-500/20 transition-all"
        >
          <PlusCircleIcon class="w-5 h-5" />
          Nova despesa fixa
        </button>
      </div>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
      <div class="bg-gray-900/50 border border-gray-800 rounded-xl p-5 flex items-center justify-between">
        <div>
          <p class="text-sm text-gray-400">Total mensal estimado</p>
          <p class="text-2xl font-semibold text-white mt-2">{{ formatCurrency(totalMonthlyValue) }}</p>
          <p class="text-xs text-gray-500 mt-1">Considerando todas as despesas ativas</p>
        </div>
        <div class="p-3 bg-green-500/10 rounded-xl">
          <BanknotesIcon class="w-6 h-6 text-green-400" />
        </div>
      </div>

      <div class="bg-gray-900/50 border border-gray-800 rounded-xl p-5 flex items-center justify-between">
        <div>
          <p class="text-sm text-gray-400">Próximos 15 dias</p>
          <p class="text-2xl font-semibold text-white mt-2">{{ upcomingExpenses.length }}</p>
          <p class="text-xs text-gray-500 mt-1">Despesas com lembretes agendados</p>
        </div>
        <div class="p-3 bg-purple-500/10 rounded-xl">
          <CalendarIcon class="w-6 h-6 text-purple-400" />
        </div>
      </div>

      <div class="bg-gray-900/50 border border-gray-800 rounded-xl p-5 flex items-center justify-between">
        <div>
          <p class="text-sm text-gray-400">Despesas cadastradas</p>
          <p class="text-2xl font-semibold text-white mt-2">{{ expenses.length }}</p>
          <p class="text-xs text-gray-500 mt-1">Ativas no sistema</p>
        </div>
        <div class="p-3 bg-blue-500/10 rounded-xl">
          <ClipboardDocumentCheckIcon class="w-6 h-6 text-blue-400" />
        </div>
      </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div class="lg:col-span-1 space-y-4">
        <div class="bg-gray-900/50 border border-gray-800 rounded-xl p-5">
          <div class="flex items-center justify-between mb-4">
            <h2 class="text-lg font-semibold text-white">Vencimentos próximos</h2>
            <span class="text-xs text-gray-500">Próximos 15 dias</span>
          </div>

          <div v-if="loadingUpcoming" class="space-y-3">
            <div v-for="i in 3" :key="`upcoming-skeleton-${i}`" class="h-20 bg-gray-800/40 rounded-lg animate-pulse" />
          </div>

          <div v-else-if="upcomingExpenses.length === 0" class="text-sm text-gray-400 text-center py-6">
            Nenhuma despesa vence nos próximos 15 dias.
          </div>

          <div v-else class="space-y-3">
            <div
              v-for="expense in upcomingExpenses"
              :key="`upcoming-${expense.id}`"
              class="p-4 rounded-lg border border-gray-800 bg-gray-900/70 hover:border-purple-500/60 transition-colors"
            >
              <div class="flex items-start justify-between gap-3">
                <div>
                  <p class="text-sm font-semibold text-white">{{ expense.name }}</p>
                  <p class="text-xs text-gray-400 mt-1">{{ formatCurrency(expense.amount) }}</p>
                </div>
                <span
                  class="text-xs font-medium px-2 py-1 rounded-full"
                  :class="getDueBadgeClass(expense.daysUntilDue)"
                >
                  {{ getDueBadgeLabel(expense.daysUntilDue) }}
                </span>
              </div>
              <div class="flex justify-between text-xs text-gray-500 mt-2">
                <span>Vence em {{ expense.daysUntilDue }} dia(s)</span>
                <span>{{ formatDate(expense.nextDueDate) }}</span>
              </div>
            </div>
          </div>
        </div>

        <div class="bg-gray-900/50 border border-gray-800 rounded-xl p-5">
          <h3 class="text-base font-semibold text-white mb-3">Como funciona</h3>
          <ul class="space-y-2 text-sm text-gray-400">
            <li class="flex gap-2 items-start">
              <span class="mt-1 h-1.5 w-1.5 rounded-full bg-purple-500"></span>
              Cadastre o valor e o dia que a despesa vence todos os meses.
            </li>
            <li class="flex gap-2 items-start">
              <span class="mt-1 h-1.5 w-1.5 rounded-full bg-purple-500"></span>
              O sistema cria lembretes automáticos 15 dias antes do vencimento.
            </li>
            <li class="flex gap-2 items-start">
              <span class="mt-1 h-1.5 w-1.5 rounded-full bg-purple-500"></span>
              Você pode acompanhar os lembretes no dashboard e em utilidades.
            </li>
          </ul>
        </div>
      </div>

      <div class="lg:col-span-2">
        <div class="bg-gray-900/50 border border-gray-800 rounded-xl">
          <div class="flex items-center justify-between border-b border-gray-800 px-6 py-4">
            <div>
              <h2 class="text-lg font-semibold text-white">Lista de despesas</h2>
              <p class="text-xs text-gray-500">Ordenadas pelo dia de vencimento</p>
            </div>
          </div>

          <div v-if="loadingExpenses" class="p-6 space-y-3">
            <div v-for="i in 5" :key="`expense-skeleton-${i}`" class="h-16 bg-gray-800/40 rounded-lg animate-pulse" />
          </div>

          <div v-else-if="expenses.length === 0" class="p-8 text-center text-sm text-gray-400">
            Nenhuma despesa fixa cadastrada ainda. Clique em "Nova despesa fixa" para adicionar a primeira.
          </div>

          <div v-else class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-800">
              <thead class="bg-gray-900/70">
                <tr>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">Despesa</th>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">Valor</th>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">Vencimento</th>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">Próximo vencimento</th>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">Dias restante</th>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">Observações</th>
                  <th class="px-6 py-3 text-right text-xs font-medium text-gray-400 uppercase tracking-wider">Ações</th>
                </tr>
              </thead>
              <tbody class="bg-gray-900/30 divide-y divide-gray-800">
                <tr v-for="expense in expensesWithMetadata" :key="expense.id" class="hover:bg-gray-800/40 transition-colors">
                  <td class="px-6 py-4">
                    <div class="text-sm font-medium text-white">{{ expense.name }}</div>
                    <div class="text-xs text-gray-500">
                      Criado em {{ formatDate(expense.createdAt) }}
                    </div>
                  </td>
                  <td class="px-6 py-4">
                    <div class="text-sm text-white">{{ formatCurrency(expense.amount) }}</div>
                  </td>
                  <td class="px-6 py-4">
                    <span class="text-sm text-gray-300">Todo dia {{ expense.dueDay }}</span>
                  </td>
                  <td class="px-6 py-4">
                    <div class="text-xs text-gray-300">{{ formatDate(expense.nextDueDate) }}</div>
                  </td>
                  <td class="px-6 py-4">
                    <span
                      class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium"
                      :class="getDueBadgeClass(expense.daysUntilDue)"
                    >
                      {{ getDueBadgeLabel(expense.daysUntilDue) }}
                    </span>
                  </td>
                  <td class="px-6 py-4 max-w-xs">
                    <p class="text-xs text-gray-400 truncate" :title="expense.description || '—'">
                      {{ expense.description || '—' }}
                    </p>
                  </td>
                  <td class="px-6 py-4 text-right text-sm font-medium space-x-2">
                    <button
                      @click="openEditModal(expense)"
                      class="inline-flex items-center gap-1 px-3 py-1.5 bg-gray-800/60 hover:bg-gray-700/80 text-gray-200 rounded-lg transition-colors"
                    >
                      <PencilSquareIcon class="w-4 h-4" />
                      Editar
                    </button>
                    <button
                      @click="confirmDelete(expense)"
                      class="inline-flex items-center gap-1 px-3 py-1.5 bg-red-600/20 hover:bg-red-600/30 text-red-300 rounded-lg transition-colors"
                    >
                      <TrashIcon class="w-4 h-4" />
                      Excluir
                    </button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>

    <div
      v-if="showModal"
      class="fixed inset-0 z-50 flex items-center justify-center bg-black/70 backdrop-blur-sm px-4"
    >
      <div class="w-full max-w-xl bg-gray-950 border border-gray-800 rounded-2xl shadow-2xl overflow-hidden">
        <div class="px-6 py-4 border-b border-gray-800 flex items-center justify-between">
          <div>
            <h3 class="text-lg font-semibold text-white">
              {{ editingExpense ? 'Editar despesa fixa' : 'Nova despesa fixa' }}
            </h3>
            <p class="text-xs text-gray-500 mt-1">
              Informe os dados principais para recorrência mensal.
            </p>
          </div>
          <button @click="closeModal" class="text-gray-400 hover:text-white transition-colors">
            <XMarkIcon class="w-5 h-5" />
          </button>
        </div>

        <form @submit.prevent="saveExpense" class="px-6 py-5 space-y-4">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-300 mb-1">Nome da despesa</label>
              <input
                v-model="expenseForm.name"
                type="text"
                required
                class="w-full px-4 py-2.5 rounded-lg bg-gray-900 border border-gray-800 focus:border-purple-500 focus:ring-1 focus:ring-purple-500 text-white placeholder-gray-500 transition-colors"
                placeholder="Ex: Aluguel, Internet, Energia"
              />
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-300 mb-1">Valor mensal</label>
              <input
                v-model.number="expenseForm.amount"
                type="number"
                step="0.01"
                min="0.01"
                required
                class="w-full px-4 py-2.5 rounded-lg bg-gray-900 border border-gray-800 focus:border-purple-500 focus:ring-1 focus:ring-purple-500 text-white placeholder-gray-500 transition-colors"
                placeholder="0,00"
              />
            </div>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-300 mb-1">Dia do vencimento</label>
              <input
                v-model.number="expenseForm.dueDay"
                type="number"
                min="1"
                max="31"
                required
                class="w-full px-4 py-2.5 rounded-lg bg-gray-900 border border-gray-800 focus:border-purple-500 focus:ring-1 focus:ring-purple-500 text-white transition-colors"
                placeholder="Dia do mês"
              />
              <p class="text-xs text-gray-500 mt-1">O lembrete é criado 15 dias antes dessa data.</p>
            </div>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-300 mb-1">Observações</label>
            <textarea
              v-model="expenseForm.description"
              rows="3"
              class="w-full px-4 py-2.5 rounded-lg bg-gray-900 border border-gray-800 focus:border-purple-500 focus:ring-1 focus:ring-purple-500 text-white placeholder-gray-500 transition-colors resize-none"
              placeholder="Detalhes relevantes, dados de pagamento, responsável, etc."
            ></textarea>
          </div>

          <div class="flex justify-end gap-3 pt-2">
            <button
              type="button"
              @click="closeModal"
              class="px-4 py-2 rounded-lg border border-gray-700 text-sm text-gray-300 hover:text-white hover:border-gray-500 transition-colors"
            >
              Cancelar
            </button>
            <button
              type="submit"
              :disabled="savingExpense"
              class="px-5 py-2 rounded-lg bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white text-sm font-medium shadow-lg shadow-purple-500/20 transition-all disabled:opacity-60 disabled:cursor-not-allowed"
            >
              {{ savingExpense ? 'Salvando...' : editingExpense ? 'Atualizar despesa' : 'Salvar despesa' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import {
  ArrowPathIcon,
  BanknotesIcon,
  CalendarIcon,
  ClipboardDocumentCheckIcon,
  PencilSquareIcon,
  PlusCircleIcon,
  TrashIcon,
  XMarkIcon
} from '@heroicons/vue/24/outline'

definePageMeta({
  layout: 'default',
  middleware: 'auth'
})

useSeoMeta({
  title: 'Despesas Fixas - Coven Beauty',
  description: 'Gestão de despesas fixas com lembretes automáticos'
})

const expenses = ref([])
const upcomingExpenses = ref([])
const loadingExpenses = ref(true)
const loadingUpcoming = ref(true)
const savingExpense = ref(false)

const showModal = ref(false)
const editingExpense = ref(null)

const expenseForm = reactive({
  name: '',
  amount: 0,
  dueDay: 1,
  description: ''
})

const totalMonthlyValue = computed(() =>
  expenses.value.reduce((acc, expense) => acc + Number(expense.amount || 0), 0)
)

const expensesWithMetadata = computed(() => {
  const reference = new Date()
  return expenses.value
    .map((expense) => {
      const nextDueDate = calculateNextDueDate(expense, reference)
      const daysUntilDue = calculateDaysUntilDue(nextDueDate, reference)
      return {
        ...expense,
        nextDueDate,
        daysUntilDue
      }
    })
    .sort((a, b) => a.dueDay - b.dueDay)
})

const { $api } = useNuxtApp()
const token = useCookie('covenos-token')

const requestHeaders = computed(() => ({
  Authorization: `Bearer ${token.value}`
}))

const resetForm = () => {
  expenseForm.name = ''
  expenseForm.amount = 0
  expenseForm.dueDay = 1
  expenseForm.description = ''
}

const openCreateModal = () => {
  editingExpense.value = null
  resetForm()
  showModal.value = true
}

const openEditModal = (expense) => {
  editingExpense.value = expense
  expenseForm.name = expense.name
  expenseForm.amount = Number(expense.amount)
  expenseForm.dueDay = expense.dueDay
  expenseForm.description = expense.description || ''
  showModal.value = true
}

const closeModal = () => {
  showModal.value = false
  editingExpense.value = null
}

const loadExpenses = async () => {
  loadingExpenses.value = true
  try {
    const response = await $api('/fixed-expenses', {
      method: 'GET',
      headers: requestHeaders.value
    })
    expenses.value = (response || []).map((expense) => ({
      ...expense,
      amount: Number(expense.amount),
      dueDay: Number(expense.dueDay)
    }))
  } catch (error) {
    useToast().error('Erro ao carregar despesas fixas.')
  } finally {
    loadingExpenses.value = false
  }
}

const loadUpcomingExpenses = async () => {
  loadingUpcoming.value = true
  try {
    const response = await $api('/fixed-expenses/upcoming?days=15', {
      method: 'GET',
      headers: requestHeaders.value
    })
    upcomingExpenses.value = (response || []).map((expense) => ({
      ...expense,
      daysUntilDue: Number(expense.daysUntilDue),
      nextDueDate: new Date(expense.nextDueDate)
    }))
  } catch (error) {
    useToast().error('Erro ao carregar despesas próximas do vencimento.')
    upcomingExpenses.value = []
  } finally {
    loadingUpcoming.value = false
  }
}

const refreshData = async () => {
  await Promise.all([loadExpenses(), loadUpcomingExpenses()])
}

const saveExpense = async () => {
  if (!expenseForm.name || !expenseForm.amount || !expenseForm.dueDay) {
    useToast().error('Preencha todos os campos obrigatórios.')
    return
  }

  savingExpense.value = true

  try {
    const payload = {
      name: expenseForm.name,
      amount: Number(expenseForm.amount),
      dueDay: Number(expenseForm.dueDay),
      description: expenseForm.description || undefined
    }

    if (editingExpense.value) {
      await $api(`/fixed-expenses/${editingExpense.value.id}`, {
        method: 'PATCH',
        headers: {
          ...requestHeaders.value,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
      })
      useToast().success('Despesa fixa atualizada com sucesso!')
    } else {
      await $api('/fixed-expenses', {
        method: 'POST',
        headers: {
          ...requestHeaders.value,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
      })
      useToast().success('Despesa fixa criada com sucesso!')
    }

    closeModal()
    await refreshData()
  } catch (error) {
    useToast().error('Erro ao salvar despesa fixa.')
  } finally {
    savingExpense.value = false
  }
}

const confirmDelete = async (expense) => {
  const confirmed = window.confirm(`Deseja realmente excluir a despesa "${expense.name}"?`)
  if (!confirmed) return

  try {
    await $api(`/fixed-expenses/${expense.id}`, {
      method: 'DELETE',
      headers: requestHeaders.value
    })
    useToast().success('Despesa fixa removida com sucesso!')
    await refreshData()
  } catch (error) {
    useToast().error('Erro ao remover despesa fixa.')
  }
}

const formatCurrency = (value) => {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(Number(value || 0))
}

const formatDate = (date) => {
  const dateObj = new Date(date)
  return dateObj.toLocaleDateString('pt-BR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric'
  })
}

const getDueBadgeLabel = (daysUntilDue) => {
  if (daysUntilDue < 0) {
    return 'Vencida'
  }
  if (daysUntilDue === 0) {
    return 'Vence hoje'
  }
  if (daysUntilDue <= 7) {
    return `${daysUntilDue} dia(s)`
  }
  return `${daysUntilDue} dias`
}

const getDueBadgeClass = (daysUntilDue) => {
  if (daysUntilDue < 0) {
    return 'bg-red-500/20 text-red-300 border border-red-500/40'
  }
  if (daysUntilDue === 0) {
    return 'bg-red-500/30 text-red-100 border border-red-500/50'
  }
  if (daysUntilDue <= 7) {
    return 'bg-yellow-500/20 text-yellow-200 border border-yellow-500/30'
  }
  return 'bg-green-500/20 text-green-200 border border-green-500/30'
}

const calculateNextDueDate = (expense, reference = new Date()) => {
  const ref = new Date(reference)
  ref.setHours(0, 0, 0, 0)

  const getDateForMonth = (year, month, day) => {
    const lastDay = new Date(year, month + 1, 0).getDate()
    const validDay = Math.min(day, lastDay)
    return new Date(year, month, validDay, 9, 0, 0, 0)
  }

  let dueDate = getDateForMonth(ref.getFullYear(), ref.getMonth(), expense.dueDay)
  if (dueDate < ref) {
    const nextMonth = new Date(ref.getFullYear(), ref.getMonth() + 1, 1)
    dueDate = getDateForMonth(nextMonth.getFullYear(), nextMonth.getMonth(), expense.dueDay)
  }

  return dueDate
}

const calculateDaysUntilDue = (dueDate, reference = new Date()) => {
  const diff = dueDate.getTime() - reference.getTime()
  return Math.ceil(diff / (1000 * 60 * 60 * 24))
}

onMounted(async () => {
  await refreshData()
})
</script>

