# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.29.tar.xz"
  sha256 "f7950ca034b15a78f5de9f1b22f4d9bad1dd497114d175cb1672a4ca78077af5"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a4b285c269e84d968886084fa8352bdacd861fe106a714fe7d0ef34145e24ea7"
    sha256 cellar: :any,                 arm64_sequoia: "8f5a83e1af415ee82673f0b913e9df45fe444d8e089fb030faf870017cfde60f"
    sha256 cellar: :any,                 arm64_sonoma:  "e816dc6ea0fd9cbf4890e45e3e95daa0ca76ee9e40955c69720275d46e3f085d"
    sha256 cellar: :any,                 sonoma:        "2ff16351ee314d9b5902ada0b47f93c99c0f7df6b8f0c699c80d5e7bc579afd6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "14f02579d8b225de145eeeaf55c141f21f7212738a2e5c8769e04c175239e21e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "02b5a6e28138db3cb75358cb70161f11f7373a8d5ac94f8a69e89cc6ce8b4662"
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
