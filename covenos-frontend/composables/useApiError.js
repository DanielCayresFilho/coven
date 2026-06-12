const DEFAULT_FIELD_KEYWORDS = {
  name: ['name', 'nome'],
  email: ['email'],
  phone: ['telefone', 'phone'],
  birthDate: ['birthdate', 'nascimento', 'data de nascimento'],
  address: ['address', 'endereço', 'endereco'],
  type: ['type', 'tipo'],
  stock: ['stock', 'estoque'],
  minStock: ['estoque mínimo', 'minstock'],
  unitQuantity: ['unitquantity', 'quantidade por unidade', 'unit quantity'],
  unitMeasurement: ['unitmeasurement', 'unidade de medida'],
  price: ['price', 'preço', 'preco'],
  duration: ['duration', 'duração', 'duracao'],
  category: ['category', 'categoria'],
}

export const useApiError = () => {
  const getMessage = (error, fallback = 'Erro inesperado') => {
    const message = error?.response?.data?.message

    if (Array.isArray(message) && message.length > 0) {
      return message.join(', ')
    }

    if (typeof message === 'string' && message.trim()) {
      return message
    }

    if (error?.message && !error?.response) {
      return error.message
    }

    return fallback
  }

  const mapFieldErrors = (error, fieldKeywords = DEFAULT_FIELD_KEYWORDS) => {
    const message = error?.response?.data?.message

    if (!Array.isArray(message)) {
      return {}
    }

    const errors = {}

    for (const msg of message) {
      const lower = msg.toLowerCase()

      for (const [field, keywords] of Object.entries(fieldKeywords)) {
        if (keywords.some((keyword) => lower.includes(keyword.toLowerCase()))) {
          errors[field] = msg
        }
      }
    }

    return errors
  }

  const fieldBorderClass = (formErrors, field) => (
    formErrors[field]
      ? 'border-red-500 focus:border-red-500 dark:border-red-500 dark:focus:border-red-500'
      : 'border-gray-300 dark:border-gray-700 focus:border-blue-500 dark:focus:border-purple-500'
  )

  const clearFormErrors = (formErrors, fields = Object.keys(formErrors)) => {
    for (const field of fields) {
      formErrors[field] = ''
    }
  }

  return {
    getMessage,
    mapFieldErrors,
    fieldBorderClass,
    clearFormErrors,
  }
}
