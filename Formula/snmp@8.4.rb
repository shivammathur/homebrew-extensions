# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f9cfd40fa25f0bd071e65deb684dd04c75364d1c.tar.gz?commit=f9cfd40fa25f0bd071e65deb684dd04c75364d1c"
  version "8.4.0"
  sha256 "d1f5976f907965a85e7abe35566b20eaa8ab99a156ed989fd0adefd7e1d5a0c9"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 26
    sha256 cellar: :any,                 arm64_sonoma:   "9b8e6c004f97ee43d048f79949704c50a6caed03d4d3c4a3aecb16b166fdf0f1"
    sha256 cellar: :any,                 arm64_ventura:  "562871586ae83842660cfdea2e3b06d29f7411365e4179a46b1577999a369192"
    sha256 cellar: :any,                 arm64_monterey: "82a62467603fec89aecb85c143d9e1edffe64bec3fa5660455d7743889e0fd69"
    sha256 cellar: :any,                 ventura:        "0773ae6e70ebc02abdd85d699688bf8e22f9abca68f143ede9ccd3db5b9a457b"
    sha256 cellar: :any,                 monterey:       "b81355a3feae5e77e1c4ef3b6cf7a9d8706030d550f399923331548a1faffe23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "84d7df493de0e783a7a37c370c6fc18ee23336b047274a6e5dc6d57ed77ef623"
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
