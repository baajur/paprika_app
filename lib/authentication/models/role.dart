class Role extends Object {
  String id;
  String systemId;
  String name;

  Role(this.systemId, this.name);

  Role.fromFireJson(String documentId, Map<String, dynamic> json) {
    this.id = documentId;
    this.systemId = json['systemId'];
    this.name = json['name'];
  }

  Map<String, dynamic> toFireJson() => {
        'systemId': this.systemId,
        'name': this.name,
      };

  @override
  String toString() {
    return 'Role{id: $id, systemId: $systemId, name: $name}';
  }
}
