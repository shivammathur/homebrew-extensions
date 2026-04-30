# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT86 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.1.tgz"
  sha256 "7c4ea8f25ebbc8999084239e7e0ef75315097e013df0e290fcef76c3d977b9d8"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "56baa2839fe5b4a56e79463bd60f0d280c52c4b1c23cae53715ec0fa11ca1c6a"
    sha256 cellar: :any,                 arm64_sequoia: "329a766613f18947095b7f84d8f9d523e621f0ec68d7665683c628cc0c92ecb9"
    sha256 cellar: :any,                 arm64_sonoma:  "afcb594f8efc68c3b17e66236463024134140dad81eff3619ac8a48c13cb8eba"
    sha256 cellar: :any,                 sonoma:        "4f2e4017c5bee5edd7606c2c970fa159aa4c884d7cc8d5c547976d2da2d89c52"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "45db70dbcd2477df87ad55f7d67fadb6521688649b74f2672375047b63b398e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5ecad210bc93994a5b3cc0dd73000f7d9d467b2fe1393bf3ce786c5d2d2aa70b"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "sqlsrv-#{version}"
    inreplace "init.cpp" do |s|
      s.gsub! "INI_BOOL( warnings_as_errors )", "zend_ini_bool_literal(INI_PREFIX INI_WARNINGS_RETURN_AS_ERRORS)"
      s.gsub! "INI_INT( severity )", "zend_ini_long_literal(INI_PREFIX INI_LOG_SEVERITY)"
      s.gsub! "INI_INT( subsystems )", "zend_ini_long_literal(INI_PREFIX INI_LOG_SUBSYSTEMS)"
      s.gsub! "INI_INT( buffered_limit )", "zend_ini_long_literal(INI_PREFIX INI_BUFFERED_QUERY_LIMIT)"
      s.gsub! "INI_INT(set_locale_info)", "zend_ini_long_literal(INI_PREFIX INI_SET_LOCALE_INFO)"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
