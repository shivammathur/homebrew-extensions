# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.33.tar.xz"
  sha256 "e293ed620cec74651bb4a071317892a478aa6840fab22db45c72d77cd42f9676"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "d92334b02626ff3c0b145d2ce8b7a6a1f3be915ad5b4eddb1df340096c2200fb"
    sha256 cellar: :any, arm64_sequoia: "126c465daa8e6474baf3f80266c78a8037fbff694b8ae5c70398d2aee740942f"
    sha256 cellar: :any, arm64_sonoma:  "0c172d47979cb8b81afd99c352f7e6b196d9e8cace1c37f12484f6eb2e22b436"
    sha256 cellar: :any, sonoma:        "d59990e67a6bee727efe1f18d6e14f45a7e9e16d329b02163501a3dc9bf25cb2"
    sha256 cellar: :any, arm64_linux:   "7ea9a18a68d7781e0bf3ca7dd639a8097ebe6fc1c6eba0050cf48a2e5163e7de"
    sha256 cellar: :any, x86_64_linux:  "aea72c5e66d6a7f1fc620de82cfe8a548a67ec211d59623102b93a47c9a12186"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
