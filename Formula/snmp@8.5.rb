# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/db545767e57d74e7ec0e1817a208d0d44e0932e6.tar.gz?commit=db545767e57d74e7ec0e1817a208d0d44e0932e6"
  version "8.4.0"
  sha256 "7f791c3bff47dd3e9254b741444fbdb29085220e20466a2ee61ae9e87c87a3c6"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "7d0a717853bba3161e42c3b6cacc7a96df9aec69c47d3f0dd8793282f2972a40"
    sha256 cellar: :any,                 arm64_sonoma:  "1009ab059e6fed6dd526c17acf12bdae8c8acff7a9fa09509f6340f5b44cb649"
    sha256 cellar: :any,                 arm64_ventura: "b9998ab65dc50d6fad20081816dee7c97275e36a23b68f3dae5f61fd7d084889"
    sha256 cellar: :any,                 ventura:       "5933a5a14c644d1331f79c5a8a9af59387bcc2b8968088654fefcb021b85bb02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6e7fc3f4b1ceb1c7c11d2d0bf3c63072e847dd3f6547e9accb1f511ec973cc8d"
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
