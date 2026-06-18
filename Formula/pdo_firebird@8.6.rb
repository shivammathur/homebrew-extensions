# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9be705297bf0148ed84bf643949972475bef2deb.tar.gz?commit=9be705297bf0148ed84bf643949972475bef2deb"
  version "8.6.0"
  sha256 "1e70965ef3cc0d73223c88d20ea184638ec8a45576db3d8e6d6ff70980167cc6"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any, arm64_tahoe:   "75437456c758b8d56090802aaf0a1d26262641746c114e3b275e280e8dc80b3f"
    sha256 cellar: :any, arm64_sequoia: "0d7a8616360e1fa23a97b97afe1f3ba64dcb22b41993cfeb92f9082829c5ba0c"
    sha256 cellar: :any, arm64_sonoma:  "2d7b62c4d7fd527e00b7ff5ef26aa384724c2d6e1a978cf59efc5f1b8d01cf12"
    sha256 cellar: :any, sonoma:        "50dd14644b21f2d0012e790b046c7b77aedc2bcdfedc81e1a5340e891a25f96a"
    sha256 cellar: :any, arm64_linux:   "6e9fbfa8cb0c50bd62b2996123e80dd8670bf0230c1f7d877ef872095b4ba268"
    sha256 cellar: :any, x86_64_linux:  "7bbec50b5574635da51c37d70d2eb6b1c8339eb95dcf3c305dab382352086738"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
