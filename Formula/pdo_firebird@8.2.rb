# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT82 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.33.tar.xz"
  sha256 "fbdeace9b38220436a4c8fd79b900df92878151db145e641750743a283b514c1"
  head "https://github.com/php/php-src.git", branch: "PHP-8.2"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.2(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "104dba89246ab9ae26370cf8812238f0a5a3f116a5e8590b0a5dda598b197744"
    sha256 cellar: :any, arm64_sequoia: "ce4c6c3630814cec0decb8877d92a69c56a956cfcedf508031ee103a05175a34"
    sha256 cellar: :any, arm64_sonoma:  "c49ec02cde0b5dc31e3d3e933d53b20af1ab25cf8f9d3accaa4fb46fab736865"
    sha256 cellar: :any, sonoma:        "9c9793ff647ae639fff1c5b99bb627ab285501b50b716c172051a0093bfec9fb"
    sha256 cellar: :any, arm64_linux:   "7f04073f8aae60b0c62f21cab25ec35dffb380a51410c564a1325a8877312e5d"
    sha256 cellar: :any, x86_64_linux:  "833031c186d84d6b4dc133aa6cc6a6cb7eef95a1ea5f9cb19b97b9cc75143580"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
