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
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_tahoe:   "2b3fcb01a0e1ca6e93464c78edcf82742d6fc5b591a96c47dd52c6a3efe83165"
    sha256 cellar: :any,                 arm64_sequoia: "142907bb3d0b94a5bdfc62c16beac80609322fb781bfee54fbd7cb16b03a909f"
    sha256 cellar: :any,                 arm64_sonoma:  "81245c8ec985c4eded8857f65fd25914c47875fc1190f410624902483c4bc9e5"
    sha256 cellar: :any,                 sonoma:        "c56654051efaaaaa840d1d9672590c52eabb2dc17eeb0e6ba1c1f828d409efaa"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ad6833af98edd3223e7fdc1a42c94c28e0faee807d6248e09dc5bc7695982280"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ecacc8f4ac18f3acad8982b7991ef08bca4cf93f4f45790522eee79eb8c7fb6d"
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
