const toasts = ref([])

export const useToast = () => {
  const addToast = (message, type = 'info', duration = 5000) => {
    const id = Date.now() + Math.random()
    const toast = {
      id,
      message,
      type,
      duration
    }
    
    toasts.value.push(toast)
    
    if (duration > 0) {
      setTimeout(() => {
        removeToast(id)
      }, duration)
    }
    
    return id
  }

  const removeToast = (id) => {
    const index = toasts.value.findIndex(toast => toast.id === id)
    if (index > -1) {
      toasts.value.splice(index, 1)
    }
  }

  const success = (message, duration) => addToast(message, 'success', duration)
  const error = (message, duration) => addToast(message, 'error', duration)
  const warning = (message, duration) => addToast(message, 'warning', duration)
  const info = (message, duration) => addToast(message, 'info', duration)

  const add = (options) => {
    const { type = 'info', title, description, duration = 5000 } = options
    const message = description || title || 'Notificação'
    return addToast(message, type, duration)
  }

  return {
    toasts: readonly(toasts),
    addToast,
    removeToast,
    success,
    error,
    warning,
    info,
    add
  }
}
