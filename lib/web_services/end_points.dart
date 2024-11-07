const baseUrl = "https://t8nat.cloud/api";

class EndPoints {
  static const login = "/login?type=provider";
  static const register = "/register-provider";
  static const otpLogin = "/authorize-phone-login";
  static const otpRegister = "/authorize-phone-register";
  static const user = "/me";
  static providerProposals(
          {required double lat,
          required double lang,
          required int perPage,
          required int page}) =>
      "/provider-proposals?per_page=$perPage&page=$page&location_lat=$lat&location_lang=$lang";
  static createProposals({required int id}) => "/create-proposal/$id";
  static const proposals = "/get-all-proposals";
  static const slides = "/slides-provider";
  static const updateUser = "/update-info";
  static const services = "/services";
  static const onOff = "/update-status-active";
  static const getStatics = "/get-statics";
  static completeProject({required int id}) => "/update-project-status/$id";
  static getProposal({required int id}) => "/my-proposal-on-project/$id";

  static const requestService = "/projects";
  static refuseProposals({required int id}) => "/proposal/refuse/$id";
  static acceptProposals({required int id}) => "/proposal/accept/$id";
  static getInvoice({required int project_id}) => "/get-invoice/$project_id";
  static getInvoicePdf({required int invoice_id}) =>
      "/get-invoice-pdf/$invoice_id";
  static createInvoice({required int project_id}) =>
      "/create-invoice/$project_id";
  static updateInvoice({required int invoice_id}) =>
      "/update-invoice/$invoice_id";
}
