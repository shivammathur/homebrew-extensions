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
  revision 2
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "b3e26f1a0c6e6cb2a13e411fb81a7a622145be3fe4ae5c189e68cf259c0c4c4a"
    sha256 cellar: :any, arm64_tahoe:       "7ddc6b5aff82292afb6d380613893e81625c1f1a226c7fc4aa53b602c1be3343"
    sha256 cellar: :any, arm64_sequoia:     "0e7c8c11e1b3c49f95ab6068c8812e3e01f793c07f0db12dac56982defd9f695"
    sha256 cellar: :any, arm64_linux:       "0f9079358ff36a13a6cd84c5bc3017edfa1b608afd429d7327346f388b51f50f"
    sha256 cellar: :any, x86_64_linux:      "9d88566b44abae66c17d5a928b050182c5222ed0849509dd1cac27478220efcb"
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
