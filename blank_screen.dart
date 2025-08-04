import 'package:flutter/material.dart';
import '../db/database_helper.dart';

// ====================
// MODELOS DE DADOS
// ====================
class Filamento {
  int? id;
  String fabricante;
  int gramas;
  DateTime dataCompra;
  double precoCompra;
  bool danificado;
  String posicaoNota;
  String cor;

  Filamento({
    this.id,
    required this.fabricante,
    required this.gramas,
    required this.dataCompra,
    required this.precoCompra,
    required this.danificado,
    required this.posicaoNota,
    required this.cor,
  });

  Map<String, dynamic> toMap() => {
    "fabricante": fabricante,
    "gramas": gramas,
    "data_compra": dataCompra.toIso8601String(),
    "preco_compra": precoCompra,
    "danificado": danificado ? 1 : 0,
    "posicao_nota": posicaoNota,
    "cor": cor,
  };

  factory Filamento.fromMap(Map<String, dynamic> map) => Filamento(
    id: map['id'],
    fabricante: map['fabricante'] ?? '',
    gramas: map['gramas'] ?? 0,
    dataCompra: DateTime.parse(map['data_compra']),
    precoCompra: (map['preco_compra'] ?? 0).toDouble(),
    danificado: map['danificado'] == 1,
    posicaoNota: map['posicao_nota'] ?? '',
    cor: map['cor'] ?? '',
  );
}

class Acessorio {
  int? id;
  String nome;
  int quantidade;
  double precoCompra;

  Acessorio({
    this.id,
    required this.nome,
    required this.quantidade,
    required this.precoCompra,
  });

  Map<String, dynamic> toMap() => {
    "nome": nome,
    "quantidade": quantidade,
    "preco_compra": precoCompra,
  };

  factory Acessorio.fromMap(Map<String, dynamic> map) => Acessorio(
    id: map['id'],
    nome: map['nome'] ?? '',
    quantidade: map['quantidade'] ?? 0,
    precoCompra: (map['preco_compra'] ?? 0).toDouble(),
  );
}

class Cliente {
  int? id;
  String nome;
  String email;
  String mensagem;
  String objetivo;

  Cliente({
    this.id,
    required this.nome,
    required this.email,
    required this.mensagem,
    required this.objetivo,
  });

  Map<String, dynamic> toMap() => {
    "nome": nome,
    "email": email,
    "mensagem": mensagem,
    "objetivo": objetivo,
  };

  factory Cliente.fromMap(Map<String, dynamic> map) => Cliente(
    id: map['id'],
    nome: map['nome'] ?? '',
    email: map['email'] ?? '',
    mensagem: map['mensagem'] ?? '',
    objetivo: map['objetivo'] ?? '',
  );
}

class Modelo3D {
  int? id;
  String nome;
  int filamentoId;
  String tipoFilamento;
  int gramasUtilizadas;
  int tempoMinutos;
  String clienteOuPessoal;
  int? clienteId;
  String? clienteNome;
  double energiaKwh;
  double custoEnergia;
  double custoFilamento;
  double custoAcessorios;
  double custoTotal;
  String acessoriosUsados;
  double? precoVenda;
  DateTime? dataCriacao;

  Modelo3D({
    this.id,
    required this.nome,
    required this.filamentoId,
    required this.tipoFilamento,
    required this.gramasUtilizadas,
    required this.tempoMinutos,
    required this.clienteOuPessoal,
    this.clienteId,
    this.clienteNome,
    required this.energiaKwh,
    required this.custoEnergia,
    required this.custoFilamento,
    required this.custoAcessorios,
    required this.custoTotal,
    required this.acessoriosUsados,
    this.precoVenda,
    this.dataCriacao,
  });

  Map<String, dynamic> toMap() => {
    "nome": nome,
    "filamento_id": filamentoId,
    "tipo_filamento": tipoFilamento,
    "gramas_utilizadas": gramasUtilizadas,
    "tempo_minutos": tempoMinutos,
    "cliente_ou_pessoal": clienteOuPessoal,
    "cliente_id": clienteId,
    "cliente_nome": clienteNome,
    "energia_kwh": energiaKwh,
    "custo_energia": custoEnergia,
    "custo_filamento": custoFilamento,
    "custo_acessorios": custoAcessorios,
    "custo_total": custoTotal,
    "acessorios_usados": acessoriosUsados,
    "preco_venda": precoVenda,
    "data_criacao": (dataCriacao ?? DateTime.now()).toIso8601String(),
  };

