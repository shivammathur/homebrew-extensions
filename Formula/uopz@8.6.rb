# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT86 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  revision 1
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  resource "uopz_pr_185_patch" do
    url "https://patch-diff.githubusercontent.com/raw/krakjoe/uopz/pull/185.patch"
    sha256 "d93be7eb2495a35807a2f4468542d3d4295df5521159964a56b11b4a49418f9e"
  end

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "19f5ccf23c9f38464c4ab0f163272b0dd9ded558091f341fdaa55daf51300abe"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ff860ec2f1b1b17ac95ee18d6839cb7b74014074974d04b254412554be74de15"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "54dc1e6cbc8069b019a5cced1ff7248fd66f34200220fcaa8d80d4b4935849f9"
    sha256 cellar: :any_skip_relocation, sonoma:        "811eb9f53e42ab7ab01004d135aaab31a097f6d759cc8cecd8c0ae6f1f8e85c9"
    sha256 cellar: :any,                 arm64_linux:   "c44248b69b4379a85575cad5b95c38171b9decd72430b5a19866cc76719c5c0f"
    sha256 cellar: :any,                 x86_64_linux:  "bc032dfe10102e0f5dd8c361854b3908dad03daf0f75ae4ac73c2bcfc1262674"
  end

  priority "10"

  def install
    Dir.chdir "uopz-#{version}"
    patch_data = File.read(resource("uopz_pr_185_patch").cached_download)
    filtered_patch = []
    skip = false
    patch_data.each_line do |line|
      if line.start_with?("diff --git a/tests/")
        skip = true
      elsif line.start_with?("diff --git ")
        skip = false
      end
      next if skip

      filtered_patch << line
    end
    File.write("uopz-pr-185.patch", filtered_patch.join)
    system "patch", "-p1", "-i", "uopz-pr-185.patch"
    inreplace "uopz.c", "zend_exception_get_default()", "zend_ce_exception"
    inreplace "uopz.c", "INI_INT(", "zend_ini_long_literal("
    inreplace "uopz.c", '"uopz.exit",	"0"', '"uopz.exit",	"1"'
    inreplace "uopz.c" do |s|
      s.gsub!("\tuopz_handlers_init();\n", "")
      s.gsub!("\tuopz_handlers_shutdown();\n", "")
      s.gsub!("uopz_disabled_guard();", "uopz_disabled_guard();\n\tuopz_activate();")
    end
    inreplace "uopz.h", "zend_bool   disable;", "zend_bool   disable;\n\tzend_bool   active;"
    inreplace "src/handlers.c" do |s|
      s.sub!("_uopz_vm_dispatch(UOPZ_OPCODE_HANDLER_ARGS_PASSTHRU)", "ZEND_USER_OPCODE_DISPATCH")
      s.sub!("{ /* {{{ */\n\tCACHE_PTR(EX(opline)->result.num, NULL);",
             "{ /* {{{ */\n\tif (!zend_hash_num_elements(&UOPZ(returns)) && " \
             "!zend_hash_num_elements(&UOPZ(hooks)) && " \
             "!zend_hash_num_elements(&UOPZ(mocks))) {\n" \
             "\t\tUOPZ_VM_DISPATCH();\n" \
             "\t}\n\n\tCACHE_PTR(EX(opline)->result.num, NULL);")
    end
    inreplace "src/util.h", "void uopz_request_init(void);",
                            "void uopz_activate(void);\nvoid uopz_request_init(void);"
    inreplace "src/util.c" do |s|
      s.sub!("#include \"return.h\"", "#include \"handlers.h\"\n#include \"return.h\"")
      s.sub!("void uopz_request_init(void) { /* {{{ */\n\tUOPZ(copts) = CG(compiler_options);",
             "void uopz_activate(void) { /* {{{ */\n\tif (UOPZ(active)) {\n" \
             "\t\treturn;\n\t}\n\n\tUOPZ(copts) = CG(compiler_options);")
      s.sub!("\tzend_hash_init(&UOPZ(returns), 8, NULL, uopz_table_dtor, 0);",
             "\tuopz_handlers_init();\n\tuopz_callers_init();\n\tUOPZ(active) = 1;\n" \
             "} /* }}} */\n\nvoid uopz_request_init(void) { /* {{{ */\n" \
             "\tUOPZ(active) = 0;\n\n\tzend_hash_init(&UOPZ(returns), 8, NULL, uopz_table_dtor, 0);")
      s.sub!("zend_hash_init(&UOPZ(hooks), 8, NULL, uopz_table_dtor, 0);",
             "zend_hash_init(&UOPZ(hooks), 8, NULL, uopz_table_dtor, 0);\n\n" \
             "\tif (!UOPZ(exit)) {\n\t\tuopz_activate();\n\t}")
      s.sub!("\n\tuopz_callers_init();", "")
      s.sub!("void uopz_request_shutdown(void) { /* {{{ */\n\tCG(compiler_options) = UOPZ(copts);",
             "void uopz_request_shutdown(void) { /* {{{ */\n\tif (UOPZ(active)) {\n" \
             "\t\tCG(compiler_options) = UOPZ(copts);\n\t\tuopz_handlers_shutdown();")
      s.sub!("\n\tuopz_callers_shutdown();",
             "\n\t\tuopz_callers_shutdown();\n\t\tUOPZ(active) = 0;\n\t}")
    end
    inreplace "src/constant.c", "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace %w[src/hook.c src/return.c],
              "Z_OBJ(EX(This)) ? &EX(This) : NULL",
              "(ZEND_CALL_INFO(execute_data) & ZEND_CALL_HAS_THIS) ? Z_OBJ(EX(This)) : NULL"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
