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
  head "https://github.com/nikic/scalar_objects.git", branch: "master"
  license "MIT"

  livecheck do
    skip "No tagged releases; using latest commit"
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "0bb4f72bd563ee5c56c7fa72335736affb08fc606d6557f47c1623004a206dcb"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "7ed50ff4e2d67e550aab143db1107e8d4b49a9f2317d549e66d3726198dad166"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "32f2ad2481521718bf421eb6e63eccc4dd06c028ab746c999347006071195e72"
    sha256 cellar: :any,                 arm64_linux:       "6f923512771ad4e65ac1c40f39f6325c86c833d865a5a451f36bdd5909ed7683"
    sha256 cellar: :any,                 x86_64_linux:      "586724797265304c78c5209237a246d8ea6fe4a0a2d52153c625142bd889d256"
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