  factory Modelo3D.fromMap(Map<String, dynamic> map) => Modelo3D(
    id: map['id'],
    nome: map['nome'] ?? '',
    filamentoId: map['filamento_id'] ?? 0,
    tipoFilamento: map['tipo_filamento'] ?? '',
    gramasUtilizadas: map['gramas_utilizadas'] ?? 0,
    tempoMinutos: map['tempo_minutos'] ?? 0,
    clienteOuPessoal: map['cliente_ou_pessoal'] ?? '',
    clienteId: map['cliente_id'],
    clienteNome: map['cliente_nome'],
    energiaKwh: (map['energia_kwh'] ?? 0).toDouble(),
    custoEnergia: (map['custo_energia'] ?? 0).toDouble(),
    custoFilamento: (map['custo_filamento'] ?? 0).toDouble(),
    custoAcessorios: (map['custo_acessorios'] ?? 0).toDouble(),
    custoTotal: (map['custo_total'] ?? 0).toDouble(),
    acessoriosUsados: map['acessorios_usados'] ?? '',
    precoVenda: map['preco_venda'] != null ? (map['preco_venda'] as num?)?.toDouble() : null,
    dataCriacao: map['data_criacao'] != null ? DateTime.parse(map['data_criacao']) : null,
  );
}

class Gasto {
  int? id;
  String descricao;
  double valor;
  DateTime data;

  Gasto({
    this.id,
    required this.descricao,
    required this.valor,
    required this.data,
  });

  Map<String, dynamic> toMap() => {
    "descricao": descricao,
    "valor": valor,
    "data": data.toIso8601String(),
  };

  factory Gasto.fromMap(Map<String, dynamic> map) => Gasto(
    id: map['id'],
    descricao: map['descricao'] ?? '',
    valor: (map['valor'] ?? 0).toDouble(),
    data: DateTime.parse(map['data']),
  );
}

// ==========================
// TELA PRINCIPAL BLANK
// ==========================
class BlankScreen extends StatefulWidget {
  final int userId;
  const BlankScreen({super.key, required this.userId});

  @override
  State<BlankScreen> createState() => _BlankScreenState();
}

class _BlankScreenState extends State<BlankScreen> {
  int _selectedIndex = 0;

  List<Filamento> filamentos = [];
  List<Acessorio> acessorios = [];
  List<Modelo3D> modelos = [];
  List<Cliente> clientes = [];
  List<Gasto> gastos = [];
  double precoKwhUser = 0.25;

