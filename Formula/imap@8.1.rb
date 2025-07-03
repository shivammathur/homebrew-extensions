# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.33.tar.xz"
  sha256 "9db83bf4590375562bc1a10b353cccbcf9fcfc56c58b7c8fb814e6865bb928d1"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.1.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "c46957d1d24bc8561ef281f272baac00ef0facf5b48511940dd9cbe248a2d859"
    sha256 cellar: :any,                 arm64_sonoma:  "118c36dee4a9e0b9b6293085aa38f41aa8e0cbfbc035653ef2c4d178c51129f7"
    sha256 cellar: :any,                 arm64_ventura: "9e990d38779837a13392978016791bcae13fd6d84ea51faf36072b0b7c6adc48"
    sha256 cellar: :any,                 ventura:       "366c2092de8297829666062cc2ac08010f294df24dc5b629c7cf3dcf440f1c69"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "edd85bf2a7b8e1fcb52342b0337010783622d283b8d209176f26da92a324a664"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9557b76748d0dffde6de8baa0488cff65de8f1f9e5ba8c29274dacc03ae1581e"
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
