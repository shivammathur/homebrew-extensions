# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Seaslog Extension
class SeaslogAT87 < AbstractPhpExtension
  init
  desc "Seaslog PHP extension"
  homepage "https://github.com/SeasX/SeasLog"
  url "https://pecl.php.net/get/SeasLog-2.2.0.tgz"
  sha256 "e40a1067075b1e0bcdfd5ff98647b9f83f502eb6b2a3d89e67b067704ea127da"
  revision 2
  head "https://github.com/SeasX/SeasLog.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/seaslog/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "a6cf006b1cb4dacad72ab925cd3bbb1d503943ea4f77235a35daf879d9d6733e"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "5e7977802451278576d87f02944a64c45ab78b5edfd4079e37546fa122cdcbf4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "696aa7850105e45b3e561a98e5f3ecfa15cd50671a64dbc2665580476a46d6e0"
    sha256 cellar: :any,                 arm64_linux:       "84a2666a1fb2abce71576e36862e647464f90c06724d36f3c482a9115e6ad404"
    sha256 cellar: :any,                 x86_64_linux:      "0aa7446e50705a5d7658cd4bcaf2a2e885f5640b240d88d1d5fa39e8971a8373"
  end

  def install
    Dir.chdir "SeasLog-#{version}"
    inreplace "src/Appender.c", "php_mkdir_ex(", "php_stream_mkdir("
    inreplace "src/Appender.c", "PHP_STREAM_MKDIR_RECURSIVE TSRMLS_CC", "PHP_STREAM_MKDIR_RECURSIVE, NULL"
    inreplace "src/ErrorHook.c" do |s|
      s.gsub!(
        "#if PHP_VERSION_ID < 80000\n" \
        "void (*old_error_cb)(int type, " \
        "const char *error_filename, " \
        "const SEASLOG_UINT error_lineno, " \
        "const char *format, va_list args);\n" \
        "#else\n" \
        "void (*old_error_cb)(int type, " \
        "const char *error_filename, " \
        "const SEASLOG_UINT error_lineno, " \
        "zend_string *message);\n" \
        "#endif",
        "#if PHP_VERSION_ID < 80000\n" \
        "void (*old_error_cb)(int type, " \
        "const char *error_filename, " \
        "const SEASLOG_UINT error_lineno, " \
        "const char *format, va_list args);\n" \
        "#elif PHP_VERSION_ID < 80200\n" \
        "void (*old_error_cb)(int type, " \
        "const char *error_filename, " \
        "const SEASLOG_UINT error_lineno, " \
        "zend_string *message);\n" \
        "#else\n" \
        "void (*old_error_cb)(int type, " \
        "zend_string *error_filename, " \
        "const SEASLOG_UINT error_lineno, " \
        "zend_string *message);\n" \
        "#endif",
      )
      s.gsub!(
        "#if PHP_VERSION_ID < 80000\n" \
        "void seaslog_error_cb(int type, " \
        "const char *error_filename, " \
        "const SEASLOG_UINT error_lineno, " \
        "const char *format, va_list args)\n" \
        "#else\n" \
        "void seaslog_error_cb(int type, " \
        "const char *error_filename, " \
        "const SEASLOG_UINT error_lineno," \
        "zend_string *message)\n" \
        "#endif",
        "#if PHP_VERSION_ID < 80000\n" \
        "void seaslog_error_cb(int type, " \
        "const char *error_filename, " \
        "const SEASLOG_UINT error_lineno, " \
        "const char *format, va_list args)\n" \
        "#elif PHP_VERSION_ID < 80200\n" \
        "void seaslog_error_cb(int type, " \
        "const char *error_filename, " \
        "const SEASLOG_UINT error_lineno," \
        "zend_string *message)\n" \
        "#else\n" \
        "void seaslog_error_cb(int type, " \
        "zend_string *error_filename, " \
        "const SEASLOG_UINT error_lineno, " \
        "zend_string *message)\n" \
        "#endif",
      )
      s.gsub!(
        "char *msg = ZSTR_VAL(message);\n#endif\n",
        "char *msg = ZSTR_VAL(message);\n#endif\n" \
        "#if PHP_VERSION_ID >= 80200\n        " \
        "const char *filename = ZSTR_VAL(error_filename);\n" \
        "#else\n        " \
        "const char *filename = error_filename;\n" \
        "#endif\n",
      )
      s.gsub!("(char *) error_filename", "(char *) filename")
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-seaslog"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