  final List<String> _titles = [
    "Gestão de Armazenamento",
    "Gestão de Modelos 3D",
    "Gestão de Clientes",
    "Contabilidade",
    "Definições"
  ];

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    precoKwhUser = await DatabaseHelper.instance.getUserPrecoKwh(widget.userId);
    await Future.wait([
      _loadFilamentos(),
      _loadAcessorios(),
      _loadModelos(),
      _loadClientes(),
      _loadGastos(),
    ]);
  }

  Future<void> _loadFilamentos() async {
    final data = await DatabaseHelper.instance.getFilamentos(widget.userId);
    setState(() {
      filamentos = data.map((e) => Filamento.fromMap(e)).toList();
    });
  }

  Future<void> _loadAcessorios() async {
    final data = await DatabaseHelper.instance.getAcessorios(widget.userId);
    setState(() {
      acessorios = data.map((e) => Acessorio.fromMap(e)).toList();
    });
  }

  Future<void> _loadModelos() async {
    final data = await DatabaseHelper.instance.getModelos(widget.userId);
    setState(() {
      modelos = data.map((e) => Modelo3D.fromMap(e)).toList();
    });
  }

  Future<void> _loadClientes() async {
    final data = await DatabaseHelper.instance.getClientes(widget.userId);
    setState(() {
      clientes = data.map((e) => Cliente.fromMap(e)).toList();
    });
  }

  Future<void> _loadGastos() async {
    final data = await DatabaseHelper.instance.getGastos(widget.userId);
    setState(() {
      gastos = data.map((e) => Gasto.fromMap(e)).toList();
    });
  }

  void _onSelectMenu(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context);
    });
  }

  Future<void> _editarPrecoKwh(BuildContext ctx) async {
    final controller = TextEditingController(text: precoKwhUser.toStringAsFixed(3));
    final res = await showDialog<double>(
      context: ctx,
      builder: (c) => AlertDialog(
        title: const Text("Preço da Luz (€/kWh)"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: "Preço por kWh"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () {
              final val = double.tryParse(controller.text.replaceAll(',', '.'));
              if (val != null) Navigator.pop(c, val);
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
    if (res != null) {
      await DatabaseHelper.instance.updateUserPrecoKwh(widget.userId, res);
      setState(() => precoKwhUser = res);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      StoragePage(
        userId: widget.userId,
        filamentos: filamentos,
        acessorios: acessorios,
        onReload: _loadAll,
      ),
      ModelsPage(
        userId: widget.userId,
        modelos: modelos,
        filamentos: filamentos,
        acessorios: acessorios,
        clientes: clientes,
        precoKwhUser: precoKwhUser,
        onReload: _loadAll,
        onAddGasto: (g) async {
          await DatabaseHelper.instance.insertGasto(g.toMap(), widget.userId);
          await _loadGastos();
        },
      ),
      ClientsPage(
        userId: widget.userId,
        clientes: clientes,
        modelos: modelos,
        onReload: _loadAll,
      ),
      AccountingPage(
        modelos: modelos,
        gastos: gastos,
        filamentos: filamentos,
        acessorios: acessorios,
      ),
      SettingsPage(
        precoKwhUser: precoKwhUser,
        onEditarPrecoKwh: () => _editarPrecoKwh(context),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.inventory_2),
              title: const Text('Gestão de Armazenamento'),
              onTap: () => _onSelectMenu(0),
              selected: _selectedIndex == 0,
            ),
            ListTile(
              leading: const Icon(Icons.precision_manufacturing),
              title: const Text('Gestão de Modelos 3D'),
              onTap: () => _onSelectMenu(1),
              selected: _selectedIndex == 1,
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Gestão de Clientes'),
              onTap: () => _onSelectMenu(2),
              selected: _selectedIndex == 2,
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Contabilidade'),
              onTap: () => _onSelectMenu(3),
              selected: _selectedIndex == 3,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Definições'),
              onTap: () => _onSelectMenu(4),
              selected: _selectedIndex == 4,
            ),
          ],
        ),
      ),
      body: pages[_selectedIndex],
    );
  }
}

// ==========================
// STORAGE PAGE
// ==========================
class StoragePage extends StatelessWidget {
  final int userId;
  final List<Filamento> filamentos;
  final List<Acessorio> acessorios;
  final VoidCallback onReload;

  const StoragePage({
    super.key,
    required this.userId,
    required this.filamentos,
    required this.acessorios,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Filamentos em Stock",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Adicionar Filamento"),
              onPressed: () async {
                final res = await showDialog<Filamento>(
                  context: context,
                  builder: (ctx) => FilamentoDialog(),
                );
                if (res != null) {
                  await DatabaseHelper.instance.insertFilamento(res.toMap(), userId);
                  onReload();
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (filamentos.isEmpty)
          const Text("Nenhum filamento cadastrado.", style: TextStyle(color: Colors.grey)),
        ...filamentos.map((f) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple[100],
                  child: Text(f.cor.isNotEmpty ? f.cor[0].toUpperCase() : "?"),
                ),
                title: Text("${f.fabricante} - ${f.cor}"),
                subtitle: Text(
                    "${f.gramas}g | Compra: ${f.dataCompra.day}/${f.dataCompra.month}/${f.dataCompra.year}\n"
                    "Preço: €${f.precoCompra.toStringAsFixed(2)} | Posição: ${f.posicaoNota}\nEstado: ${f.danificado ? 'Danificado/Humidade' : 'Bom'}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await DatabaseHelper.instance.deleteFilamento(f.id!);
                    onReload();
                  },
                ),
              ),
            )),
        const Divider(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Acessórios Disponíveis",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Adicionar Acessório"),
              onPressed: () async {
                final res = await showDialog<Acessorio>(
                  context: context,
                  builder: (ctx) => AcessorioDialog(),
                );
                if (res != null) {
                  await DatabaseHelper.instance.insertAcessorio(res.toMap(), userId);
                  onReload();
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (acessorios.isEmpty)
          const Text("Nenhum acessório cadastrado.", style: TextStyle(color: Colors.grey)),
        ...acessorios.map((a) => Card(
              child: ListTile(
                title: Text(a.nome),
                subtitle: Text("Quantidade: ${a.quantidade} | Preço: €${a.precoCompra.toStringAsFixed(2)}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await DatabaseHelper.instance.deleteAcessorio(a.id!);
                    onReload();
                  },
                ),
              ),
            )),
      ],
    );
  }
}

