class AppQuery {
  static String customerRequestQuery = """
  query CustomerRequest(\$id: Int!) {
    customerRequest(id: \$id) {
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

}
