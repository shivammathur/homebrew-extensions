# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/01093b7c137d9096a5857cfd55287e01090bb342.tar.gz?commit=01093b7c137d9096a5857cfd55287e01090bb342"
  version "8.5.0"
  sha256 "df473c4d05c026fe281db4f09c292861235063c31e2b13b05147536f341accd6"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "49bb78027f87134c52333ea411f1dd6a3d877c8c7daeda584df165e7a86fdb58"
    sha256 cellar: :any,                 arm64_sonoma:  "8769b336dc2fa29cc5cb898095a14f735a2d63277dabec5438eae0ddfd4261d9"
    sha256 cellar: :any,                 arm64_ventura: "047f78b812bd5a963a47dc54f4533762789ef7e778eb7d6686749e4f39ddf3fe"
    sha256 cellar: :any,                 ventura:       "63027d7113c22c8af734423427878acd59369c25dc1c366cfbf3ffd70fb079c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6961e9b59e4a304de149cf82ab0a5f4f3d25429b55aa6c6e282966a81350aed4"
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
