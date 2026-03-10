export const useDate = () => {
  const getLocalDateString = (date = new Date()) => {
    const d = new Date(date)
    const year = d.getFullYear()
    const month = String(d.getMonth() + 1).padStart(2, '0')
    const day = String(d.getDate()).padStart(2, '0')
    return `${year}-${month}-${day}`
  }

  const getLocalTimeString = (date = new Date()) => {
    const d = new Date(date)
    const hours = String(d.getHours()).padStart(2, '0')
    const minutes = String(d.getMinutes()).padStart(2, '0')
    return `${hours}:${minutes}`
  }

  const buildLocalISO = (dateStr, timeStr) => {
    const [year, month, day] = dateStr.split('-').map(Number)
    const [hours, minutes] = timeStr.split(':').map(Number)
    return new Date(year, month - 1, day, hours, minutes, 0)
  }

  const toLocalISO = (date) => {
    const d = new Date(date)
    const year = d.getFullYear()
    const month = String(d.getMonth() + 1).padStart(2, '0')
    const day = String(d.getDate()).padStart(2, '0')
    const hours = String(d.getHours()).padStart(2, '0')
    const minutes = String(d.getMinutes()).padStart(2, '0')
    const seconds = String(d.getSeconds()).padStart(2, '0')
    return `${year}-${month}-${day}T${hours}:${minutes}:${seconds}`
  }

  const isSameLocalDay = (date1, date2 = new Date()) => {
    return getLocalDateString(date1) === getLocalDateString(date2)
  }

  const formatDate = (dateString) => {
    if (!dateString) return ''
    return new Date(dateString).toLocaleDateString('pt-BR', {
      day: '2-digit',
      month: 'short',
      year: 'numeric'
    })
  }

  const formatDateTime = (dateString) => {
    if (!dateString) return ''
    return new Date(dateString).toLocaleString('pt-BR')
  }

  const formatTime = (dateString) => {
    if (!dateString) return ''
    return new Date(dateString).toLocaleTimeString('pt-BR', {
      hour: '2-digit',
      minute: '2-digit'
    })
  }

  const formatCurrency = (value) => {
    return new Intl.NumberFormat('pt-BR', {
      style: 'currency',
      currency: 'BRL'
    }).format(value || 0)
  }

  return {
    getLocalDateString,
    getLocalTimeString,
    buildLocalISO,
    toLocalISO,
    isSameLocalDay,
    formatDate,
    formatDateTime,
    formatTime,
    formatCurrency
  }
}
