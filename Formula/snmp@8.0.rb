# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/31b3988504b443365bfa4881257782b00919a751.tar.gz"
  sha256 "6f0f2a0dbb37e904859d7cc9ac12425434333a5c4b811b674621525430bd5472"
  version "8.0.30"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "2a18ca7881173c50900cfbf90aeebd57217a1c314b8724250859478140b0098a"
    sha256 cellar: :any,                 arm64_sequoia: "50707dea67bd06fcd90220aec4327fbcf0de97f93b3858bba306d8d35c7d0fb6"
    sha256 cellar: :any,                 arm64_sonoma:  "aaf1d69c1fe5f11e95c915be952c9232df1e892d577341e6c7e1075fedc19181"
    sha256 cellar: :any,                 sonoma:        "fcb021ae060ba732f38044696e6c2651a6f78e53f2428503ef2618c6922e36cc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "30216aa28bd42aab49eb5c9c0d793517543f265417780901efbac17586e67ab2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8a4ea894b208666dfed3921a6098752ff624c3c768d16958791169c0ca7817e7"
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
