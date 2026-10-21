# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.36.tar.xz"
  sha256 "dd54693aa334c5c4d72e9aee96b082c2473750a18a6c1d105789c93a3b1692fd"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "dce6fae7b24860f37adcc0677c596952ccff79ed683d3bc5d25655019385def1"
    sha256 cellar: :any, arm64_tahoe:       "31dd3abfd6a03b16c581077ffdd663321642dc0d7b0439b9e2e1d041bc88fbd5"
    sha256 cellar: :any, arm64_sequoia:     "437f6fe12f633f0395ddf8e3cdacce90be2c06dde7849332ac26896a76ad5c7f"
    sha256 cellar: :any, arm64_linux:       "be7b12cc3985539a7a7964c38210036ae59d30a29a6045190d2b1adff2633981"
    sha256 cellar: :any, x86_64_linux:      "a4af9c5ad444098fa21939f18b1b491a9f14e042c1696e9112a865cdfddf75b9"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
