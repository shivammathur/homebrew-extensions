# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4de530c8e7f4d5fa3df1d0e15d79a7bd44cc597c.tar.gz"
  version "7.0.33"
  sha256 "3371c5712eae64aa28eda7733a02d93ec298894d57eb0ce3fdac0904bbee4a16"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "3f8cefead2f7aed0986ea9c6d0035ba163c6ca96f79c6de1ba47c8ab7e314cf3"
    sha256 cellar: :any,                 arm64_sequoia: "2b9387cbc7fa1df6e2fb03e6d20808504d1b3d65736e08d8d3a24319aef426ad"
    sha256 cellar: :any,                 arm64_sonoma:  "b2ac90427daf81a3429cff48352030e9625cab172f16cffb9a62398a9330f83a"
    sha256 cellar: :any,                 sonoma:        "304a1ea5ddc899943577af70952ec4d735d156ca7aedd4e680d7ae6046d941d6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5cad96280b0b20d021309189b37805011eba765f4c4871ad3d0fa978af7aea39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0e97f1273b50ad2cbac48624d429b627a805cb62043005b4455734dd5554be5"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
