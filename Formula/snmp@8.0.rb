# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/88664f288c699b0d63f324ef96340af335d23672.tar.gz"
  sha256 "790dd5d5a0d72a312239d77f04c42c7cb6b425aa22086fbc17879edab9ba9475"
  version "8.0.30"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "2fd40c328541bbc52be6c58c2f8428b47f1c64fce2548b3c19801773172ea2bd"
    sha256 cellar: :any,                 arm64_sequoia: "45ae445e033caed80af9de6ffb8b07a7fc48ba4b3ded8f49aa60330462369e3b"
    sha256 cellar: :any,                 arm64_sonoma:  "7df3a86db89790144138d95719001c5b37ea32a49d6f199decb9c64bae74f408"
    sha256 cellar: :any,                 sonoma:        "9ee87bf421f5b74b0dd11b367df8bdacea8d177c4da501e318f84cce8466cd7c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ebfc2ed218bbc4a90e087d7d67165ef04c6f93ddc9af313d23d23275a993bb72"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "21ce0260fea4354c41bf011b36aa38b75516955cffa5ede563b7e50bc5a53b81"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
