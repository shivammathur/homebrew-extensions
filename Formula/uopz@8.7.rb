# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT87 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "5703751282cecbdf13ea705244ea9f5e4be881f084d37a027bc9de7271f5e817"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "b3c50772bb8a2a5f52efa1fb222db9424366c7d87b3841ddb6948885533f2000"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "2521efe13a01335ac009c6ad61a372945c077fadbe16a204a8f3e3455fb160f7"
    sha256 cellar: :any,                 arm64_linux:       "42309e191c932f47dc61fb3b026659fc10d88460863aded2df910f15b70d311b"
    sha256 cellar: :any,                 x86_64_linux:      "bc5a81d812562254bc382782eadcd6ebc040a6c705970316ba0937a3dd108518"
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
