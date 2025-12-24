# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.34.tar.xz"
  sha256 "ffa9e0982e82eeaea848f57687b425ed173aa278fe563001310ae2638db5c251"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.1.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "0d31370e3e0a23be504a3664a7a9cc377310655eb5dc7bf4ea3838157741c51d"
    sha256 cellar: :any,                 arm64_sequoia: "aaac047257c42a0465e6de1ec2feafb2be812ece5b8e9023df6b27a8fc3443c4"
    sha256 cellar: :any,                 arm64_sonoma:  "1878c2a8160bd23b1da356f1d730ec78c49c795bc004c4042fd8a7e7c0bda949"
    sha256 cellar: :any,                 sonoma:        "672b4de1032b00e0184413cef81c67be0e581192b7c46057c2a14a842f761f21"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5fffc5ceb804762abfc12b3d522edd85608340111c15743b69e7f76ef4a230bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7d1a90d204491fc6c30c8e31ef663dfba7e71af69ad69903aecb150ed60bb0eb"
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
