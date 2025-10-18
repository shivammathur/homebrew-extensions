# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT70 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.9.0.tgz"
  sha256 "0fce417b33879fdae3d50cc1aa5b284ab12662147ea2206fa6e1fadde8b48c58"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "89ecd877b7d08be0dd7fae0b6174570bea63484f7bab5386c1b6ee7e03b55d70"
    sha256 cellar: :any,                 arm64_ventura:  "c20686b9b572d85d3b587d3dc49e1e89cb7535418e638e5f05a5fa6579de0b5e"
    sha256 cellar: :any,                 arm64_monterey: "5df37249fb1a4ebbfd926d5a19293c0c513b098bd66a58683bf874bcd33f2eab"
    sha256 cellar: :any,                 arm64_big_sur:  "e4ad4e8bb32149a049f52539b2c1561a181bb5e0da4f99b2a28c0c3af385ba00"
    sha256 cellar: :any,                 ventura:        "0493abc7a75175dbb053cd13b3908c8686d3b1cf6d0d26f2a4557ec63df379a9"
    sha256 cellar: :any,                 monterey:       "a537061077a50f28545deadf00a4bf561afb13da8bbd81571f9ca10100b61918"
    sha256 cellar: :any,                 big_sur:        "77b502f55313ae023a436fa3a3a461ba44e9a7be9973a0b9df9ce3c866d4f550"
    sha256 cellar: :any,                 catalina:       "b226fd4f69ae34d67bae719b614c0b7912bb30e5443acffa59482bdcb957710c"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "d928d74244f6221bf0a9f99a56858f679bea6158dc2d7cbdc5ca0a2add61fee7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eeaef2aab8f40f050c15134cf64c66dec0a59e50882a3d83db6213b6df002eee"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
