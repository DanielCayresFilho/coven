<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between">
      <div>
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Relatório de Clientes</h1>
        <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">Top clientes que mais consomem</p>
      </div>
      <div class="mt-4 sm:mt-0 flex items-center gap-4">
        <button
          @click="toggleValuesVisibility"
          class="px-4 py-2 bg-gray-600 hover:bg-gray-700 text-white rounded-lg transition-colors flex items-center gap-2"
        >
          <component :is="hideValues ? EyeIcon : EyeSlashIcon" class="w-5 h-5" />
          {{ hideValues ? 'Mostrar Valores' : 'Esconder Valores' }}
        </button>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex justify-center items-center py-12">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-purple-600"></div>
    </div>

    <!-- Top Clients Table -->
    <div v-else class="bg-white dark:bg-gray-900/50 backdrop-blur border border-gray-200 dark:border-gray-800 rounded-xl overflow-hidden">
      <div class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
          <thead class="bg-gray-50 dark:bg-gray-800">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                Posição
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                Cliente
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                Agendamentos
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                Total Gasto
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                Ticket Médio
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                Último Atendimento
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                Ações
              </th>
            </tr>
          </thead>
          <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
            <tr
              v-for="(client, index) in topClients"
              :key="client.id"
              class="hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors"
            >
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">
                #{{ index + 1 }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="flex items-center">
                  <div class="flex-shrink-0 h-10 w-10 rounded-full bg-purple-100 dark:bg-purple-900/30 flex items-center justify-center">
                    <span class="text-purple-600 dark:text-purple-400 font-semibold">
                      {{ client.name.charAt(0).toUpperCase() }}
                    </span>
                  </div>
                  <div class="ml-4">
                    <div class="text-sm font-medium text-gray-900 dark:text-white">
                      {{ client.name }}
                    </div>
                    <div class="text-sm text-gray-500 dark:text-gray-400">
                      {{ client.email || client.phone || 'Sem contato' }}
                    </div>
                  </div>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                {{ client.appointmentCount }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-gray-900 dark:text-white">
                {{ hideValues ? '••••••' : formatCurrency(client.totalSpent) }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                {{ hideValues ? '••••' : formatCurrency(client.averageTicket) }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400">
                {{ client.lastAppointment ? formatDate(client.lastAppointment) : 'Nunca' }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                <button
                  @click="viewClientDetails(client.id)"
                  class="text-purple-600 hover:text-purple-900 dark:text-purple-400 dark:hover:text-purple-300"
                >
                  Ver Detalhes
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div v-if="topClients.length === 0" class="text-center py-12">
        <p class="text-gray-500 dark:text-gray-400">Nenhum cliente encontrado</p>
      </div>
    </div>

    <!-- Client Details Modal -->
    <div
      v-if="selectedClient"
      class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4"
      @click.self="closeClientDetails"
    >
      <div class="bg-white dark:bg-gray-900 rounded-xl max-w-4xl w-full max-h-[90vh] overflow-y-auto">
        <div class="p-6 border-b border-gray-200 dark:border-gray-800">
          <div class="flex items-center justify-between">
            <h2 class="text-xl font-bold text-gray-900 dark:text-white">
              Detalhes do Cliente: {{ selectedClient.name }}
            </h2>
            <button
              @click="closeClientDetails"
              class="text-gray-400 hover:text-gray-600 dark:hover:text-gray-300"
            >
              <XMarkIcon class="w-6 h-6" />
            </button>
          </div>
        </div>

        <div class="p-6 space-y-6">
          <!-- Client Info -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <p class="text-sm text-gray-600 dark:text-gray-400">Email</p>
              <p class="text-sm font-medium text-gray-900 dark:text-white">
                {{ selectedClient.email || 'Não informado' }}
              </p>
            </div>
            <div>
              <p class="text-sm text-gray-600 dark:text-gray-400">Telefone</p>
              <p class="text-sm font-medium text-gray-900 dark:text-white">
                {{ selectedClient.phone || 'Não informado' }}
              </p>
            </div>
            <div>
              <p class="text-sm text-gray-600 dark:text-gray-400">Total Gasto</p>
              <p class="text-lg font-bold text-purple-600 dark:text-purple-400">
                {{ hideValues ? '••••••' : formatCurrency(selectedClient.totalSpent) }}
              </p>
            </div>
            <div>
              <p class="text-sm text-gray-600 dark:text-gray-400">Ticket Médio</p>
              <p class="text-lg font-bold text-gray-900 dark:text-white">
                {{ hideValues ? '••••' : formatCurrency(selectedClient.averageTicket) }}
              </p>
            </div>
          </div>

          <!-- Appointments -->
          <div>
            <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
              Agendamentos ({{ selectedClient.appointments?.length || 0 }})
            </h3>
            <div class="space-y-2">
              <div
                v-for="apt in selectedClient.appointments"
                :key="apt.id"
                class="bg-gray-50 dark:bg-gray-800 rounded-lg p-4"
              >
                <div class="flex justify-between items-start">
                  <div>
                    <p class="font-medium text-gray-900 dark:text-white">
                      {{ formatDate(apt.date) }}
                    </p>
                    <p class="text-sm text-gray-600 dark:text-gray-400">
                      {{ apt.procedures?.map(p => p.procedure.name).join(', ') || 'Sem procedimentos' }}
                    </p>
                  </div>
                  <p class="font-semibold text-gray-900 dark:text-white">
                    {{ hideValues ? '••••' : formatCurrency(apt.finalPrice || apt.totalPrice || 0) }}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { EyeIcon, EyeSlashIcon, XMarkIcon } from '@heroicons/vue/24/outline'

definePageMeta({
  layout: 'default',
  middleware: 'auth'
})

useSeoMeta({
  title: 'Relatório de Clientes - Coven Beauty',
  description: 'Relatório de clientes que mais consomem'
})

const { $api } = useNuxtApp()
const topClients = ref([])
const selectedClient = ref(null)
const loading = ref(true)
const hideValues = ref(false)

const formatCurrency = (value) => {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(value || 0)
}

const formatDate = (date) => {
  if (!date) return 'N/A'
  return new Date(date).toLocaleDateString('pt-BR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric'
  })
}

const toggleValuesVisibility = () => {
  hideValues.value = !hideValues.value
}

const loadTopClients = async () => {
  try {
    loading.value = true
    const token = useCookie('covenos-token')
    const response = await $api('/clients/reports/top?limit=20', {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${token.value}`
      }
    })
    topClients.value = response || []
  } catch (error) {
    console.error('Erro ao carregar top clientes:', error)
    useToast().add({ type: 'error', title: 'Erro ao carregar relatório' })
  } finally {
    loading.value = false
  }
}

const viewClientDetails = async (clientId) => {
  try {
    const token = useCookie('covenos-token')
    const response = await $api(`/clients/reports/${clientId}`, {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${token.value}`
      }
    })
    selectedClient.value = response
  } catch (error) {
    console.error('Erro ao carregar detalhes do cliente:', error)
    useToast().add({ type: 'error', title: 'Erro ao carregar detalhes' })
  }
}

const closeClientDetails = () => {
  selectedClient.value = null
}

onMounted(async () => {
  await loadTopClients()
})
</script>

