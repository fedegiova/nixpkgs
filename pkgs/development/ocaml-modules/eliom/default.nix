{ buildDunePackage
, lib
, fetchFromGitHub
, fetchpatch
, which
, ocsigen_server
, lwt_react
, ppx_deriving
, ppx_optcomp
, js_of_ocaml-ocamlbuild
, js_of_ocaml-ppx
, js_of_ocaml-ppx_deriving_json
, js_of_ocaml-lwt
, js_of_ocaml-tyxml
, lwt_ppx
, ocsipersist
}:

buildDunePackage rec {
  pname = "eliom";
  version = "10.3.1";

  src = fetchFromGitHub {
    owner = "ocsigen";
    repo = "eliom";
    rev = version;
    hash = "sha256-REOyxwnQqWOKywVYwN/WP22cNKZv5Nv0OpFVbNBPJN8=";
  };

  # Compatibility with tyxml 4.6.x
  patches = fetchpatch {
    url = "https://github.com/ocsigen/eliom/commit/9a6adcce3959a37b971890999331335d07f4f732.patch";
    hash = "sha256-rgsqohSAHHljvag3c+HNGEgW9qwmqPq8qfTpX6vVKtg=";
  };

  nativeBuildInputs = [
    which
  ];
  buildInputs = [
    js_of_ocaml-ocamlbuild
    js_of_ocaml-ppx_deriving_json
    ppx_optcomp
  ];

  propagatedBuildInputs = [
    js_of_ocaml-lwt
    js_of_ocaml-ppx
    js_of_ocaml-tyxml
    lwt_ppx
    lwt_react
    ocsigen_server
    ocsipersist
    ppx_deriving
  ];

  strictDeps = true;

  setupHook = [ ./setup-hook.sh ];

  meta = {
    homepage = "http://ocsigen.org/eliom/";
    description = "OCaml Framework for programming Web sites and client/server Web applications";

    longDescription = ''Eliom is a framework for programming Web sites
    and client/server Web applications. It introduces new concepts to
    simplify programming common behaviours and uses advanced static
    typing features of OCaml to check many properties of the Web site
    at compile time. If you want to write a Web application, Eliom
    makes possible to write the whole application as a single program
    (client and server parts). A syntax extension is used to
    distinguish both parts and the client side is compiled to JS using
    Ocsigen Js_of_ocaml.'';

    license = lib.licenses.lgpl21;

    maintainers = [ lib.maintainers.gal_bolle ];
  };
}