class FilamentoDialog extends StatefulWidget {
  @override
  State<FilamentoDialog> createState() => _FilamentoDialogState();
}

class _FilamentoDialogState extends State<FilamentoDialog> {
  final _formKey = GlobalKey<FormState>();
  String fabricante = "";
  int gramas = 0;
  DateTime? dataCompra;
  double precoCompra = 0.0;
  bool danificado = false;
  String posicaoNota = "";
  String cor = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Novo Filamento"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Fabricante"),
                validator: (v) => v == null || v.isEmpty ? "Obrigatório" : null,
                onSaved: (v) => fabricante = v!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Cor"),
                validator: (v) => v == null || v.isEmpty ? "Obrigatório" : null,
                onSaved: (v) => cor = v!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Gramas em stock"),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || int.tryParse(v) == null ? "Número" : null,
                onSaved: (v) => gramas = int.parse(v!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Preço de compra (€)"),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || double.tryParse(v.replaceAll(',', '.')) == null ? "Valor" : null,
                onSaved: (v) => precoCompra = double.parse(v!.replaceAll(',', '.')),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Posição/Nota"),
                onSaved: (v) => posicaoNota = v ?? '',
              ),
              Row(
                children: [
                  const Text("Data de compra: "),
                  TextButton(
                    child: Text(dataCompra == null
                        ? "Escolher"
                        : "${dataCompra!.day}/${dataCompra!.month}/${dataCompra!.year}"),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) setState(() => dataCompra = picked);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: danificado,
                    onChanged: (v) => setState(() => danificado = v!),
                  ),
                  const Text("Danificado/Humidade"),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar")),
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate() && dataCompra != null) {
                _formKey.currentState!.save();
                Navigator.pop(
                  context,
                  Filamento(
                    fabricante: fabricante,
                    gramas: gramas,
                    dataCompra: dataCompra!,
                    precoCompra: precoCompra,
                    danificado: danificado,
                    posicaoNota: posicaoNota,
                    cor: cor,
                  ),
                );
              }
            },
            child: const Text("Salvar")),
      ],
    );
  }
}

class AcessorioDialog extends StatefulWidget {
  @override
  State<AcessorioDialog> createState() => _AcessorioDialogState();
}

class _AcessorioDialogState extends State<AcessorioDialog> {
  final _formKey = GlobalKey<FormState>();
  String nome = "";
  int quantidade = 0;
  double precoCompra = 0.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Novo Acessório"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Nome"),
              validator: (v) => v == null || v.isEmpty ? "Obrigatório" : null,
              onSaved: (v) => nome = v!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Quantidade"),
              keyboardType: TextInputType.number,
              validator: (v) => v == null || int.tryParse(v) == null ? "Número" : null,
              onSaved: (v) => quantidade = int.parse(v!),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Preço de compra (€)"),
              keyboardType: TextInputType.number,
              validator: (v) => v == null || double.tryParse(v.replaceAll(',', '.')) == null ? "Valor" : null,
              onSaved: (v) => precoCompra = double.parse(v!.replaceAll(',', '.')),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.pop(context, Acessorio(nome: nome, quantidade: quantidade, precoCompra: precoCompra));
              }
            },
            child: const Text("Salvar")),
      ],
    );
  }
}

