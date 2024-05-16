# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/446ff6a742dd7c2545b1d0c55e85fadf7b8f424b.tar.gz?commit=446ff6a742dd7c2545b1d0c55e85fadf7b8f424b"
  version "8.4.0"
  sha256 "f695826acdd3bdb060006001a98119f9acf2644cce33537f56946b6965e42f90"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 41
    sha256 cellar: :any,                 arm64_sonoma:   "26e701bb4d5cdf321c9ae22235b538bcfae0e50bb4b1753833ec5d5effdbd148"
    sha256 cellar: :any,                 arm64_ventura:  "dd79258c529501d62d8220c6d1d460436585db2dae8fababe13e5bfdac76decc"
    sha256 cellar: :any,                 arm64_monterey: "e48e84dbe589efeb309cc334e44fcecb3fef988728016b220615970af2d8419f"
    sha256 cellar: :any,                 ventura:        "8e49186cafc7da0d8eda1b716c7c46986b7edcfd8b14092c382293fbc1f955a6"
    sha256 cellar: :any,                 monterey:       "5d5a57282c2529dd3fe0baf44bc0824bc161cb936d804d11b4d1f11510078a85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "294b9c575d2a7be64eea5cff81b98431c64de307f104530e198a8eaa8c029313"
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
