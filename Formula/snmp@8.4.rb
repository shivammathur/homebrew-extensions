# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/5fc68d8babfcb15b9da67c80fce3ceaabe895ebd.tar.gz?commit=5fc68d8babfcb15b9da67c80fce3ceaabe895ebd"
  version "8.4.0"
  sha256 "2dc981de6aa6558494841a18a8546c46233b84019aa29c25b608c739c0820357"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 55
    sha256 cellar: :any,                 arm64_sonoma:   "818ec75c6b6c31c15cc085c3ef2e4737adac6a8c770f731915623ba6842fcabd"
    sha256 cellar: :any,                 arm64_ventura:  "2d8b2a8ec5ee89004cbd6862f85692d78d2ff96498a2a3a3a5846e357eb0a13e"
    sha256 cellar: :any,                 arm64_monterey: "8cbf470e56ab56933b83670c6855fb55135074ca043e2ee8dfe3a0824b8435b3"
    sha256 cellar: :any,                 ventura:        "fbe37caf25ed9324147d94b4313a638240e1380270bca239e155c42625793063"
    sha256 cellar: :any,                 monterey:       "4bb965ca194d57419ef6ceafc6e82904e555465c916f6bfa117ac2e50b5bbb25"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5613dae2777f2b2eaa65d9e733ecc6d4b131e50919cd7a0bc575e752e7718f68"
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