// ==========================
// MODELS PAGE
// ==========================
class ModelsPage extends StatelessWidget {
  final int userId;
  final List<Modelo3D> modelos;
  final List<Filamento> filamentos;
  final List<Acessorio> acessorios;
  final List<Cliente> clientes;
  final double precoKwhUser;
  final VoidCallback onReload;
  final Future<void> Function(Gasto) onAddGasto;

  const ModelsPage({
    super.key,
    required this.userId,
    required this.modelos,
    required this.filamentos,
    required this.acessorios,
    required this.clientes,
    required this.precoKwhUser,
    required this.onReload,
    required this.onAddGasto,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Projetos de Modelos 3D",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Novo Modelo"),
              onPressed: () async {
                if (filamentos.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Adicione primeiro um filamento!")),
                  );
                  return;
                }
                final res = await showDialog<Modelo3D>(
                  context: context,
                  builder: (ctx) => Modelo3DDialog(
                    filamentos: filamentos,
                    acessorios: acessorios,
                    clientes: clientes,
                    precoKwhUser: precoKwhUser,
                  ),
                );
                if (res != null) {
                  await DatabaseHelper.instance.insertModelo(res.toMap(), userId);
                  if (res.custoEnergia > 0) {
                    await onAddGasto(Gasto(
                      descricao: "Energia - ${res.nome}",
                      valor: res.custoEnergia,
                      data: DateTime.now(),
                    ));
                  }
                  onReload();
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (modelos.isEmpty)
          const Text("Nenhum modelo registrado.", style: TextStyle(color: Colors.grey)),
        ...modelos.map((m) => Card(
              child: ListTile(
                title: Text(m.nome),
                subtitle: Text(
                    "Filamento: ${m.tipoFilamento}, ${m.gramasUtilizadas}g (€${m.custoFilamento.toStringAsFixed(2)})\n"
                    "Acessórios: €${m.custoAcessorios.toStringAsFixed(2)} | Energia: ${m.energiaKwh.toStringAsFixed(2)}kWh (€${m.custoEnergia.toStringAsFixed(2)})\n"
                    "Total: €${m.custoTotal.toStringAsFixed(2)}\n"
                    "Preço venda: €${(m.precoVenda ?? 0).toStringAsFixed(2)}\n"
                    "Cliente: ${m.clienteOuPessoal == "Cliente" ? (m.clienteNome ?? '') : "Pessoal"}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await DatabaseHelper.instance.deleteModelo(m.id!);
                    onReload();
                  },
                ),
              ),
            )),
      ],
    );
  }
}

class Modelo3DDialog extends StatefulWidget {
  final List<Filamento> filamentos;
  final List<Acessorio> acessorios;
  final List<Cliente> clientes;
  final double precoKwhUser;
  const Modelo3DDialog({
    super.key,
    required this.filamentos,
    required this.acessorios,
    required this.clientes,
    required this.precoKwhUser,
  });

  @override
  State<Modelo3DDialog> createState() => _Modelo3DDialogState();
}

class _Modelo3DDialogState extends State<Modelo3DDialog> {
  final _formKey = GlobalKey<FormState>();
  String nome = "";
  int filamentoId = 0;
  String tipoFilamento = "";
  int gramasUtilizadas = 0;
  int tempoMinutos = 0;
  String clienteOuPessoal = "Pessoal";
  int? clienteId;
  String? clienteNome;
  double custoEnergia = 0.0;
  double custoFilamento = 0.0;
  double custoAcessorios = 0.0;
  double custoTotal = 0.0;
  double energiaKwh = 0.0;
  double? precoVenda = 0;
  double potenciaPadraoKw = 0.13; // 130W

  Map<int, int> acessoriosSelecionados = {};

