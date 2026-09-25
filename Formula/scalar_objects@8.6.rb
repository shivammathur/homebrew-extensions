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
  revision 2
  head "https://github.com/nikic/scalar_objects.git", branch: "master"
  license "MIT"

  livecheck do
    skip "No tagged releases; using latest commit"
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "a4eb3e4e7aefc546c8a782af8a4745dc9b1a58dcb940e2b783b5f22c56511f4c"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "f41bd26bcfda0d41643baaecd6c496ba597f868595f27b8cd7173657a61d71a4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "4332bcd88ff0eedaca4eb602d8a8cf81d9f1e8649f78125e92146856bc634002"
    sha256 cellar: :any,                 arm64_linux:       "d8a9a3060942ce6a461d0e2d0a0973d06eb11fb200150b71b8798a1b50788809"
    sha256 cellar: :any,                 x86_64_linux:      "11bcbb373dd747bc521a3c58564cf41b4676fd437a6f6cc47b4eb5b5bce60951"
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
