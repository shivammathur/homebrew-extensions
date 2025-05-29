# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a63d0a49b0e91a08167b3201d97631ce4923cfd7.tar.gz?commit=a63d0a49b0e91a08167b3201d97631ce4923cfd7"
  version "8.5.0"
  sha256 "00631ded66966e240d1479499a245e72682cc29598007857042d5f77f2da93da"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 26
    sha256 cellar: :any,                 arm64_sequoia: "b90eb888d3d33a2dfc01054d671a81a251d61306f32c17be80f169db9b663c23"
    sha256 cellar: :any,                 arm64_sonoma:  "8d9599877b10ba53c08eae9b517c1dcafbbda640af2ed7a700d3bafbc830171f"
    sha256 cellar: :any,                 arm64_ventura: "239989b6c1abb61e04e74fa4495338cb0f53b7b98eed64c0acc7713120cf3fba"
    sha256 cellar: :any,                 ventura:       "c080fe46921a3106c34ab7f5a49533f74176901f2ddfed8358cb3e1bb7959fb4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "170dc7d37c939fe1f5bad68f05f5f66364b8738e21a5f2d77bb350293709eef3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6f8a5b43991d4c8a3b8e2b33084751bd64afcf0f92e527ed9fcddda55837d5cb"
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
