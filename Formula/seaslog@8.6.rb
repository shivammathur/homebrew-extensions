# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Seaslog Extension
class SeaslogAT86 < AbstractPhpExtension
  init
  desc "Seaslog PHP extension"
  homepage "https://github.com/SeasX/SeasLog"
  url "https://pecl.php.net/get/SeasLog-2.2.0.tgz"
  sha256 "e40a1067075b1e0bcdfd5ff98647b9f83f502eb6b2a3d89e67b067704ea127da"
  revision 3
  head "https://github.com/SeasX/SeasLog.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/seaslog/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "56845502f7e4d813c35c9d5e6bfe96905553f01516b5ec1b2f9a23d8b4f580f4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "f11422d02392acc33ef41a8f9f32e7e17a7806cc4400adaad6f6f0ea78c04a59"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "99860a33d7230ae2964f1f13e99e30d64b3b18a4e9f817728a705d61a540337d"
    sha256 cellar: :any,                 arm64_linux:       "9631a507b2af50a7ea0d2b9573c2a77b2f696020bdf6cc05870bdbdf0e88e9fe"
    sha256 cellar: :any,                 x86_64_linux:      "637a5b069bf1f10c262f87f7dc289260db160bda97ed6a837b1b7b491d3a0435"
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
