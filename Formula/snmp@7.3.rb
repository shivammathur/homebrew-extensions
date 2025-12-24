# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2c97539020cfaadf6998f23fd301cb5158464fbc.tar.gz"
  version "7.3.33"
  sha256 "c9bc90d6c3d7b2d3a9e17581d36382f4db3e20e3e43225db5437c52e2f2de7bf"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ad68e62f33e3b1827cdf0f2678d6829ad58ea24aa35531a59fa3284f3ff612bc"
    sha256 cellar: :any,                 arm64_sequoia: "7c34a043a35ac856e39ccbbd6b8c84b859c0c059962c99a90ddc4ebbddcbb150"
    sha256 cellar: :any,                 arm64_sonoma:  "2193a5201a66f56f0ca1250be0f685bec854b2fe6f153aff8d35b1c339d7d7bf"
    sha256 cellar: :any,                 sonoma:        "4a2be8b838b513bded3123241de0134125d781fea91070839051a66989983f9f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8fd11387b5d5773a6b5beb285dc988dc42743f2c8780e2ab1b10b1245819493b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0a38b9b4c07ba0b353e624e9a25a4fe7a94dd002cea31f6449c0ed58343f203a"
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
