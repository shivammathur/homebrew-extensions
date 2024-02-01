# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT84 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "cc708d5ea43ec1c0b0b500894b84d640ec6e50b195cf960536f49d406b2bb8c0"
    sha256 cellar: :any,                 arm64_monterey: "6ea487c7ed50e60521eec4a3ea2500c02210d01680fe665714088d189378e273"
    sha256 cellar: :any,                 arm64_big_sur:  "5f09657dedbaf2dd4e2b2848a0c8de736be25df027705bc21a15c7deb4276fdd"
    sha256 cellar: :any,                 ventura:        "012ad52c6e2db298bb13240faea32c94dc78ad6b0aa2cc80a54d8617cd3feb52"
    sha256 cellar: :any,                 monterey:       "a8c0f48f80e4365c47dc9cd1194b06a6cea8c60de6d13246d416ed32225c9350"
    sha256 cellar: :any,                 big_sur:        "22f2b38b5ab4fbe8f4f80e2c8e9755056783834b754278bffd7de4bb08c18cbd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4be5f12400b941ec62ea500747b2ccb2ac580994c6088872d4e59599d3925db2"
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
