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
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "b6746ca62aecb8584907e1c717d73335e53ad114218bdc5a5390b32cb00f20b4"
    sha256 cellar: :any, arm64_tahoe:       "0fceafe93073e95e3484cdfc8be18eefe50893d2d4ef249ebca8be8d3d722b02"
    sha256 cellar: :any, arm64_sequoia:     "ceeefbd33f5c8551031af9d5c3955d3b75eeb7ff6a9fd33c797f9ad408790fbf"
    sha256 cellar: :any, arm64_linux:       "b95f6908a76d40d3e0caf7b9de8dbc2c17aef76de3c0280d7805ea1b68cf7f62"
    sha256 cellar: :any, x86_64_linux:      "229e12f1052e0b0c60b4452ed7bfe1a163999eff1810d832ee93e8767d4a753b"
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
