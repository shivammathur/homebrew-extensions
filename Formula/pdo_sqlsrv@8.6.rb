# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT86 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.3.tgz"
  sha256 "198a7b37da0658d36a93d158a0ec179b137b3a4d241c90a6650ae9ee8f91ec4a"
  revision 2
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "cf9c025153acb1f2263cae5640787c02e9f2077edf7947dd721a4bb8ad6c816d"
    sha256 cellar: :any, arm64_tahoe:       "78503ea65c79241fa4660ec2d998c3e27a628ff73e237a8337cac4fe0d8ba494"
    sha256 cellar: :any, arm64_sequoia:     "ae61c5fc8f31523670ff42f7202335b6e6c805220a5a6817054d884010945bb5"
    sha256 cellar: :any, arm64_linux:       "a4294d959c230b5d53b9e1250775f0ab19e997fb24de9f342d6721a8b4dd22c9"
    sha256 cellar: :any, x86_64_linux:      "d2469fba9348f1f9e24324f4dc501954a6c3c84f464250e3d5f5571e131b34a3"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    inreplace "shared/core_stream.cpp" do |s|
      s.gsub! "php_stream_context* STREAMS_DC", "php_stream_context* context STREAMS_DC"
      s.gsub! "php_stream_wrapper_log_error(wrapper, options,",
              "php_stream_wrapper_log_warn(wrapper, context, options, InvalidParam,"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
