# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/78364ef97ed46c585a31c601f4e8f8330d5a95c5.tar.gz?commit=78364ef97ed46c585a31c601f4e8f8330d5a95c5"
  version "8.4.0"
  sha256 "64a37e6855b48af40f8518ddd69cd22d5a32a43dbcce7668ca45606cd29037bb"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_sonoma:   "d6ac9b6bb99219dfbaaa09ba76bcf020450aa5162f1760cc724624e4ac1aee6b"
    sha256 cellar: :any,                 arm64_ventura:  "3fb45a2c1622c53b5be89ef726e251d2604a78a2470c118466d71fb75ad0f2f7"
    sha256 cellar: :any,                 arm64_monterey: "f677d59e1f89e34bc317904da87027ffe7f071c88eea107b54eae6f4a44ec556"
    sha256 cellar: :any,                 ventura:        "940026ebb009e186a3dfdc56eb9712136e9620b1f8ac7308473912c708f677a2"
    sha256 cellar: :any,                 monterey:       "30a0409a15762d040e1f5cf4b9855f9f74525f328c429924f4a6b782e5cc44a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "54479f75a75dc8e6d949e8b88b4fd42b17c706b71cad34cac749edc66ca6d0b9"
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
