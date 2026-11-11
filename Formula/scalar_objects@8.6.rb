# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT86 < AbstractPhpExtension
  init
  desc "Scalar objects PHP extension"
  homepage "https://github.com/nikic/scalar_objects"
  url "https://github.com/nikic/scalar_objects/archive/86dbcc0c939732faac93e3c5ea233205df142bf0.tar.gz"
  sha256 "a0f621772b37a9d15326f40cc9a28051504d9432ba089a734c1803f8081b0b39"
  version "86dbcc0c939732faac93e3c5ea233205df142bf0"
  revision 3
  head "https://github.com/nikic/scalar_objects.git", branch: "master"
  license "MIT"

  livecheck do
    skip "No tagged releases; using latest commit"
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "0fdeb514c7b9ae630b3ea7ddbc08596d73016b0e1941d781565de27fe3278527"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "12bce826aa8fac5dc25066b2e3d559682c231ee7826f3d4d5040f4ccb1ca0a03"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "da9017c875d213ddb399ec6448c8a55fb04ddced4801fdccaeec9c573e9346ba"
    sha256 cellar: :any,                 arm64_linux:       "016838852fcdb0d924724c57939303a707e44208358e6e7fdfc5e5ff040c9d27"
    sha256 cellar: :any,                 x86_64_linux:      "662d6f6ce7f79f3a2623bc51581a85c30fca68b99b82e0852337c9ebdabae945"
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
