# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.27.tar.xz"
  sha256 "c15a09a9d199437144ecfef7d712ec4ca5c6820cf34acc24cc8489dd0cee41ba"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "446675a80dc6b9a3fc5049dd00f3645eda0e7bacafa36ee1557d8d727adeb8cc"
    sha256 cellar: :any,                 arm64_sequoia: "90dff875e47a21caff09b4310cb156a503e6c8f89df0b8bb43a2eeeda49a9eb1"
    sha256 cellar: :any,                 arm64_sonoma:  "f02fdd035e46f3e974da0b8fc5e97717cae3341d7aa426f020d975de94c34856"
    sha256 cellar: :any,                 sonoma:        "4b611a4b4022a1cc474e8de96d4960d0e960bf08ab4ec26a581df679f1886564"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "547d7e7b15dbcfae83f8c52d5e6851720725e03be12703f54de23e2f75fe19d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "76bca87c30f71489be5bc2ee9bf69c97a304c59c915ddb70ecfe6777d51a6d1d"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
