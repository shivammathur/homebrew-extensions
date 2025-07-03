# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.29.tar.xz"
  sha256 "475f991afd2d5b901fb410be407d929bc00c46285d3f439a02c59e8b6fe3589c"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.2.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "94895ab6d1f68e014d640bf2175ecaf149c9b4df408e601f10e0c01e13ef6245"
    sha256 cellar: :any,                 arm64_sonoma:  "cdf68155d81fc4839244b6fb01aa2ffb50e292cc8518cadd62ae0c703fa03b38"
    sha256 cellar: :any,                 arm64_ventura: "976ca80d17da2f248a0d96f0b273c0f163d149fba6d42e70d10741e855555810"
    sha256 cellar: :any,                 ventura:       "f0400e7bcd60dfc6b2b1a625325b73dcfed49463b58e5b893d94587ae8c54f12"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2172fd759502a04f0f7561c3d16595833005d4da292ca4dc264ed78d7411fd80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "95cf370e1738bcbe0556e37e6c9ba3c21b77a707bacd6792e263b5d53c7bac1f"
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
