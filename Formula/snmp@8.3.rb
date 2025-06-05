# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.22.tar.xz"
  sha256 "66c86889059bd27ccf460590ca48fcaf3261349cc9bdba2023ac6a265beabf36"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "df44dc3f1cbc43ef295349d09128bbdf92b8f471d6c960cecf5fed7e846e392f"
    sha256 cellar: :any,                 arm64_sonoma:  "e2a69a11a0f7583068ab3e3ad5515e7d7291a391205c17c323d9d890f22a4a29"
    sha256 cellar: :any,                 arm64_ventura: "06da6d1eac4f7ad18aae9af7828f1e37ee1c0b6e1e6a3e82d69afc606f22ce4c"
    sha256 cellar: :any,                 ventura:       "e89a2e41aa3f880068800a168bc5f0329577de631a62a9e113034bc21a3e6fbb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f6a1ab61822c259289d8386f96c97316ab0b0e107b56d22b7deb8624b0c0f778"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6b486db86bdc4734204434581b9def94e7b7db5e7625dcdbd8efcd387dd59e9b"
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
