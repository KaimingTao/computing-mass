// Table is the middleware between object and table like data type or UI representation

{
  caption: 'display name',
  property: 'intertional accessing name, map to object property name',
  hidden: false, // default is not hidden
  ediatable: false, // default is not editable
  disable: false, // default is used in the table, it's different with hidden, it's just not there
  getter: () => {},
  formater: () => {},
  setter: () => {}
}
