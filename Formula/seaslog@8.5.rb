# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Seaslog Extension
class SeaslogAT85 < AbstractPhpExtension
  init
  desc "Seaslog PHP extension"
  homepage "https://github.com/SeasX/SeasLog"
  url "https://pecl.php.net/get/SeasLog-2.2.0.tgz"
  sha256 "e40a1067075b1e0bcdfd5ff98647b9f83f502eb6b2a3d89e67b067704ea127da"
  head "https://github.com/SeasX/SeasLog.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/seaslog/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5fdb796934ea9c9ae18ce15aed9c56e85afa6f3b4be8e83701591d68bd69a2a3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ff5589772a32a9c1a81769c9464d1cb3309f92ce534cef8f41ccfc900d49646d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b00b8e8fb0b2fcffc0e0443f8f7749bf0ac7cc3e2140c0e6a8bcedc43700c78f"
    sha256 cellar: :any_skip_relocation, sonoma:        "6ce2d84d40ced2c7378bdad904e87330f939373693b092cbd338c943f7afffd5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "38dd0a5d83284742aa6bd214c1d60820f0fd0cfd66cd8f2cf59aac24c0fba326"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7a415e42d9cf246262a6f3a6cfab7db044f9eefd6199180884f948d9af3f7eb5"
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
