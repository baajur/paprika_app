import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paprika_app/authentication/models/branch.dart';
import 'package:paprika_app/authentication/models/device.dart';
import 'package:paprika_app/pos/models/cash_drawer.dart';
import 'package:paprika_app/pos/models/document.dart';
import 'package:paprika_app/pos/services/cash_drawer_services.dart';
import 'package:paprika_app/pos/services/invoice_services.dart';

class SalesRepository {
  final InvoiceApi _invoiceApi = InvoiceApi();
  final CashDrawerFirebaseApi _cashDrawerFirebaseApi = CashDrawerFirebaseApi();

  Future<List<DocumentLine>> fetchInvoiceDetail(Document invoice) =>
      _invoiceApi.fetchInvoiceDetail(invoice);

  Future<DocumentReference> createInvoice(Document invoice) =>
      _invoiceApi.createInvoice(invoice);

  Future<DocumentReference> createDetailInvoice(
          String invoiceId, DocumentLine detail) =>
      _invoiceApi.createDetailInvoice(invoiceId, detail);

  Future<void> updateInvoiceData(Document invoice) =>
      _invoiceApi.updateInvoiceData(invoice);

  Future<CashDrawer> fetchCashDrawerById(String id) =>
      _cashDrawerFirebaseApi.fetchCashDrawerById(id);

  Future<List<CashDrawer>> fetchCashDrawersByBranch(Branch branch) =>
      _cashDrawerFirebaseApi.fetchCashDrawersByBranch(branch);

  Future<OpeningCashDrawer> fetchOpenedCashDrawerOfDevice(Device device) =>
      _cashDrawerFirebaseApi.fetchOpenedCashDrawerOfDevice(device);

  Future<List<Document>> fetchDocumentByEnterprise(
          Branch branch,
          String documentType,
          Timestamp fromDate,
          Timestamp toDate,
          String state) =>
      _invoiceApi.fetchDocumentsBy(
          branch, documentType, fromDate, toDate, state);

  Future<void> openCashDrawer(OpeningCashDrawer openingCashDrawer) =>
      _cashDrawerFirebaseApi.createOpeningCashDrawer(openingCashDrawer);

  Future<void> updateOpeningCashDrawer(OpeningCashDrawer openingCashDrawer) =>
      _cashDrawerFirebaseApi.updateOpeningCashDrawer(openingCashDrawer);

  Future<OpeningCashDrawer> lastOpeningCashDrawer(
          DateTime dateTime, Branch branch, CashDrawer cashDrawer) =>
      _cashDrawerFirebaseApi.lastOpeningCashDrawer(
          dateTime, branch, cashDrawer);

  Future<List<Document>> fetchInvoiceOfCashDrawer(CashDrawer cashDrawer) =>
      _cashDrawerFirebaseApi.fetchInvoiceOfCashDrawer(cashDrawer);
}
