# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f1295864597a2e46ee2694c5bcdc0132427e9c3f.tar.gz?commit=f1295864597a2e46ee2694c5bcdc0132427e9c3f"
  version "8.5.0"
  sha256 "57d7f3b0ebc5e0b0c354b7f0db8fced9658274bdb89ae25f0f808b9bd2c30cf3"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 29
    sha256 cellar: :any,                 arm64_sequoia: "138847620baf6e43cf9accfd35525868296f4c52b15fd0c2cf04831bd0e53ea7"
    sha256 cellar: :any,                 arm64_sonoma:  "d0b52e6ac39d7066d5eb7a3134865ab229b9419bd03130518dec251f1c01b4fb"
    sha256 cellar: :any,                 arm64_ventura: "b392fa9d57e1748543632a2979377e79a4529815c6d3751c19990c9e8f529879"
    sha256 cellar: :any,                 ventura:       "12b2357093611eb99d09688bb6e402134410f8565a6bcf9e306148a06f1eaedd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c52c3b9a2da1137cb9e9878c846b14b8162d0a961fe1c9b731d0773e5e14eed5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9c6558fc9bffdfb78b91e35ab1ab434b3e61e1e134da6db6ef3a9efafca3da97"
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
