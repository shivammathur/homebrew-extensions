# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.29.tar.xz"
  sha256 "f7950ca034b15a78f5de9f1b22f4d9bad1dd497114d175cb1672a4ca78077af5"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "fec0a30aae6e5cc9dc030d7aae79e9aa723e241d6c4664df84323b611940a50f"
    sha256 cellar: :any,                 arm64_sequoia: "536678a91949b6c5346fe022464bfd673bcc4d10a03f51ced55bd37bc3082fcc"
    sha256 cellar: :any,                 arm64_sonoma:  "29a7599c4eb7598b79907ecaad3b0934644f1aec6cb6778ac40c95b864856773"
    sha256 cellar: :any,                 sonoma:        "de8b5b4112d63def175cfa8482afe2d0eb1ec1c2f7d3db5877fe8a3d0b3739db"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9a167b182d9495bcf161068c7ca63423802334805ddd0e322c90be0fb5eb1e42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2f2521ac0df15a5a85f15a3fe131591c7ea7e7b096bfcf2692699445fe3cf42c"
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
