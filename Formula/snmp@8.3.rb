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
    sha256 cellar: :any,                 arm64_sequoia: "4dbadcaf1b6e75f00c8fe04303a160637d5ebcbdf9af6f0a8856143c501652a7"
    sha256 cellar: :any,                 arm64_sonoma:  "e9668872d0e8228e9e2b20ad6ae2c24c0c387c5af2429446b0b5cd3cb2486033"
    sha256 cellar: :any,                 arm64_ventura: "03fbdb98bdd8c228ab51f18505d2501e754a70aa9eb4628cbce9c060e2bbb22d"
    sha256 cellar: :any,                 ventura:       "ad6f990d85041747f6e37ff930a45920f9228630301de849f504f80ad36bdc78"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d7efbc6ee419d69bd5b662180d173548f03d093d7e18ae6922bd58315dae1c70"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e283cdc7fe0c3f95851293458c45849f2a052dabd5343af9c7a006734cda1281"
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
