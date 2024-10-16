class AppMutation {
  static String login = """
    mutation Login(\$username: String!, \$password: String!, \$fcmToken: String, \$rememberMe: Boolean) {
      login(input: { username: \$username, password: \$password, fcmToken: \$fcmToken, rememberMe: \$rememberMe }) {
        user {
          id
          username
        }
        expiresAt
        token
      }
    }
  """;

  static String updateCustomerRequestStatusMutation = """
  mutation UpdateCustomerRequestStatusInput(\$input: UpdateCustomerRequestInput!) {
    UpdateCustomerRequestStatusInput(input: \$input) {
      id
    }
  }
  """;

  static String deleteCustomerRequestMutation = """
  mutation DeleteCustomerRequest(\$id: Int!) {
    deleteCustomerRequest(id: \$id) {
      id
      date
      payeeName
      notes
      editable
      deletable
      paymentAccountNumber
      createdAt
    }
  }
  """;

  static String saveCustomerRequestMutation = """
    mutation SaveCustomerRequest(\$id: Int!, \$payeeName: String!, \$typeCode: String!, \$date: String!, \$deliveryTypeCode: String!) {
      saveCustomerRequest(
        input: {
          id: \$id
          payeeName: \$payeeName
          typeCode: \$typeCode
          date: \$date
          deliveryTypeCode: \$deliveryTypeCode
        }
      ) {
        id
        date
      }
    }
  """;

  static String createTicketReplyMutation = """
    mutation CreateTicketReply(\$body: String!, \$ticketId: Int!) {
      createTicketReply(input: { body: \$body, ticketId: \$ticketId }) {
        id
      }
    }
  """;
}
