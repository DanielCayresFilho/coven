<template>
  <div class="space-y-8">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between">
      <div>
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Categorias Financeiras</h1>
        <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">Gerencie as categorias do sistema financeiro</p>
      </div>
    </div>

    <!-- Grid com 4 seções -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- Entrada de Dinheiro -->
      <CategorySection
        title="Entrada de Dinheiro"
        description="Categorias para receitas e entradas"
        :icon="ArrowTrendingUpIcon"
        color="green"
        :categories="entryMoneyCategories"
        :loading="loading.entryMoney"
        :saving="saving.entryMoney"
        @create="createEntryMoney"
        @update="updateEntryMoney"
        @delete="deleteEntryMoney"
      />

      <!-- Custos Variáveis -->
      <CategorySection
        title="Custos Variáveis"
        description="Categorias para despesas variáveis"
        :icon="ChartBarIcon"
        color="orange"
        :categories="costVariableCategories"
        :loading="loading.costVariable"
        :saving="saving.costVariable"
        @create="createCostVariable"
        @update="updateCostVariable"
        @delete="deleteCostVariable"
      />

      <!-- Contas Fixas -->
      <CategorySection
        title="Contas Fixas"
        description="Categorias para despesas fixas"
        :icon="CalendarIcon"
        color="blue"
        :categories="fixesAccountsCategories"
        :loading="loading.fixesAccounts"
        :saving="saving.fixesAccounts"
        @create="createFixesAccounts"
        @update="updateFixesAccounts"
        @delete="deleteFixesAccounts"
      />

      <!-- Investimentos -->
      <CategorySection
        title="Investimentos"
        description="Categorias para investimentos"
        :icon="BanknotesIcon"
        color="purple"
        :categories="investmentsCategories"
        :loading="loading.investments"
        :saving="saving.investments"
        @create="createInvestments"
        @update="updateInvestments"
        @delete="deleteInvestments"
      />
    </div>
  </div>
</template>

<script setup>
import { 
  ArrowTrendingUpIcon,
  ChartBarIcon,
  CalendarIcon,
  BanknotesIcon
} from '@heroicons/vue/24/outline'

definePageMeta({
  layout: 'default',
  middleware: 'auth'
})

useSeoMeta({
  title: 'Categorias Financeiras - Coven Beauty',
  description: 'Gerenciamento de categorias financeiras'
})

// Estado
const entryMoneyCategories = ref([])
const costVariableCategories = ref([])
const fixesAccountsCategories = ref([])
const investmentsCategories = ref([])

const loading = reactive({
  entryMoney: true,
  costVariable: true,
  fixesAccounts: true,
  investments: true
})

const saving = reactive({
  entryMoney: false,
  costVariable: false,
  fixesAccounts: false,
  investments: false
})

// Métodos para Entrada de Dinheiro
const loadEntryMoney = async () => {
  loading.entryMoney = true
  try {
    const { $api } = useNuxtApp()
    entryMoneyCategories.value = await $api('/financial-categories/entry-money')
  } catch (error) {
    console.error('Erro ao carregar categorias de entrada:', error)
    entryMoneyCategories.value = []
  } finally {
    loading.entryMoney = false
  }
}

const createEntryMoney = async (name) => {
  saving.entryMoney = true
  try {
    const { $api } = useNuxtApp()
    await $api('/financial-categories/entry-money', {
      method: 'POST',
      body: { name }
    })
    await loadEntryMoney()
    useToast().success('Categoria criada com sucesso!')
  } catch (error) {
    useToast().error(error.response?.data?.message || 'Erro ao criar categoria')
  } finally {
    saving.entryMoney = false
  }
}

const updateEntryMoney = async (id, name) => {
  saving.entryMoney = true
  try {
    const { $api } = useNuxtApp()
    await $api(`/financial-categories/entry-money/${id}`, {
      method: 'PATCH',
      body: { name }
    })
    await loadEntryMoney()
    useToast().success('Categoria atualizada com sucesso!')
  } catch (error) {
    useToast().error(error.response?.data?.message || 'Erro ao atualizar categoria')
  } finally {
    saving.entryMoney = false
  }
}

const deleteEntryMoney = async (id) => {
  try {
    const { $api } = useNuxtApp()
    await $api(`/financial-categories/entry-money/${id}`, {
      method: 'DELETE'
    })
    await loadEntryMoney()
    useToast().success('Categoria excluída com sucesso!')
  } catch (error) {
    useToast().error(error.response?.data?.message || 'Erro ao excluir categoria')
  }
}

// Métodos para Custos Variáveis
const loadCostVariable = async () => {
  loading.costVariable = true
  try {
    const { $api } = useNuxtApp()
    costVariableCategories.value = await $api('/financial-categories/cost-variable')
  } catch (error) {
    console.error('Erro ao carregar categorias de custos variáveis:', error)
    costVariableCategories.value = []
  } finally {
    loading.costVariable = false
  }
}

