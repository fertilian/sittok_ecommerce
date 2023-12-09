class ApiConnect {
  static const hostConnect = "http://192.168.6.51:8000";
  static const connectApi = "$hostConnect/api";
  static const login = "$connectApi/login";
  static const register = "$connectApi/register";
  static const kategori = "$connectApi/kategori";
  static const aset = "$connectApi/getDataAset";
  static const detilbarang = "$connectApi/getDetilAset";
  static const favorit = "$connectApi/getDataAsetFav";
  static const total = "$connectApi/getTotalKeranjang";
  static const paymen = "$connectApi/getAllPaymen";
  static const detiljual = "$connectApi/storeDetil";
  static const keranjang = "$connectApi/getDataKeranjang";
  static const getKlaim = "$connectApi/getDetilJual";
  static const getNota = "$connectApi/getNota";
  static const profil = "$connectApi/getUserById";
  static const updateprofil = "$connectApi/updateProfile";
  static const jual = "$connectApi/storeJual";
  static const getjual = "$connectApi/getDataJualByCustomer";
  static const minQty = "$connectApi/updateQty";
  static const bayar = "$connectApi/updateJual";
  static const updateKlaim= "$connectApi/updateKlaim";
  static const updatebarang = "$connectApi/updateDataBarang";
  static const triger = "$connectApi/updateDataBarang";

  static const add_datakeranjang = "$connectApi/addDataKeranjang";
  static const add_datafavorit = "$connectApi/addDataFavorit";
  static const del_datafavorit = "$connectApi/deleteDataFavorit";
  static const addQty = "$connectApi/updateDataKeranjang";
  static const statusjual = "$connectApi/updateStatusKeranjang";
}
