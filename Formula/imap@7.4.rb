# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/78eed5e70e3c16e2d310ccd95b9e247891033cf5.tar.gz"
  version "7.4.33"
  sha256 "2514d5ba7da9f9546a3be16c88f11ab59fa89796a3cf2b6b3f747c596c7c8b21"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "261f537ce2a8cad082f406380f5e42fd276f908961222212cd8d85480f05f4a2"
    sha256 cellar: :any,                 arm64_sonoma:  "f9f5cd2f18c25d1e53717d65afedec9bf487cc7945bfbb5aff8cdf3bae502318"
    sha256 cellar: :any,                 arm64_ventura: "c1b5220e254c04a95cff4f20edcae19cce052e5818e27a43ed176e5a082c3c1c"
    sha256 cellar: :any,                 ventura:       "f44b1dec90ee8d097baccfec80f44c10c4375460b5082cf5858406a1cdc99829"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "481c3c72c752a3aa229305869225e0ffadacda7762445c58061a6684e7c6ae16"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4ff5fa4462e4dade809e20c193131335db91924ae4c2bd1c4a9cbfb5030e96ef"
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