  void calcularCustos() {
    if (filamentoId == 0 && widget.filamentos.isNotEmpty) {
      filamentoId = widget.filamentos.first.id!;
    }
    final f = widget.filamentos.firstWhere((f) => f.id == filamentoId, orElse: () => widget.filamentos.first);
    tipoFilamento = f.cor;
    custoFilamento = (f.gramas == 0)
        ? 0
        : (gramasUtilizadas / f.gramas) * f.precoCompra;

    custoAcessorios = 0.0;
    if (acessoriosSelecionados.isNotEmpty) {
      for (var entry in acessoriosSelecionados.entries) {
        final ac = widget.acessorios.firstWhere((a) => a.id == entry.key);
        custoAcessorios += entry.value * ac.precoCompra;
      }
    }
    // Calcula energia automaticamente pelo tempo
    energiaKwh = ((tempoMinutos / 60.0) * potenciaPadraoKw);
    custoEnergia = energiaKwh * widget.precoKwhUser;
    custoTotal = custoFilamento + custoAcessorios + custoEnergia;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Novo Modelo 3D"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nome"),
                validator: (v) => v == null || v.isEmpty ? "Obrigatório" : null,
                onSaved: (v) => nome = v!,
              ),
              DropdownButtonFormField<int>(
                value: widget.filamentos.first.id,
                decoration: const InputDecoration(labelText: "Filamento usado"),
                items: widget.filamentos
                    .map((f) => DropdownMenuItem<int>(
                        value: f.id, child: Text("${f.cor} (${f.fabricante})")))
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    filamentoId = v!;
                    tipoFilamento = widget.filamentos.firstWhere((f) => f.id == v).cor;
                  });
                },
                onSaved: (v) {
                  filamentoId = v!;
                  tipoFilamento = widget.filamentos.firstWhere((f) => f.id == v).cor;
                },
                validator: (v) => v == null ? "Selecione o filamento" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Gramas Utilizadas"),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || int.tryParse(v) == null ? "Número" : null,
                onChanged: (v) {
                  gramasUtilizadas = int.tryParse(v) ?? 0;
                },
                onSaved: (v) => gramasUtilizadas = int.parse(v!),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: "Tempo de impressão (minutos)"),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || int.tryParse(v) == null ? "Minutos" : null,
                onChanged: (v) {
                  tempoMinutos = int.tryParse(v) ?? 0;
                  setState(() {
                    energiaKwh = ((tempoMinutos / 60.0) * potenciaPadraoKw);
                  });
                },
                onSaved: (v) => tempoMinutos = int.parse(v!),
              ),
              Row(
                children: [
                  const Text("Potência impressora (W):"),
                  Expanded(
                    child: TextFormField(
                      initialValue: (potenciaPadraoKw * 1000).toStringAsFixed(0),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(),
                      onChanged: (v) {
                        double w = double.tryParse(v) ?? 130.0;
                        setState(() {
                          potenciaPadraoKw = w / 1000.0;
                          energiaKwh = ((tempoMinutos / 60.0) * potenciaPadraoKw);
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text("Consumo: ${energiaKwh.toStringAsFixed(3)} kWh"),
                ],
              ),
              DropdownButtonFormField<String>(
                value: "Pessoal",
                decoration: const InputDecoration(labelText: "Destino"),
                items: const [
                  DropdownMenuItem(value: "Pessoal", child: Text("Pessoal")),
                  DropdownMenuItem(value: "Cliente", child: Text("Cliente")),
                ],
                onChanged: (v) => setState(() => clienteOuPessoal = v ?? "Pessoal"),
                onSaved: (v) => clienteOuPessoal = v ?? "Pessoal",
              ),
              if (clienteOuPessoal == "Cliente")
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: "Cliente"),
                  value: widget.clientes.isNotEmpty ? widget.clientes.first.id : null,
                  items: widget.clientes
                      .map((c) => DropdownMenuItem<int>(
                          value: c.id, child: Text(c.nome)))
                      .toList(),
                  onChanged: (v) {
                    clienteId = v;
                    clienteNome = widget.clientes.firstWhere((c) => c.id == v).nome;
                  },
                  onSaved: (v) {
                    clienteId = v;
                    clienteNome = widget.clientes.firstWhere((c) => c.id == v).nome;
                  },
                  validator: (v) => v == null ? "Selecione o cliente" : null,
                ),
              const SizedBox(height: 12),
              const Text("Acessórios usados (escolha e quantidade):"),
              ...widget.acessorios.map((a) => Row(
                children: [
                  Expanded(child: Text(a.nome)),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: "0"),
                      keyboardType: TextInputType.number,
                      initialValue: "0",
                      onChanged: (v) {
                        final qtd = int.tryParse(v) ?? 0;
                        setState(() {
                          if (qtd > 0) {
                            acessoriosSelecionados[a.id!] = qtd;
                          } else {
                            acessoriosSelecionados.remove(a.id!);
                          }
                        });
                      },
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: "Preço de venda (€)"),
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  precoVenda = double.tryParse(v.replaceAll(',', '.')) ?? 0;
                },
                onSaved: (v) =>
                    precoVenda = double.tryParse(v!.replaceAll(',', '.')) ?? 0,
              ),
              const SizedBox(height: 8),
              Text("Preço de luz atual: €${widget.precoKwhUser.toStringAsFixed(3)} por kWh"),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    calcularCustos();
                  });
                },
                child: const Text("Calcular Custos"),
              ),
              const SizedBox(height: 8),
              Text("Custo Filamento: €${custoFilamento.toStringAsFixed(2)}\n"
                  "Acessórios: €${custoAcessorios.toStringAsFixed(2)}\n"
                  "Energia: €${custoEnergia.toStringAsFixed(2)}\n"
                  "Total: €${custoTotal.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                calcularCustos();
                String accString = "";
                if (acessoriosSelecionados.isNotEmpty) {
                  for (var entry in acessoriosSelecionados.entries) {
                    final ac = widget.acessorios.firstWhere((a) => a.id == entry.key);
                    accString += "${ac.nome}:${entry.value},";
                  }
                }
                Navigator.pop(
                  context,
                  Modelo3D(
                    nome: nome,
                    filamentoId: filamentoId,
                    tipoFilamento: tipoFilamento,
                    gramasUtilizadas: gramasUtilizadas,
                    tempoMinutos: tempoMinutos,
                    clienteOuPessoal: clienteOuPessoal,
                    clienteId: clienteId,
                    clienteNome: clienteNome,
                    energiaKwh: energiaKwh,
                    custoEnergia: custoEnergia,
                    custoFilamento: custoFilamento,
                    custoAcessorios: custoAcessorios,
                    custoTotal: custoTotal,
                    acessoriosUsados: accString,
                    precoVenda: precoVenda,
                    dataCriacao: DateTime.now(),
                  ),
                );
              }
            },
            child: const Text("Salvar")),
      ],
    );
  }
}

