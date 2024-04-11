# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a7c5407f48a201326cf82f638150540886e853b7.tar.gz"
  version "7.3.33"
  sha256 "bd7b6d3b30779b5fb89856e5d5dc90c6fa9a332029e22c7a9c179907f1706984"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "1f8c227c0837e313ef7035550378f64262805b2fba13a841684981a8ef1f3553"
    sha256 cellar: :any,                 arm64_ventura:  "61c5f30dbcd74362d6798d8b6d830d54851008e75dc229ef08d6ffc20c85116d"
    sha256 cellar: :any,                 arm64_monterey: "45e16ad7b9c7be42969431b0f99cbfc18bfd5905931064faf21f05696d6ad79b"
    sha256 cellar: :any,                 ventura:        "761b39406a5c07576799e1adb4ce671c9348ce44ea77eda66fc2568206191def"
    sha256 cellar: :any,                 monterey:       "69e9a4765f7521caefef7736021b746fbc19a2f754f7da390e665d0a6e586f14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ee9b28f3c4fd4b69b4e76885effd6e25a9f3a99d2b98416e3847e90c088d84d6"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