const createCostVariable = async (name) => {
  saving.costVariable = true
  try {
    const { $api } = useNuxtApp()
    await $api('/financial-categories/cost-variable', {
      method: 'POST',
      body: { name }
    })
    await loadCostVariable()
    useToast().success('Categoria criada com sucesso!')
  } catch (error) {
    useToast().error(error.response?.data?.message || 'Erro ao criar categoria')
  } finally {
    saving.costVariable = false
  }
}

const updateCostVariable = async (id, name) => {
  saving.costVariable = true
  try {
    const { $api } = useNuxtApp()
    await $api(`/financial-categories/cost-variable/${id}`, {
      method: 'PATCH',
      body: { name }
    })
    await loadCostVariable()
    useToast().success('Categoria atualizada com sucesso!')
  } catch (error) {
    useToast().error(error.response?.data?.message || 'Erro ao atualizar categoria')
  } finally {
    saving.costVariable = false
  }
}

const deleteCostVariable = async (id) => {
  try {
    const { $api } = useNuxtApp()
    await $api(`/financial-categories/cost-variable/${id}`, {
      method: 'DELETE'
    })
    await loadCostVariable()
    useToast().success('Categoria excluída com sucesso!')
  } catch (error) {
    useToast().error(error.response?.data?.message || 'Erro ao excluir categoria')
  }
}

// Métodos para Contas Fixas
const loadFixesAccounts = async () => {
  loading.fixesAccounts = true
  try {
    const { $api } = useNuxtApp()
    fixesAccountsCategories.value = await $api('/financial-categories/fixes-accounts')
  } catch (error) {
    console.error('Erro ao carregar categorias de contas fixas:', error)
    fixesAccountsCategories.value = []
  } finally {
    loading.fixesAccounts = false
  }
}

const createFixesAccounts = async (name) => {
  saving.fixesAccounts = true
  try {
    const { $api } = useNuxtApp()
    await $api('/financial-categories/fixes-accounts', {
      method: 'POST',
      body: { name }
    })
    await loadFixesAccounts()
    useToast().success('Categoria criada com sucesso!')
  } catch (error) {
    useToast().error(error.response?.data?.message || 'Erro ao criar categoria')
  } finally {
    saving.fixesAccounts = false
  }
}

const updateFixesAccounts = async (id, name) => {
  saving.fixesAccounts = true
  try {
    const { $api } = useNuxtApp()
    await $api(`/financial-categories/fixes-accounts/${id}`, {
      method: 'PATCH',
      body: { name }
    })
    await loadFixesAccounts()
    useToast().success('Categoria atualizada com sucesso!')
  } catch (error) {
    useToast().error(error.response?.data?.message || 'Erro ao atualizar categoria')
  } finally {
    saving.fixesAccounts = false
  }
}

const deleteFixesAccounts = async (id) => {
  try {
    const { $api } = useNuxtApp()
    await $api(`/financial-categories/fixes-accounts/${id}`, {
      method: 'DELETE'
    })
    await loadFixesAccounts()
    useToast().success('Categoria excluída com sucesso!')
  } catch (error) {
    useToast().error(error.response?.data?.message || 'Erro ao excluir categoria')
  }
}

// Métodos para Investimentos
const loadInvestments = async () => {
  loading.investments = true
  try {
    const { $api } = useNuxtApp()
    investmentsCategories.value = await $api('/financial-categories/investments')
  } catch (error) {
    console.error('Erro ao carregar categorias de investimentos:', error)
    investmentsCategories.value = []
  } finally {
    loading.investments = false
  }
}

const createInvestments = async (name) => {
  saving.investments = true
  try {
    const { $api } = useNuxtApp()
    await $api('/financial-categories/investments', {
      method: 'POST',
      body: { name }
    })
    await loadInvestments()
    useToast().success('Categoria criada com sucesso!')
  } catch (error) {
    useToast().error(error.response?.data?.message || 'Erro ao criar categoria')
  } finally {
    saving.investments = false
  }
}

const updateInvestments = async (id, name) => {
  saving.investments = true
  try {
    const { $api } = useNuxtApp()
    await $api(`/financial-categories/investments/${id}`, {
      method: 'PATCH',
      body: { name }
    })
    await loadInvestments()
    useToast().success('Categoria atualizada com sucesso!')
  } catch (error) {
    useToast().error(error.response?.data?.message || 'Erro ao atualizar categoria')
  } finally {
    saving.investments = false
  }
}

const deleteInvestments = async (id) => {
  try {
    const { $api } = useNuxtApp()
    await $api(`/financial-categories/investments/${id}`, {
      method: 'DELETE'
    })
    await loadInvestments()
    useToast().success('Categoria excluída com sucesso!')
  } catch (error) {
    useToast().error(error.response?.data?.message || 'Erro ao excluir categoria')
  }
}

// Lifecycle
onMounted(async () => {
  await Promise.all([
    loadEntryMoney(),
    loadCostVariable(),
    loadFixesAccounts(),
    loadInvestments()
  ])
})
</script>