// ==========================
// CLIENTS PAGE
// ==========================
class ClientsPage extends StatelessWidget {
  final int userId;
  final List<Cliente> clientes;
  final List<Modelo3D> modelos;
  final VoidCallback onReload;

  const ClientsPage({
    super.key,
    required this.userId,
    required this.clientes,
    required this.modelos,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Clientes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Adicionar Cliente"),
              onPressed: () async {
                final res = await showDialog<Cliente>(
                  context: context,
                  builder: (ctx) => ClienteDialog(),
                );
                if (res != null) {
                  await DatabaseHelper.instance.insertCliente(res.toMap(), userId);
                  onReload();
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (clientes.isEmpty)
          const Text("Nenhum cliente registrado.", style: TextStyle(color: Colors.grey)),
        ...clientes.map((c) => Card(
              child: ExpansionTile(
                title: Text(c.nome),
                subtitle: Text("Email: ${c.email} | Objetivo: ${c.objetivo}"),
                children: [
                  ListTile(
                    title: const Text("Projetos deste cliente:"),
                  ),
                  ...modelos
                      .where((m) => m.clienteId == c.id)
                      .map((m) => ListTile(
                            title: Text(m.nome),
                            subtitle: Text(
                                "Data: ${m.dataCriacao?.day}/${m.dataCriacao?.month}/${m.dataCriacao?.year} | Total: €${m.custoTotal.toStringAsFixed(2)}"),
                          ))
                      .toList(),
                  TextButton.icon(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text("Apagar Cliente"),
                    onPressed: () async {
                      await DatabaseHelper.instance.deleteCliente(c.id!);
                      onReload();
                    },
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class ClienteDialog extends StatefulWidget {
  @override
  State<ClienteDialog> createState() => _ClienteDialogState();
}

class _ClienteDialogState extends State<ClienteDialog> {
  final _formKey = GlobalKey<FormState>();
  String nome = "";
  String email = "";
  String mensagem = "";
  String objetivo = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Novo Cliente"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nome"),
                validator: (v) => v == null || v.isEmpty ? "Obrigatório" : null,
                onSaved: (v) => nome = v!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Email"),
                validator: (v) => v == null || v.isEmpty ? "Obrigatório" : null,
                onSaved: (v) => email = v!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Objetivo"),
                validator: (v) => v == null || v.isEmpty ? "Obrigatório" : null,
                onSaved: (v) => objetivo = v!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Mensagem"),
                maxLines: 2,
                onSaved: (v) => mensagem = v ?? "",
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.pop(
                  context,
                  Cliente(
                    nome: nome,
                    email: email,
                    mensagem: mensagem,
                    objetivo: objetivo,
                  ),
                );
              }
            },
            child: const Text("Salvar")),
      ],
    );
  }
}

// ==========================
// ACCOUNTING PAGE
// ==========================
class AccountingPage extends StatelessWidget {
  final List<Modelo3D> modelos;
  final List<Gasto> gastos;
  final List<Filamento> filamentos;
  final List<Acessorio> acessorios;

  const AccountingPage({
    super.key,
    required this.modelos,
    required this.gastos,
    required this.filamentos,
    required this.acessorios,
  });

  @override
  Widget build(BuildContext context) {
    double totalEnergia = modelos.fold(0, (sum, m) => sum + m.energiaKwh);
    double custoEnergia = modelos.fold(0, (sum, m) => sum + m.custoEnergia);
    double gastoFilamento = modelos.fold(0, (sum, m) => sum + m.custoFilamento);
    double gastoAcessorios = modelos.fold(0, (sum, m) => sum + m.custoAcessorios);
    double gastoOutros = gastos.fold(0, (s, g) => s + g.valor);

    // Ganhos (só modelos vendidos, ou seja, com preçoVenda > 0 e cliente)
    double ganhos = modelos
        .where((m) => (m.clienteOuPessoal == "Cliente" || m.clienteId != null) && (m.precoVenda ?? 0) > 0)
        .fold(0.0, (sum, m) => sum + (m.precoVenda ?? 0));
    // Lucro
    double custos = custoEnergia + gastoFilamento + gastoAcessorios + gastoOutros;
    double lucro = ganhos - custos;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text("Resumo Contábil", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        Card(
          color: Colors.green[50],
          child: ListTile(
            title: const Text("Ganhos em vendas"),
            subtitle: Text("Total ganho: €${ganhos.toStringAsFixed(2)}"),
          ),
        ),
        Card(
          color: lucro >= 0 ? Colors.green[100] : Colors.red[100],
          child: ListTile(
            title: const Text("Lucro"),
            subtitle: Text("Lucro líquido: €${lucro.toStringAsFixed(2)}"),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text("Energia (impressoras)"),
            subtitle: Text("Total: ${totalEnergia.toStringAsFixed(2)} kWh\nCusto: €${custoEnergia.toStringAsFixed(2)}"),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text("Filamento"),
            subtitle: Text("Gasto total: €${gastoFilamento.toStringAsFixed(2)}"),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text("Acessórios"),
            subtitle: Text("Gasto total: €${gastoAcessorios.toStringAsFixed(2)}"),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text("Outros Gastos"),
            subtitle: Text("Outros gastos registrados: €${gastoOutros.toStringAsFixed(2)}"),
          ),
        ),
        const SizedBox(height: 24),
        const Text("Lançamentos", style: TextStyle(fontWeight: FontWeight.bold)),
        ...gastos.map((g) => ListTile(
              title: Text(g.descricao),
              subtitle: Text("${g.data.day}/${g.data.month}/${g.data.year}"),
              trailing: Text("€${g.valor.toStringAsFixed(2)}"),
            )),
      ],
    );
  }
}

// ==========================
// SETTINGS PAGE
// ==========================
class SettingsPage extends StatelessWidget {
  final double precoKwhUser;
  final VoidCallback onEditarPrecoKwh;

  const SettingsPage({
    super.key,
    required this.precoKwhUser,
    required this.onEditarPrecoKwh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Definições", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Text("Preço da luz atual: €${precoKwhUser.toStringAsFixed(3)} por kWh"),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text("Alterar preço da luz"),
            onPressed: onEditarPrecoKwh,
          ),
          const SizedBox(height: 32),
          const Text(
            "Outras definições poderão ser acrescentadas futuramente.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}