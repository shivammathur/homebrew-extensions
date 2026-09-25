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
  revision 2
  head "https://github.com/SeasX/SeasLog.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/seaslog/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "b66c572937a2e28c75e2d33c0e62d32b00c39ea431e37d540583f954a6d1116d"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "4dd7242084ef2957e574a010498ef05c9269ca966304478754505269c18a2344"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "1c69cda7356603eb75cbda0d7f3f7b98a906351bd8713d50a33c347040e90a16"
    sha256 cellar: :any,                 arm64_linux:       "94f5804bf8d4a476ccd047bec4331feadf2ac1e93e2e55c6e7fc52312010984a"
    sha256 cellar: :any,                 x86_64_linux:      "00140e4b0cf2ca93710f9a27b7621596b8e15f9f8e3504b1d1ef013fc0e6294b"
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
