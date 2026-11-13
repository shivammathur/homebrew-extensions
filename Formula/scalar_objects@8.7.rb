# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT87 < AbstractPhpExtension
  init
  desc "Scalar objects PHP extension"
  homepage "https://github.com/nikic/scalar_objects"
  url "https://github.com/nikic/scalar_objects/archive/86dbcc0c939732faac93e3c5ea233205df142bf0.tar.gz"
  sha256 "a0f621772b37a9d15326f40cc9a28051504d9432ba089a734c1803f8081b0b39"
  version "86dbcc0c939732faac93e3c5ea233205df142bf0"
  revision 2
  head "https://github.com/nikic/scalar_objects.git", branch: "master"
  license "MIT"

  livecheck do
    skip "No tagged releases; using latest commit"
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "b1b89b60959c0fe38793cecf60d672c616fba3783373a9c80adc1ee7b1b0ed5b"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "2e9bc9e484f44383df7fcfac3ec397bfa94da3882692676addb9528afac5c0e3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "10192c48beeec6c54a9023863bff2e2e8a3942a4346a05fc1a19c69b57026869"
    sha256 cellar: :any,                 arm64_linux:       "acf7d18dadf078aeb107c7c1bd351306ee77d3c72e1f54ab21a01c07742dbac7"
    sha256 cellar: :any,                 x86_64_linux:      "a65524fcfd36211d2596c198b346102cb4017037e1da94dd4bf39299884a9c03"
  end

  def install
    inreplace "scalar_objects.c",
              '#include "php_scalar_objects.h"',
              "#include \"Zend/zend_vm.h\"\n#include \"php_scalar_objects.h\""
    inreplace "php_scalar_objects.h",
              ";\nZEND_END_MODULE_GLOBALS(scalar_objects)",
              ";\n\tzend_bool has_handlers;\nZEND_END_MODULE_GLOBALS(scalar_objects)"
    inreplace "scalar_objects.c" do |s|
      s.sub! "\tobj =",
              "\tif (!SCALAR_OBJECTS_G(has_handlers)) {\n" \
              "\t\treturn ZEND_USER_OPCODE_DISPATCH;\n" \
              "\t}\n\n" \
              "\tobj ="
      s.sub! "\tzend_set_user_opcode_handler(ZEND_INIT_METHOD_CALL, scalar_objects_method_call_handler);\n", ""
      s.sub! "zend_class_entry *ce = NULL;\n",
              "zend_class_entry *ce = NULL;\n" \
              "\tzend_execute_data *ex;\n" \
              "\tzend_op_array *op_array;\n" \
              "\tuint32_t i;\n"
      s.sub! "SCALAR_OBJECTS_G(handlers)[type] = ce;\n",
              "SCALAR_OBJECTS_G(handlers)[type] = ce;\n" \
              "\tif (!SCALAR_OBJECTS_G(has_handlers)) {\n" \
              "\t\tzend_set_user_opcode_handler(ZEND_INIT_METHOD_CALL, scalar_objects_method_call_handler);\n" \
              "\t\tex = execute_data->prev_execute_data;\n" \
              "\t\tif (ex && ex->func && ZEND_USER_CODE(ex->func->type)) {\n" \
              "\t\t\top_array = &ex->func->op_array;\n" \
              "\t\t\tfor (i = 0; i < op_array->last; i++) {\n" \
              "\t\t\t\tif (op_array->opcodes[i].opcode == ZEND_INIT_METHOD_CALL) {\n" \
              "\t\t\t\t\tzend_vm_set_opcode_handler(&op_array->opcodes[i]);\n" \
              "\t\t\t\t}\n" \
              "\t\t\t}\n" \
              "\t\t}\n" \
              "\t}\n" \
              "\tSCALAR_OBJECTS_G(has_handlers) = 1;\n"
      s.sub!("sizeof(zend_class_entry *));\n\n\treturn SUCCESS;",
             "sizeof(zend_class_entry *));\n" \
             "\tSCALAR_OBJECTS_G(has_handlers) = 0;\n\n" \
             "\treturn SUCCESS;")
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
