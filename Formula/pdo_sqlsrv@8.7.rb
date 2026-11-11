# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT87 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.3.tgz"
  sha256 "198a7b37da0658d36a93d158a0ec179b137b3a4d241c90a6650ae9ee8f91ec4a"
  revision 1
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "2c481a0150aeb86ba1219e1b127d9d49edfc6d4ed8ecd9bc4f0980a22145b706"
    sha256 cellar: :any, arm64_tahoe:       "af12d1bda316b3dbb58c180791150a51ebb13f98cbe17322bef41a9b6d315227"
    sha256 cellar: :any, arm64_sequoia:     "3c26c99ba4026268df0128e84a9d2085422922447baf4b9c26e7a11cfba1cf7e"
    sha256 cellar: :any, arm64_linux:       "4ea0cea438aa95c6d804d2ba7ac63b4c1759ddf9e9d0fda56ee70b20cc5311a2"
    sha256 cellar: :any, x86_64_linux:      "23af6058b3f913cd6beaa0dcbea5e1763a47a947a9a034286d89d6d5220ac252"
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
